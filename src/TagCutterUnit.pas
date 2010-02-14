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


unit TagCutterUnit;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, Forms,
	VirtualTrees, ExtCtrls, StdCtrls, QStrings, ComCtrls, MEXPtypes;

Type
		TCommand = (Command_replace, Command_InsertText, Command_Trim, Command_cut, Command_cutLeft, Command_cutRight);

    TCommandRec = record
            command : TCommand;
						field : Integer;
            Pos1 : integer;
            Pos2:  integer;
            String1       :  String;
            String2       :  String;
    end;
    PCommandRec = ^TCommandRec;

type
  TTagCutter = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Panel1: TPanel;
    AddCommandBtn: TButton;
    ReplacePanel: TPanel;
    Label3: TLabel;
    replaceFindEdit: TEdit;
    ReplaceWithEdit: TEdit;
    Label4: TLabel;
    FromToPanel: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    FromEdit: TEdit;
    ToEdit: TEdit;
    CutByPanel: TPanel;
    Label7: TLabel;
    CutByEdit: TEdit;
    Label8: TLabel;
    PreviewTree: TVirtualStringTree;
    Panel3: TPanel;
    Label1: TLabel;
    commandCB: TComboBox;
    FieldCB: TComboBox;
    Label2: TLabel;
    InsertPanel: TPanel;
    InsertTextEdit: TEdit;
    Label9: TLabel;
    InsertRadio1: TRadioButton;
    InsertRadio2: TRadioButton;
    InsertRadio3: TRadioButton;
    InsertAtPosEdit: TEdit;
    CommandTree: TVirtualStringTree;
    Button1: TButton;
    GroupBox4: TGroupBox;
    updateTags: TCheckBox;
    Panel2: TPanel;
    StartBtn: TButton;
    pbar: TProgressBar;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure AddCommandBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CommandTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure InsertRadio1Click(Sender: TObject);
    procedure InsertRadio2Click(Sender: TObject);
    procedure InsertRadio3Click(Sender: TObject);
    procedure InsertTextEditChange(Sender: TObject);
    procedure InsertAtPosEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CutByEditChange(Sender: TObject);
    procedure FromEditChange(Sender: TObject);
    procedure ToEditChange(Sender: TObject);
    procedure replaceFindEditChange(Sender: TObject);
    procedure ReplaceWithEditChange(Sender: TObject);
    procedure FieldCBChange(Sender: TObject);
    procedure CommandTreeChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure commandCBChange(Sender: TObject);
    procedure PreviewTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
		procedure StartBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
      Procedure LoadLanguageGUI;
      procedure ProjektCommand;
      function GetCR:PCommandRec;
      procedure UpdatePreview;
      function GetFieldCbItemIndex(field: Integer): Integer;
//      function getFieldTagValue(CR:PCommandRec):integer;
      function ChangeText(s:String; CR:PCommandRec):String;  overload;
      function ChangeText(s:String):String;     overload;
      function ChangeText(s:String; field:integer):String;  overload;

//      function ChangeText2(script:string; recPointer:pointer):String;
  public
        list:Tlist;
    { Public declarations }
  end;

var
  TagCutter: TTagCutter;

implementation
uses
    defs, MainForm, LanguageConstants, prefernces;
{$R *.DFM}

Procedure TTagCutter.LoadLanguageGUI;
begin
		 GroupBox3.Caption := GetText(TXT_CutterCommands) + ' ';
     AddCommandBtn.Caption := GetText(TXT_Add);
     Button1.Caption := GetText(TXT_Remove);
     GroupBox1.Caption := GetText(TXT_CutterCommand);
     label1.Caption := GetText(TXT_CutterCommand);
     label2.Caption := GetText(TXT_CutterField);

     CommandCB.Items.Add(GetText(TXT_CutterReplaceCmd));
     CommandCB.Items.Add(GetText(TXT_CutterInsertCmd));
     CommandCB.Items.Add(GetText(TXT_CutterTrimCmd));
     CommandCB.Items.Add(GetText(TXT_CutterCutCmd));
     CommandCB.Items.Add(GetText(TXT_CutterCutLeftCmd));
     CommandCB.Items.Add(GetText(TXT_CutterCutRightCmd));

     FieldCB.Items.AddObject(GetText(TXT_ColumnArtist), TObject(FArtist));
     FieldCB.Items.AddObject(GetText(TXT_ColumnTitle), TObject(FTitle));
     FieldCB.Items.AddObject(GetText(TXT_ColumnAlbum), TObject(FAlbum));
     FieldCB.Items.AddObject(GetText(TXT_ColumnGenre), TObject(FGenre));
     FieldCB.Items.AddObject(GetText(TXT_ColumnComment), TObject(FComment));

     label9.Caption := GetText(TXT_CutterInsertTextEdit);
     InsertRadio1.Caption := GetText(TXT_CutterInsertBefore);
     InsertRadio2.Caption := GetText(TXT_CutterAppend);
     InsertRadio3.Caption := GetText(TXT_CutterInsertAtPos);

     label7.Caption := GetText(TXT_CutterCutLabel);
     label8.Caption := GetText(TXT_CutterCharacters);

     label5.Caption := GetText(TXT_CutterFromLabel);
     label6.Caption := GetText(TXT_CutterToLabel);

     label3.Caption := GetText(TXT_CutterReplaceLabel);
     label4.Caption := GetText(TXT_CutterWithLabel);

     GroupBox2.Caption := GetText(TXT_CutterPreview) + ' ';
     PreviewTree.Header.Columns[0].Text := GetText(TXT_CutterOldValue);
     PreviewTree.Header.Columns[1].Text := GetText(TXT_CutterNewValue);

     GroupBox4.Caption := GetText(TXT_CutterOptions);
		 UpdateTags.Caption := GetText(TXT_UpdateTags);
		 Button3.Caption := GetTExt(TXT_SpecifyTags);

     StartBtn.Caption := GetText(TXT_Start);
     Button2.Caption  := GetText(TXT_Cancel);

     Caption := GetText(TXT_TagCutterCaption)
end;

function TTagCutter.GetFieldCbItemIndex(field: Integer): Integer;
var
	i: Integer;
begin
	result := -1;
	for i:=0 to FieldCB.Items.Count-1 do
  	if Integer(FieldCB.Items.Objects[i]) = field then
    begin
    	result := i;
      break
    end;
end;

function TTagCutter.changeText(s:String):String;
var
   aNode : PVirtualNode;
begin
	aNode := CommandTree.GetFirst;
  while aNode <> nil do
  begin
  	s := ChangeText(s, CommandTree.GetNodeData(aNode));
    aNode := CommandTree.GetNext(aNode)
  end;
  result := s
end;

function TTagCutter.changeText(s:String; field:integer):String;
var
   aNode : PVirtualNode;
begin
     aNode := CommandTree.GetFirst;
     while aNode <> nil do
     begin
          if PCommandRec(CommandTree.GetNodeData(aNode)).field = field then
             s := ChangeText(s, CommandTree.GetNodeData(aNode));
          aNode := CommandTree.GetNext(aNode)
     end;
     result := s
end;

function TTagCutter.ChangeText(s:String; CR:PCommandRec):String;
begin
     if CR.command = Command_Replace then
     begin
          if length(CR.String1)=0 then
             result := s
          else result := Q_ReplaceText(s, CR.String1, CR.String2)
     end else
     if CR.command = Command_InsertText then
     begin
          if length(CR.String1)=0 then
             result := s
          else
          begin
               if CR.Pos1 = 0 then //insert in beginning
                  result := CR.String1 + s else
               if CR.Pos1 = 1 then //append
                  result := s + CR.String1 else
               result := Q_CopyRange(s, 1, CR.Pos2) + CR.String1 + Q_CopyFrom(s, CR.Pos2+1)
          end
     end else
     if CR.command = Command_Trim then
     begin
          result := Q_CopyRange(s, CR.Pos1+1, CR.Pos2+1)
     end else
     if CR.command = Command_Cut then
     begin
          result := Q_CopyRange(s, 1, CR.Pos1) + Q_CopyFrom(s, CR.Pos2+1)
     end else
     if CR.command = Command_CutLeft then
     begin
          result := s;
          Q_CutLeft(result, CR.Pos1)
     end else
     if CR.Command = Command_CutRight then
     begin
          result := s;
          Q_CutRight(result, CR.Pos1)
     end
end;

{function TTagCutter.getFieldTagValue(CR:PCommandRec):integer;
begin
     case CR.Field of
          0: result := FArtist;
          1: result := FTitle;
          2: result := FAlbum;
          3: result := FGenre;
     else result := FComment;
     end
end;   }

function TTagCutter.GetCR:PCommandRec;
var
   aNode : PVirtualNode;
begin
     aNode := CommandTree.GetFirstSelected;
     if assigned(aNode) then
        result := CommandTree.GetNodeData(aNode)
     else result := nil
end;

procedure TTagCutter.updatePreview;
begin
     CommandTree.repaint;
     PreviewTree.repaint
end;

procedure TTagCutter.FormCreate(Sender: TObject);
begin
     Icon := MainFormInstance.Icon1.picture.icon;
     list := Tlist.create;
     CommandTree.NodeDataSize := SizeOf(TCommandRec);
     LoadLanguageGUI
end;

procedure TTagCutter.AddCommandBtnClick(Sender: TObject);
var
   CR : PCommandRec;
   aNode : PVirtualNode;
begin
     aNode := CommandTree.AddChild(nil);
     CR := CommandTree.GetNodeData(aNode);
     FillChar(cr^, SizeOf(TCommandRec), 0);
     cr.field := Integer(FieldCB.Items.Objects[0]);
     CommandTree.ClearSelection;
     CommandTree.Selected[aNode] := true
end;

procedure TTagCutter.FormShow(Sender: TObject);
begin
     PreviewTree.RootNodeCount := list.Count;
     ProjektCommand
end;

procedure TTagCutter.FormDestroy(Sender: TObject);
begin
     list.free
end;

procedure TTagCutter.ProjektCommand;
var
   aNode : PVirtualNode;
   CR : PCommandRec;
begin
     aNode := CommandTree.GetFirstSelected;
     commandCB.Enabled := assigned(aNode);
     fieldCB.Enabled := assigned(aNode);

     ReplacePanel.Visible := commandCB.Enabled and (commandCB.ItemIndex = 0);
     InsertPanel.Visible := commandCB.Enabled and (commandCB.ItemIndex = 1);
     FromToPanel.Visible := commandCB.Enabled and (commandCB.ItemIndex in [2, 3]);
     CutByPanel.Visible := commandCB.Enabled and (commandCB.ItemIndex in [4, 5]);

     if assigned(aNode) then
     begin
          CR := CommandTree.GetNodeData(aNode);
          fieldCB.ItemIndex := GetFieldCbItemIndex(CR.Field);
          replaceFindEdit.Text := CR.String1;
          ReplaceWithEdit.Text := CR.String2;
          FromEdit.Text := inttostr(CR.pos1);
          ToEdit.Text := inttostr(CR.pos2);
          InsertTextEdit.Text := CR.String1;
          InsertAtPosEdit.Text := inttostr(CR.pos2);
          CutByEdit.Text := inttostr(CR.pos1);
          if CR.command = Command_InsertText then
          begin
               InsertRadio1.Checked := CR.Pos1 = 0;
               InsertRadio2.Checked := CR.Pos1 = 1;
               InsertRadio3.Checked := CR.Pos1 = 2;
               InsertAtPosEdit.Enabled := InsertRadio3.Checked
          end
     end;
     updatePreview
end;

procedure TTagCutter.CommandTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
	CR : PCommandRec;
  FieldText: String;
  i: Integer;
begin
	CR := CommandTree.GetNodeData(Node);
  i := GetFieldCbItemIndex(CR.Field);
  if i >= 0 then
  	FieldText := fieldCB.Items[GetFieldCbItemIndex(CR.field)]
  else
  	FieldText := '';;

 if CR.command = Command_Replace then
    CellText := GetText(TXT_CutterReplace, [CR.String1, CR.String2, FieldText]) else
 if CR.command = Command_InsertText then
    CellText := GetText(TXT_CutterInsertText, [CR.String2, FieldText]) else
 if CR.command = Command_Cut then
    CellText := GetText(TXT_CutterCut, [inttostr(CR.pos1), FieldText]) else
 if CR.command = Command_CutLeft then
    CellText := GetText(TXT_CutterCutLeft, [inttostr(CR.pos1), FieldText]) else
 if CR.command = Command_CutRight then
    CellText := GetText(TXT_CutterCutRight, [inttostr(CR.pos1), FieldText]) else
 if CR.command = Command_Trim then
    CellText := GetText(TXT_Trim, [inttostr(CR.pos1), inttostr(CR.pos2), FieldText])
end;



procedure TTagCutter.InsertRadio1Click(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) then
	begin
  	cr.Pos1 := 0;
	  updatePreview
  end
end;

procedure TTagCutter.InsertRadio2Click(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) then
	begin
  	cr.Pos1 := 1;
	  updatePreview
  end
end;

procedure TTagCutter.InsertRadio3Click(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) then
	begin
  	cr.Pos1 :=2;
    InsertAtPosEdit.Enabled := true;
    updatePreview
  end
end;

procedure TTagCutter.InsertTextEditChange(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) and InsertTextEdit.Modified then
	begin
  	cr.String1 := InsertTextEdit.Text;
	  updatePreview
  end
end;

procedure TTagCutter.InsertAtPosEditChange(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) and InsertAtPosEdit.Modified and Q_IsInteger(InsertAtPosEdit.Text) then
	begin
  	cr.Pos2 := StrToInt(InsertAtPosEdit.Text);
	  updatePreview
  end
end;

procedure TTagCutter.CutByEditChange(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) and CutByEdit.Modified and Q_IsInteger(CutByEdit.Text) then
	begin
  	cr.Pos1 := StrToInt(CutbyEdit.Text);
	  updatePreview
  end
end;

procedure TTagCutter.FromEditChange(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) and FromEdit.Modified and Q_IsInteger(FromEdit.Text) then
	begin
  	cr.Pos1 := StrToInt(FromEdit.Text);
	  updatePreview
  end
end;

procedure TTagCutter.ToEditChange(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) and ToEdit.Modified and Q_IsInteger(ToEdit.Text) then
	begin
  	cr.Pos2 := StrToInt(ToEdit.Text);
	  updatePreview
  end
end;

procedure TTagCutter.replaceFindEditChange(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) and replaceFindEdit.Modified then
	begin
  	cr.String1 := replaceFindEdit.Text;
	  updatePreview
  end
end;

procedure TTagCutter.ReplaceWithEditChange(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) and replaceWithEdit.Modified then
	begin                   
  	cr.String2 := replaceWithEdit.Text;
	  updatePreview
  end
end;

procedure TTagCutter.FieldCBChange(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) and (FieldCB.ItemIndex >= 0) then
	begin
  	cr.field :=  Integer(FieldCB.Items.Objects[FieldCB.ItemIndex]);
	  updatePreview
  end
end;

procedure TTagCutter.CommandTreeChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
   CR : PCommandRec;
begin
	if CommandTree.Selected[Node] then
  begin
  	CR := CommandTree.GetNodeData(Node);
    CommandCB.ItemIndex := Integer(CR.Command);
  end
  else
  	CommandCB.Enabled := false;
  ProjektCommand
end;

procedure TTagCutter.commandCBChange(Sender: TObject);
var
	cr: PCommandRec;
begin
	cr := GetCR;
  if assigned(cr) then
	begin
  	cr.command := TCommand(CommandCB.ItemIndex);
    cr.Pos1 := 0;
    cr.Pos2 := 0;
    cr.String1 := '';
    cr.String2 := '';
    ProjektCommand
  end
end;

procedure TTagCutter.PreviewTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
   field:integer;
   p:pointer;
begin
  if CommandTree.SelectedCount > 0 then
  begin
    p := CommandTree.GetNodeData(CommandTree.GetFirstSelected);
    field := PCommandRec(p).Field;
    if Column = 0 then //old
       CellText := MainFormInstance.GetFTextP(list.items[Node.index], field) else
    if Column = 1 then //new
       CellText := //ChangeText2(edit1.text, list.items[Node.index])
       ChangeText(MainFormInstance.GetFTextP(list.items[Node.index], field), PCommandRec(p).field)
  end else
  CellText := ''
end;

procedure TTagCutter.StartBtnClick(Sender: TObject);
function FieldInArray(arr: array of TtagValue; field:integer):boolean;
var
   i:integer;
begin
	result := false;
  for i:=0 to length(arr)-1 do
  	result := result or (arr[i].field = field)
end;
var
   aNode : PVirtualNode;
   arr : TtagValues;
	 CR : PCommandRec;
	 i, fieldIndex:integer;
   errMsg, errMsgTotal: string;
begin
	screen.Cursor := crHourglass;
	pbar.Position := 0;
	pbar.Max := list.count;
	for i:=0 to list.Count-1 do
	begin
		setLength(arr, 0);
		aNode := CommandTree.GetFirst;
		while aNode <> nil do
		begin
			CR := CommandTree.GetNodeData(aNode);
			if (length(arr) = 0) or not FieldInArray(arr, CR.field) then
			begin
				setLength(arr, length(arr)+1);
				fieldIndex := length(arr)-1;

				arr[fieldIndex].field := CR.Field;
				arr[fieldIndex].value := ChangeText(MainFormInstance.GetFTextP(list.items[i], arr[fieldIndex].field), CR.field);
				if Q_SameStr(arr[fieldIndex].value, MainFormInstance.GetFTextP(list.items[i], arr[fieldIndex].field)) then
					setLength(arr, length(arr)-1)
			end;
			aNode := CommandTree.GetNext(aNode)
		end;
    errMsg := '';
		if length(arr)>0 then
			MainFormInstance.UpdateRecValues(list.items[i], arr, errMsg, updateTags.checked);
  	if length(errMsg) > 0 then
    	errMsgTotal := errMsgTotal + CRLF + CRLF + 'Error tagging file "' + MainFormInstance.GetFTextP(list.items[i], FFILENAME) + '":' + CRLF + errMsg;
		pbar.Position := pbar.Position +1
	end;
	screen.Cursor := crDefault;

  if length(errMsgTotal) > 0 then
  begin
  	Q_CutLeft(errMsgTotal, 2);
  	MainFormInstance.Showmessagex(errMsgTotal)
  end;

	modalresult := mrOk
end;

procedure TTagCutter.Button1Click(Sender: TObject);
begin
     CommandTree.DeleteSelectedNodes
end;

{ experimental scripts stuff
function TTagCutter.changeText2(script:string; recPointer:pointer):String;
function sToint(s:String; var failed:boolean):integer;
begin
     result := 0;
     try
//     Q_CutLeft(s, 1);
//     Q_CutRight(s, 1);
     result := StrToInt(s)
     except
           failed := true
     end
end;
function getTextInsideParams(s:String):String;
var
   i, c:integer;
begin
     result := '';
     c := 0;
     for i:=1 to length(s) do
     begin
          if s[i] = ')' then
             dec(c);
          if c > 0 then
             result := result + s[i];
          if s[i] = '(' then
             inc(c)
     end
end;
function getParts(str:String; sep:char; sl:TStringList):integer; //deler strengen op, bruger ',' som sep. Retunerer sl.count
var
   i, c : Integer;
   s : string;
begin
     sl.clear;
     result := 0;
     c := 0;
     s := '';
     for i:=1 to length(str) do
     begin
          if str[i] = ')' then
             dec(c);

          if (c = 0) and (str[i] = sep) then
          begin
               if length(trim(s)) > 0 then
               begin
                    sl.Add(trim(s));
                    s := ''
               end;
               continue
          end;

          s := s + str[i];

          if str[i] = '(' then
             inc(c)
     end;
     if length(trim(s)) > 0 then
        sl.Add(s);
     result := sl.count
end;
function parseStr(str:String; var failed:boolean):String;
var
   i : integer;
   s, s1, s2, s3 : String;
   sl : TStringList;
begin
     sl := TStringList.create;

     try
     if Q_SameStrL('%&COPYTO', str, 8) then   // copyTo(string, til)
     begin
          s := getTextInsideParams(str);
          //deler den op i 2
          if getParts(s, ',', sl) = 2 then
          begin
               for i:=0 to 1 do
                   sl.Strings[i] := parseStr(sl.Strings[i], failed);

               result := Q_CopyRange(sl.Strings[0], 1, sToint(sl.Strings[1], failed));
               exit
          end
     end else
     if Q_SameStrL('%&COPY', str, 6) then   // copy(string, fra, til)
     begin
          s := getTextInsideParams(str);
          //deler den op i 3
          if getParts(s, ',', sl) = 3 then
          begin
               for i:=0 to 2 do
                   sl.Strings[i] := parseStr(sl.Strings[i], failed);

               result := Q_CopyRange(sl.Strings[0], sToint(sl.Strings[1], failed), sToint(sl.Strings[2], failed));
               exit
          end
     end else
     result := str
     except
           failed := true
     end;
     sl.Free
end;

function checkCommand(cmd:string; var parseString:string; pPos:integer; var str:String):boolean;
var
   i:integer;
begin
//     Q_CutRight(parseString, pPos-1);
     if (length(parseString)-pPos+1 >= length(cmd)) and Q_SameTextL(cmd, Q_CopyFrom(parseString, pPos), length(cmd)) then
     begin
          str := str + '%&' + upperCase(cmd);
          result := true;
          //blanker parseString
          for i:=pPos to pPos+length(cmd)-1 do
              parseString[i] := ' '
     end else result := false
end;

//main
var
   failed : boolean;
   str, s, final : String;
   i, k : integer;
   insideText : boolean;
   sl : TStringlist;

   rec : Prec;
begin
     rec := recPointer;

     final := '';

     str := script;

     sl := TStringlist.create;
     getParts(str, '+', sl);

     for k:=0 to sl.count-1 do
     begin
     str := sl.Strings[k];
     //klargør kommandoer. Str flyttes til s
     insideText := false;
     s := '';
     for i:=1 to length(str) do
     begin
          if str[i] = '"' then
             insideText := not insideText
          else
          begin
               if insideText then
                  s := s + str[i]
               else
               if str[i] <> ' ' then
               begin
                    if not checkCommand('%artist%', str, i, s) then
                    if not checkCommand('%title%', str, i, s) then
                    if not checkCommand('%album%', str, i, s) then
                    if not checkCommand('CopyTo', str, i, s) then
                    if not checkCommand('Copy', str, i, s) then
                    s := s + str[i]
               end
          end
     end;
     s := Q_ReplaceStr(s, '%&%ARTIST%', MainFormInstance.GetFTextP(rec, FArtist));
     s := Q_ReplaceStr(s, '%&%TITLE%', MainFormInstance.GetFTextP(rec, FTitle));
     s := Q_ReplaceStr(s, '%&%ALBUM%', MainFormInstance.GetFTextP(rec, FAlbum));

     failed := false;
     s := parseStr(s, failed);
     if failed then
        MainFormInstance.ShowMessageX('Faaajl')
     else final := final + s
     end;

     sl.free;
     result := final
end;     }

procedure TTagCutter.Button3Click(Sender: TObject);
begin
	pref.PC.ActivePage := pref.TSid3Editor;
	MainFormInstance.Generalconfiguration1Click(sender);
	self.Show
end;

end.
