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


unit DubWiz;

interface

uses
	Windows, Classes, sysUtils, Controls, Forms, Graphics, QStringList,
	VirtualTrees, QStrings, ComCtrls, StdCtrls, ExtCtrls, WAIPC, Spin, FileCtrl,
  Menus, ImgList,
  MEXPtypes;

type
    TscanLevel = (slCRC, slArtistTitle1, slArtistTitleFuzzy, slArtistTitleSoundex, slTitle, slFinished);

type
  TDubWizForm = class(TForm)
    tree: TVirtualStringTree;
    pop: TPopupMenu;
    Checkallduplicatesinthisdirectory1: TMenuItem;
    Panel1: TPanel;
    pBar: TProgressBar;
    Panel2: TPanel;
    p1Label: TLabel;
    Marklabel: TLabel;
    p2Label: TLabel;
    p6Label: TLabel;
    Panel4: TPanel;
    Panel3: TPanel;
    DeleteButton: TButton;
    NextPhaseBtn: TButton;
    AutoCheckButton: TButton;
    deselectAllBtn: TButton;
    ShowNumbersCB: TCheckBox;
    CloseBtn: TButton;
    p5Label: TLabel;
    showArtistCB: TCheckBox;
    PrevPhaseBtn: TButton;
    p3Label: TLabel;
    UseTimeDiff: TCheckBox;
    TimeDiff: TSpinEdit;
    msLabel: TLabel;
    Button1: TButton;
    SFlabel: TLabel;
    DelDirsCB: TCheckBox;
    ShowArtistTitleCB: TCheckBox;
    images: TImageList;
    p4Label: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure treeCollapsing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var Allowed: Boolean);
    procedure treePaintText(Sender: TBaseVirtualTree;
      const Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure treeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure FormCreate(Sender: TObject);
    procedure treeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure treeCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure Checkallduplicatesinthisdirectory1Click(Sender: TObject);
    procedure popPopup(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure NextPhaseBtnClick(Sender: TObject);
    procedure showArtistCBClick(Sender: TObject);
    procedure AutoCheckButtonClick(Sender: TObject);
    procedure deselectAllBtnClick(Sender: TObject);
    procedure ShowNumbersCBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure PrevPhaseBtnClick(Sender: TObject);
    procedure treeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FormDestroy(Sender: TObject);
    procedure treeDblClick(Sender: TObject);
    procedure UseTimeDiffClick(Sender: TObject);
    procedure ShowArtistTitleCBClick(Sender: TObject);
    procedure treeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
 private
         currentScanLevel : TScanLevel;
         playedOnce:boolean;
         procedure play(s:string);
         function getFtextP(p:pointer; field:integer):string;
    { Private declarations }
  public
//        dbindex:integer;
        list : TList; //liste over de recs der skal søges i
        spaceFreed:cardinal;
        FFHighestBitrate : Integer;
        DeleteCancelled : boolean;
        Procedure ScanDubs(level:TscanLevel);
        Procedure UpdateSpaceFreedLabel;
    { Public declarations }
  end;

type
TNodeKind = (nkArtist, nkTitle, nkArtistTitle, nkFile, nkQuality);

Ttrec = record
      ref  : pointer;
      kind : TNodeKind;
end;
Ptrec = ^Ttrec;

TnodePointer = record
      sameArtistInDir:integer;
      alreadyChecked:boolean;
      r  : pointer;
      node : PVirtualNode;
end;
PnodePointer = ^TnodePointer;

var
  DubWizForm: TDubWizForm;

implementation
 uses MainForm, defs, delfiles;

const CancelText:String='C&ancel';
      DeleteText:String='&Delete checked files';

{$R *.DFM}

procedure TDubWizForm.play(s:string);
begin
     if fileexists(s) then
     with MainFormInstance do
     begin
          if not playedOnce then
             SaveWinplayUndo;
          playedOnce := true;
          winplaylist.clear;
          WinplayInsertFname(s, nil, amNowhere, kill_NONE, false, false);
          winplaySave(0);
          button2(hwnd_winamp)
     end
end;

Procedure TDubWizForm.UpdateSpaceFreedLabel;
begin
     SFlabel.caption := 'Space freed: ' + floattoStrF(SpaceFreed div 1024,ffnumber,8,0) + ' kb'
end;

function TDubWizForm.getFtextP(p:pointer; field:integer):string;
begin
     result := MainFormInstance.GetFTExtP(p, field)
end;

function CompareCRC(Item1, Item2: Pointer): integer;
begin
     result := CompCardinal(Prec(Item1).CRC,  Prec(Item2).CRC);
     if result=0 then
        result := Prec(Item1).Fpath - Prec(Item2).FPath; //CompInteger(Prec(Item1).Fpath, Prec(Item2).Fpath);
     if result=0 then
        result := GetOneOrZero(Q_CompText(MainFormInstance.GetFtextP(Item1, fTitle), MainFormInstance.GetFtextP(Item2, fTitle)));
end;

function CompareArtistTitle(Item1, Item2: Pointer): integer;
begin
     if (Q_PosText(MainFormInstance.GetFtextP(Item1, fArtist), MainFormInstance.GetFtextP(Item2, fArtist))>0) or (Q_PosText(MainFormInstance.GetFtextP(Item2, fArtist), MainFormInstance.GetFtextP(Item1, fArtist))>0) then
        result := 0
     else
     result := GetOneOrZero(Q_CompText(MainFormInstance.GetFtextP(Item1, fArtist), MainFormInstance.GetFtextP(Item2, fArtist)));
     if result=0 then
        result := GetOneOrZero(Q_CompText(MainFormInstance.GetFtextP(Item1, fTitle), MainFormInstance.GetFtextP(Item2, fTitle)))
end;

function CompareTitle(Item1, Item2: Pointer): integer;
begin
     result := GetOneOrZero(Q_CompText(MainFormInstance.GetFtextP(Item1, fTitle), MainFormInstance.GetFtextP(Item2, fTitle)))
end;

Procedure TDubWizForm.ScanDubs(Level:TscanLevel);
function GetNodeWithArtist(text:string):PvirtualNode;
var      aNode:PVirtualNode;
         TR:Ptrec;
begin
     result := nil;
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          TR := tree.GetNodeData(aNode);
          if (TR.kind=nkArtist) and Q_SameText(text, getFtextP(TR.ref, fArtist)) then
          begin
               result := aNode;
               break
          end;
          aNode := tree.GetNext(aNode)
     end
end;

function AddToTree(parentNode:PVirtualNode; var titleNode:PVirtualNode; const rec:Prec; showArtist:boolean):PVirtualNode;
var      TR:Ptrec;
         qNode:PVirtualNode;
begin
     if (parentNode=nil) and (titleNode=nil) and showArtist then
        parentNode := GetNodeWithArtist(getFtextP(rec, fArtist));
     if (parentNode=nil) and (titleNode=nil) and showArtist then //lav ny artistNode
     begin
          parentNode := tree.AddChild(nil);
          tree.CheckType[parentNode] := ctTriStateCheckBox;
          TR := tree.GetNodeData(parentNode);
          TR.ref := rec;
          TR.kind := nkArtist
     end;

     if titleNode=nil then
     begin
          titleNode := tree.AddChild(parentNode);
          tree.CheckType[titleNode] := ctTriStateCheckBox;
          TR := tree.GetNodeData(titleNode);
          TR.ref := rec;
          TR.kind := nkTitle
     end;

     result := tree.AddChild(titleNode);
     tree.CheckType[result] := ctCheckbox;
     TR := tree.GetNodeData(result);
     TR.ref := rec;
     TR.kind := nkFile;

     qNode := tree.AddChild(result);
     TR := tree.GetNodeData(qNode);
     TR.ref := rec;
     TR.kind := nkArtistTitle;
     tree.isVisible[qNode] := ShowArtistTitleCB.checked;

     qNode := tree.AddChild(result);
     TR := tree.GetNodeData(qNode);
     TR.ref := rec;
     TR.kind := nkQuality
end;

function CheckTimeDiff(const p1, p2:PREC; const value:integer):boolean;
var      i:int64;
begin
  if UseTimeDiff.Checked then
  begin
    i := int64(p1.length) - int64(p2.length);
    if i < 0 then
       i := i*-1;
    result := i <= value
  end
  	else result := true
end;

function CompareArtistTitle2(const s1, s2:String):boolean;
begin
	if (length(s1)<=3) or (length(s2)<=3) then
    result := false
  else
  	result := (Q_PosStr(s1, s2)>0) or (Q_PosStr(s2, s1)>0)
end;
var
  i, k, compI, value:integer;
  titleNode:pVirtualNode;
  sortlist, helpList: TList;
  ShowArtist, oneAdded:boolean;
  StrArr: array of array[0..1] of String;
begin
     screen.cursor := crHourglass;

     value := TimeDiff.Value;

     showArtistCB.enabled := level <> slTitle;
     autoCheckButton.Enabled := level <> slTitle;
     showArtist := showArtistCB.Enabled and showArtistCB.checked;
     tree.BeginUpdate;
     tree.clear;
     //laver sortlist:
     sortList := Tlist.create;
     sortList.Count := list.Count;
     for i:=0 to list.count-1 do
     	 sortList.Items[i] := list.Items[i];

     if level = slCRC then
     begin
          sortList.Sort(CompareCRC);
          //fjerner alle der ikke er dupes
          for i:=sortlist.count-1 downto 0 do
          begin
               if (Prec(sortlist.items[i]).crc = -1) or (Prec(sortlist.items[i]).crc = 0) or (not (((i>0) and (Prec(sortlist.items[i]).crc = Prec(sortList.items[i-1]).crc)) or ((i<sortlist.count-1) and (Prec(sortlist.items[i]).crc = Prec(sortList.items[i+1]).crc)))) then
                  sortList.delete(i)
          end;
          i := 0;
          while i < sortlist.count do
          begin
               titleNode := nil;
               compI := i;
               while (i<sortlist.count) and (Prec(sortList.items[i]).CRC=Prec(sortlist.Items[compI]).CRC) do
               begin
                    AddToTree(nil, titleNode, sortList.items[i], showArtist);
                    inc(i)
               end
          end
     end else
     if level = slArtistTitle1 then
     begin
          sortList.Sort(CompareArtistTitle);
          //fjerner alle der ikke er dupes
          for i:=sortlist.count-1 downto 0 do
          begin
               if not (((i>0) and CheckTimeDiff(sortlist.items[i], sortlist.items[i-1], value) and Q_SameText(GetFtextP(sortlist.items[i], fArtist), GetFtextP(sortlist.items[i-1], fArtist)) and Q_SameText(GetFtextP(sortlist.items[i], fTitle), GetFtextP(sortlist.items[i-1], fTitle))) or ((i<sortlist.count-1) and CheckTimeDiff(sortlist.items[i], sortlist.items[i+1], value) and Q_SameText(GetFtextP(sortlist.items[i], fArtist), GetFtextP(sortlist.items[i+1], fArtist)) and  Q_SameText(GetFtextP(sortlist.items[i], fTitle), GetFtextP(sortlist.items[i+1], fTitle)))) then
                  sortList.delete(i)
          end;
          i := 0;
          while i < sortlist.count do
          begin
               titleNode := nil;
               compI := i;
               while (i<sortlist.count) and CheckTimeDiff(sortlist.items[i], sortlist.items[compI], value) and Q_SameText(GetFtextP(sortlist.items[i], fArtist), GetFtextP(sortlist.items[compI], fArtist)) and Q_SameText(GetFtextP(sortlist.items[i], fTitle), GetFtextP(sortlist.items[compI], fTitle)) do
               begin
                    AddToTree(nil, titleNode, sortList.items[i], showArtist);
                    inc(i)
               end
          end
     end else
     if level = slArtistTitleFuzzy then    //Fuzzy match
     begin
          setLength(strArr, sortList.count);
          for i:=0 to sortList.count-1 do
          begin
               strArr[i][0] := (GetFuzzyText(getFtextP(sortList.items[i], FArtistSortOrder)));
               strArr[i][1] := (GetFuzzyText(getFtextP(sortList.items[i], FTitle)))
          end;
          helpList := Tlist.create;
          for i:=0 to sortList.count-1 do
          if assigned(sortList.items[i]) then
          begin
               oneAdded := false;
               for k:=i+1 to sortList.count-1 do
               if assigned(sortList.items[k]) then
               begin
                    if CheckTimeDiff(sortList.items[i], sortList.items[k], value) and CompareArtistTitle2(strArr[i][0], strArr[k][0]) and CompareArtistTitle2(strArr[i][1], strArr[k][1]) then
                       if oneAdded then
                       begin
                            helpList.add(sortList.items[k]);
                            sortList.items[k] := nil
                       end
                       else
                       begin
                            helpList.add(sortList.items[i]);
                            helpList.add(sortList.items[k]);
                            sortList.items[k] := nil;
                            oneAdded := true
                       end
               end;
               sortList.items[i] := nil
          end;
          setLength(strArr, helpList.count);
          for i:=0 to helpList.count-1 do
          begin
               strArr[i][0] := (GetFuzzyText(getFtextP(helpList.items[i], FArtistSortOrder)));
               strArr[i][1] := (GetFuzzyText(getFtextP(helpList.items[i], fTitle)))
          end;
          i := 0;
          while i < helpList.count do
          begin
               titleNode := nil;
               compI := i;
               while (i<helpList.count) and CheckTimeDiff(helpList.items[i], helpList.items[compI], value) and CompareArtistTitle2(strArr[i][0], strArr[compI][0]) and CompareArtistTitle2(strArr[i][1], strArr[compI][1]) do
               begin
                    AddToTree(nil, titleNode, helpList.items[i], showArtist);
                    inc(i)
               end
          end;
          setLength(strArr, 0);
          helpList.free
     end else
     if level = slArtistTitleSoundex then    //Soundex match
     begin
          setLength(strArr, sortList.count);
          for i:=0 to sortList.count-1 do
          begin
            // TODO: implement this - perhaps using Levenshtein instead of soundex
            // strArr[i][0] := Soundex(getFtextP(sortList.items[i], FArtistSortOrder), 8);
            // strArr[i][1] := Soundex(getFtextP(sortList.items[i], fTitle), 8)
          end;
          helpList := Tlist.create;
          for i:=0 to sortList.count-1 do
          if assigned(sortList.items[i]) then
          begin
               oneAdded := false;
               for k:=i+1 to sortList.count-1 do
               if assigned(sortList.items[k]) then
               begin
                    if CheckTimeDiff(sortList.items[i], sortList.items[k], value) and Q_SameStrL(strArr[i][0], strArr[k][0], 8) and Q_SameStrL(strArr[i][1], strArr[k][1], 8) then
                       if oneAdded then
                       begin
                            helpList.add(sortList.items[k]);
                            sortList.items[k] := nil
                       end
                       else
                       begin
                            helpList.add(sortList.items[i]);
                            helpList.add(sortList.items[k]);
                            sortList.items[k] := nil;
                            oneAdded := true
                       end
               end;
               sortList.items[i] := nil
          end;
          setLength(strArr, helpList.count);
          for i:=0 to helpList.count-1 do
          begin
            // TODO: implement this - perhaps using Levenshtein instead of soundex
            //strArr[i][0] := Soundex(getFtextP(helpList.items[i], FArtistSortOrder), 8);
            //strArr[i][1] := Soundex(getFtextP(helpList.items[i], fTitle), 8)
          end;
          i := 0;
          while i < helpList.count do
          begin
               titleNode := nil;
               compI := i;
               while (i<helpList.count) and CheckTimeDiff(helpList.items[i], helpList.items[compI], value) and Q_SameStr(strArr[i][0], strArr[compI][0]) and Q_SameStr(strArr[i][1], strArr[compI][1]) do
               begin
                    AddToTree(nil, titleNode, helpList.items[i], showArtist);
                    inc(i)
               end
          end;
          setLength(strArr, 0);
          helpList.free
     end else
     if level = slTitle then
     begin
          sortList.Sort(CompareTitle);
          //fjerner alle der ikke er dupes
          for i:=sortlist.count-1 downto 0 do
          begin
               if not (((i>0) and CheckTimeDiff(sortList.items[i], sortList.items[i-1], value) and Q_SameText(GetFtextP(sortlist.items[i], fTitle), GetFtextP(sortlist.items[i-1], fTitle))) or ((i<sortlist.count-1) and CheckTimeDiff(sortList.items[i], sortList.items[i+1], value) and Q_SameText(GetFtextP(sortlist.items[i], fTitle), GetFtextP(sortlist.items[i+1], fTitle)))) then
                  sortList.delete(i)
          end;
          i := 0;
          while i < sortlist.count do
          begin
               titleNode := nil;
               compI := i;
               while (i<sortlist.count) and CheckTimeDiff(sortList.items[i], sortList.items[compI], value) and  Q_SameText(GetFtextP(sortlist.items[i], fTitle), GetFtextP(sortlist.items[compI], fTitle)) do
               begin
                    AddToTree(nil, titleNode, sortList.items[i], showArtist);
                    inc(i)
               end
          end
     end;

     sortList.free;
     tree.SortTree(0, sdAscending);
     tree.ReinitNode(nil, true); //expander alle files, så quality vises som default
     tree.EndUpdate;
     screen.cursor := crDefault;
     if (tree.RootNodeCount = 0) and (level = slCRC) then
     		NextPhaseBtnClick(nil)
end;

procedure TDubWizForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        modalresult :=  mrok
end;

procedure TDubWizForm.Button1Click(Sender: TObject);
begin
     scanDubs(currentScanLevel)
end;

procedure TDubWizForm.treeCollapsing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var Allowed: Boolean);
begin
        allowed := false;
end;

procedure TDubWizForm.treePaintText(Sender: TBaseVirtualTree;
  const Canvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
     if sender.Selected[Node] then
        canvas.font.color := clWhite
     else if Ptrec(sender.GetNodeData(Node)).kind = nkArtist then
        canvas.font.color := clNavy
     else if Ptrec(sender.GetNodeData(Node)).kind = nkTitle then
        canvas.font.color := clRed
     else if Ptrec(sender.GetNodeData(Node)).kind = nkFile then
        canvas.font.color := clBlack
     else if Ptrec(sender.GetNodeData(Node)).kind = nkQuality then
        canvas.font.color := clGray
     else if Ptrec(sender.GetNodeData(Node)).kind = nkArtistTitle then
        canvas.font.color := 00408000
end;

procedure TDubWizForm.treeInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
     if Ptrec(sender.GetNodeData(Node)).kind = nkFile then
         Include(InitialStates, IvsExpanded)
end;

procedure TDubWizForm.FormCreate(Sender: TObject);
begin
     Icon := MainFormInstance.Icon1.picture.icon;
     List := Tlist.create;
     spaceFreed := 0;
     CurrentScanLevel := slCRC;
     tree.NodeDataSize := SizeOf(Ttrec);
     DeleteButton.Caption := DeleteText;
     DeleteCancelled := false;
     playedOnce := false
end;

procedure TDubWizForm.treeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
function ChildCheckedCount:integer;
var      aNode:PVirtualNode;
begin
     result := 0;
     aNode := sender.GetFirstChild(Node);
     while aNode <> nil do
     begin
          if sender.CheckState[aNode] <> csUncheckedNormal then
             inc(result);
          aNode := sender.GetNextSibling(aNode)
     end
end;
var   TR:Ptrec;
begin
     TR := sender.GetNodeData(Node);
     if TR.kind = nkArtist then
        CellText := getFtextP(TR.ref, fArtist)
     else
     if TR.kind = nkTitle then
        CellText := getFtextP(TR.ref, fTitle)
     else
     if TR.kind = nkFile then
        CellText := getFtextP(TR.ref, fFilename)
     else
     if TR.kind = nkArtistTitle then
        CellText := getFtextP(TR.ref, fartistTitle)
     else
     if TR.kind = nkQuality then
        CellText := getFtextP(TR.ref, fQuality) + ' - ' + getFtextP(TR.ref, fLength) + ' sec. - ' + getFtextP(TR.ref, ffSize) + ' kb';

     if ShowNumbersCB.checked and (column<>255) and (sender.ChildCount[Node]>0) then //der kaldes fra IKKE CompareNodes
        CellText := '(' + inttostr(ChildCheckedCount) + '/' + inttostr(sender.ChildCount[Node]) + ') ' + CellText;
end;

procedure TDubWizForm.treeCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var      w1, w2:WideString;
begin
     if (Ptrec(sender.GetNodeData(Node1)).kind = nkQuality) and (Ptrec(sender.GetNodeData(Node2)).kind = nkArtistTitle)
        then result := 1
     else
     if (Ptrec(sender.GetNodeData(Node2)).kind = nkQuality) and (Ptrec(sender.GetNodeData(Node1)).kind = nkArtistTitle)
        then result := -1
     else
     begin
          treeGetText(sender, Node1, 255, ttNormal, w1);
          treeGetText(sender, Node2, 255, ttNormal, w2);
          result := Q_CompText(w1, w2)
     end
end;

procedure TDubWizForm.Checkallduplicatesinthisdirectory1Click(
  Sender: TObject);
var       aNode:PVirtualNode;
          dir:String;
begin
     if tree.SelectedCount<>1 then exit;
     aNode := tree.GetFirstSelected;
     if Ptrec(tree.GetNodeData(aNode)).kind <> nkFile then exit;
     dir := GetFtextP(Ptrec(tree.GetNodeData(aNode)).ref, fFilePath);
     tree.Beginupdate;
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          if (Ptrec(tree.GetNodeData(aNode)).kind=nkFile) and Q_SameText(dir, GetFtextP(Ptrec(tree.GetNodeData(aNode)).ref, fFilePath)) then
             tree.CheckState[aNode] := csCheckedNormal;
          aNode := tree.GetNext(aNode)
     end;
     tree.Endupdate
end;

procedure TDubWizForm.popPopup(Sender: TObject);
begin
     Checkallduplicatesinthisdirectory1.visible := tree.SelectedCount=1;
     if not Checkallduplicatesinthisdirectory1.visible then exit;
     Checkallduplicatesinthisdirectory1.visible := Ptrec(tree.GetNodeData(tree.GetFirstSelected)).kind = nkFile
end;

function sortStringsByLength(List: TQ_StringList; Index1, Index2: Integer): Integer;
begin
	result := length(list.strings[index2]) - length(list.strings[index1])
end;

procedure TDubWizForm.DeleteButtonClick(Sender: TObject);
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
var       aNode, bNode:PVirtualNode;
          TR:Ptrec;
          status:string;
          i:integer;
          exists:boolean;
          fileList:TQ_Stringlist;
          DelDirs:TQ_StringList;
begin
     if Q_SameText(DeleteButton.Caption, CancelText) then
     begin
          DeleteCancelled := true;
          exit
     end;
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          TR := tree.GetNodeData(aNode);
          if (TR.kind=nkTitle) and (tree.CheckState[aNode]=csCheckedNormal) then
          begin //alle titler på én sang er markerede!
               tree.ClearSelection;
               tree.FullyVisible[aNode] := true;
               tree.Selected[aNode] := true;
               tree.Expanded[aNode] := true;
               if not MainFormInstance.YesNoBoxx('Warning!', 'All files titled "' + getFtextP(TR.ref, fTitle) + '" has been selected for deleting. Continue?', 'Delete all', 'Cancel', 2) then
                  exit //der er valgt cancel
          end;
          aNode := tree.GetNext(aNode)
     end;
     //Finder count
     fileList := TQ_Stringlist.create;
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          TR := tree.GetNodeData(aNode);
          if (TR.kind=nkFile) and (tree.CheckState[aNode]=csCheckedNormal) then
             fileList.Add(getFtextP(TR.ref, fFilename));
          aNode := tree.GetNext(aNode)
     end;
     //eo Finder Count
     if fileList.Count=0 then
     begin
          fileList.free;
          exit
     end;
     fileList.sort;
     Application.CreateForm(Tdeletefromhd, deletefromhd);
     deletefromhd.files.clear;
     deletefromhd.files.Items.AddStrings(fileList);
     fileList.Free;

     delDirs := TQ_Stringlist.create;
     DelDirs.Sorted := true;
     DelDirs.Duplicates := dupIgnore;

     CurrentActiveForm := deleteFromHd;
     if deletefromhd.ShowModal = mryes then
     begin
          //Sletter:
          screen.cursor := crAppStart;
          closeBtn.Enabled := false;
          autoCheckButton.Enabled := false;
          NextPhaseBtn.Enabled := false;
          deselectAllBtn.Enabled := false;
          PrevPhaseBtn.Enabled := false;

          pBar.Max := deleteFromHD.files.Items.Count;
          pBar.position := 0;
          tree.beginUpdate;
          status := '';
          DeleteButton.Caption := CancelText;
          aNode := tree.GetFirst;
          while (aNode <> nil) and not DeleteCancelled do
          begin
               TR := tree.GetNodeData(aNode);
               if (TR.kind=nkFile) and (tree.CheckState[aNode]=csCheckedNormal) then
               begin
                    SFlabel.Caption := 'Deleting ' + getFtextP(TR.ref, fFilename);
                    MainFormInstance.forceRepaint(SFlabel);
                    pBar.Position := pBar.Position+1;
                    exists := fileexists(getFtextP(TR.ref, fFilename));
                    if exists and MainFormInstance.isPlayingInWinamp(getFtextP(TR.ref, fFilename)) then
                       button4(hWnd_WinAmp); //stop
                    if not exists or FileDeleteRB(getFtextP(TR.ref, fFilename)) then
                    begin
                         if exists then
                         begin
                              inc(SpaceFreed, Prec(TR.ref).fsize);
                              if DelDirsCB.checked then
                                 AddDelDir(getFtextP(TR.ref, fFilePath), DelDirs)
                         end;
                         updateSpaceFreedLabel;
                         Include(PRec(Tr.Ref).Flags, rfDeletePending);
                         //MainFormInstance.releaseRec(TR.ref, true);
                         list.Delete(list.IndexOf(TR.ref));
                         //reclist.Delete(reclist.indexOf(TR.ref));

                         bNode := tree.GetNext(aNode);
                         while assigned(bNode) and (bNode.Parent = aNode) do
                               bNode := tree.GetNext(bNode);

                         tree.DeleteNode(aNode);
                         aNode := bNode
                    end else
                    begin
                         status := status + 'Could not delete ' + getFtextP(TR.ref, fFilename) + #13#13;
                         aNode := tree.GetNext(aNode)
                    end
               end else
               aNode := tree.GetNext(aNode);
               application.processmessages //checked om Cancel er blevet trykket
          end;
          tree.endUpdate;

          if DelDirsCB.checked then
          begin
               SFlabel.Caption := 'Deleting direcotries...';
               MainFormInstance.forceRepaint(SFlabel);
               delDirs.Sorted := false;
               delDirs.CustomSort(sortStringsByLength);
               for i:=0 to delDirs.Count-1 do
                   if not MainFormInstance.DirInAutoScanList(delDirs.strings[i]) then
                      removeDir(delDirs.strings[i])
          end;

          delDirs.Free;

          screen.cursor := crDefault;
          if not DeleteCancelled then
             ScanDubs(currentScanLevel);
          DeleteCancelled := false;
          DeleteButton.Caption := DeleteText;
          if length(status)>0 then
          begin
               Q_CutRight(status, 2);//klipper #13#13 fra
               MainFormInstance.showmessageX(status)
          end
     end; //of sletter
     MainFormInstance.ReleaseRecs(true, true);
     reclist.Pack;
     deleteFromHD.files.Items.Clear;
     CurrentActiveForm := self;
     deleteFromHD.Release;
     FreeAndNil(DeleteFromHD);
     closeBtn.Enabled := true;
     PrevPhaseBtn.Enabled := currentScanLevel <> slCRC;
     autoCheckButton.Enabled := not (currentScanLevel in [slTitle, slFinished]);
     NextPhaseBtn.Enabled := currentScanLevel <> slFinished;
     deselectAllBtn.Enabled := currentScanLevel <> slFinished;
     DeleteButton.Enabled := currentScanLevel <> slFinished;
     SFlabel.Caption := 'Done'
end;

procedure TDubWizForm.showArtistCBClick(Sender: TObject);
begin
     ScanDubs(currentScanLevel)
end;
  
function doAutoSort(Item1, Item2: Pointer): Integer;
function getbitrate(p:PnodePointer):integer;
begin
     result := abs(Prec(p.r).kbps)
end;
var  p1, p2:PnodePointer;
{ første kriterie er, om den er checked af brugeren i forvejen. Næste er kvalitet, og sidst er antallet af filer af samme artist i biblioteket}
begin
     result := 0;
     p1 := item1;
     p2 := item2;
     if p1.alreadyChecked and not p2.alreadyChecked then
     begin
          result := 1;
          exit
     end;
     if p2.alreadyChecked and not p1.alreadyChecked then
     begin
          result := -1;
          exit
     end;
     //test kvalitet, bitrate
     if getBitrate(p1)>getBitrate(p2) then
     begin
          result := -1;
          exit
     end;
     if getBitrate(p1)<getBitrate(p2) then
     begin
          result := 1;
          exit
     end;
     if p1.sameArtistInDir>p2.sameArtistInDir then
     begin
          result := -1;
          exit
     end;
     if p1.sameArtistInDir<p2.sameArtistInDir then
     begin
          result := 1;
          exit
     end;
     if (Q_PosText(MainFormInstance.getFtextP(p1.r, fArtist), MainFormInstance.getFtextP(p1.r, fFilePath))>0) and (Q_PosText(MainFormInstance.getFtextP(p2.r, fArtist), MainFormInstance.getFtextP(p2.r, fFilePath))=0) and (Q_PosText(MainFormInstance.getFtextP(p1.r, fAlbum), MainFormInstance.getFtextP(p1.r, fFilePath))>0) and (Q_PosText(MainFormInstance.getFtextP(p2.r, fAlbum), MainFormInstance.getFtextP(p2.r, fFilePath))=0) then
     begin
          result := -1;
          exit
     end;
     if (Q_PosText(MainFormInstance.getFtextP(p1.r, fArtist), MainFormInstance.getFtextP(p1.r, fFilePath))=0) and (Q_PosText(MainFormInstance.getFtextP(p2.r, fArtist), MainFormInstance.GetFtextP(p2.r, fFilePath))>0) and (Q_PosText(MainFormInstance.getFtextP(p1.r, fAlbum), MainFormInstance.getFtextP(p1.r, fFilePath))=0) and (Q_PosText(MainFormInstance.getFtextP(p2.r, fAlbum), MainFormInstance.GetFtextP(p2.r, fFilePath))>0) then
     begin
          result := 1;
          exit
     end;
     if (Q_PosText(MainFormInstance.getFtextP(p1.r, fArtist), MainFormInstance.getFtextP(p1.r, fFilePath))>0) and (Q_PosText(MainFormInstance.getFtextP(p2.r, fArtist), MainFormInstance.getFtextP(p2.r, fFilePath))=0) then
     begin
          result := -1;
          exit
     end;
     if (Q_PosText(MainFormInstance.getFtextP(p1.r, fArtist), MainFormInstance.getFtextP(p1.r, fFilePath))=0) and (Q_PosText(MainFormInstance.getFtextP(p2.r, fArtist), MainFormInstance.GetFtextP(p2.r, fFilePath))>0) then
     begin
          result := 1;
          exit
     end
end;

procedure TDubWizForm.AutoCheckButtonClick(Sender: TObject);
procedure CleanList(lst:Tlist);
var       i:integer;
begin
     for i:=0 to lst.count-1 do
         dispose(PnodePointer(lst.items[i]));
     lst.clear
end;

function GetSameArtistInDir(r:Prec):integer;
var      dir, artist:string;
         i:integer;
begin
     result := 0;
     dir := getFtextP(r, fFilePath);
     artist := getFtextP(r, fArtist);
     for i:=0 to reclist.Count-1 do
     begin
          if (reclist.List^[i]<>r) and Q_SameText(dir, getFtextP(reclist.List^[i], fFilePath)) and Q_SameText(artist, getFtextP(reclist.List^[i], fArtist)) then
             inc(result)
     end
end;
var       p:PnodePointer;
          lst:Tlist;
          aNode, fNode:PVirtualNode;
          TR:Ptrec;
          i:integer;
{Der oprettes en liste for hver title, hvor alle sange er i. Derefter sorteres listen efter en algorit. og det øverste element bliver ikke valgt, resten gør}
begin
     screen.cursor := crHourglass;
     lst := Tlist.create;
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          TR := tree.GetNodeData(aNode);
          if TR.kind = nkTitle then
          begin
               fNode := tree.GetFirstChild(aNode);
               while fNode <> nil do
               begin
                    TR := tree.GetNodeData(fNode);
                    if TR.kind = nkFile then
                    begin
                         new(p);
                         fillChar(p^, sizeOf(p^), #0);
                         p.sameArtistInDir := 0;
                         p.alreadyChecked := tree.CheckState[fNode] = csCheckedNormal;
                         p.r := TR.ref;
                         p.node := fNode;
                         lst.Add(p)
                    end;
                    fNode := tree.GetNextSibling(fNode)
               end;
               for i:=0 to lst.count-1 do
               begin
                    p := lst.Items[i];
                    if not p.alreadyChecked then
                       p.sameArtistInDir := GetSameArtistInDir(p.r)
               end;
               lst.Sort(doAutoSort);
               for i:=1 to lst.count-1 do
               begin
                    p := lst.items[i];
                    tree.CheckState[p.node] := csCheckedNormal
               end;
               CleanList(lst);
          end;
          aNode := tree.GetNext(aNode)
     end;
     lst.free;
     screen.cursor := crDefault
end;


procedure TDubWizForm.deselectAllBtnClick(Sender: TObject);
var       aNode:PVirtualNode;
begin
     with tree do
     begin
          BeginUpdate;
          aNode := GetFirst;
          while aNode <> nil do
          begin
               checkState[aNode] := csUncheckedNormal;
               aNode := GetNext(aNode)
          end;
          Endupdate
     end
end;

procedure TDubWizForm.ShowNumbersCBClick(Sender: TObject);
begin
     tree.repaint
end;

procedure TDubWizForm.FormShow(Sender: TObject);
begin
     UpdateSpaceFreedLabel;
     PrevPhaseBtn.Enabled := currentScanLevel <> slCRC;
     autoCheckButton.Enabled := not (currentScanLevel in [slTitle, slFinished]);
     NextPhaseBtn.Enabled := currentScanLevel <> slFinished;
     deselectAllBtn.Enabled := currentScanLevel <> slFinished;
     DeleteButton.Enabled := currentScanLevel <> slFinished
end;

procedure TDubWizForm.CloseBtnClick(Sender: TObject);
begin
     modalResult := mrOk
end;

procedure TDubWizForm.NextPhaseBtnClick(Sender: TObject);
begin
     if currentScanLevel = slCRC then
     begin
          currentScanLevel := slArtistTitle1;
          markLabel.top := p2Label.top-2
     end else
     if currentScanLevel = slArtistTitle1 then
     begin
          currentScanLevel := slArtistTitleFuzzy;
          markLabel.top := p3Label.top-2
     end else
     if currentScanLevel = slArtistTitleFuzzy then
     begin
          currentScanLevel := slArtistTitleSoundex;
          markLabel.top := p4Label.top-2
     end else
     if currentScanLevel = slArtistTitleSoundex then
     begin
          currentScanLevel := slTitle;
          markLabel.top := p5Label.top-2
     end else
     begin
          currentScanLevel := slFinished;
          markLabel.top := p6Label.top-2
     end;
     PrevPhaseBtn.Enabled := currentScanLevel <> slCRC;
     autoCheckButton.Enabled := not (currentScanLevel in [slTitle, slFinished]);
     NextPhaseBtn.Enabled := currentScanLevel <> slFinished;
     deselectAllBtn.Enabled := currentScanLevel <> slFinished;
     DeleteButton.Enabled := currentScanLevel <> slFinished;
     if currentScanLevel = slFinished then
        tree.clear
     else scanDubs(currentScanLevel)
end;

procedure TDubWizForm.PrevPhaseBtnClick(Sender: TObject);
begin
     if currentScanLevel = slFinished then
     begin
          currentScanLevel := slTitle;
          markLabel.top := p5Label.top-2
     end else
     if currentScanLevel = slTitle then
     begin
          currentScanLevel := slArtistTitleSoundex;
          markLabel.top := p4Label.top-2
     end else
     if currentScanLevel = slArtistTitleSoundex then
     begin
          currentScanLevel := slArtistTitleFuzzy;
          markLabel.top := p3Label.top-2
     end else
     if currentScanLevel = slArtistTitleFuzzy then
     begin
          currentScanLevel := slArtistTitle1;
          markLabel.top := p2Label.top-2
     end else
     if currentScanLevel = slArtistTitle1 then
     begin
          currentScanLevel := slCRC;
          markLabel.top := p1Label.top-2
     end;
     PrevPhaseBtn.Enabled := currentScanLevel <> slCRC;
     autoCheckButton.Enabled := not (currentScanLevel in [slTitle, slFinished]);
     NextPhaseBtn.Enabled := currentScanLevel <> slFinished;
     deselectAllBtn.Enabled := currentScanLevel <> slFinished;
     DeleteButton.Enabled := currentScanLevel <> slFinished;
     if currentScanLevel = slFinished then
        tree.clear
     else scanDubs(currentScanLevel)
end;

procedure TDubWizForm.treeFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
	finalize(Ptrec(sender.GetNodeData(node))^)
end;

procedure TDubWizForm.FormDestroy(Sender: TObject);
begin
     List.free;
     if playedOnce then
        MainFormInstance.winplayundo
end;

procedure TDubWizForm.treeDblClick(Sender: TObject);
var       aNode:PVirtualNode;
          TR:Ptrec;
begin
  aNode := tree.GetFirstSelected;
  if assigned(aNode) then
  begin
    TR := tree.GetNodeData(aNode);
    if (TR.kind = nkQuality) and fileexists(getFtextP(TR.ref, fFilename)) then
      play(getFtextP(TR.ref, fFilename))
  end
end;

procedure TDubWizForm.UseTimeDiffClick(Sender: TObject);
begin
     TimeDiff.enabled := useTimeDiff.checked;
     msLabel.enabled := useTimeDiff.checked;
     scanDubs(currentScanlevel)
end;

procedure TDubWizForm.ShowArtistTitleCBClick(Sender: TObject);
var       aNode:PVirtualNode;
          TR:Ptrec;
begin
     tree.BeginUpdate;
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          TR := tree.GetNodeData(aNode);
          if TR.kind = nkArtistTitle then
             tree.IsVisible[aNode] := ShowArtistTitleCB.Checked;
          aNode := tree.GetNext(aNode)
     end;
     tree.endUpdate
end;

procedure TDubWizForm.treeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
	if Ptrec(tree.GetNodeData(Node)).Kind = nkQuality then
  	ImageIndex := 0 
end;

end.



