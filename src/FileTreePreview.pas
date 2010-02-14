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


unit FileTreePreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, 
  ExtCtrls, VirtualTrees, StdCtrls, Qstrings;

type
  TFilePreviewForm = class(TForm)
    tree: TVirtualStringTree;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ExpandCollapsePanel: TPanel;
    ExpandAll: TButton;
    CollapseAll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure treeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure treeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure treeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure treeCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure ExpandCollapsePanelResize(Sender: TObject);
    procedure ExpandAllClick(Sender: TObject);
    procedure CollapseAllClick(Sender: TObject);
  private
         function findElseCreate(const text:string; const nodeType:byte; const parent:PvirtualNode; const imageIndex:integer=-1):PvirtualNode;
    { Private declarations }
  public
        procedure forceNode(const filePath:string; const musicFile:boolean=true; const imageIndex:integer=-1);
    { Public declarations }
  end;

type
    TfileTreeRec = record
                 text : string;
                 nodeType : byte;
                 imageIndex : integer;
    end;
    PfileTreeRec = ^TfileTreeRec;

Const
     NT_Drive:byte=0;
     NT_Dir:byte=1;
     NT_MusicFile:byte=2;
     NT_OtherFile:byte=3;
var
  FilePreviewForm: TFilePreviewForm;

implementation

uses MainForm;

{$R *.DFM}

function TFilePreviewForm.findElseCreate(const text:string; const nodeType:byte; const parent:PvirtualNode; const imageIndex:integer=-1):PvirtualNode;
var      aNode:PvirtualNode;
         TR:PfiletreeRec;
begin
     result := nil;

     if not (nodeType in [NT_MusicFILE, NT_otherFile]) then
     begin
          aNode := tree.GetFirstChild(parent);

          while aNode <> nil do
          begin
               TR := tree.GetNodeData(aNode);
               if (nodeType=TR.nodeType) and Q_SameText(text, TR.text) then
               begin
                    result := aNode;
                    break //while
               end;
               aNode := tree.GetNextSibling(aNode)
          end
     end;

     if not assigned(result) then
     begin //create node
          result := tree.AddChild(parent);
          TR := tree.GetNodeData(result);
          TR.text := text;
          TR.nodeType := nodeType;
          TR.imageIndex := ImageIndex
     end
end;

procedure TFilePreviewForm.forceNode(const filePath:string; const musicFile:boolean=true; const imageIndex:integer=-1);
var       aNode:PvirtualNode;
          drev, dirs, fname, dir:string;
          i:integer;
begin
     drev := Q_CopyRange(filePath, 0, Q_StrScan(filePath, '\')-2);
     fName := MainFormInstance.GetFileName(filePath);
     dirs := Q_CopyRange(filePath, length(drev)+2, length(filePath)-length(fName)-1);
     //drev node
     aNode := findElseCreate(drev, NT_DRIVE, tree.RootNode);

     //dir nodes:
     while length(dirs)>0 do
     begin
          i := Q_StrScan(dirs, '\');
          if i>0 then
          begin
               dir := Q_CopyRange(dirs, 0, i-2);
               Q_CutLeft(dirs, length(dir)+1)
          end else
          begin
               dir := dirs;
               dirs := ''
          end;
          aNode := findElseCreate(dir, NT_DIR, aNode)
     end;

     //fileNode
     if musicFile then
        findElseCreate(fName, NT_MusicFILE, aNode)
     else findElseCreate(fName, NT_OtherFile, aNode, imageIndex)
end;

procedure TFilePreviewForm.FormCreate(Sender: TObject);
begin
     Icon := MainFormInstance.Icon1.picture.icon;
     tree.NodeDataSize := sizeOf(TfileTreeRec)
end;

procedure TFilePreviewForm.treeFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
     finalize(PfileTreeRec(Sender.GetNodeData(Node))^)
end;

procedure TFilePreviewForm.treeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
begin
     CellText := PfileTreeRec(sender.GetNodeData(Node)).text
end;

procedure TFilePreviewForm.treeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var   TR:PfileTreeRec;
begin
     TR := sender.GetNodeData(Node);
     if TR.imageIndex >= 0 then
        ImageIndex := TR.imageIndex
     else
     if TR.nodeType = NT_DIR then
        if sender.Expanded[Node] then
           imageIndex := 15
        else imageIndex := 14
     else if TR.nodeType = NT_DRIVE then
          imageIndex := 16
     else if TR.nodeType = NT_MusicFILE then
          imageIndex := 19
end;

procedure TFilePreviewForm.treeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var      TR1, TR2:PfileTreeRec;
begin
     TR1 := Sender.GetNodeData(Node1);
     TR2 := Sender.GetNodeData(Node2);

     if TR1.nodeType = TR2.nodeType then
        result := Q_CompText(TR1.Text, TR2.Text)
     else
     if (TR1.nodeType=NT_DIR) and (TR2.nodeType in [NT_MusicFILE, NT_OtherFile]) then
        result := -1 else
     if (TR1.nodeType in [NT_MusicFILE, NT_OtherFile]) and (TR2.nodeType=NT_DIR) then
        result := 1 else
     if (TR1.nodeType = NT_MusicFILE) and (TR2.nodeType = NT_OtherFile) then
        result := 1 else
     if (TR1.nodeType = NT_OtherFile) and (TR2.nodeType = NT_MusicFILE) then
        result := -1
end;


procedure TFilePreviewForm.ExpandCollapsePanelResize(Sender: TObject);
begin
     ExpandAll.Width := ExpandCollapsePanel.ClientWidth div 2;
     CollapseAll.Left := ExpandAll.Width;
     CollapseAll.Width := ExpandAll.Width
end;

procedure TFilePreviewForm.ExpandAllClick(Sender: TObject);
var       aNode:PvirtualNode;
begin
     tree.Beginupdate;
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          tree.Expanded[aNode] := true;
          aNode := tree.GetNext(aNode)
     end;
     tree.EndUpdate
end;

procedure TFilePreviewForm.CollapseAllClick(Sender: TObject);
var       aNode:PvirtualNode;
begin
     tree.Beginupdate;
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          tree.Expanded[aNode] := false;
          aNode := tree.GetNext(aNode)
     end;
     tree.EndUpdate
end;

end.


