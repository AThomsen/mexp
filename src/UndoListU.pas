{-----------------------------------------------------------------------------
This file is part of MEXP.

    MEXP is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    MEXP is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with MEXP.  If not, see <http://www.gnu.org/licenses/>.

The Initial Developer of the Original Code is Anders Thomsen [mail at andersthomsen dot dk]

Contributions by:

-----------------------------------------------------------------------------}


unit UndoListU;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, MEXPtypes, 
  ExtCtrls, VirtualTrees, StdCtrls, ComCtrls, fileCtrl, QStrings, QStringList;

type
  TundoListForm = class(TForm)
    tree: TVirtualStringTree;
    Panel1: TPanel;
    goBtn: TButton;
    pBar: TProgressBar;
    pLabel: TLabel;
    closeBtn: TButton;
    DelDirsCB: TCheckBox;
    Label1: TLabel;
    procedure treeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure treeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FormCreate(Sender: TObject);
    procedure treeCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure goBtnClick(Sender: TObject);
    procedure closeBtnClick(Sender: TObject);
  private
    cancelled:boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  undoListForm: TundoListForm;

implementation
uses          MainForm, defs;
{$R *.DFM}

procedure TundoListForm.treeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
function otToText(ot:TopType):String;
begin
     case ot of
          otMove: result := 'Move/rename'
     end
end;
begin
     case Column of
          0:     CellText := otToText(PfileUndoRec(Sender.GetNodeData(Node)).opType);
          1:     CellText := DateTimeToStr(PfileUndoRec(Sender.GetNodeData(Node)).dt);
          2:     CellText := PfileUndoRec(Sender.GetNodeData(Node)).oldName;
          3:     CellText := PfileUndoRec(Sender.GetNodeData(Node)).newName
     end
end;

procedure TundoListForm.treeFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
     finalize(PfileUndoRec(sender.GetNodeData(Node))^)
end;

procedure TundoListForm.FormCreate(Sender: TObject);
begin
     tree.NodeDataSize := SizeOf(TfileUndoRec)
end;

procedure TundoListForm.treeCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
begin
     if PfileUndoRec(sender.GetNodeData(Node1)).dt > PfileUndoRec(sender.GetNodeData(Node2)).dt then
        result := 1
     else if PfileUndoRec(sender.GetNodeData(Node1)).dt < PfileUndoRec(sender.GetNodeData(Node2)).dt then
          result := -1
     else result := 0
end;

function sortStringsByLength(List: TQ_StringList; Index1, Index2: Integer): Integer;
begin
     result := length(list.strings[index2]) - length(list.strings[index1])
end;

procedure TundoListForm.goBtnClick(Sender: TObject);
procedure AddDelDir(dir:string; lst:TQ_StringList);
var       i:integer;
begin
     dir := MainFormInstance.CutBS(dir);
     while (length(dir)>0) and (Q_StrRScan(dir, '\') > 0) and not lst.find(dir, i) do
     begin
          dir := MainFormInstance.CutBS(dir);
          if directoryExists(dir) then
             lst.Add(dir)
          else break;
          dir := Q_CopyRange(dir, 0, Q_StrRScan(dir, '\')-2)
     end
end;
procedure RemoveRec(rec:Prec);
begin
	Include(rec.Flags, rfDeletePending);
  MainFormInstance.releaseRecs(true, true);
	reclist.Pack
end;
var       UR:PfileUndoRec;
          i:integer;
          aNode, bNode:PVirtualNode;
          b, proceed:boolean;
          rec2:Prec;
          delDirs:TQ_StringList;
begin
     if tree.SelectedCount=0 then
     exit;

     DelDirs := TQ_Stringlist.create;
     DelDirs.Sorted := true;
     DelDirs.Duplicates := dupIgnore;

     cancelled := false;
     pbar.position := 0;
     pbar.Max := tree.SelectedCount;

     closeBtn.Caption := 'Cancel';
     closeBtn.ModalResult := mrNone;

     goBtn.Enabled := false;
     tree.Enabled := false;

     aNode := tree.GetFirstSelected;
     while (anode <> nil) and not cancelled do
     begin
          application.processmessages;
          pBar.position := pBar.position+1;

          UR := tree.GetNodeData(aNode);
          if UR.canUndo then
          begin
               pLabel.caption := 'Moving ' + UR.newName + ' -> ' + UR.oldName;
               MainFormInstance.forceRepaint(pLabel);

               proceed := true; //=cancel
               b := fileexists(UR.oldName);
               while b do
               begin
                    //filen eksisterer allerede..
                    case MainFormInstance.RenameDialog('File already exists', UR.newName, UR.oldName) of
                         rrRename:  b := fileexists(UR.oldName);
                         rrOverwrite :
                         begin
                              if DelDirsCB.Checked then
                                 AddDelDir(MainFormInstance.getFilePath(UR.oldName), delDirs);
                              b := false;
                              rec2 := MainFormInstance.findInReclist(UR.oldName);
                              if assigned(rec2) then   //fjerner gammel instance
                                 removeRec(rec2)
                         end;
                         rrDelete:  // Delete Source
                         begin
                              if FileDeleteRB(UR.newName) then
                              begin
                                   if DelDirsCB.Checked then
                                      AddDelDir(MainFormInstance.getFilePath(UR.newName), delDirs);
                                   rec2 := MainFormInstance.findInReclist(UR.newName);
                                   if assigned(rec2) then   //fjerner gammel instance
                                      removeRec(rec2)
                              end else MainFormInstance.showmessageX('Could not delete file:' + #13 + UR.newName);
                              b := false;
                              proceed := false
                         end;
                         rrCancel:
                         begin
                              b := false;
                              proceed := false
                         end
                    end
               end;
               if not proceed then
               begin
                    bNode := aNode;
                    aNode := tree.GetNextSelected(aNode);
                    tree.Selected[bNode] := false;
                    continue //næste fil
               end;

               //Flytter filen!
               if forceDirectories(MainFormInstance.getFilePath(UR.oldName)) then
									if MoveFileX(UR.newName, UR.oldName, true) then
                  begin
                       if DelDirsCB.Checked then
                       begin
                            AddDelDir(MainFormInstance.getFilePath(UR.newName), delDirs);
                            AddDelDir(MainFormInstance.getFilePath(UR.oldName), delDirs)
                       end;
                       rec2 := MainFormInstance.findInReclist(UR.newName);
                       if assigned(rec2) then
                       begin
                        BeginSetArtistAlbumFilename;
                        try
                       		setFilename(rec2, UR.oldName, true);
                        	rec2.LastWriteTime := FileAge(UR.OldName)
                        finally
                        	EndSetArtistAlbumFilename
                        end;
                       end
                  end
                  else MainFormInstance.showmessageX('Could not move' + #13 + UR.newName + #13 + 'to' + #13 + UR.oldName)
               else MainFormInstance.showmessageX('Could not move' + #13 + UR.newName + #13 + 'to' + #13 + UR.oldName + #13 + 'Could not create directory' + #13 + MainFormInstance.getFilepath(UR.oldName))
          end; //of if canUndo
     aNode := tree.GetNextSelected(aNode)
     end; //of while
     if cancelled then
        pLabel.Caption := 'Cancelled...'
     else pLabel.Caption := 'Done';
     tree.DeleteSelectedNodes;

     if DelDirsCB.Checked then
     begin
          delDirs.Sorted := false;
          delDirs.CustomSort(sortStringsByLength);
          for i:=0 to deldirs.count-1 do
              if not MainFormInstance.DirInAutoScanList(delDirs.strings[i]) then
                 RemoveDir(delDirs.strings[i]) //sletter biblioteket, men kun hvis det er tomt
		 end;

		 DelDirs.free;

     closeBtn.Caption := 'Close';
     closeBtn.ModalResult := mrOk;

     tree.Enabled := true;
     goBtn.Enabled := true
end;

procedure TundoListForm.closeBtnClick(Sender: TObject);
begin
     if closeBtn.modalResult = mrNone then
        cancelled := true
end;

end.
