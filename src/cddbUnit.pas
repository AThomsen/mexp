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


unit cddbUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, MEXPtypes, 
  VirtualTrees, defs, StdCtrls, QStrings, ActiveX, ExtCtrls, WAIPC,
	ComCtrls, MexpIniFile, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP;

Type
    Tcd = record
        found : boolean;
        tracks : integer;
        server : String;
        artist : String;
        albumtitle : String;
        cat   : String;
        discID : String;
        s : String; //holder databaseentrien
    end;
    Pcd = ^Tcd;

    TcdRec = record
           artist : string;
           title : string;
           comment : string;
           ms : cardinal;
    end;
    PcdRec = ^TcdRec;

    Ttrec = record
          rec : Prec;
          cdRec : PcdRec;
          save : boolean;
    end;
    Ptrec = ^Ttrec;
type
  TCddbForm = class(TForm)
    Panel1: TPanel;
    Tree: TVirtualStringTree;
    Panel2: TPanel;
    Label5: TLabel;
    SameArtist: TCheckBox;
    Panel3: TPanel;
    Label1: TLabel;
    cddbDataLabel: TLabel;
    Panel4: TPanel;
    Status: TLabel;
    QueryGrp: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    ArtistLabel: TLabel;
    AlbumLabel: TLabel;
    Bevel1: TBevel;
    QueryFakeIdBtn: TButton;
    QueryArtistAlbumBtn: TButton;
    ArtistEdit: TEdit;
    AlbumEdit: TEdit;
    GroupBox1: TGroupBox;
    cdTree: TVirtualStringTree;
    showCorrectTracks: TCheckBox;
    cdInfoPanel: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cddbExt: TLabel;
    cddbArtist: TEdit;
    cddbAlbum: TEdit;
    cddbYear: TEdit;
    cddbGenre: TEdit;
    SaveOptGroupBox: TGroupBox;
    Bevel2: TBevel;
    updateTags: TCheckBox;
    saveArtist: TCheckBox;
    saveTitle: TCheckBox;
    saveAlbum: TCheckBox;
    saveTrack: TCheckBox;
    saveComment: TCheckBox;
    saveYear: TCheckBox;
    saveGenre: TCheckBox;
    pbar: TProgressBar;
    AutoLoadCD: TCheckBox;
    GroupBox3: TGroupBox;
    FakeServerEdit: TEdit;
    Label4: TLabel;
    Button1: TButton;
    Savebtn: TButton;
    Bevel3: TBevel;
    SearchServerEdit: TEdit;
    Label11: TLabel;
    AutoOrderBtn: TButton;
    autoAutoOrder: TCheckBox;
    Label12: TLabel;
    artistTitleSep: TEdit;
    Label13: TLabel;
    reparseBtn: TButton;
    userBtn: TButton;
    saveCompilation: TCheckBox;
    SpecifyTagsBtn: TButton;
    IdHttp: TIdHTTP;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure QueryFakeIdBtnClick(Sender: TObject);
    procedure cdTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure cdTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure TreeDragAllowed(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure TreeDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure TreeColumnResize(Sender: TVTHeader; Column: TColumnIndex);
    procedure FormShow(Sender: TObject);
    procedure QueryArtistAlbumBtnClick(Sender: TObject);
    procedure showCorrectTracksClick(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure TreeCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure TreeHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure cdTreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure cdTreeCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure SavebtnClick(Sender: TObject);
    procedure AutoOrderBtnClick(Sender: TObject);
		procedure TreeChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure SameArtistClick(Sender: TObject);
    procedure reparseBtnClick(Sender: TObject);
    procedure userBtnClick(Sender: TObject);
    procedure TreeDblClick(Sender: TObject);
    procedure Panel4Resize(Sender: TObject);
    procedure TreeEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure TreeNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure SpecifyTagsBtnClick(Sender: TObject);
    procedure TreeGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: WideString);
  private
				 userEmail, cddbAppName : String;
         playedOnce:boolean;
         procedure play(s:string);
         Procedure InitLanguage;
         Function GetFTextP(const P:Pointer; const Field:integer):String;
         procedure forceRepaint(control:TControl);
         function fixString(s:string):string;
         function correct8Hex(s:String):String;
         procedure AddToTree(cd:Tcd);
         procedure CleanTree;
         procedure updateCheck;

         procedure ReadCD(CD:Pcd);
         procedure FindAndDownloadMatch;
         function AutoOrder:boolean;
         function GetServerEnd:String;
         function GetHttpString(const url: String; var output: String): Boolean;
    { Private declarations }
  public
        list:TList;
        procedure Init;
    { Public declarations }
  end;

var
  CddbForm: TCddbForm;

implementation

uses MainForm, LanguageConstants, prefernces;

{$R *.DFM}

Procedure TCddbForm.InitLanguage;
begin
     Caption               := GetText(TXT_cddbLookup);
     //tree
      with tree.Header do
      begin
           Columns[0].Text := GetText(TXT_ColumnFile);
           Columns[1].Text := GetText(TXT_ColumnTitle);
           Columns[2].Text := GetText(TXT_ColumnTrack);
           Columns[3].Text := GetText(TXT_ColumnLength);
           Columns[5].Text := GetText(TXT_ColumnLength);
           Columns[6].Text := GetText(TXT_ColumnArtist);
           Columns[7].Text := GetText(TXT_ColumnTitle);
           Columns[8].Text := GetText(TXT_ColumnTrack);
           Columns[9].Text := GetText(TXT_ColumnComment);
           Columns[10].Text := GetText(TXT_Tag)
      end; //eo tree

     label1.Caption              := GetText(TXT_OriginalData);
     cddbDataLabel.Caption       := GetText(TXT_CddbData);
     label5.Caption              := GetText(TXT_cddbUseDragNDrop);
     SameArtist.Caption          := GetText(TXT_SameArtist);
     AutoOrderBtn.Caption        := GetText(TXT_AutoOrderTracks);
     autoAutoOrder.Caption       := GetText(TXT_OnEveryCdLoad);
     QueryGrp.Caption            := GetText(TXT_Query) + ' ';
     label2.Caption              := GetText(TXT_QueryText);
     label3.Caption              := GetText(TXT_SearchArtistAlbumText);
     ArtistLabel.Caption         := GetText(TXT_ColumnArtist);
     AlbumLabel.Caption          := GetText(TXT_ColumnAlbum);
     QueryFakeIdBtn.Caption      := GetText(TXT_Search);
     QueryArtistAlbumBtn.Caption := GetText(TXT_Search);
     AutoLoadCD.Caption          := GetText(TXT_AutoDownloadBestMatch);

     GroupBox3.Caption           := GetText(TXT_Options) + ' ';
     label4.Caption              := GetText(TXT_QueryServer);
     userBtn.Caption             := GetText(TXT_cddbUser);
     label11.Caption             := GetText(TXT_SearchServer);
     label13.Caption             := GetText(TXT_Advanced);
     label12.Caption             := GetText(TXT_ArtistTitleSep);
     reparseBtn.Caption          := GetText(TXT_reparse);

     SaveOptGroupBox.Caption     := GetText(TXT_Save_options) + ' ';
		 updateTags.Caption          := GetText(TXT_Updatetags);

     saveArtist.Caption          := GetText(TXT_ColumnArtist);
     SaveAlbum.Caption           := GetText(TXT_ColumnAlbum);
     SaveYear.Caption            := GetText(TXT_ColumnYear);
     SaveGenre.Caption           := GetText(TXT_ColumnGenre);
     SaveTitle.Caption           := GetText(TXT_ColumnTitle);
     SaveTrack.Caption           := GetText(TXT_ColumnTrack);
     SaveComment.Caption         := GetText(TXT_ColumnComment);
     SaveCompilation.Caption     := GetText(TXT_ColumnCompilation);
		 SpecifyTagsBtn.Caption 		 := GetTExt(TXT_SpecifyTags);	
     GroupBox1.Caption           := GetText(TXT_SearchResults) + ' ';
     ShowCorrectTracks.Caption   := GetText(TXT_ShowCorrectTracks);
     label6.Caption              := GetText(TXT_ColumnArtist);
     label7.Caption              := GetText(TXT_ColumnAlbum);
     label8.Caption              := GetText(TXT_ColumnYear);
     label9.Caption              := GetText(TXT_ColumnGenre);
		 label10.Caption             := GetText(TXT_ExtData);

     SaveBtn.Caption             := GetText(TXT_Save);
     Button1.Caption             := GetText(TXT_Cancel)
end;

Function TCddbForm.GetServerEnd:String;
begin
     result := Q_ReplaceStr(UserEmail, '.', '%2E');
     result := Q_ReplaceStr(result, ' ', '');
     result := Q_ReplaceStr(result, '@', '+');
		 result := '&hello=' + result + '+' + cddbAppName + '&proto=5'
		 //hello=joe+my.host.com+xmcd+2.1&proto=5
		 //'&hello=mexp+mexp%2Edk+MEXP+beta1&proto=5'
end;

procedure TCddbForm.Init;
var
   aNode : PVirtualNode;
   i : integer;
   TR : Ptrec;
   artists, albums : array of string;
   b : boolean;
begin
     setLength(artists, list.count);
     setLength(albums, list.count);
     for i:=0 to list.Count-1 do
     begin
          aNode := tree.AddChild(nil);
          TR := tree.GetNodeData(aNode);
          FillChar(TR^, sizeOf(TR^), 0);
          TR.rec := list.Items[i];

          artists[i] := GetFTextP(TR.rec, FArtist);
          albums[i] := GetFTextP(TR.rec, FAlbum)
     end;
     b := true;
     for i:=0 to length(artists)-2 do
         b := b and (Q_SameText(artists[i], artists[i+1]) or (length(artists[i])=0) or (length(artists[i+1])=0));
     if b then
        ArtistEdit.Text := artists[0]
     else ArtistEdit.Text := '';

     b := true;
     for i:=0 to length(albums)-2 do
         b := b and (Q_SameText(albums[i], albums[i+1]) or (length(albums[i])=0) or (length(albums[i+1])=0));
     if b then
        AlbumEdit.Text := albums[0]
     else AlbumEdit.Text := ''
end;

Function TCddbForm.GetFTextP(const P:Pointer; const Field:integer):String;
begin
     result := MainFormInstance.GetFTextP(p, Field)
end;

procedure TCddbForm.forceRepaint(control:TControl);
begin
     MainFormInstance.forceRepaint(control);
     control.Update;
     application.processmessages
end;

procedure TCddbForm.FormCreate(Sender: TObject);
var
	server, username, password: String;
  port, i: Integer;
begin
  if MainFormInstance.GetProxySettingsFromWinamp(Server, Port, username, password) then
  begin
  	IdHttp.ProxyParams.ProxyServer := server;
    IdHttp.ProxyParams.ProxyPort := port;
    IdHttp.ProxyParams.ProxyUsername := username;
    IdHttp.ProxyParams.ProxyPassword := password
  end;

  Icon := MainFormInstance.Icon1.picture.icon;
  playedOnce := false;
  tree.NodeDataSize := SizeOf(Ttrec);
  cdTree.NodeDataSize := SizeOf(Tcd);
  list := Tlist.create;
  status.Caption := GetText(TXT_Ready);
  InitLanguage;

  //læser indstillinger;
  with Settings do
  begin
    if ValueExists('cddbAppName') then
      cddbAppName := ReadString('cddbAppName')
    else cddbAppName := 'MEXP+beta3';
    if ValueExists('cddbUser') then
       UserEmail := ReadString('cddbUser')
    else UserEmail := 'mexp@mexp.dk';
    if ValueExists('cddbAutoAutoOrder') then
       autoAutoOrder.Checked := readBool('cddbAutoAutoOrder');
    if ValueExists('cddbAutoLoadCD') then
       AutoLoadCD.Checked := readBool('cddbAutoLoadCD');
    if ValueExists('cddbServer1') and ValueExists('cddbServer2') then
    begin
         FakeServerEdit.Text := ReadString('cddbServer1');
         SearchServerEdit.Text := ReadString('cddbServer2')
    end;
    if ValueExists('cddbShowCorrectTracks') then
       ShowCorrectTracks.Checked := readBool('cddbShowCorrectTracks');

    for i:=0 to SaveOptGroupBox.ControlCount-1 do
        if (SaveOptGroupBox.Controls[i] is TCheckbox) and valueExists('cddb' + TCheckBox(SaveOptGroupBox.Controls[i]).name) then
           TCheckBox(SaveOptGroupBox.Controls[i]).checked := readBool('cddb' + TCheckBox(SaveOptGroupBox.Controls[i]).name)
  end
end;

procedure TCddbForm.FormDestroy(Sender: TObject);
var
	 i:integer;
begin
		 with Settings do
		 begin
					writeString('cddbAppName', cddbAppName);
					writeString('cddbUser', UserEmail);
					writeBool('cddbAutoAutoOrder', autoAutoOrder.Checked);
					writeBool('cddbAutoLoadCD', AutoLoadCD.Checked);
					writeString('cddbServer1', FakeServerEdit.Text);
					writeString('cddbServer2', SearchServerEdit.Text);
					writeBool('cddbShowCorrectTracks', ShowCorrectTracks.Checked);

          for i:=0 to SaveOptGroupBox.ControlCount-1 do
              if (SaveOptGroupBox.Controls[i] is TCheckbox) and (SaveOptGroupBox.Controls[i] <> saveCompilation) then
								 writeBool('cddb' + TCheckBox(SaveOptGroupBox.Controls[i]).name, TCheckBox(SaveOptGroupBox.Controls[i]).checked)
     end;
     if playedOnce then
				MainFormInstance.winplayundo;
		 list.Free;
		 cleanTree
end;

procedure TCddbForm.TreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
   TR : Ptrec;
begin
     TR := tree.GetNodeData(Node);
     if Column in [0..3] then
     begin
          if assigned(TR.rec) then
          begin
               case Column of
                    0: CellText := GetFTextP(TR.rec, FFname);
                    1: CellText := GetFTextP(TR.rec, FTitle);
                    2: CellText := GetFTextP(TR.rec, FTrack);
                    3: CellText := GetFTextP(TR.rec, FLength)
               end
          end else
              if Column = 0 then
                 CellText := GetText(TXT_Unassigned)
              else CellText := '-'
     end else
     if Column = 4 then //splitteren
        CellText := '' else
     if Column in [5..9] then //new from cddb
     begin
          if assigned(TR.cdRec) then
          begin
               case Column of
                    5: CellText := IntTimeToStr(TR.cdRec.ms, false, false);
                    6: CellText := TR.cdRec.artist;
                    7: CellText := TR.cdRec.title;
                    8: CellText := inttostr(Node.index+1);
                    9: CellText := TR.cdRec.comment
               end
          end
          else CellText := '-'
     end else CellText := ''
end;

function TCddbForm.correct8Hex(s:String):String;
begin
     while length(s)<8 do
           s := '0' + s;
     result := s
end;

function TCddbForm.fixString(s:string):string;
begin
     result := s;
     Q_ReplaceText(result, #0, '');
     Q_ReplaceText(result, #10, '');
     Q_ReplaceText(result, #13, CRLF)
end;


procedure TCddbForm.AddToTree(cd: Tcd);
var
   p : Pcd;
begin
     p := cdTree.GetNodeData(cdTree.AddChild(nil));
     fillChar(p^, SizeOf(p^), 0);
     p.Server := cd.Server;
     p.artist := cd.artist;
     p.albumtitle := cd.albumtitle;
     p.cat := cd.cat;
     p.discID := cd.discID;
     p.tracks := cd.tracks;
     p.s := cd.s;
     p.found := cd.found
end;

procedure TCddbForm.FindAndDownloadMatch;
var
   artist, album: string;
   aNode, mNode : PVirtualNode;
   cd : Pcd;
begin
     artist := trim(artistEdit.Text);
     album := trim(albumEdit.Text);

     mNode := nil;
     aNode := cdTree.GetFirst;
     while aNode <> nil do
     begin
          cd := cdTree.GetNodeData(aNode);

          if Q_SameText(artist, cd.artist) and Q_SameText(album, cd.albumtitle) then
          begin
               if not assigned(mNode) then
                  mNode := aNode
          end;
          aNode := cdTree.GetNext(aNode)
     end;
     cdTree.ClearSelection;

     if assigned(mNode) then
        cdTree.Selected[mNode] := true
end;

function TCddbForm.GetHttpString(const url: String; var output: String): Boolean;
begin
	result := false;
  try
    output := trim(IdHttp.Get(Url));
    result := true;
  except
    output := '';
    result := false;
  end;
  try
  	IdHttp.Disconnect;
  except
	end;
end;

procedure TCddbForm.QueryArtistAlbumBtnClick(Sender: TObject);
function CreateSearchString(s:string):String;
begin
     result := Q_ReplaceText(s, 'å', ' ');
     result := Q_ReplaceText(result, 'æ', ' ');
     result := Q_ReplaceText(result, 'ø', ' ')
end;
var
   s, a, t, artist, album : String;
   CD : Tcd;
begin
	try
  	IdHttp.Disconnect;
  except
	end;

  saveBtn.Enabled := false;
  cdInfoPanel.Visible := false;
  AutoOrderBtn.Enabled := false;

  Status.Caption := GetText(TXT_Querying) + '...';
  forceRepaint(Status);
  screen.cursor := crHourglass;

  cdTree.RootNodeCount := 0;

  artist := '';
  album := '';
  s := CreateSearchString(trim(trim(artistEdit.text) + ' ' + trim(albumEdit.text)));
  s := Q_ReplaceText(s, ' ', '+');

  a := '';
  if length(trim(artistEdit.text))>0 then
    a := '&fields=artist';
  if length(trim(albumEdit.text))>0 then
    a := a + '&fields=title';

  if GetHttpString('http://www.' + trim(SearchServerEdit.Text) + '/freedb_search.php?words=' + s + '&allfields=NO' + a + '&allcats=YES&grouping=none', s) then
     if Q_PosText('all categories', s)>0 then
     begin
          status.Caption := GetText(TXT_FoundMatches);

          s := fixString(s);
          s := Q_ReplaceText(s, '<br>', '');
          s := Q_ReplaceText(s, '</tr>', '');
          s := Q_ReplaceText(s, #10, '');
          Q_CutLeft(s, Q_PosText('all categories', s));
          s := Q_CopyRange(s, 35, Q_PosText('</table>', s));

          while length(s)>1 do
          begin
               a := Q_CopyRange(s, Q_StrScan(s, '<'), Q_PosText('</a>', s)-1);

               fillChar(CD, SizeOf(CD), 0);
               CD.server := trim(SearchServerEdit.Text);

               CD.cat := Q_CopyRange(a, Q_PosText('cat=', a)+4, Q_PosText('&id', a)-1);
               CD.discID := correct8Hex(Q_CopyRange(a, Q_PosText('&id=', a)+4, Q_PosText('">', a)-1));
               CD.tracks := Q_HexToUInt(Q_CopyFrom(CD.discID, 7));

               if Q_SameText(Q_CopyRange(a, 1, 8), '<tr><td>') then
               begin
                    t := Q_CopyFrom(a, Q_PosText('">', a)+2);
                    if Q_PosStr(' / ', t)>0 then
                    begin
                         artist := Q_CopyRange(t, 1, Q_PosStr(' / ', t)-1);
                         album := Q_CopyFrom(t, Q_PosStr(' / ', t) +3)
                    end else
                    begin
                         artist := '';
                         album := t
                    end
               end;
               CD.artist := artist;
               CD.albumtitle := album;
               addToTree(CD);

               Q_CutLeft(s, Q_PosText('</a>', s)+3);
               if Q_PosText('</a>', s) = 0 then
                  s := ''
          end
     end else status.Caption := GetText(TXT_NoMatchFound)
     else status.Caption := GetText(TXT_ErrorConnecting);

     cdTree.SortTree(0, sdAscending);
     showCorrectTracksClick(nil);
     if AutoLoadCD.Checked then
        FindAndDownloadMatch;
     screen.cursor := crDefault
end;

procedure TCddbForm.QueryFakeIdBtnClick(Sender: TObject);
function cddb_sum( n : integer ) : Integer;
begin
  Result := 0;
  while ( n > 0 ) do
  begin
    Result := Result + n mod 10;
    n := n div 10
  end
end;
var
   url, frames:string;
   totLen : cardinal;
   discID : int64;
   tracks, frm, n:integer;
   aNode:PVirtualNode;
   TR : Ptrec;

   s, a : String;
   code : integer;
   CD : Tcd;
begin
     saveBtn.Enabled := false;
     cdInfoPanel.Visible := false;
     AutoOrderBtn.Enabled := false;

     status.Caption := GetText(TXT_Querying) + '...';
     forceRepaint(status);

     screen.Cursor := crHourglass;

     cleanTree;
     cdTree.RootNodeCount := 0;

     url := 'http://' + trim(FakeServerEdit.Text) + '/~cddb/cddb.cgi?cmd=cddb+query';
     frames := '';
     frm := 150;
     n := 0;
     tracks := 0;
     totLen := 2000;

     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          TR := tree.GetNodeData(aNode);
          if assigned(TR.rec) then
          begin
               inc(n, cddb_sum(totLen div 1000));
               frames := frames + inttostr(frm) + '+';
               inc(frm, integer(Trunc((TR.rec.length / 1000) * 75)));
               inc(totLen, TR.rec.length);

               inc(tracks)
          end;
          aNode := tree.GetNext(aNode)
     end;
     totLen := (totLen - 2000) div 1000;
     discID := ( ( n mod $FF ) shl 24 ) or ( totLen shl 8 ) or tracks;

     url := url + '+' + lowerCase(IntToHex(discID, 8)) + '+' + inttostr(tracks) + '+' + frames + inttostr(totLen) + GetServerEnd;

     // DISCID og URL er fundet nu!
     if GetHttpString(url, s) and (length(s) > 2) and Q_IsInteger(s[1]+s[2]+s[3]) then
     begin
          s := FixString(s);
          code := StrToInt(s[1]+s[2]+s[3]);
          Q_CutLeft(s, 4);
          if code = 200 then //found exact match !
          begin
               fillChar(CD, SizeOf(CD), 0);

               CD.server := trim(FakeServerEdit.Text);
               CD.cat := Q_CopyRange(s, 1, Q_StrScan(s, ' ')-1);
               Q_CutLeft(s, length(CD.cat)+1);

               CD.discID := correct8Hex(Q_CopyRange(s, 1, Q_StrScan(s, ' ')-1));
               Q_CutLeft(s, length(CD.discID)+1);

               CD.tracks := Q_HexToUInt(Q_CopyFrom(CD.discID, 7));

               a := Q_CopyRange(s, 1, Q_PosStr(CRLF, s)-1);
               if Q_PosStr(' / ', a)>0 then
               begin
                    CD.artist := Q_CopyRange(a, 1, Q_PosStr(' / ', a)-1);
                    CD.albumtitle := Q_CopyFrom(a, Q_PosStr(' / ', a) +3)
               end else
               begin
                    CD.artist := '';
                    CD.albumtitle := a
               end;
               Q_CutLeft(s, length(a)+2);

               addToTree(CD);
               status.Caption := '';
               
               if AutoLoadCD.Checked then
                  cdTree.Selected[cdTree.GetFirst] := true;

               status.Caption := Status.Caption + #13 + GetText(TXT_FoundExact);
               forceRepaint(status)
          end else                                                         
          if code in [210, 211] then //Found inexact matches, list follows (until terminating marker '.')
          begin
               Q_CutLeft(s, Q_PosStr(CRLF, s)+1);
               while (length(s)>0) and (s[1] <> '.') do
               begin
                    fillChar(CD, SizeOf(CD), 0);

                    CD.server := trim(FakeServerEdit.Text);
                    CD.cat := Q_CopyRange(s, 1, Q_StrScan(s, ' ')-1);
                    Q_CutLeft(s, length(CD.cat)+1);

                    CD.discID := Q_CopyRange(s, 1, Q_StrScan(s, ' ')-1);
                    Q_CutLeft(s, length(CD.discID)+1);

                    CD.tracks := Q_HexToUInt(Q_CopyFrom(CD.discID, 7));
                    
                    a := Q_CopyRange(s, 1, Q_PosStr(CRLF, s)-1);
                    if Q_PosStr(' / ', a)>0 then
                    begin
                         CD.artist := Q_CopyRange(a, 1, Q_PosStr(' / ', a)-1);
                         CD.albumtitle := Q_CopyFrom(a, Q_PosStr(' / ', a) +3)
                    end else
                    begin
                         CD.artist := '';
                         CD.albumtitle := a
                    end;
                    Q_CutLeft(s, length(a)+2);

                    addToTree(CD)
               end;
               status.Caption := '';
               if AutoLoadCD.Checked then
                  FindAndDownloadMatch;
               if code = 210 then
                  status.Caption := status.Caption + #13 + GetText(TXT_FoundExact)
               else status.Caption := status.Caption + #13 + GetText(TXT_FoundInexact);
               forceRepaint(status)
          end else
          if code = 202 then
             status.Caption := GetText(TXT_NoMatchFound)
          else
          if code = 403 then
             status.Caption := GetText(TXT_Databaseentryiscorrupt)
          else
          if code = 409 then
             status.Caption := GetText(TXT_Errorconnecting)
          else
              status.Caption := GetText(TXT_Errorconnecting) + ' CDDB error-code: ' + inttostr(code);
     end else
         status.Caption := GetText(TXT_Errorconnecting);

     cdTree.SortTree(0, sdAscending);
     showCorrectTracksClick(nil);
     screen.Cursor := crDefault
end;

procedure TCddbForm.CleanTree;
//fjerner alle nodes i Treet hvor TR.rec = nil
var
   aNode, bNode : PVirtualNode;
   TR : Ptrec;
begin
     aNode := tree.getfirst;
     while aNode <> nil do
     begin
          TR := tree.GetNodeData(aNode);
          TR.save := false;
          if assigned(TR.cdrec) then
             dispose(TR.cdrec);
          TR.cdRec := nil;
          bNode := tree.GetNext(aNode);
          if not assigned(TR.rec) then
             tree.DeleteNode(aNode);
          aNode := bNode
     end;
     updateCheck
end;

procedure TCddbForm.updateCheck;
var
   aNode : PVirtualNode;
begin
     tree.BeginUpdate;
     tree.OnChecked := nil;
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          if assigned(ptrec(tree.GetNodeData(aNode)).rec) and assigned(ptrec(tree.GetNodeData(aNode)).cdRec) then
          begin
               tree.CheckType[aNode] := ctCheckbox;
               if ptrec(tree.GetNodeData(aNode)).save then
                  tree.CheckState[aNode] := csCheckedNormal
               else tree.CheckState[aNode] := csUncheckedNormal
          end
          else tree.CheckType[aNode] := ctNone;
          aNode := tree.GetNext(aNode)
     end;
     tree.OnChecked := TreeChecked;
     tree.endupdate
end;

procedure TCddbForm.ReadCD(CD:Pcd);
Function fixBScodes(s:String):String;
begin
     s := Q_ReplaceText(s, '\\', '\');
     s := Q_ReplaceText(s, '\n', CRLF);
     result := Q_ReplaceText(s, '\t', char(VK_TAB))
end;
Function getField(field:string; s:string):string;
var
   line : string;
   i : integer;
begin
     result := '';
     i := Q_PosText(field, s);
     if i>0 then
     begin
          Q_CutLeft(s, i-1);
          while length(s)>0 do
          begin
               line := Q_CopyRange(s, 1, Q_PosStr(CRLF, s)-1);
               Q_CutLeft(s, length(line)+2);
               if (length(line)>length(field)) and Q_SameTextL(line, field, length(field)) then
                  result := result + trim(Q_CopyFrom(line, length(field)+1))
          end
     end;
     result := fixBScodes(result)
end;
//MAIN
var
   differentArtists, autoorderFailed : boolean;
   s, f, a : String;
   code, i, k : integer;
   offsets : array of integer;
   aNode : PVirtualNode;
   TR : Ptrec;
begin
     status.Caption := GetText(TXT_DownloadingCDInfo);
     forceRepaint(status);
		 screen.Cursor := crHourglass;
     differentArtists := false;     //bestemmer om artist kolonnen skal vises

     if not cd.found then
     begin
          if GetHttpString('http://' + cd.server + '/~cddb/cddb.cgi?cmd=cddb+read+' + CD.cat + '+' + CD.discID + GetServerEnd, s) and (length(s) > 2) and Q_IsInteger(s[1]+s[2]+s[3]) then
          begin
               s := FixString(s);
               code := StrToInt(s[1]+s[2]+s[3]);
               Q_CutLeft(s, Q_PosStr(CRLF, s)+1);
               if code = 210 then //OK, CDDB database entry follows (until terminating marker)
               begin
                    cd.found := true;
                    cd.s := s
               end //else fejl
          end //else fejl
     end;
     if cd.found then
     begin
          cddbArtist.text := cd.artist;
          cddbAlbum.Text := cd.albumtitle;

					s := cd.s;

          Q_CutLeft(s, Q_PosText('Track frame offsets:', s)+22);

					setLength(offsets, 0);
          while Q_IsInteger(trim(Q_CopyRange(s, 2, Q_PosStr(CRLF, s)))) do
          begin
               setLength(offsets, length(offsets)+1);
               offsets[length(offsets)-1] := StrToInt(trim(Q_CopyRange(s, 2, Q_PosStr(CRLF, s))));

               Q_CutLeft(s, Q_PosStr(CRLF, s)+1)
          end;
          a := 'Disc Length:';
          f := trim(Q_CopyRange(s, Q_PosText(a, s) + length(a), Q_PosStr(CRLF, s, Q_PosText(a, s))-1));
					if not Q_IsInteger(f) then
						f := trim(Q_CopyRange(f, 1, Q_StrScan(f, ' '))); //seconds
					if not Q_IsInteger(f) then
          begin
							 status.Caption := GetText(TXT_InvalidDatabaseFormat);
               screen.cursor := crDefault;
							 exit
          end;
          setLength(offsets, length(offsets)+1);
          offsets[length(offsets)-1] := StrToInt(f) * 75;

          cd.tracks := length(offsets)-1;

          //year:
          f := GetField('DYEAR=', s);
          if Q_IsInteger(f) then
             cddbYear.text := f
          else cddbYear.Text := '';

          //genre:
          f := GetField('DGENRE=', s);
          cddbGenre.Text := f;

          //extended data:
          f := GetField('EXTD=', s);
          cddbExt.Caption := trim(f);

          tree.BeginUpdate;
          cleanTree;
          if tree.RootNodeCount < cd.tracks then
             tree.RootNodeCount := cd.tracks;

          //parser tracs   :
          aNode := tree.GetFirst;
          for i:=0 to cd.tracks-1 do
          begin
               TR := tree.GetNodeData(aNode);
               new(TR.cdrec);
               fillChar(TR.cdrec^, SizeOf(Tr.cdrec^), 0);
               TR.save := assigned(TR.rec);

               //length:
               TR.cdRec.ms := Trunc(((offsets[i+1] - offsets[i])/75) * 1000);

               //artist and Title:
               f := 'TTITLE' + inttostr(i) + '=';
               k := Q_PosText(f, s) + length(f);
               a := Q_CopyRange(s, k, Q_PosStr(CRLF, s, k)-1);

							 if Q_PosStr(artistTitleSep.Text, a)>0 then
               begin
                    differentArtists := true;
                    TR.cdRec.artist := trim(fixBScodes(Q_CopyRange(a, 1, Q_PosStr(artistTitleSep.Text, a)-1)));
                    TR.cdRec.title := trim(fixBScodes(Q_CopyFrom(a, Q_PosStr(artistTitleSep.Text, a)+length(artistTitleSep.Text))))
               end else
               begin
                    TR.cdRec.artist := cd.artist;
                    TR.cdRec.title := fixBScodes(a)
               end;

               //"comment"
               f := 'EXTT' + inttostr(i) + '=';
               k := Q_PosText(f, s) + length(f);
               TR.cdRec.comment := trim(fixBScodes(Q_CopyRange(s, k, Q_PosStr(CRLF, s, k)-1)));
               
               aNode := tree.GetNext(aNode)
          end;
          SameArtist.Checked := not differentArtists;
          saveCompilation.Checked := differentArtists;
          if differentArtists then
             tree.Header.Columns[6].Options := tree.Header.Columns[6].Options + [coVisible]
          else tree.Header.Columns[6].Options := tree.Header.Columns[6].Options - [coVisible];

          if autoAutoOrder.Checked then
             autoorderFailed := not autoOrder
          else
          begin
               autoorderFailed := false;
               updateCheck
          end;

          tree.EndUpdate;

          saveBtn.Enabled := true;
          cdInfoPanel.Visible := true;
          AutoOrderBtn.Enabled := true;

          status.Caption := GetText(TXT_Downloaded);
          if autoorderFailed then
             status.Caption := status.Caption + #13 + GetText(TXT_AutoOrderError)
     end else status.Caption := GetText(TXT_DatabaseEntryNotFound);
     screen.Cursor := crDefault
end;

procedure TCddbForm.cdTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
   cd : Pcd;
begin
     cd := cdTree.GetNodeData(Node);
     if length(cd.artist)>0 then
        CellText := cd.artist + ' / ' + cd.albumtitle
     else CellText := cd.albumtitle;
     if not showCorrectTracks.checked and (cd.tracks>0) then
        CellText := '(' + inttostr(cd.tracks) + ') ' + CellText
end;

procedure TCddbForm.cdTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
     finalize(Pcd(Sender.GetNodeData(Node))^)
end;

procedure TCddbForm.TreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
     finalize(Ptrec(Sender.GetNodeData(Node))^)
end;

procedure TCddbForm.TreeDragDrop(Sender: TBaseVirtualTree; Source: TObject;
  DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
  Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
   Attachmode: TVTNodeAttachMode;
   p : array of pointer;
   aNode, Node1, Node2 : PVirtualNode;
   swap : boolean;
begin
      swap := shift = [ssShift];
      //tager "backup" af listen over cdRecs
      setLength(p, tree.rootNodeCount);
      aNode := tree.GetFirst;
      while aNode <> nil do
      begin
           p[aNode.Index] := Ptrec(tree.GetNodeData(aNode)).cdRec;
           aNode := tree.GetNext(aNode)
      end;
      //eo "backup"
      if swap then
      begin
           Node1 := sender.GetFirstSelected;
           Node2 := sender.DropTargetNode;
           if assigned(Node1) and assigned(Node2) and (Node1 <> Node2) then
           begin
                if Node2.index < Node1.index then
                begin //bytter om, så node1.index < node2.index
                     aNode := Node2;
                     Node2 := Node1;
                     Node1 := aNode
                end;
                aNode := tree.GetPrevious(Node2); //aNode er lige før Node2
                tree.MoveTo(Node2, Node1, amInsertBefore, false); //rykker Node2 op foran Node1
                tree.MoveTo(Node1, aNode, amInsertAfter, false); //flytter Node1 til lige efter aNode
           end
           else status.Caption := GetText(TXT_CouldNotSwap)
      end else
      begin // not swap
           case Mode of
                dmAbove:  AttachMode := amInsertBefore;
                dmOnNode: AttachMode := amInsertAfter;
                dmBelow:  AttachMode := amInsertAfter;
                else AttachMode := amNowhere;
           end;
           sender.MoveTo(sender.GetFirstSelected, sender.DropTargetNode, AttachMode, false)
      end;
      //lægger cdRecs i rigtig rækkefølge igen
      aNode := tree.GetFirst;
      while aNode <> nil do
      begin
           Ptrec(tree.GetNodeData(aNode)).cdRec := p[aNode.index];
           if (p[aNode.index] = nil) and (tree.CheckType[aNode] <> ctNone) then
           begin
                tree.CheckState[aNode] := csUncheckedNormal;
                tree.CheckType[aNode] := ctNone
           end;
           if (p[aNode.index] <> nil) and (Ptrec(tree.GetNodeData(aNode)).rec <> nil) and (tree.CheckType[aNode] = ctNone) then
           begin
                tree.CheckState[aNode] := csUncheckedNormal;
                tree.CheckType[aNode] := ctCheckbox
           end;
           aNode := tree.GetNext(aNode)
      end;
      setLength(p, 0)
end;

procedure TCddbForm.TreeDragAllowed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
     Allowed := Column <= 3
end;

procedure TCddbForm.TreeDragOver(Sender: TBaseVirtualTree; Source: TObject;
  Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
  var Effect: Integer; var Accept: Boolean);
begin
     Accept := (shift = []) or ((shift = [ssShift]) and (Mode = dmOnNode))
end;

procedure TCddbForm.TreeColumnResize(Sender: TVTHeader; Column: TColumnIndex);
begin
     cddbDataLabel.Left := tree.left + Sender.Columns[4].left + 8
end;

procedure TCddbForm.FormShow(Sender: TObject);
begin
     TreeColumnResize(tree.Header, 0)
end;

function TCddbForm.AutoOrder:boolean;
function match(c1, c2, delta : cardinal):boolean;
begin
     result := abs(int64(c2) - int64(c1)) <= delta
end;
var
   aNode : PVirtualNode;
   TR : Ptrec;
   ra : array of prec;
   rc : array of Ptrec;
   raFuzzy : array of String;
   rcFuzzy : array of String;
   i, k, delta, useFuzzy : integer;
   noneAssigned, found, failed : boolean;
begin
     failed := false;
     tree.BeginUpdate;
     setLength(ra, 0);
     //samler alle precs sammen
     aNode := tree.GetFirst;
     while aNode <> nil do
     begin
          TR := tree.GetNodeData(aNode);
          if assigned(TR.rec) then
          begin
               setLength(ra, length(ra)+1);
               ra[length(ra)-1] := TR.rec;
               setLength(raFuzzy, length(ra));
               raFuzzy[length(ra)-1] := GetFuzzyText(GetFTextP(TR.rec, FTitle));
               TR.rec := nil
          end;
          if assigned(TR.cdRec) then
          begin
               setLength(rc, length(rc)+1);
               rc[length(rc)-1] := TR;
               setLength(rcFuzzy, length(rc));
               rcFuzzy[length(rc)-1] := GetFuzzyText(TR.cdRec.title)
          end;
          aNode := tree.GetNext(aNode)
     end;

     for useFuzzy:=1 downto 0 do
     for i:=0 to length(rc)-1 do   //løber alle CDrecsene igennem
     begin
          for delta:=0 to 2500 do // 2,5 sekunds forskel maks
          begin
               noneAssigned := true;
               found := false;
               for k:=0 to length(ra)-1 do
               begin
                    if assigned(ra[k]) then
                       noneAssigned := false;
                    if assigned(ra[k]) and not assigned(rc[i].rec) then
                    begin
                         if ((useFuzzy=1) or match(rc[i].cdRec.ms, ra[k].length, delta)) and ((useFuzzy=0) or Q_SameText(raFuzzy[k], rcFuzzy[i])) then
                         begin
                              rc[i].save := true;
                              rc[i].rec := ra[k];
                              ra[k] := nil;
                              found := true;
                              break
                         end
                    end
               end;
               if noneAssigned or found then
                  break;  //delta-løkken
               failed := (delta = 2500) and (useFuzzy = 0)
          end;
          if noneAssigned then
             break
     end;

     //sikrer, at alle recs i ra er uddelt:
     for i:=0 to length(ra)-1 do
         if assigned(ra[i]) then
         begin
              aNode := tree.GetFirst;
              while aNode <> nil do
              begin
                   TR := tree.GetNodeData(aNode);
                   if not Assigned(TR.rec) then
                   begin
                        failed := true;
                        TR.save := false;
                        TR.rec := ra[i];
                        ra[i] := nil;
                        break
                   end;
                   aNode := tree.GetNext(aNode)
              end
         end;
     updateCheck;
     tree.EndUpdate;
     result := not failed
end;

procedure TCddbForm.showCorrectTracksClick(Sender: TObject);
var
   aNode : PVirtualNode;
begin
     cdTree.BeginUpdate;
     aNode := cdTree.GetFirst;
     while aNode <> nil do
     begin
          cdTree.IsVisible[aNode] := not showCorrectTracks.Checked or (list.count = Pcd(cdTree.GetNodeData(aNode)).tracks);
          aNode := cdTree.GetNext(aNode)
     end;
     cdTree.EndUpdate
end;

procedure TCddbForm.Label4Click(Sender: TObject);
begin
     showCorrectTracks.Checked := not showCorrectTracks.Checked
end;

procedure TCddbForm.TreeCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
   r1, r2 : Prec;
begin
     r1 := Ptrec(tree.GetNodeData(Node1)).rec;
     r2 := Ptrec(tree.GetNodeData(Node2)).rec;

     if assigned(r1) and not assigned(r2) then
        result := -1
     else
     if not assigned(r1) and assigned(r2) then
        result := 1
     else
     if assigned(r1) and assigned(r2) then
     case Column of
          0: result := Q_CompText(getFtextP(r1, FFname), getFTextP(r2, FFname));
          1: result := Q_CompText(getFtextP(r1, FTitle), getFTextP(r2, FTitle));
          2: result := r1.Track - r2.Track;
          3: result := r1.Length - r2.Length
          else result := 0
     end
     else result := 0
end;

procedure TCddbForm.TreeHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   p : array of pointer;
   aNode : PVirtualNode;
begin
     if column <= 3 then
     begin
          tree.BeginUpdate;
          //tager "backup" af listen over cdRecs
          setLength(p, tree.rootNodeCount);
          aNode := tree.GetFirst;
          while aNode <> nil do
          begin
               p[aNode.Index] := Ptrec(tree.GetNodeData(aNode)).cdRec;
               aNode := tree.GetNext(aNode)
          end;
          //eo "backup"
          if tree.Header.SortColumn = Column then
             if tree.Header.SortDirection = sdAscending then
                tree.Header.SortDirection := sdDescending
                else tree.Header.SortDirection := sdAscending
          else tree.Header.SortColumn := Column;


          tree.SortTree(Column, tree.Header.SortDirection);

          //lægger cdRecs i rigtig rækkefølge igen
          aNode := tree.GetFirst;
          while aNode <> nil do
          begin
               Ptrec(tree.GetNodeData(aNode)).cdRec := p[aNode.index];
               aNode := tree.GetNext(aNode)
          end;
          setLength(p, 0);
          updateCheck;
          tree.EndUpdate
     end
end;

procedure TCddbForm.cdTreeChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
     if sender.Selected[Node] then
        ReadCD(Sender.GetNodeData(Node))
end;

procedure TCddbForm.cdTreeCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
   s1, s2:widestring;
begin
     cdTreeGetText(sender, Node1, 0, ttNormal, s1);
     cdTreeGetText(sender, Node2, 0, ttNormal, s2);
     result := Q_CompText(s1, s2)
end;

procedure TCddbForm.SavebtnClick(Sender: TObject);
var
   values : TtagValues;
   aNode : PVirtualNode;
   TR: Ptrec;
   i, count : integer;
   saved : boolean;
   errMsg, errMsgTotal: string;
begin
     if cdTree.GetFirstSelected = nil then
        exit;
     saved := false;

     if saveArtist.Checked then
     begin
          setLength(values, length(values)+1);
          values[length(values)-1].field := FArtist
     end;

     if saveAlbum.Checked then
     begin
          setLength(values, length(values)+1);
          values[length(values)-1].field := FAlbum
     end;

     if saveYear.Checked then
     begin
          setLength(values, length(values)+1);
          values[length(values)-1].field := FYear
     end;

     if saveGenre.Checked then
     begin
          setLength(values, length(values)+1);
          values[length(values)-1].field := FGenre
     end;

     if saveTitle.Checked then
     begin
          setLength(values, length(values)+1);
          values[length(values)-1].field := FTitle
     end;

     if saveTrack.Checked then
     begin
          setLength(values, length(values)+1);
          values[length(values)-1].field := FTrack;
          setLength(values, length(values)+1);
          values[length(values)-1].field := FTotalTracks
     end;

     if saveComment.Checked then
     begin
          setLength(values, length(values)+1);
          values[length(values)-1].field := FComment
     end;

     if saveCompilation.Checked then
     begin
          setLength(values, length(values)+1);
          values[length(values)-1].field := FCompilation
     end;

     if length(values)>0 then
     begin
          screen.Cursor := crHourglass;

          //finder count
          count := 0;
          aNode := tree.GetFirst;
          while aNode <> nil do
          begin
               if (tree.CheckType[aNode] = ctCheckBox) and (tree.CheckState[aNode] = csCheckedNormal) then
                  inc(count);
               aNode := tree.GetNext(aNode)
          end;
          //eo Count

          pbar.Position := 0;
          pbar.Max := count;
          status.Visible := false;
          pbar.Visible := true;
          status.Visible := true;

          aNode := tree.GetFirst;
          while aNode <> nil do
          begin
            TR := tree.GetNodeData(aNode);
            if assigned(TR.rec) and assigned(TR.cdRec) and (tree.CheckType[aNode] = ctCheckBox) and (tree.CheckState[aNode] = csCheckedNormal) then
            begin
              status.Caption := GetText(TXT_SavingFile, [getFtextP(TR.rec, FFname)]);
              forceRepaint(status);

              for i:=0 to length(values)-1 do
                   case values[i].field of
                        FArtist :       if SameArtist.Checked then
                                           values[i].value := trim(cddbArtist.text)
                                        else values[i].value := trim(TR.cdRec.artist);
                        FAlbum  :       values[i].value := trim(cddbAlbum.text);
                        FYear   :       values[i].value := trim(cddbYear.Text);
                        FGenre  :       values[i].value := trim(cddbGenre.Text);
                        FTitle  :       values[i].value := trim(TR.cdRec.title);
                        FTrack  :       values[i].value := IntToStr(aNode.index +1);
                        FTotalTracks:   values[i].value := IntToStr(count);
                        FComment:       values[i].value := trim(TR.cdRec.comment);
                        FCompilation:   if SaveCompilation.Checked then
                                           values[i].value := '1' else
                                           values[i].value := '0'
                   end;
              errMsg := '';
              MainFormInstance.UpdateRecValues(TR.rec, values, errMsg, updateTags.Checked);

              if length(errMsg) > 0 then
					    	errMsgTotal := errMsgTotal + CRLF + CRLF + 'Error tagging file "' + MainFormInstance.GetFTextP(list.items[i], FFILENAME) + '":' + CRLF + errMsg;

              pbar.Position := pbar.Position +1;
              saved := true
            end;
            aNode := tree.GetNext(aNode)
     		end
     end;
     pbar.Visible := false;
     if saved then
     begin
          status.Caption := GetText(TXT_TagsSaved);
          screen.cursor := crDefault;
          modalResult := mrOk
     end
     else status.Caption := GetText(TXT_CouldNotSaveTags);
     forceRepaint(status);
     screen.cursor := crDefault;

    if length(errMsgTotal) > 0 then
		begin
		 	Q_CutLeft(errMsgTotal, 2);
		  MainFormInstance.Showmessagex(errMsgTotal)
    end;
end;

procedure TCddbForm.AutoOrderBtnClick(Sender: TObject);
begin
     if not AutoOrder then
        status.Caption := GetText(TXT_AutoOrderError)
end;

procedure TCddbForm.TreeChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
     ptrec(tree.GetNodeData(Node)).Save := tree.CheckState[Node] = csCheckedNormal
end;

procedure TCddbForm.SameArtistClick(Sender: TObject);
begin
     if SameArtist.Checked then
        tree.Header.Columns[6].Options := tree.Header.Columns[6].Options - [coVisible]
     else tree.Header.Columns[6].Options := tree.Header.Columns[6].Options + [coVisible];
end;

procedure TCddbForm.reparseBtnClick(Sender: TObject);
begin
     if cdTree.GetfirstSelected <> nil then
        ReadCD(cdTree.GetNodeData(cdTree.GetFirstSelected))
end;

procedure TCddbForm.userBtnClick(Sender: TObject);
var
   s : String;
begin
     s := UserEmail;
     if MainFormInstance.InputBoxx(Caption, GetText(TXT_cddbChangeUserText), s) then
        if (Q_StrScan(s, '@')>0) and (Q_StrScan(s, '.')>0) then
           UserEmail := s
        else MainFormInstance.ShowMessageX(GetText(TXT_InvalidMailAdress))
end;

procedure TCddbForm.TreeDblClick(Sender: TObject);
var       aNode:PVirtualNode;
          TR:Ptrec;
begin
     aNode := tree.GetFirstSelected;
     if assigned(aNode) then
     begin
          TR := tree.GetNodeData(aNode);
          if assigned(TR.rec) and fileexists(getFtextP(TR.rec, fFilename)) then
             play(getFtextP(TR.rec, fFilename))
     end
end;

procedure TCddbForm.play(s:string);
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


procedure TCddbForm.Panel4Resize(Sender: TObject);
begin
     GroupBox1.Width := panel4.Width - 539;
     cdTRee.Width := GroupBox1.Width - 32;
     Button1.Left := width - 161;
     SaveBtn.Left := width - 307
end;

procedure TCddbForm.TreeEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
     allowed := (Column in [6, 7, 9]) and assigned(ptrec(tree.GetNodeData(Node)).cdRec)
end;

procedure TCddbForm.TreeNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
begin
     if (Column in [6, 7, 9]) and assigned(ptrec(tree.GetNodeData(Node)).cdRec) then
        case Column of
             6: ptrec(tree.GetNodeData(Node)).cdRec.artist := NewText;
             7: ptrec(tree.GetNodeData(Node)).cdRec.title := NewText;
             9: ptrec(tree.GetNodeData(Node)).cdRec.comment := NewText
        end
end;

procedure TCddbForm.SpecifyTagsBtnClick(Sender: TObject);
begin
	pref.PC.ActivePage := pref.TSid3Editor;
	MainFormInstance.Generalconfiguration1Click(sender);
	self.Show
end;

procedure TCddbForm.TreeGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: WideString);
begin
  if assigned(Ptrec(tree.GetNodeData(Node)).rec) then
    HintText := MainFormInstance.GetHint(Ptrec(tree.GetNodeData(Node)).rec)
  else
  	HintText := ''
end;

end.


