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


unit TagEditor;
{
Tag on controls specifies what they belong to:
     10: database
     11: Id3v1
     12: Id3v2
}
interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	StdCtrls, ExtCtrls, ComCtrls, VirtualTrees, BMDThread,
	ImgList, ContNrs,
  MpegAudio,
	Id3tags, QStrings, QStringList, FileCtrl, WAIPC,
	inuptbox2U, math,
  MpegPlus, OggVorbis, ApeTag, WMAfile, Monkey, WavFile,
  MyId3v2Base, JvID3v2Types,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, MEXPtypes,
  JvCombobox, Variants, JvExStdCtrls;

const
	tagDB = 10;
  tagId3v1 = 11;
  tagId3v2 = 12;
  tagApe = 13;
  tagWma = 14;
  tagOgg = 15;

  tagMAX = tagOgg;

type
	TComponentArray = array of TComponent;

type
	TStringArray = array of String;

TUndoType = (
          UTstring,
          UTstringArray,
          UTinteger,
          UTchecked,
          UTcomments,
          UTroles,
          UTgenres,
          UTgroups,
          UTcustomFields,
          UTTagFields
          );

//UNDO
TundoRec = Record
				 UndoType : TundoType;
         Obj : TObject;
         OrigState : boolean;
         Gray : boolean;
         p:pointer
end;
PundoRec = ^TUndoRec;

type
  TLanguageCombo = class(TInterfacedObject, IVTEditLink)
  private
    FComboBox: TJvCombobox;
    FEditing: Boolean;
    FEditNode: PVirtualNode;
		FEditTree: TBaseVirtualTree;
		FNodeRect: TRect;
  public
		constructor Create;
    destructor Destroy; override;

		Procedure LanguageComboLeave(Sender:Tobject);
		function BeginEdit: Boolean; stdcall;
    function CancelEdit: Boolean; stdcall;
    function EndEdit: Boolean; stdcall;
    function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
		function GetBounds: TRect; stdcall;
    procedure ProcessMessage(var Message: TMessage); stdcall;
		procedure SetBounds(R: TRect); stdcall;

    property ComboBox: TJvCombobox read FComboBox write FComboBox;
    property EditNode: PVirtualNode read FEditNode write FEditNode;
    property EditTree: TBaseVirtualTree read FEditTree write FEditTree;
    property Editing: Boolean read FEditing write FEditing;
    property NodeRect: TRect read FNodeRect write FNodeRect;
  end;

  TstatRec = Record
        ref : pointer;
				HasV1 : boolean;
				HasV2 : boolean;
				HasApe : boolean;
				HasWma : boolean;
				HasOgg : boolean;
				Id3V2ver : TJvID3Version;
				V1Changed : boolean;
				v2Changed : boolean;
				apeChanged : boolean;
				wmaChanged : boolean;
				oggChanged : boolean;
				FileExists : boolean;

				MpegDataStartPos : integer;
				HasTagLyrics : array[tagId3v1..tagMAX] of boolean; 	//Lyrics in
				HasLyrics3V1 : boolean;
				HasLyrics3V2 : boolean;
//				hasPrivateFrame : boolean;

        writeAble : boolean;
				readAble : boolean;
				Lyrics : string;
				Status : String;
				values:array of pointer;
end;
PstatRec = ^TstatRec;

type
  TGenresCombo = class(TInterfacedObject, IVTEditLink)
  private
    FComboBox: TJvCombobox;
    FEditing: Boolean;
    FEditNode: PVirtualNode;
    FEditTree: TBaseVirtualTree;
    FNodeRect: TRect;
  public
    constructor Create;
    destructor Destroy; override;

//    Procedure GenresComboLeave(Sender:Tobject);
		function BeginEdit: Boolean; stdcall;
		function CancelEdit: Boolean; stdcall;
    function EndEdit: Boolean; stdcall;
    function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
    function GetBounds: TRect; stdcall;
    procedure ProcessMessage(var Message: TMessage); stdcall;
    procedure SetBounds(R: TRect); stdcall;

    property ComboBox: TJvCombobox read FComboBox write FComboBox;
    property EditNode: PVirtualNode read FEditNode write FEditNode;
    property EditTree: TBaseVirtualTree read FEditTree write FEditTree;
    property Editing: Boolean read FEditing write FEditing;
    property NodeRect: TRect read FNodeRect write FNodeRect;
  end;

Type
TCustomFieldRec = Record
	FieldIndex: Integer;
  gray: Boolean;
  value: String;
end;
PCustomFieldRec = ^TCustomFieldRec;

  TEditor = class(TForm)
		ReadMpegInfo: TBMDThread;
    ImageList1: TImageList;
    UndoImages: TImageList;
    Panel4: TPanel;
    SaveBtn: TButton;
    CancelBtn: TButton;
    pbar: TProgressBar;
    LyricsThread: TBMDThread;
		cleanNewStrings: TCheckBox;
    Panel1: TPanel;
    Bevel4: TBevel;
    LyricsBox: TGroupBox;
    Bevel7: TBevel;
    netStatus: TLabel;
    LyricsList: TVirtualStringTree;
    GetFromInternet: TCheckBox;
    GroupsBox: TGroupBox;
    Bevel5: TBevel;
    SaveGroups: TCheckBox;
    GroupCheck: TVirtualStringTree;
    CBcompilation: TCheckBox;
    PageControl1: TPageControl;
    TabValues: TTabSheet;
    Label9: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Track: TEdit;
    Artist: TJvCombobox;
    Title: TJvCombobox;
    Album: TJvCombobox;
    genreCover: TCheckBox;
    genreRemix: TCheckBox;
    Genre: TVirtualStringTree;
    AddGenre: TButton;
    DelGenre: TButton;
    year: TEdit;
    comment: TEdit;
    GroupBox2: TGroupBox;
    CFROM1010: TRadioButton;
    CFROM1011: TRadioButton;
    CFROM1012: TRadioButton;
    CFROM1013: TRadioButton;
    CFROM1014: TRadioButton;
    CFROM1015: TRadioButton;
    TabId3v1: TTabSheet;
    Label18: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label22: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Bevel3: TBevel;
    Id3v1Track: TEdit;
    Id3v1Artist: TJvCombobox;
    Id3v1Title: TJvCombobox;
    Id3v1Album: TJvCombobox;
    Id3v1Year: TEdit;
    Id3v1Comment: TEdit;
    Id3v1Genre: TJvCombobox;
    GroupBox3: TGroupBox;
    CFROM1111: TRadioButton;
    CFROM1110: TRadioButton;
    CFROM1112: TRadioButton;
    CFROM1113: TRadioButton;
    TabId3v2: TTabSheet;
    Panel2: TPanel;
		Panel3: TPanel;
    Label14: TLabel;
    Label40: TLabel;
    Label35: TLabel;
    TRCK: TEdit;
    TRCKtotal: TEdit;
    TBPM: TEdit;
    PanelTitle: TPanel;
    Label26: TLabel;
    Label2: TLabel;
    label37: TLabel;
    Label38: TLabel;
    Bevel1: TBevel;
    TIT1: TEdit;
    TIT2: TJvCombobox;
    TIT3: TEdit;
    TPE4: TEdit;
    ToggleTitle: TButton;
    PanelArtist: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label39: TLabel;
    Label36: TLabel;
    Label8: TLabel;
    Bevel2: TBevel;
    TPE1: TJvCombobox;
    TPE2: TEdit;
    TPE3: TEdit;
    TOPE: TEdit;
    TCOM: TEdit;
    ToggleArtist: TButton;
    PanelAlbum: TPanel;
    Label3: TLabel;
    Label41: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LangLabel: TLabel;
    DizLabel: TLabel;
    TextLabel: TLabel;
    TALB: TJvCombobox;
    CommTree: TVirtualStringTree;
    TLAN: TJvCombobox;
    CommAdd: TButton;
    CommDel: TButton;
    V2Cover: TCheckBox;
    V2Remix: TCheckBox;
    COMMdiz: TEdit;
    COMMtext: TMemo;
    COMMlanguage: TJvCombobox;
    TCON: TVirtualStringTree;
    AddTCON: TButton;
		DelTCON: TButton;
    v2Scroll: TScrollBar;
    GroupBox4: TGroupBox;
    CFROM1212: TRadioButton;
    CFROM1210: TRadioButton;
    CFROM1211: TRadioButton;
    CFROM1213: TRadioButton;
    TabApe: TTabSheet;
    Label33: TLabel;
    Label34: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    ApeTrack: TEdit;
    ApeArtist: TJvCombobox;
    ApeTitle: TJvCombobox;
    ApeAlbum: TJvCombobox;
    ApeYear: TEdit;
    ApeGenre: TJvCombobox;
    GroupBox5: TGroupBox;
    CFROM1313: TRadioButton;
    CFROM1310: TRadioButton;
    CFROM1311: TRadioButton;
    CFROM1312: TRadioButton;
    TabWMA: TTabSheet;
    GroupBox6: TGroupBox;
		CFROM1414: TRadioButton;
    CFROM1410: TRadioButton;
    TabOgg: TTabSheet;
    GroupBox7: TGroupBox;
    CFROM1515: TRadioButton;
    CFROM1510: TRadioButton;
    TabId3v2X1: TTabSheet;
    TabLyrics: TTabSheet;
    LyricsMemo: TMemo;
    CBhasId3v1Tag: TCheckBox;
    CBhasId3v2Tag: TCheckBox;
    HasLyrics: TCheckBox;
    Id3v2VerPanel: TPanel;
    id3v23: TRadioButton;
		id3v24: TRadioButton;
    tagLyrics: TCheckBox;
    Lyrics3v1: TCheckBox;
    Lyrics3v2: TCheckBox;
    CBhasApeTag: TCheckBox;
    CBHasWMAtag: TCheckBox;
    CBhasOggTag: TCheckBox;
    Stat: TVirtualStringTree;
    readFileThread: TBMDThread;
    IdHttp: TIdHTTP;
    SaveThread: TBMDThread;
    Label67: TLabel;
    TotalTracks: TEdit;
    Label68: TLabel;
    ApeTotalTracks: TEdit;
    Label70: TLabel;
    PartOfSet: TEdit;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    MpegInfo: TLabel;
    Label72: TLabel;
    totalParts: TEdit;
    CustomFieldTree: TVirtualStringTree;
    SyncTabs: TCheckBox;
    Label74: TLabel;
    Label71: TLabel;
    ArtistSortOrder: TJvComboBox;
    Label73: TLabel;
    TPOS: TEdit;
    Label75: TLabel;
    TPOStotal: TEdit;
    Label5: TLabel;
    TYER: TEdit;
    Bevel10: TBevel;
    Label76: TLabel;
    TSOP: TJvComboBox;
    Label77: TLabel;
    ApePartOfSet: TEdit;
    Label78: TLabel;
    ApeTotalParts: TEdit;
    Label79: TLabel;
    ApeArtistSortOrder: TJvComboBox;
    Label46: TLabel;
    ApeComment: TEdit;
    Panel5: TPanel;
    Label54: TLabel;
    OggTrack: TEdit;
    Label69: TLabel;
    OggTotalTracks: TEdit;
    Label85: TLabel;
    OggArtistSortOrder: TJvComboBox;
    OggVersion: TEdit;
    Label66: TLabel;
    Label65: TLabel;
    OggCopyright: TEdit;
    OggGenre: TJvComboBox;
    Label60: TLabel;
    Label59: TLabel;
    OggComment: TEdit;
    OggPartOfSet: TEdit;
    Label83: TLabel;
    Label57: TLabel;
    OggAlbum: TJvComboBox;
    OggTitle: TJvComboBox;
    Label56: TLabel;
    Label55: TLabel;
    OggArtist: TJvComboBox;
    Label58: TLabel;
    OggYear: TEdit;
    scrollBarOgg: TScrollBar;
    OggOtherFields: TVirtualStringTree;
    btnAddOggOtherField: TButton;
    btnDelOggOtherField: TButton;
    timFocusSecondColumn: TTimer;
    Label84: TLabel;
    Label86: TLabel;
    ApeOtherFields: TVirtualStringTree;
    Button1: TButton;
    Button2: TButton;
    Panel6: TPanel;
    scbWma: TScrollBar;
    Label47: TLabel;
    WMAtrack: TEdit;
    Label48: TLabel;
    WMAArtist: TJvComboBox;
    Label49: TLabel;
    WMATitle: TJvComboBox;
    WMAAlbum: TJvComboBox;
    Label50: TLabel;
    Label80: TLabel;
    WMAPartOfSet: TEdit;
    Label52: TLabel;
    WMAComment: TEdit;
    Label53: TLabel;
    WMAGenre: TJvComboBox;
    Label61: TLabel;
    WMARating: TEdit;
    Label62: TLabel;
    WMACopyright: TEdit;
    Label63: TLabel;
    WMAAlbumCover: TEdit;
    Label64: TLabel;
    WMAPromotion: TEdit;
    Label82: TLabel;
    WMAartistSortOrder: TJvComboBox;
    WMATotalParts: TEdit;
    Label81: TLabel;
    Label51: TLabel;
    WMAYear: TEdit;
    Label87: TLabel;
    wmaOtherFields: TVirtualStringTree;
    Button3: TButton;
    Button4: TButton;
    Panel7: TPanel;
    Label11: TLabel;
    TCOP: TEdit;
    Label25: TLabel;
    TOWN: TEdit;
    Label24: TLabel;
    TPUB: TEdit;
    Label13: TLabel;
    TENC: TEdit;
    TEXT: TEdit;
    Label10: TLabel;
    Label12: TLabel;
    WXXX: TEdit;
    Label15: TLabel;
    TMCL: TVirtualStringTree;
    AddMusiciansBut: TButton;
    DelMusiciansBut: TButton;
    TIPL: TVirtualStringTree;
    AddInvPeopleBut: TButton;
    DelInvPeopleBut: TButton;
    Label23: TLabel;
    Label88: TLabel;
    Id3v2OtherFields: TVirtualStringTree;
    Button5: TButton;
    Button6: TButton;
    v2ExtraScroll: TScrollBar;
		procedure FormCreate(Sender: TObject);
		procedure ReadMpegInfoStart(Sender: TObject; Thread: TBMDExecuteThread;
      var Data: Pointer);
    procedure ReadMpegInfoExecute(Sender: TObject;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure CommTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
    procedure TMCLGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
    procedure TRCKChange(Sender: TObject);
    procedure ToggleTitleClick(Sender: TObject);
    procedure ToggleArtistClick(Sender: TObject);
		procedure CBhasTagClick(Sender: TObject);
		procedure ArtistChange(Sender: TObject);
    procedure UndoRefPictClick(Sender: TObject);
		procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CommAddClick(Sender: TObject);
    procedure CommTreeCreateEditor(Sender: TBaseVirtualTree;
			Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure CommTreeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure COMMFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure CommTreeNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; Text: WideString);
    procedure CommDelClick(Sender: TObject);
    procedure AddMusiciansButClick(Sender: TObject);
		procedure DelMusiciansButClick(Sender: TObject);
    procedure DelInvPeopleButClick(Sender: TObject);
		procedure AddInvPeopleButClick(Sender: TObject);
    procedure TMCLFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure TIPLEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure TIPLNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
			Column: TColumnIndex; Text: WideString);
    procedure TIPLInitNode(Sender: TBaseVirtualTree; ParentNode,
			Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
		Procedure UpdateCheckBoxes(Sender: TObject);
		procedure Lyrics3v1Click(Sender: TObject);
    procedure Lyrics3v2Click(Sender: TObject);
				procedure COMMExit(Sender: TObject);
    procedure CommDelDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure CommTreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure COMMdizChange(Sender: TObject);
    procedure COMMtextChange(Sender: TObject);
    procedure COMMlanguageClick(Sender: TObject);
    procedure COMMlanguageChange(Sender: TObject);
    procedure v2ScrollScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure ArtistExit(Sender: TObject);
		procedure TCONCreateEditor(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure TCONGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
    procedure DelTCONClick(Sender: TObject);
		procedure AddTCONClick(Sender: TObject);
    procedure AddGenreClick(Sender: TObject);
    procedure DelGenreClick(Sender: TObject);
    procedure GenreEdited(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure TCONEdited(Sender: TBaseVirtualTree; Node: PVirtualNode;
			Column: TColumnIndex);
    procedure COMMlanguageExit(Sender: TObject);
    procedure COMMdizExit(Sender: TObject);
    procedure genreCoverKeyPress(Sender: TObject; var Key: Char);
    procedure genreCoverMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GroupCheckGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var Text: WideString);
    procedure GroupCheckChecking(Sender: TBaseVirtualTree;
			Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure StatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure StatFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure StatChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
		procedure GenreFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure CommTreeFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
		procedure TMCLFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure SaveGroupsClick(Sender: TObject);
    procedure GroupCheckChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure LyricsThreadExecute(Sender: TObject;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure LyricsListFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure LyricsListGetText(Sender: TBaseVirtualTree;
			Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
			var CellText: WideString);
    procedure LyricsListDblClick(Sender: TObject);
    procedure LyricsListCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure GetFromInternetClick(Sender: TObject);
		procedure PageControl1Change(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
		procedure CFROM_Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure readFileThreadExecute(Sender: TObject;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure FillLyricsList(Sender: TBMDThread;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure SaveThreadExecute(Sender: TObject; Thread: TBMDExecuteThread;
      var Data: Pointer);
    procedure StatRecProcessed(Sender: TBMDThread;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure StatFocusNode(Sender: TBMDThread;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure SetMpeginfoCaption(Sender: TBMDThread;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure doAfterSave(Sender: TBMDThread; Thread: TBMDExecuteThread; var Data: Pointer);
    procedure CustomFieldTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure CustomFieldTreeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
//    procedure CustomFieldTreeBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
//    Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure CustomFieldTreeEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure CustomFieldTreeNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure CustomFieldTreeFocusChanging(Sender: TBaseVirtualTree;
      OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure CustomFieldTreeFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure ArtistDropDown(Sender: TObject);
    procedure AlbumDropDown(Sender: TObject);
    procedure scrollBarOggScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure OggOtherFieldsNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure OggOtherFieldsBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
    Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure OggOtherFieldsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure btnAddOggOtherFieldClick(Sender: TObject);
    procedure OggOtherFieldsEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure OggOtherFieldsEdited(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure timFocusSecondColumnTimer(Sender: TObject);
    procedure btnDelOggOtherFieldClick(Sender: TObject);
    procedure TabWMAShow(Sender: TObject);
    procedure scbWmaScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure wmaOtherFieldsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure v2ExtraScrollScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure TabId3v2X1Show(Sender: TObject);
    procedure StatGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: WideString);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CommTreeBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
    Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure Id3v2OtherFieldsBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
    Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure Id3v2OtherFieldsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure Id3v2OtherFieldsNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure Id3v2OtherFieldsEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure CustomFieldTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect;
      var ContentRect: TRect);

  private
				WindowShowBoolsSet,winampShowed, plShowed, eqShowed, mbShowed: boolean;
        function IsId3v2Control(const fieldName: string; checkFrom: TWinControl): Boolean;
				function LoadValues: Boolean;
				procedure UpdateImageIndexes;
				Procedure ShowUndo(Sender: TObject);
        Procedure AddToStat(Thread:TBMDExecuteThread; SR:PstatRec; S:String; focus:boolean=true);
				Function HasChanged(Sender: TObject;  SR:PstatRec):Boolean;
        Function CustomFieldChanged(cfr:PCustomFieldRec; SR:PstatRec):Boolean;
        procedure FieldChanged(Sender: TObject; skipGrayOut:boolean=false);
        Function getSyncCheck(Obj: TObject; includeGenreCB:boolean=false):Boolean;
				Function GetSourceComponents(target:TComponent):TComponentArray;
				function GetDbControlNamesFromId3v2Name(control: TControl):TStringArray;
				function GetId3v2ControlNamesFromDatabaseName(control: String):TStringArray;
//        function doGetSaveChanged(Obj:TControl; pSR:pointer; version:integer):boolean;
        Procedure CreateUndoIcons;
        function NeedOfNewUndo(sender: TObject):Boolean;
				Function GetFText(P:Pointer;Field:integer):String;
				Function SaveV2Frame(id3v2: TMyID3Controller; FrameName:String; SR:PstatRec; version: TJvId3Version):Integer;
				Function UpdateStringValueTabSync (SR:PstatRec; Obj:TControl; var value:string; id3v2Version: TJvId3Version = iveLowerThan2_2 ):boolean;
				procedure SaveDBGenre(SR:PstatRec; pR:pointer);
//        function GetStringFromSR(pSR:pointer; Comp:TComponent):String;
				function GetV2GenreToSave(p:pointer; version: TJvId3Version):String;
//        function FindMatchingDBcomp(comp:TComponent):Tcomponent;
        Procedure setBoxValue(Obj: TObject; Value:String; createNewUndo:Boolean; copyGraySettings:boolean=false; graySetting:boolean=false); overload;
        Function getBoxValue(Obj: TObject):String;
//        Function getV1GenreFromTree(aTree:TBaseVirtualTree):String;
				Function getV1GenreFromUndoGenres(pUR:pointer; Id3v1Compatible: Boolean):String;
				Procedure setV1Genre(s:String);
				Function getRealV1Genre(s:String):integer;
        Function cleanString(s:string;force:boolean=false):string;
				Function GetSRvalueIndex(Obj:TObject; SR:PstatRec):integer;
				procedure addGenreToRec(p:pointer; s:string);
				Procedure FillValuesToBoxes;
				function GetTagSupported(tagID: Integer):boolean; overload;
				function GetTagSupported(tagID: Integer; pSR: Pointer):Boolean; overload;
//        procedure ToggleCopySettings(tagIdSource:integer; tagIdTarget:integer=-1);
//        function GetCopySettings(tagIdTarget:integer):integer;
				procedure UpdateCopyButtons;
				procedure CheckDefaultLyricsVersion;
        procedure SaveLyrics3(Fstr:TStream; pSR:pointer);
				procedure LoadLyrics3(Fstr:TStream; pSR:pointer);

        function IsOtherFieldsTree(obj: TObject): boolean;

		{ Private declarations }
	public
        AnythingChanged: Boolean;
        MultipleFiles : Boolean;
				FileExist : Boolean;
        TagLoaded : Boolean;
        MpegReaderTerminated : Boolean;

//				FId3v2 : Tid3v2tagEx;
				FId3v1 : TID3v1Tag;
				FApe : TApeTag;
				FWma : TWmaFile;
				FOgg : TOggVorbis;
				FMonkey : TMonkey;

				v1Components : TComponentlist;
				v2Components : TComponentlist;
				apeComponents : TComponentlist;
				oggComponents : TComponentlist;
				wmaComponents : TComponentlist;

        Recs : TList;

        undoList:TList;

				function LyricsChanged(pSR:pointer; onlyFileTag:boolean=false):boolean;
        function HasTagLyrics(pSR:pointer): Boolean;
				procedure FillInValues(Thread:TBMDExecuteThread; Pr:pointer; pSR:pointer; firstRun:boolean; updateStats:boolean=true; useFileWriteBeginEnd: Boolean = true);
//        procedure SaveMouseOverBackup(Obj: array of Tobject);
//        procedure LoadMouseOverBackup;
//        procedure FreeMouseOverBackup(setChanged:boolean);
        function checkIfAllGenresAllowed(aTree: TBaseVirtualTree):Boolean;
        function getFirstComment:string;
				Procedure AddCommentToTree(Language : Integer; Description : String; Value : String); overload;
        Procedure AddGenreToTree(Tree : TVirtualStringTree; Text : String);
//        procedure CopyDatabaseToTags;
        function IsV1Genre(s:String):Boolean;
        procedure copyGenres(source:TVirtualStringTree; target:TVirtualStringTree); overload;
				procedure copyGenres(source:String; target:TVirtualStringTree); overload;
        Function CreateUndo(sender: TObject; origState:boolean=false): Boolean;
				procedure deleteUndo(index:integer);
				procedure doDeleteUndo(p:pointer);
        Procedure doUndo(sender: TObject);
        Procedure doInternalUndo(p:pointer; updateGUI:Boolean);
//        procedure createUndoStream(aTree : TVirtualStringTree; const s:TStream);
        function CanUndo(sender:TObject):Boolean;
        Procedure SetBoxValue(Obj: TObject; Value:Tobject;  undoCreated: Boolean; createNewUndo:Boolean; copyGraySettings:boolean=false); overload;
				function doCreateUndo(sender: TObject; origState:boolean; Gray:boolean): pointer;
        procedure UpdateChangedCaption;
				function getHasTagVerChanged(TagType:integer; pSR:pointer):boolean;
				function GetHasTag(TagType: Integer; pSR:pointer):Boolean;
				function EqualUndoRecs(p1, p2:pointer; GrayAllowedInCheckedTree: Boolean=false):boolean;
        function EqualUndoRecContents(currentSource, originalSource, currentTarget, originalTarget:PundoRec):boolean;
        function DiffersFromOrigState(index:integer):boolean;
        procedure setGrayed(target: TObject; value:boolean; clear:boolean=false);
        function getGrayed(target: TObject): boolean;
//				Procedure AddRoleToTree(Tree : TVirtualStringTree; Role : String; Name : String); overload;
//				Procedure AddRoleToTree(Tree : TVirtualStringTree; p:pointer); overload;

				function Init: Boolean;
    { Public declarations }
  end;

TValuesRecord = Record
				Artist:String;
        Title:String;
        Album: String;
				Genre:String;
				Year:String;
				Comment:String;
        Track :String;
        Applied: boolean
end;

Tlyrics3fields = Record
        ident:string;
				length:integer;
				value:string
end;
Plyrics3fields = ^Tlyrics3fields;

TlyricsRec = Record
        title:string;
				URL:string;
        loaded:boolean;
        lyrics:string
end;
PlyricsRec = ^TlyricsRec;

TCommRec = Record
	Gray: boolean;
  Description : String;
  Value : String;
  Language : Integer;
  Empty : Boolean
end;
PcommRec = ^TcommRec;

TroleRec = Record
        Role : String;
        Name : String;
        Empty : Boolean
end;
ProleRec = ^TroleRec;

TgenreRec = Record
        Text : String;
end;
PgenreRec = ^TgenreRec;

TgroupCheckRec = Record
        index : integer;
        canGray : boolean;
end;
PgroupCheckRec = ^TgroupCheckRec;

TTagFieldRec = Record
  gray: Boolean;
  fieldName: string;
  description: string;
  value: String;
end;
PTagFieldRec = ^TTagFieldRec;

TundoTagFields = Record
	arr: array of TTagFieldRec
end;
PundoTagFields = ^TundoTagFields;

TundoGroups = Record
	arr : array of Tcheckboxstate
end;
PundoGroups = ^TundoGroups;

TundoString = Record
            s : String
end;
PundoString = ^TundoString;

TundoStringArray = Record
	arr : array of String
end;
PundoStringArray = ^TundoStringArray;

TundoChecked = Record
            b : TCheckBoxState
end;
PundoChecked = ^TundoChecked;

TundoInteger = Record
             i : integer;
end;
PundoInteger = ^TundoInteger;

TundoGenres = Record
           cover : TcheckboxState;
           remix : TcheckboxState;
           arr : array of string;
end;
PundoGenres = ^TundoGenres;

TundoCustomFields = Record
	arr : array of TCustomFieldRec;
end;
PundoCustomFields = ^TundoCustomFields;

TundoComments = Record
					 arr : array of PcommRec;
end;
PundoComments = ^TundoComments;

TundoRoles = Record
           arr : array of ProleRec;
end;
PundoRoles = ^TundoRoles;

TlyricParseRec = Record
               url:string;
							 html:string
end;

TFillInValueProcedureInfo = Record
	Pr:pointer;
	pSR:pointer;
	firstRun:boolean;
	updateStats: Boolean;
	useFileWriteBeginEnd: Boolean;
end;
PFillInValueProcedureInfo = ^TFillInValueProcedureInfo;

Const
		 colorGray :TColor = $00E6E6E6;
		 colorWhite :TColor = clWhite;

		 ApeOggGroupIdent : String = 'MEXP GROUP';
		 ApeOggCompilationIdent : String = 'MEXP COMPILATION';

     ApeOggWmaRatingIdent: string = 'RATING';

		 WMAGroupIdent : String = 'MEXP/GROUP';
		 WMACompilationIdent : String = 'MEXP/COMPILATION';

		 TagNames: array[10..15] of String =
							('', 'Id3v1', 'Id3v2', 'Ape', 'WMA', 'Ogg');

		 Id3v2ControlNames: array[1..13] of array[1..2] of String =
												(('TRCK', 'Track'), ('TRCKtotal', 'TotalTracks'), ('TIT2', 'title'),
                        ('TPE1', 'Artist'), ('TALB', 'Album'), ('CommTree', 'Comment'),
                        ('TYER', 'Year'), ('TCON', 'Genre'), ('TPOS', 'PartOfSet'),
                        ('TPOSTotal', 'TotalParts'), ('TSOP', 'ArtistSortOrder'),
                        ('CommTree', 'CustomFieldTree'), ('Id3v2OtherFields', 'CustomFieldTree')
                        );

var
	Editor: TEditor;
	MouseOverBackup : TValuesRecord;
	copyTagSettings : array[tagDB..tagMAX] of integer;   //hvis copyTagSettings[tagDB] = tagIdv2, så kopieres værdierne fra id3v2 over i db
	HasTagCheckboxes: array[tagId3v1..tagMAX] of TCheckbox;

implementation

Uses
	Defs, MainForm, prefernces, LanguageConstants;
{$R *.DFM}

{ TLanguageCombo }

function TLanguageCombo.BeginEdit: Boolean;
begin
  if Assigned(ComboBox) then
  begin
    Result := True;
		Combobox.ItemIndex := PCommRec(EditTree.GetNodeData(EditNode)).Language;
		ComboBox.Show;
    ComboBox.SetFocus;
    Editing := True;
  end else
    Result := False;
end;

function TLanguageCombo.CancelEdit: Boolean;
begin
  Result := True;  // Always allow a cancel
  if Editing then
  begin
    Editing := False;
    ComboBox.Hide;
		if  EditTree.CanFocus then EditTree.SetFocus;
    EditTree := nil;
    EditNode := nil;
  end
end;

constructor TLanguageCombo.Create;
begin
  ComboBox := TJvComboBox.Create(nil); // Nobody owns it
  ComboBox.Visible := False;
  ComboBox.Sorted := false;
  Combobox.Style := csDropDownList;
  Combobox.AutoComplete := false;
  Combobox.OnExit := LanguageComboLeave;
end;

destructor TLanguageCombo.Destroy;
begin
  ComboBox.Items.clear;
  ComboBox.Free;
  inherited;
end;

Procedure TLanguageCombo.LanguageComboLeave(Sender:TObject);
begin
	Editor.CommTree.EndEditNode
end;

function TLanguageCombo.EndEdit: Boolean;
var
  NodeData: PCommRec;
begin
  Result := True;  // Always allow end
  if Editing then
  begin
    NodeData := EditTree.GetNodeData(EditNode);
    if Combobox.text = '' then NodeData^.Language := -1 else NodeData^.Language := ComboBox.ItemIndex;
    NodeData.Empty := false;
    EditTree := nil;
    EditNode := nil
  end
end;

function TLanguageCombo.GetBounds: TRect;
begin
//  Result := ComboBox.BoundsRect skal ikke være der
end;

function TLanguageCombo.PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
var
  NodeData: PCommRec;
begin
  Result := False;
  if Assigned(ComboBox) then
  begin
    Result := True;
    EditTree := Tree;
    ComboBox.Parent := EditTree;
    EditNode := Node;
		ComboBox.Items.clear;
    FillLanguagesToTStrings(ComboBox.Items);

    NodeData := Tree.GetNodeData(Node);
    Combobox.ItemIndex := NodeData.Language;

    NodeRect := Tree.GetDisplayRect(Node, Column, False, False);
    ComboBox.Top := NodeRect.Top;
    ComboBox.Left := NodeRect.Left;
    if Column = -1 then
       combobox.width := Tree.ClientWidth else
       combobox.width := TVirtualStringTree(tree).header.Columns.Items[column].width;
		ComboBox.Height := 100;
    ComboBox.ItemIndex := 0;
  end
end;

procedure TLanguageCombo.ProcessMessage(var Message: TMessage);
begin
  ComboBox.WindowProc(Message);
end;

procedure TLanguageCombo.SetBounds(R: TRect);
begin
  ComboBox.BoundsRect := R
end;

{ END OF        TLanguageCombo }

{ TGenresCombo }

function TGenresCombo.BeginEdit: Boolean;
begin
	if Assigned(ComboBox) then
  begin
    Result := True;
    //Combobox.ItemIndex := PCommRec(EditTree.GetNodeData(EditNode)).Language;
    Combobox.Text := PgenreRec(Edittree.getNodeData(editNode)).text;
    ComboBox.Show;
    ComboBox.SetFocus;
    Editing := True;
  end else
    Result := False;
end;

function TGenresCombo.CancelEdit: Boolean;
begin
  Result := True;  // Always allow a cancel
  if Editing then
  begin
    Editing := False;
    ComboBox.Hide;
    if  EditTree.CanFocus then EditTree.SetFocus;
    EditTree := nil;
    EditNode := nil;
	end
end;

constructor TGenresCombo.Create;
begin
  ComboBox := TJvComboBox.Create(nil); // Nobody owns it
  ComboBox.Visible := False;
  ComboBox.flat := true;
  ComboBox.Sorted := true;
  Combobox.Style := csDropDown;
  Combobox.AutoComplete := false;
	Combobox.OnExit := nil//GenresComboLeave
end;

destructor TGenresCombo.Destroy;
begin
	ComboBox.Free;
	inherited;
end;

function TGenresCombo.EndEdit: Boolean;
var      i,x:integer;
				 aNode : PVirtualNode;
begin
	Result := True;  // Always allow end
	if Editing then
	begin
			 //combobox.ItemIndex := GetGenreID(combobox.text); duer ikke da genrelisten i comboboxen er sorteret
			 if comboBox.Style = csDropDownList then if comboBox.text <> '' then
			 begin
						//i := comboBox.items.IndexOf(comboBox.text);
						x:=-1;
						for i:=0 to comboBox.Items.count-1 do if Q_SameText(comboBox.text, combobox.items.strings[i]) then x := i;
						if x = -1 then comboBox.text := '' else comboBox.ItemIndex := x
			 end;
			 //finder dupes
			 aNode := EditTree.getFirst;
			 while aNode <> nil do
			 begin
						if aNode <> editNode then
						begin
								 if Q_SameText(PgenreRec(Edittree.getNodeData(aNode)).text, comboBox.text) then
								 begin
											comboBox.ItemIndex := -1;
											break
								 end
						end;
						aNode := editTree.getNext(aNode)
			 end;
			 PgenreRec(Edittree.getNodeData(editNode)).text := comboBox.text;
			 EditTree := nil;
			 EditNode := nil
	end
end;

function TGenresCombo.GetBounds: TRect;
begin
  Result := ComboBox.BoundsRect
end;

function TGenresCombo.PrepareEdit(Tree: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex): Boolean;
var
  NodeData: PCommRec;
  i:integer;
begin
  Result := False;
  if Assigned(ComboBox) then
  begin
    Result := True;
		EditTree := Tree;
    ComboBox.Parent := EditTree;
    EditNode := Node;
    ComboBox.Items.clear;
    if Editor.checkIfAllGenresAllowed(Tree) then
    begin
         ComboBox.Items.AddStrings(genreList);
         Combobox.Style := csDropDown
    end else
    begin
         for i:=0 to MaxGenres do ComboBox.items.add(Genres[i]);
         ComboBox.Style := csDropDownList
    end;
    combobox.sorted := true;

    NodeData := Tree.GetNodeData(Node);
		Combobox.ItemIndex := NodeData.Language;

    NodeRect := Tree.GetDisplayRect(Node, Column, False, False);
    ComboBox.Top := NodeRect.Top;
    ComboBox.Left := NodeRect.Left;
    if Column = -1 then
       combobox.width := Tree.ClientWidth else
       combobox.width := TVirtualStringTree(tree).header.Columns.Items[column].width;
    ComboBox.Height := 100;
    ComboBox.ItemIndex := 0;
  end
end;

procedure TGenresCombo.ProcessMessage(var Message: TMessage);
begin
  ComboBox.WindowProc(Message);
end;

procedure TGenresCombo.SetBounds(R: TRect);
begin
//  ComboBox.BoundsRect := R
end;

{ END OF        TGenresCombo }

procedure TEditor.FormCreate(Sender: TObject);
var
	i:integer;
  aNode:PvirtualNode;
	server, username, password: String;
  port: Integer;
begin
  //Icon
  Icon := MainFormInstance.Icon1.picture.icon;
  
  if MainFormInstance.GetProxySettingsFromWinamp(Server, Port, username, password) then
  begin
  	IdHttp.ProxyParams.ProxyServer := server;
    IdHttp.ProxyParams.ProxyPort := port;
    IdHttp.ProxyParams.ProxyUsername := username;
    IdHttp.ProxyParams.ProxyPassword := password
  end;

  AnythingChanged := false;
  WindowShowBoolsSet := false;
  Recs := TList.create;
  for i:=tagDB to high(copyTagSettings) do
    copyTagSettings[i] := i;
  HasTagCheckboxes[tagId3v1] := CBHasId3v1Tag;
  HasTagCheckboxes[tagId3v2] := CBHasId3v2Tag;
  HasTagCheckboxes[tagApe] := CBHasApeTag;
  HasTagCheckboxes[tagWMA] := CBHasWMATag;
  HasTagCheckboxes[tagOgg] := CBHasOggTag;

  undoList := TList.create;
  TagLoaded := false;
  PanelTitle.Height := 27;
  PanelArtist.Height := 28;
  CommTree.NodeDataSize := SizeOf(TcommRec);
  TMCL.NodeDataSize := SizeOf(TroleRec);
  TIPL.NodeDataSize := SizeOf(TroleRec);
  TCON.NodeDataSize := SizeOf(TgenreRec);
  Genre.NodeDataSize := SizeOf(TgenreRec);

  CustomFieldTree.NodeDataSize := SizeOf(TCustomFieldRec);
  OggOtherFields.NodeDataSize := SizeOf(TTagFieldRec);
  ApeOtherFields.NodeDataSize := SizeOf(TTagFieldRec);
  WmaOtherFields.NodeDataSize := SizeOf(TTagFieldRec);
  Id3v2OtherFields.NodeDataSize := SizeOf(TTagFieldRec);
  Stat.NodeDataSize := SizeOf(TstatRec);
  LyricsList.NodeDataSize := SizeOf(TlyricsRec);
  GroupCheck.NodeDataSize := SizeOf(TgroupCheckRec);

  for i:=0 to MaxGenres do
    Id3v1Genre.Items.add(Genres[i]);
  Id3v1Genre.Sorted := true;

  FillLanguagesToTStrings(COMMlanguage.Items);

  FillLanguagesToTStrings(TLAN.Items);

  GroupCheck.RootNodeCount := GroupList.count;
  aNode := GroupCheck.getFirst;
  for i:=0 to GroupList.Count-1 do //GroupCheckBox.Items.Add(PGroupRec(Grouplist.items[i]).Name);
  begin
    GroupCheck.CheckType[aNode] := ctCheckBox;
    PgroupCheckRec(GroupCheck.GetNodeData(aNode)).index := i;
    PgroupCheckRec(GroupCheck.GetNodeData(aNode)).canGray := false;
    aNode := GroupCheck.getNext(aNode)
  end;

  CustomFieldTree.RootNodeCount := FieldList.Count;


  v1Components := TComponentlist.create;
  v2Components := TComponentlist.create;
  apeComponents := TComponentlist.create;
  oggComponents := TComponentlist.create;
  wmaComponents := TComponentlist.create;
  v1Components.OwnsObjects := false;
  v2Components.OwnsObjects := false;
  apeComponents.OwnsObjects := false;
  oggComponents.OwnsObjects := false;
  wmaComponents.OwnsObjects := false;

  v2scroll.PageSize := v2Scroll.Height;

  //defaults fra Preferences:
  cleanNewStrings.checked := Pref.Id3_autoformatNewText.checked;
  SaveGroups.Checked := Pref.Id3_SaveGroups.checked;
  SyncTabs.checked := Pref.Id3_SyncTabs.checked;
  stat.ShowHint := pref.showhnt.Checked
  //end of defaults
end;

Function TEditor.cleanString(s:string; force:boolean=false):string;
begin
		 if cleanNewStrings.checked or force then
				result := MainFormInstance.cleanString(s)
		 else result := trim(s)
end;

function TEditor.IsV1Genre(s:String):Boolean;
var      i:integer;
begin
	result := false;
	if length(trim(s))=0 then
		result := true
	else
		for i:=0 to MaxGenres do
			result := result or Q_SameText(s, GenreList.Strings[i])
end;

function TEditor.checkIfAllGenresAllowed(aTree: TBaseVirtualTree):Boolean;
var      aNode : PVirtualNode;
begin
	if id3v24.checked or (aTree=Genre) then result := true
	else
	begin
		result := true;
		aNode := aTree.GetFirst;
		while aNode <> nil do
		begin
			if aTree.FocusedNode <> aNode then
			begin
				if not IsV1Genre(PGenreRec(aTree.getNodeData(aNode)).text) then
					result := false
			end;
			if result then aNode := aTree.getNext(aNode) else aNode := nil
		end
	end
end;

function TEditor.IsOtherFieldsTree(obj: TObject): boolean;
begin
	result := (obj = OggOtherFields) or (obj = ApeOtherFields) or (obj = WmaOtherfields) or (obj = Id3v2OtherFields)
end;

function TEditor.HasTagLyrics(pSR:pointer): Boolean;
var
	i: integer;
begin
	result := false;
  for i:=tagId3v1 to tagMAX do
  	result := result or PStatRec(pSR).HasTagLyrics[i]
end;

function TEditor.LyricsChanged(pSR:pointer; onlyFileTag:boolean=false):boolean;
var
	SR:PstatRec;
	i: Integer;
begin
	SR := pSR;
	if multipleFiles then
	begin
		result := false;
		exit
	end;
	if onlyFileTag then
	begin
		result := false;
		for i:=tagId3v1 to tagMAX do
			result := result or (GetTagSupported(i, SR) and HasTagCheckboxes[i].Checked);
		result := result and not Q_SameStr(trim(SR.Lyrics), trim(lyricsMemo.text)) and tagLyrics.checked;

    result := result or (HasTagLyrics(SR) <> tagLyrics.checked) or (HasTagLyrics(SR) and not HasLyrics.Checked);

    for i:=tagId3v1 to tagMAX do
    begin
	    result := result or (SR.HasTagLyrics[i] and GetTagSupported(i, SR) and not HasTagCheckboxes[i].Checked)
    end
	end
  else
	begin
		result := not Q_SameStr(trim(SR.Lyrics), trim(lyricsMemo.text));
    result := result or (HasTagLyrics(SR) <> tagLyrics.checked) or (SR.HasLyrics3V1 <> Lyrics3V1.checked) or (SR.HasLyrics3v2 <> Lyrics3V2.checked);
    for i:=tagId3v2 to tagMAX do
    begin
			result := result or (SR.HasTagLyrics[i] and GetTagSupported(i, SR) and not HasTagCheckboxes[i].Checked)
    end
	end
end;

procedure TEditor.ReadMpegInfoStart(Sender: TObject;
  Thread: TBMDExecuteThread; var Data: Pointer);
begin
	MpegInfo.caption := 'Reading Mpeg info...'
end;

procedure TEditor.ReadMpegInfoExecute(Sender: TObject; Thread: TBMDExecuteThread; var Data: Pointer);
var
	MpegAudio : TMpegAudio;
  MusePack : TMpegPlus;
  FOgg: TOggVorbis;
  FWma: TWMAFile;
  FWav: TWavFile;
  Result, KBps : String;
  Fstr : TStream;
  SR : PstatRec;
  aNode : PvirtualNode;
begin
  if stat.RootNodeCount = 1 then
  	aNode := stat.GetFirst
  else
  	aNode := stat.GetFirstSelected;

  if assigned(aNode) then
  begin
    SR := stat.getNodeData(aNode);

    if SR.readAble then
    begin
         Fstr := TFileStream.create(getFtext(SR.ref, fFilename) , fmOpenRead or fmShareDenyNone);
         if Prec(SR.ref).audioType = 0 then  //MpegAudio
         begin
              MpegAudio := TMpegAudio.Create;
              if SR.HasV2 then
                 MpegAudio.ReadFromStream(Fstr, SR.MpegDataStartPos, SR.HasV1)
              else MpegAudio.ReadFromStream(Fstr, 0, SR.HasV1);
              if MpegAudio.Valid then
              begin
                   if MpegAudio.VBR.Found then Kbps := 'VBR : ' + Inttostr(MpegAudio.BitRate) + ' kpbs (average)' else Kbps := inttostr(MpegAudio.BitRate) + ' kbps';
                   Result :=
                   'Codec : ' + MpegAudio.Version + ' ' + MpegAudio.Layer + #13 +
                   'Quality : ' + kbps + ', ' + IntToStr (MpegAudio.SampleRate) + ' Hz, ' + MpegAudio.ChannelMode + #13 +
                   'Duration : ' + FormatDateTime ('h:nn:ss', MpegAudio.Duration / (24.0 * 60 * 60 * 1000))+Format (' (%d seconds)', [MpegAudio.duration div 1000]) + #13 +
                   'Frames : ' + inttostr(MpegAudio.Frames) + #13 +
                   'First frame found at : ' + inttostr(MpegAudio.FirstFramePos) + #13 +
                   'Emphasis : ' + MpegAudio.Emphasis + #13 +
                   'Guessed encoder : ' + MpegAudio.Encoder
              end else Result := 'Error reading info';
              MpegAudio.free
         end else
         if Prec(SR.ref).audioType = 1 then //MusePack
         begin
              MusePack := TMPEGplus.Create;
              //Fstr.position SKAL være der hvor musikframen begynder!
              if SR.HasV2 then
                 Fstr.Position := SR.MpegDataStartPos
              else Fstr.Position := 0;

              MusePack.ReadFromStream(Fstr, SR.HasV1, FStr.Position);
              if MusePack.Valid then
              begin
                   Result :=
                   'Codec : MusePack/MpegPlus, Streamversion ' + inttostr(MusePack.StreamVersion) + #13 +
                   'Quality : Encoding profile: "' + MusePack.Profile + '" ' + inttostr(MusePack.BitRate) + ' kbps ' + MusePack.ChannelMode + #13 +
                   'Duration : ' + FormatDateTime ('h:nn:ss', round(MusePack.Duration*1000) / (24.0 * 60 * 60 * 1000))+Format (' (%d seconds)', [round(MusePack.duration)]) + #13 +
                   'Frames : ' + inttostr(MusePack.FrameCount) + #13 +
                   'First frame found at : ' + inttostr(SR.MpegDataStartPos)
              end;
              MusePack.free
         end else
         if Prec(SR.ref).audioType = 2 then //OggVorbis
         begin
              FOgg := TOggVorbis.create;
              if FOgg.ReadFromStream(FStr{, SR.MpegDataStartPos}) and FOgg.Valid then
              begin
                Result :=
                   'Codec : Ogg Vorbis' + #13 + 'Vendor: ' + FOgg.Vendor + #13 +
                   'Quality : ' + InttoStr(FOgg.Bitrate) + ' kbps, ' + inttostr(FOgg.BitrateNominal) + ' kbps nominal, ' + IntToStr (FOgg.SampleRate) + ' Hz, ' + FOgg.ChannelMode + #13 +
                   'Duration : ' + FormatDateTime ('h:nn:ss', round(FOgg.Duration*1000) / (24.0 * 60 * 60 * 1000))+Format (' (%d seconds)', [round(FOgg.duration)]) + #13 +
                   'First frame found at : ' + inttostr(SR.MpegDataStartPos)
              end;
              FOgg.Free
         end else
         if Prec(SR.ref).audioType = 3 then //WMA
         begin
              FWMA := TWmaFile.create;
              if FWMA.ReadFromStream(FStr) and FWMA.Valid then
              begin
                Result :=
                   'Codec : Windows Media Audio' + #13 +
                   'Quality : ' + InttoStr(FWMA.Bitrate) + ' kbps, ' + IntToStr (FWMA.SampleRate) + ' Hz, ' + FWMA.ChannelMode + #13 +
                   'Duration : ' + FormatDateTime ('h:nn:ss', round(FWMA.Duration*1000) / (24.0 * 60 * 60 * 1000))+Format (' (%d seconds)', [round(FWMA.duration)])
              end;
              FWMA.Free
         end else
         if Prec(SR.ref).audioType = 4 then //Monkeys Audio
         begin
              FMonkey := TMonkey.create;
              if FMonkey.ReadFromStream(FStr, SR.MpegDataStartPos) and FMonkey.Valid then
              begin
                Result :=
                   'Codec : Monkeys Audio - version ' + FormatFloat('.00', FMonkey.VersionID / 1000) + #13 +
                   'Compression: ' + MONKEY_COMPRESSION[FMonkey.CompressionID div 1000] {+ ' = ' + FormatFloat('00.00', FMonkey.Ratio) + '%' }+ #13 +
                   'Quality : ' + InttoStr(Round(((Fstr.Size *8) / FMonkey.Duration) / 1000)) + ' kbps, ' + IntToStr (FMonkey.SampleRate) + ' Hz, ' + FMonkey.ChannelMode + #13 +
                   'Duration : ' + FormatDateTime ('h:nn:ss', round(FMonkey.Duration*1000) / (24.0 * 60 * 60 * 1000))+Format (' (%d seconds)', [round(FMonkey.duration)])// + #13 +
                   //'Peak value : ' +  FormatFloat('00.00', FMonkey.Peak) + '%'
              end;
              FMonkey.Free
         end else
         if Prec(SR.ref).audioType = 5 then //WAV
         begin
              FWav := TWavFile.create;
              if FWav.ReadFromStream(FStr) and FWav.Valid then
              begin
                Result :=
                   'Codec : Windows Wave - ' + FWav.Format + #13 +
                   'Quality : ' +  IntToStr (FWav.SampleRate) + ' Hz, ' + FWav.ChannelMode + #13 +
                   'Duration : ' + FormatDateTime ('h:nn:ss', round(FWav.Duration*1000) / (24.0 * 60 * 60 * 1000))+Format (' (%d seconds)', [round(FWav.duration)])
              end;
              FWav.Free
         end;
         Fstr.free
    end
    else
    Result := 'Could not read file!'
  end
  else
  	Result := '';
  Thread.Synchronize(SetMpegInfoCaption, @result)
end;

function TEditor.Init: Boolean;
var
	i, SongsHeight:integer;
	r: Trect;

begin
	if pref.HideOnEdit.checked then
	begin
		// hide winamp window
		winampShowed := ShowWindow(hwnd_Winamp, SW_HIDE);
		plShowed := ShowWindow(hwnd_PL, SW_HIDE);
		eqShowed := ShowWindow(hwnd_EQ, SW_HIDE);
		mbShowed := ShowWindow(hwnd_MB, SW_HIDE);
		WindowShowBoolsSet := true
		//eo gem væk
	end
	else WindowShowBoolsSet := false;

	if TagLoaded then
  begin
  	result := true;
  	exit
  end
  else
	begin
		for i:=0 to editor.componentcount-1 do
			if editor.components[i] is TComponent then
				case TComponent(editor.components[i]).tag  of
					11: v1Components.Add(editor.components[i]);
					12: v2Components.Add(editor.components[i]);
					13: apeComponents.Add(editor.components[i]);
					14: wmaComponents.Add(editor.components[i]);
					15: oggComponents.Add(editor.components[i])
				end
  end;

	Result := LoadValues;
  if result then
  begin
    UpdateCheckBoxes(nil);

    // adjusting window height
    r := MainFormInstance.GetMonitorRect(Self);
    SongsHeight := stat.Header.Height + 4 + (integer(stat.DefaultNodeHeight) * integer(stat.RootNodeCount));
    i := Editor.Height - stat.Height;
    if i + SongsHeight > r.Bottom - r.Top then
    begin
      Editor.Position := poDesigned;
      Editor.Left := r.Left + ((r.Right - R.Left) div 2) - (Editor.Width div 2);
      Editor.Height := r.Bottom - r.Top;
      Editor.Top := 0
    end
    else
    begin
      Editor.Position := poDesigned;
      Editor.Left := r.Left + ((r.Right - R.Left) div 2) - (Editor.Width div 2);
      Editor.Height := i + SongsHeight;
      Editor.Top := r.Top + Trunc((r.Bottom - r.Top)/2 - Editor.Height/2)
    end
  end
end;

procedure TEditor.UpdateImageIndexes;
begin
	if (CBhasId3v1Tag.state <> cbUnchecked) and CBhasId3v1Tag.enabled then
	begin
		TabId3v1.imageindex := 1;
		TabId3v1.enabled := true
	end else
	begin
		TabId3v1.imageindex := 0;
		TabId3v1.enabled := false
	end;

	if (CBhasId3v2Tag.state <> cbUnchecked) and CBhasId3v2Tag.enabled then
	begin
		TabId3v2.imageindex := 1;
		TabId3v2X1.imageindex := 1;
		TabId3v2.enabled := true;
		TabId3v2X1.enabled := true;
	end else
	begin
		TabId3v2.imageindex := 0;
		TabId3v2X1.imageindex := 0;
		TabId3v2.enabled := false;
		TabId3v2X1.enabled := false
	end;

	if (CBhasApeTag.state <> cbUnchecked) and CBhasApeTag.enabled then
	begin
		TabApe.imageindex := 1;
		TabApe.enabled := true;
	end else
	begin
		TabApe.imageindex := 0;
		TabApe.enabled := false;
	end;

	if (CBhasWMATag.state <> cbUnchecked) and CBhasWMATag.enabled then
	begin
		TabWMA.imageindex := 1;
		TabWMA.enabled := true;
	end else
	begin
		TabWMA.imageindex := 0;
		TabWMA.enabled := false;
	end;

	if (CBhasOggTag.state <> cbUnchecked) and CBhasOggTag.enabled then
	begin
		TabOgg.imageindex := 1;
		TabOgg.enabled := true;
	end else
	begin
		TabOgg.imageindex := 0;
		TabOgg.enabled := false;
	end
end;

Function TEditor.GetFText(P:Pointer;Field:integer):String;
begin
	result := MainFormInstance.GetFTextP(p, Field)
end;

{Procedure TEditor.AddRoleToTree(Tree : TVirtualStringTree; Role : String; Name : String);
var
	aNode : PVirtualNode;
	R : ProleRec;
begin
	aNode := Tree.AddChild(nil);
	R := Tree.GetNodeData(aNode);
	R.Role := Role;
	R.Name := Name;
	R.Empty := false
end;

Procedure TEditor.AddRoleToTree(Tree : TVirtualStringTree; p:pointer);
var
	aNode : PVirtualNode;
	R, PR : ProleRec;
begin
	aNode := Tree.AddChild(nil);
	PR := p;
	R := Tree.GetNodeData(aNode);
	R.Role := PR.Role;
	R.Name := PR.Name;
	R.Empty := false
end;   }


Procedure TEditor.AddCommentToTree(Language : Integer; Description : String; Value : String);
var
	aNode : PVirtualNode;
	R : PcommRec;
begin
	aNode := CommTree.AddChild(nil);
	R := CommTree.GetNodeData(aNode);
	R.Language := Language;
	R.Description := Description;
	R.Value := Value;
	R.Empty := false;
  R.Gray := false;
end;

Procedure TEditor.AddGenreToTree(Tree : TVirtualStringTree; Text : String);
var
	aNode : PVirtualNode;
	R : PGenreRec;
begin
	if Q_SameText(text, 'cover') then
	begin
		if Tree = Genre then genreCover.checked := true;
          if Tree = TCON then V2Cover.checked := true
     end else if Q_SameText(text, 'remix') then
     begin
          if Tree = Genre then genreRemix.checked := true;
          if Tree = TCON then V2Remix.checked := true
     end else
     begin
          aNode := Tree.AddChild(nil);
          R := Tree.GetNodeData(aNode);
          R.Text := Text
     end
end;

Procedure TEditor.FillValuesToBoxes;
function getValueindex(arr:array of pointer; comp:Tcomponent):integer;
var      i:integer;
begin
	result := -1;
	for i:=0 to length(arr)-1 do
		if PundoRec(arr[i]).Obj = comp then
		begin
			result := i;
			break
		end
end;

procedure fillGroupCheck(UG : PundoGroups; firstRun:Boolean);
var
	aNode:PvirtualNode;
begin
	aNode := groupCheck.GetFirst;
	while aNode <> nil do
	begin
		if firstRun then
		begin
			if UG.arr[aNode.index] = cbChecked then groupCheck.CheckState[aNode] := csCheckedNormal else
			if UG.arr[aNode.index] = cbUnChecked then groupCheck.CheckState[aNode] := csUnCheckedNormal
		end else
		begin
			if ((UG.arr[aNode.index] = cbChecked) and (groupCheck.CheckState[aNode] = csUnCheckedNormal)) or ((UG.arr[aNode.index] = cbUnChecked) and (groupCheck.CheckState[aNode] = csCheckedNormal)) then
			begin
				groupCheck.CheckState[aNode] := csMixedNormal;
				PgroupCheckRec(GroupCheck.getNodeData(aNode)).canGray := true
			end
		end;
	aNode := groupCheck.GetNext(aNode)
	end
end;

procedure FillTagFieldsTree(tree: TVirtualStringTree; uc: PUndoTagFields; firstRun: Boolean);
var
	aNode: PVirtualNode;
  ct: PTagFieldRec;
	setUnGrayed: array of boolean;
  i, j: integer;
  found: boolean;
begin
	SetLength(setUnGrayed, tree.RootNodeCount);

  for i:=0 to length(uc.arr)-1 do
  begin
    found := false;
    aNode := tree.GetFirst;
    while aNode <> nil do
    begin
      ct := tree.GetNodeData(aNode);
      if Q_SameText(ct.fieldName, uc.arr[i].FieldName) and Q_SameText(ct.Description, uc.arr[i].Description) then
      begin
      	found := true;
        setUnGrayed[aNode.Index] := true;
        if not Q_SameStr(ct.value, uc.arr[i].value) then
        begin
          ct.gray := true;
          ct.value := ''
        end;
      end;
      aNode := tree.GetNext(aNode)
    end;

    if not found then
    begin
    	aNode := tree.AddChild(nil);
      tree.ReinitNode(aNode, false);
      ct := tree.GetNodeData(aNode);
      ct.gray := not firstRun;
      ct.fieldName := uc.arr[i].fieldName;
      ct.description := uc.arr[i].description;
			if not ct.Gray then ct.value := uc.arr[i].value;
      SetLength(setUnGrayed, tree.RootNodeCount);
      if firstRun then
      	setUnGrayed[length(setUnGrayed)-1] := true
    end
  end;

  //Gray fields that did not exist for all files
  for i:=0 to length(setUnGrayed)-1 do
  begin
  	if not setUnGrayed[i] then
    begin
    	aNode := tree.GetFirst;
      for j:=1 to i do
      	aNode := tree.GetNext(aNode);
      ct := tree.GetNodeData(aNode);
      ct.gray := True;
      ct.Value := ''
    end
  end
end;

procedure FillCustomFieldTree(UC : PundoCustomFields; firstRun:Boolean);
var
	aNode:PvirtualNode;
  cf: PCustomFieldRec;
begin
	aNode := CustomFieldTree.GetFirst;
	while aNode <> nil do
	begin
  	cf := CustomFieldTree.GetNodeData(anode);

		if firstRun then
    begin
    	cf.value := UC.arr[cf.FieldIndex].value;
      cf.gray := false
    end
		else
    if not cf.Gray and not Q_SameStr(cf.Value, UC.Arr[CF.FieldIndex].value) then
    begin
    	cf.Gray := true;
      cf.Value := ''
		end;
		aNode := CustomFieldTree.GetNext(aNode)
	end
end;

procedure FillCommTree(UC : PundoComments; firstRun:Boolean);
var
	aNode: PVirtualNode;
  cr: PCommRec;
	setUnGrayed: array of boolean;
  i, j: integer;
  found: boolean;
begin
	SetLength(setUnGrayed, CommTree.RootNodeCount);

  for i:=0 to length(uc.arr)-1 do
  begin
    found := false;
    aNode := CommTree.GetFirst;
    while aNode <> nil do
    begin
      cr := CommTree.GetNodeData(aNode);
      if Q_SameText(cr.Description, uc.arr[i].Description) and (cr.Language = uc.arr[i].Language) then
      begin
      	found := true;
        setUnGrayed[aNode.Index] := true;
        if not Q_SameStr(cr.value, uc.arr[i].value) then
        begin
          cr.gray := true;
          cr.value := ''
        end;
      end;
      aNode := CommTree.GetNext(aNode)
    end;

    if not found then
    begin
    	aNode := CommTree.AddChild(nil);
      CommTree.ReinitNode(aNode, false);
      cr := CommTree.GetNodeData(aNode);
      cr.gray := not firstRun;
      cr.Description := uc.arr[i].Description;
      cr.Language := uc.arr[i].Language;
			if not cr.Gray then cr.value := uc.arr[i].value;
      SetLength(setUnGrayed, CommTree.RootNodeCount);
      if firstRun then
      	setUnGrayed[length(setUnGrayed)-1] := true
    end
  end;

  //Gray fields that did not exist for all files
  for i:=0 to length(setUnGrayed)-1 do
  begin
  	if not setUnGrayed[i] then
    begin
    	aNode := CommTree.GetFirst;
      for j:=1 to i do
      	aNode := CommTree.GetNext(aNode);
      cr := CommTree.GetNodeData(aNode);
      cr.gray := True;
      cr.Value := ''
    end
  end
end;
{         Fylder data fra statnodsene til boksene i formen. Det er her der bestemmes om den skal grayes }
var       sNode:PvirtualNode;
					SR1, SR2:PstatRec;
					k, i, i1, i2 : integer;
					comp : Tcomponent;
					gray : boolean;
					StrLSt : TQ_StringList;
begin
  i2 := -1;
  SR2 := nil;

  StrLSt := TQ_StringList.create;
  StrLst.Sorted := true;
  StrLst.Duplicates := dupIgnore;
  for k:=0 to componentcount-1 do         //gennemløber alle controls og fylder dem baseret
	  if (components[k].Tag in [tagDB, tagId3v1, tagId3v2, tagApe, tagWMA, tagOgg]) and (components[k] <> genreCover) and  (components[k] <> genreRemix) and (components[k] <> V2Cover) and (components[k] <> V2Remix) then
	  begin
		  comp := components[k];
		  gray := false;
		  //          firstrun := true;

		  sNode := stat.GetFirst;
		  SR1 := stat.GetNodeData(sNode);
		  i1 := getValueIndex(SR1.values, comp);

		  if comp = GroupCheck then
			  fillGroupCheck(PundoRec(SR1.values[i1]).p, true) else
		  if comp = CustomFieldTree then
			  fillCustomFieldTree(PundoRec(SR1.values[i1]).p, true) else
		  if comp = CommTree then
			  FillCommTree(PundoRec(SR1.Values[i1]).p, true) else
		  if IsOtherFieldsTree(comp) then
			  FillTagFieldsTree(TVirtualStringtree(comp), PundoRec(SR1.values[i1]).p, true);

		  sNode := stat.GetNext(sNode);
		  while (sNode <> nil) do
		  begin
			  SR2 := stat.GetNodeData(sNode);
			  i2 := getValueIndex(SR2.values, comp);

			  if comp = GroupCheck then
				   fillGroupCheck(PundoRec(SR2.values[i2]).p, false)
        else
			  if comp = CustomFieldTree then
        	fillCustomFieldTree(PundoRec(SR2.values[i2]).p, false)
			  else
			  if comp = CommTree then
				  FillCommTree(PundoRec(SR2.Values[i2]).p, false)
        else
			  if IsOtherFieldsTree(comp) then
				  FillTagFieldsTree(TVirtualStringTree(comp), PundoRec(SR2.values[i2]).p, false)
			  else
			  begin
				  gray := gray or not EqualUndoRecs(SR1.values[i1], SR2.values[i2]);

				  if PundoRec(SR2.values[i2]).Obj is TJvComboBox then //fylder i comboboxen
          begin
				    if PundoRec(SR2.values[i2]).undoType = UTstring then
				    begin
				      if length(PundoString(PundoRec(SR2.values[i2]).p).s)>0 then
              	StrLst.add(PundoString(PundoRec(SR2.values[i2]).p).s)
				    end
				  end
			  end;
  //               firstRun := false;
			  sNode := stat.getNext(sNode)
		  end; //of while sNode <> nil

      if (comp <> groupCheck) and (comp <> CustomFieldTree) and (comp <> CommTree) and (not IsOtherFieldsTree(comp)) then
      begin
        setGrayed(comp, gray);
        if gray then
        begin
          if PundoRec(SR2.values[i2]).Obj is TJvComboBox then
            for i:=0 to StrLst.count-1 do
              TJvComboBox(PundoRec(SR2.values[i2]).Obj).items.add(StrLst.strings[i])
        end
        else
        begin
          //If i1 = -1 something is wrong!
          doInternalUndo(SR1.values[i1], false)
        end
      end;

  	StrLst.clear;
  end; //of for componentcount
  StrLst.free
end;

procedure TEditor.FillInValues(Thread:TBMDExecuteThread; Pr:Pointer; pSR:Pointer; firstRun:boolean; updateStats:boolean=true; useFileWriteBeginEnd: Boolean = true);
function FindLanguage(s:String):integer;
var      x:integer;
begin
	result := -1;
  if Q_SameText(s, UnknownLanguageCode) or (length(trim(s))=0) then
  	result := -1
  else
  	for x:=0 to Length(LanguageCodes)-1 do
    	if Q_PosText(s, LanguageCodes[x]) > 0 then
      	Result := x
end;

{function FindNextV2Frame(name:string; Iv2:Tid3v2tagEx; Start:integer):integer;
var      i:integer;
begin
	result := -1;
	for i:=Start to Iv2.Frames.Count do
	begin
		if Q_SameText(Iv2.Frames.getFrameID(i), name) then
		begin
			result := i;
			break
		end
	end
end;

function FindV2Frame(name:string; Iv2:Tid3v2tagEx):integer;
begin
		 result := FindNextV2Frame(name, iv2, 1)
end;   }

procedure FillInValue(target:TComponent; const s:Variant; SR: PstatRec);
function createStringUndo(target:TComponent; s:String):pointer;
var      UndoRec : PundoRec;
         undoString : PundoString;
begin
     new(UndoRec);
     UndoRec.UndoType := UTstring;
     UndoRec.Obj := target;
     UndoRec.OrigState := true;
     UndoRec.Gray := false;

		 new(undoString);
     UndoRec.p := undoString;
     undoString.s := s;

     result := undoRec
end;

var
	i, x:integer;
  cbs : TcheckBoxState;
  undoGenres : PundoGenres;
  UndoRec : PundoRec;
  undoCheckState : PundoChecked;
  undoComments : PundoComments;
  undoRoles : PundoRoles;
  undoInteger : PundoInteger;
  undoGroups : PundoGroups;
  undoCustomFields: PundoCustomFields;
  undoTagFields: PundoTagFields;
  Iarr: array of integer;
  Sarr: array of string;
  Str:String;
  sDblArr: array of array of string;
begin
	if target is TEdit then
     begin
          Str := s;
          setLength(SR.values, length(SR.values)+1);
          SR.values[length(SR.values)-1] := createStringUndo(target, str)
     end else
		 if target is TJvComboBox then
		 begin
					if (VarType(s) = varString) or (VarType(s) = varOleStr) then
					begin
							 Str := trim(s);
							 setLength(SR.values, length(SR.values)+1);
							 SR.values[length(SR.values)-1] := createStringUndo(target, str)
					end else
					if VarType(s) = varInteger then  //itemIndex gemmes
					begin
							 i := s;

               new(UndoRec);
               UndoRec.UndoType := UTinteger;
							 UndoRec.Obj := target;
               UndoRec.OrigState := true;
               UndoRec.Gray := false;

               new(undoInteger);
               UndoRec.p := undoInteger;
               undoInteger.i := i;

               setLength(SR.values, length(SR.values)+1);
               SR.values[length(SR.values)-1] := undoRec
          end
     end else
     if target is TCheckBox then
		 begin
          if VarType(s) = VarString then cbs := cbUnchecked else cbs := s;
          new(UndoRec);
          UndoRec.UndoType := UTchecked;
					UndoRec.Obj := target;
          UndoRec.OrigState := true;
          UndoRec.Gray := false;

          new(undoCheckstate);
          UndoRec.p := undoCheckstate;
          undoCheckstate.b := cbs;

          setLength(SR.values, length(SR.values)+1);
          SR.values[length(SR.values)-1] := undoRec
     end else
		if target = CustomFieldTree then	// s = array of String
    begin
    	if VarType(s) = varString then
      	setLength(Sarr, 0)
      else Sarr := s;

      new(UndoRec);
      UndoRec.UndoType := UTcustomFields;
			UndoRec.Obj := target;
      UndoRec.OrigState := true;
      UndoRec.Gray := false;

      new(undoCustomFields);
      UndoRec.p := undoCustomFields;

      SetLength(undoCustomFields.Arr, length(Sarr));
      for i:=0 to length(Sarr)-1 do
      begin
      	undoCustomFields.Arr[i].FieldIndex := i;
      	undoCustomFields.Arr[i].value := Sarr[i];
        undoCustomFields.arr[i].gray := false
      end;

      setLength(SR.values, length(SR.values)+1);
      SR.values[length(SR.values)-1] := undoRec
    end
    else
    if target = Genre then       //Genre    s = array of Integer
		begin
					if VarType(s) = varString then
						setLength(Iarr, 0)
					else Iarr := s;

          new(UndoRec);
					UndoRec.UndoType := UTgenres;
					UndoRec.Obj := target;
          UndoRec.OrigState := true;
          UndoRec.Gray := false;

          new(undoGenres);
          UndoRec.p := undoGenres;

          undoGenres.cover := cbUnchecked;
					undoGenres.remix := cbUnchecked;
															//////
				 {	setLength(undoGenres.arr, 1);
					undoGenres.arr[0] := 'Pop';    }
					setLength(undoGenres.arr, length(Iarr));
					x := 0;
					for i:=0 to length(Iarr)-1 do
					begin
							 if Q_sameText(genreList.strings[Iarr[i]], 'cover') then undoGenres.cover := cbChecked else
							 if Q_sameText(genreList.strings[Iarr[i]], 'remix') then undoGenres.remix := cbChecked else
							 begin
								undoGenres.arr[x] := genreList.strings[Iarr[i]];
								inc(x)
							 end
					end;
					setLength(undoGenres.arr, x);
					setLength(SR.values, length(SR.values)+1);
					SR.values[length(SR.values)-1] := undoRec
     end else
     if target = TCON then          //TCON   s = array of Strings
     begin
          if VarType(s) = varString then setLength(Sarr, 0) else Sarr := s;

          new(UndoRec);
					UndoRec.UndoType := UTgenres;
          UndoRec.Obj := target;
          UndoRec.OrigState := true;
          UndoRec.Gray := false;

          new(undoGenres);
          UndoRec.p := undoGenres;

          undoGenres.cover := cbUnchecked;
          undoGenres.remix := cbUnchecked;
          setLength(undoGenres.arr, length(Sarr));
          x := 0;
          for i:=0 to length(Sarr)-1 do
					begin
							 if Q_sameText(Sarr[i], 'cover') then undoGenres.cover := cbChecked else
               if Q_sameText(Sarr[i], 'remix') then undoGenres.remix := cbChecked else
               begin
										undoGenres.arr[x] := Sarr[i];
                    inc(x)
               end
          end;
          setLength(undoGenres.arr, x);

					setLength(SR.values, length(SR.values)+1);
          SR.values[length(SR.values)-1] := undoRec
     end else
     if target = CommTree then        //Comment  s = array of pointers
     begin
          new(UndoRec);
          UndoRec.UndoType := UTcomments;
          UndoRec.Obj := target;
          UndoRec.OrigState := true;
          UndoRec.Gray := false;

          new(undoComments);
          UndoRec.p := undoComments;

          if VarType(s) = varString then setLength(Iarr, 0) else Iarr := s;
          setLength(undoComments.arr, length(Iarr));
          for i:=0 to length(Iarr)-1 do
          	undoComments.arr[i] := (Ptr(Iarr[i]));

          setLength(SR.values, length(SR.values)+1);
          SR.values[length(SR.values)-1] := undoRec
     end else
     if (target = TMCL) or (target = TIPL) then  //musicians & involved people  s = array of pointers
		 begin
          new(UndoRec);
          UndoRec.UndoType := UTroles;
          UndoRec.Obj := target;
          UndoRec.OrigState := true;
          UndoRec.Gray := false;

          new(undoRoles);
          UndoRec.p := undoRoles;

					if VarType(s) = varString then setLength(Iarr, 0) else Iarr := s;
          setLength(undoRoles.arr, length(Iarr));
          for i:=0 to length(Iarr)-1 do
              undoRoles.arr[i] := (Ptr(Iarr[i]));

          setLength(SR.values, length(SR.values)+1);
          SR.values[length(SR.values)-1] := undoRec
		 end else
     if target = groupCheck then // s er array of int, 0=cbUnChecked, 1=cbChecked
     begin
					new(UndoRec);
          UndoRec.UndoType := UTgroups;
          UndoRec.Obj := target;
          UndoRec.OrigState := true;
          UndoRec.Gray := false;

          new(undoGroups);
          UndoRec.p := undoGroups;

          if VarType(s) = varString then setLength(Iarr, 0) else Iarr := s;

          setLength(undoGroups.arr, length(Iarr));
          for i:=0 to length(Iarr)-1 do
							if Iarr[i]=1 then undoGroups.arr[i] := cbChecked else undoGroups.arr[i] := cbUnchecked;

					setLength(SR.values, length(SR.values)+1);
          SR.values[length(SR.values)-1] := undoRec
     end else
     if IsOtherFieldsTree(target) then	//s is array of array of string
     begin
	     	new(UndoRec);
        UndoRec.UndoType := UTtagFields;
        UndoRec.Obj := target;
        UndoRec.OrigState := true;
        UndoRec.Gray := false;

        new(undoTagFields);
        UndoRec.p := undoTagFields;

        if VarType(s) = varString then
        	SetLength(sDblArr, 0)
	      else
					sDblArr := s;

        setLength(undoTagFields.arr, length(sDblArr));
        for i:=0 to length(sDblArr)-1 do
        begin
        	undoTagFields.arr[i].gray := false;
          undoTagFields.arr[i].fieldName := sDblArr[i][0];
          undoTagFields.arr[i].description := sDblArr[i][1];
          undoTagFields.arr[i].value := sDblArr[i][2]
        end;

        setLength(SR.values, length(SR.values)+1);
        SR.values[length(SR.values)-1] := undoRec
     end;

		 finalize(Iarr);
     Iarr := nil;
     finalize(Sarr);
     Sarr := nil;
     finalize(sDblArr);
     sDblArr := nil;
end;

procedure FillDummyValues(const CList: TComponentList; SR: PStatRec);
var
	i: Integer;
begin
	for i:=0 to CList.Count-1 do
		FillInValue(CList.items[i], '', SR); //fylder op med dummy værdier
end;

function GetYear(dt: TDateTime): word;
var
  month, day: word;
begin
  DecodeDate(dt, result, month, day);
end;

Function getGenreText(S:String):String;
begin
		 if Q_IsInteger(S) and (StrToInt(S) >= 0) and (StrToInt(S) <= MaxGenres) then
				result := GenreList[strToInt(S)]
		 else
		 if s <> '255' then result := s else result := ''
end;


//////// MAIN procedure TEditor.FillInValues(Pr:Pointer; pSR:Pointer; firstRun:boolean; updateStats:boolean=true);
var
  id3v2: TMyID3Controller;
  id3Frame: TJVId3Frame;
  id3LstFrame: TJvID3SimpleListFrame;
  id3CntFrame: TJvID3ContentFrame;
  id3DblLstFrame: TJvID3DoubleListFrame;

	r : Prec;
  SR : PstatRec;
  CF, s, key, value, id3v2Artist : String;         //CF = Current Filename
  wsValue: wideString;
  keyFound: array of Boolean;
  bt: Byte;
  i, x:integer;
  Iarr: array of integer;
  Sarr: array of String;
  sDblArr: array of array of string;
  cbs : TcheckBoxState;
  FStr : TStream;
  commRec:PcommRec;
  roleRec:ProleRec;
  aNode:PvirtualNode;
  filled: boolean;
begin
  r := Pr;
  SR := pSR;

  //Database
  FillInValue(Artist, getFtext(r, fArtist), SR);
  FillInValue(Album, getFtext(r, fAlbum), SR);
  FillInValue(Title, getFtext(r, fTitle), SR);
  FillInValue(Year, getFtext(r, fYear), SR);
  FillInValue(Comment, getFtext(r, fComment), SR);
  FillInValue(Track, getFtext(r, fTrack), SR);
  FillInValue(TotalTracks, GetFText(r, fTotalTracks), SR);
  FillInValue(PartOfSet, integer(MainFormInstance.GetPartOfSet(r)), SR);
  FillInValue(TotalParts, integer(MainFormInstance.GetTotalParts(r)), SR);

  if MainFormInstance.SameArtistAndArtistSortOrder(r) then
    FillInValue(ArtistSortOrder, '', SR)
  else
    FillInValue(ArtistSortOrder, GetFText(r, FArtistSortOrder), SR);

  //CustomField
  SetLength(Sarr, FieldList.Count);
  for i:=0 to FieldList.Count-1 do
  	Sarr[i] := GetFText(r, FCustomField + i);
  if length(Sarr) = 0 then
  	FillInValue(CustomFieldTree, '', SR)
  else
  	FillInValue(CustomFieldTree, Sarr, SR);
  Sarr := nil;

  //genre
  setLength(Iarr, length(r.genre));
  for i:=0 to length(r.Genre)-1 do
    Iarr[i]:=r.Genre[i];
  if length(Iarr) = 0 then
    FillInValue(Genre, '', SR)
  else FillInValue(Genre, Iarr, SR);
  Iarr := nil;

  //compilation
  if rfCompilation in r.Flags then cbs := cbChecked else cbs := cbUnchecked;
  CBcompilation.OnClick := nil;
  FillInValue(CBcompilation, cbs, SR);
  CBcompilation.OnClick := SaveGroupsClick;

  //groups
  setLength(Iarr, groupCheck.rootnodeCount);
  aNode := GroupCheck.GetFirst;
  while aNode <> nil do
  begin
   if MainFormInstance.hasGroup(r.groups, PgroupCheckRec(GroupCheck.getNodeData(aNode)).index) then Iarr[aNode.index] := 1 else Iarr[aNode.index] := 0;
   aNode := GroupCheck.getNext(aNode)
  end;
  FillInValue(groupCheck, Iarr, SR);
  // EO database

  CF := GetFtext(R, fFilename);
  SR.FileExists := fileExists(CF);
  if SR.FileExists then
  begin
  if useFileWriteBeginEnd then
    MainFormInstance.BeginWriteToFile(r);
  SR.readAble := GetFileAccess(CF, true, false);
  SR.writeAble := GetFileAccess(CF, false, true, true);    // try to remove read-only attribute
  if useFileWriteBeginEnd then
    MainFormInstance.EndWriteToFile(r);

  If SR.ReadAble then
  begin

  	if Audiotypes[R.AudioType].Id3v1 then
      FId3v1 := TId3V1Tag.Create
    else FId3v1 := nil;

    if Audiotypes[R.AudioType].ApeV1 or Audiotypes[R.AudioType].ApeV2 then
      FApe := TApeTag.Create
    else FApe := nil;

    if Audiotypes[R.AudioType].WMA then
      Fwma := TWmaFile.Create
    else Fwma := nil;

    if Audiotypes[R.AudioType].Ogg then
      FOgg := TOggVorbis.Create
    else Fogg := nil;

   	BeginUseId3v2;
    try
      id3v2 := TMyID3Controller.Create(nil);

      FStr := TFilestream.Create(CF, fmOpenRead or fmShareDenyNone);

      try
         id3v2.LoadFromStream(Fstr);
        SR.HasV2 := id3v2.Header.HasTag;
        if SR.HasV2 then SR.Id3V2ver := id3v2.ReadVersion;
        if SR.HasV2 then SR.MpegDataStartPos := id3v2.TagSize + 10 else SR.MpegDataStartPos := 0;
      except
        SR.HasV2 := false
      end;

      if assigned(FId3v1) then
        FId3v1.LoadFromStream(Fstr, Fstr.Size);
      SR.HasV1 := assigned(FId3v1) and FId3v1.Ok;

      if assigned(FApe) then
        SR.HasApe := FApe.ReadFromStream(Fstr) and FApe.Exists
      else SR.HasApe := false;

      if assigned(Fwma) then
        SR.HasWMA := Fwma.ReadFromStream(FStr) and Fwma.Valid
      else SR.HasWma := false;

      if assigned(Fogg) then
        SR.HasOgg := FOgg.ReadFromStream(Fstr) and Fogg.Valid
      else SR.HasOgg := false;

      if updateStats and SR.HasV2 then
      begin
        if SR.Id3V2ver <= iveLowerThan2_2 then AddToStat(Thread, SR, 'Has an Id3v2 version lower than 2 - not supported!');
        if SR.Id3V2ver = ive2_2 then AddToStat(Thread, SR, 'Has an Id3v2 version of 2. File will be saved in version 3 or 4!');
        if SR.Id3V2ver >= iveHigherThan2_4 then AddToStat(Thread, SR, 'Has an Id3v2 version higher than 4 - not supported!');

        id3v23.checked := (firstrun or id3v23.checked) and (SR.Id3V2ver in [ive2_2, ive2_3]) or (SR.Id3V2ver <= iveLowerThan2_2);
        id3v24.checked := (firstrun or id3v24.checked) and (SR.Id3V2ver = ive2_4);// or (SR.Id3V2ver <= iveLowerThan2_2)
      end;

      If SR.HasV1 then
      begin
        //Reading Id3v1 values into form:
        FillInValue(Id3v1Artist, FId3v1.Artist, SR);
        FillInValue(Id3v1Title, FId3v1.Title, SR);
        FillInValue(Id3v1Album, FId3v1.Album, SR);
        FillInValue(Id3v1Year, FId3v1.Year, SR);
        FillInValue(Id3v1Genre, FId3v1.Genre, SR);
        FillInValue(Id3v1Comment, FId3v1.Comment, SR);
        if FId3v1.Track = 0 then
          FillInValue(Id3v1Track, '', SR)
        else
         FillInValue(Id3v1Track, IntToStr(FId3v1.Track), SR);
        if updateStats then AddToStat(Thread, SR, 'Id3v1 loaded');
      end
      else FillDummyValues(v1Components, SR); //fylder op med dummy værdier

      if SR.HasApe then
      begin
        FillInValue(ApeTrack, MainFormInstance.GetTrackNo(FApe.Track), SR);
        FillInValue(ApeTotalTracks, MainFormInstance.GetTotalTracks(FApe.Track), SR);
        FillInValue(ApeArtist, FApe.Artist, SR);
        FillInValue(ApeTitle, FApe.Title, SR);
        FillInValue(ApeAlbum, FApe.Album, SR);
        FillInValue(ApeYear, RemoveBrackets(FApe.Year), SR);
        FillInValue(ApeGenre, FApe.Genre, SR);
        FillInValue(ApeComment, FApe.Comment, SR);

        SetLength(keyFound, 0);
        SetLength(keyFound, 2);

  			SetLength(sDblArr, 0);
        for i:=0 to FApe.AddList.Count-1 do
        begin
          key := FApe.GetAddListKeyName(TStream(FApe.AddList.Items[i]), value);

        	if Q_SameText(key, 'ArtistSortOrder') and not (Q_SameStr(FApe.Artist, value) or Q_SameStr(theFix(FApe.Artist), value)) then
          begin
          	FillInValue(ApeArtistSortOrder, value, SR);
            KeyFound[0] := true
          end
          else

          if Q_SameText(Key, 'PartOfSet') then
          begin
          	KeyFound[1] := true;
          	bt := 0;
          	MainFormInstance.SetpartOfSetFromString(bt, value);
          	FillInValue(ApePartOfSet, MainFormInstance.GetPartOfSet(bt), SR);
            FillInValue(ApeTotalParts, MainFormInstance.GetTotalParts(bt), SR)
          end
          else

          if not Q_SameText(key, ApeOggGroupIdent) and not Q_SameText(key, ApeOggCompilationIdent) and not Q_SameText(key, ApeOggWmaRatingIdent) then
          begin
          	SetLength(sDblArr, length(sDblArr)+1);
            SetLength(sDblArr[length(sDblArr)-1], 3);
            sDblArr[length(sDblArr)-1][0] := key;
            sDblArr[length(sDblArr)-1][1] := '';
            sDblArr[length(sDblArr)-1][2] := value
          end
        end;

        if length(sDblArr)=0 then FillInValue(ApeOtherFields, '', SR) else FillInValue(ApeOtherFields, sDblArr, SR);

        if not KeyFound[0] then
        	FillInValue(ApeArtistSortOrder, '', SR);

        if not KeyFound[1] then
        begin
        	FillInValue(ApePartOfSet, '', SR);
          FillInValue(ApeTotalParts, '', SR)
        end;

        if not multipleFiles and not SR.HasTagLyrics[tagApe] then
        begin
          SR.Lyrics := trim(FApe.Lyrics);
          SR.HasTagLyrics[tagApe] := length(SR.Lyrics)>0
        end;

        if updateStats then AddToStat(Thread, SR, 'Ape-tag loaded')
      end
      else FillDummyValues(ApeComponents, SR);

      if SR.HasWMA then
      begin
        FillInValue(WMATrack, Fwma.Track, SR);
        FillInValue(WMAArtist, Fwma.Artist, SR);
        FillInValue(WMATitle, Fwma.Title, SR);
        FillInValue(WMAAlbum, Fwma.Album, SR);
        FillInValue(WMAYear, Fwma.Year, SR);
        FillInValue(WMAGenre, Fwma.Genre, SR);
        FillInValue(WMAComment, Fwma.Comment, SR);
        FillInValue(WMARating, Fwma.Rating, SR);
        FillInValue(WMACopyright, Fwma.Copyright, SR);
        FillInValue(WMAAlbumCover, Fwma.AlbumCoverURL, SR);
        FillInValue(WMAPromotion, Fwma.PromotionURL, SR);

        SetLength(keyFound, 0);
        SetLength(keyFound, 2);

        SetLength(sDblArr, 0);
        for i:=0 to FWMA.AddList.Count-1 do
        begin
          key := FWMA.GetAddListKeyName(TStream(FWMA.AddList.Items[i]), wsValue);

        	if Q_SameText(key, 'WM/ArtistSortOrder') and not (Q_SameStr(FWMA.Artist, wsValue) or Q_SameStr(theFix(FWMA.Artist), wsValue)) then
          begin
          	FillInValue(WMAArtistSortOrder, wsValue, SR);
            KeyFound[0] := true
          end
          else

          if Q_SameText(Key, 'WM/PartOfSet') then
          begin
          	KeyFound[1] := true;
          	bt := 0;
          	MainFormInstance.SetpartOfSetFromString(bt, wsValue);
          	FillInValue(WMAPartOfSet, MainFormInstance.GetPartOfSet(bt), SR);
            FillInValue(WMATotalParts, MainFormInstance.GetTotalParts(bt), SR)
          end
          else

          if not Q_SameText(key, WmaGroupIdent) and not Q_SameText(key, WmaCompilationIdent) and not Q_SameText(key, ApeOggWmaRatingIdent) then
          begin
          	SetLength(sDblArr, length(sDblArr)+1);
            SetLength(sDblArr[length(sDblArr)-1], 3);
            sDblArr[length(sDblArr)-1][0] := key;
            sDblArr[length(sDblArr)-1][1] := '';
            sDblArr[length(sDblArr)-1][2] := wsValue
          end
        end;

        if length(sDblArr)=0 then FillInValue(WmaOtherFields, '', SR) else FillInValue(WmaOtherFields, sDblArr, SR);

        if not KeyFound[0] then
        	FillInValue(WMAArtistSortOrder, '', SR);

        if not KeyFound[1] then
        begin
        	FillInValue(WMAPartOfSet, '', SR);
          FillInValue(WMATotalParts, '', SR)
        end;

        if not multipleFiles and not SR.HasTagLyrics[tagWma] then
        begin
          SR.Lyrics := trim(Fwma.Lyrics);
          SR.HasTagLyrics[tagWma] := length(SR.Lyrics)>0
        end;
        if updateStats then
        	AddToStat(Thread, SR, 'WMA-tag loaded')
      end
      else FillDummyValues(WMAComponents, SR);

      if SR.HasOgg then
      begin
        FillInValue(OggTrack, MainFormInstance.GetTrackNo(FOgg.Track), SR);
        FillInValue(OggTotalTracks, MainFormInstance.GetTotalTracks(FOgg.Track), SR);
        FillInValue(OggArtist, Fogg.Artist, SR);
        FillInValue(OggTitle, Fogg.Title, SR);
        FillInValue(OggAlbum, Fogg.Album, SR);
        FillInValue(OggYear, Fogg.Date, SR);
        FillInValue(OggGenre, Fogg.Genre, SR);
        FillInValue(OggComment, Fogg.Comment, SR);
        FillInValue(OggCopyright, Fogg.Copyright, SR);
        FillInValue(OggVersion, Fogg.Version, SR);

        SetLength(keyFound, 0);
        SetLength(keyFound, 2);

        SetLength(sDblArr, 0);
        for i:=0 to Fogg.AdditionalTags.Count-1 do
        begin
          key := Fogg.GetAddListKeyName(Fogg.AdditionalTags.Strings[i], value);

        	if Q_SameText(key, 'ARTISTSORTORDER') and not (Q_SameStr(FOgg.Artist, value) or Q_SameStr(theFix(FOgg.Artist), value)) then
          begin
          	FillInValue(OggArtistSortOrder, value, SR);
            KeyFound[0] := true
          end
          else

          if Q_SameText(Key, 'DISCNUMBER') then
          begin
          	KeyFound[1] := true;
          	bt := 0;
          	MainFormInstance.SetpartOfSetFromString(bt, value);
          	FillInValue(OggPartOfSet, MainFormInstance.GetPartOfSet(bt), SR)
          end

          else
          if not Q_SameText(key, ApeOggGroupIdent) and not Q_SameText(key, ApeOggCompilationIdent) and not Q_SameText(key, ApeOggWmaRatingIdent) then
          begin
          	SetLength(sDblArr, length(sDblArr)+1);
            SetLength(sDblArr[length(sDblArr)-1], 3);
            sDblArr[length(sDblArr)-1][0] := key;
            sDblArr[length(sDblArr)-1][1] := '';
            sDblArr[length(sDblArr)-1][2] := value
          end
        end;

        if length(sDblArr)=0 then FillInValue(OggOtherFields, '', SR) else FillInValue(OggOtherFields, sDblArr, SR);

        if not KeyFound[0] then
        	FillInValue(OggArtistSortOrder, '', SR);

        if not KeyFound[1] then
        	FillInValue(OggPartOfSet, '', SR);

        if not multipleFiles and not SR.HasTagLyrics[tagOgg] then
        begin
          SR.Lyrics := trim(FOgg.Lyrics);
          SR.HasTagLyrics[tagOgg] := length(SR.Lyrics)>0
        end;
        if updateStats then AddToStat(Thread, SR, 'Ogg-tag loaded')
      end
      else FillDummyValues(OggComponents, SR);

    if SR.HasV2 then
    begin
         //Reading Id3v2 values into form:
         //Track
         if Id3v2.FindFirstFrame(fiTrackNum, id3Frame) then
         begin
            s := TJvID3TextFrame(id3Frame).Text;
            Q_TrimInPlace(s);
            if Q_StrScan(s, '/')>0 then
            begin
              FillInValue(TRCKtotal, Q_CopyFrom(s, Q_StrScan(s, '/')+1), SR);
              s := Q_CopyLeft(s, Q_StrScan(s, '/')-1)
            end else FillInValue(TRCKtotal, '', SR);
            if Q_IsInteger(s) then
              FillInValue(TRCK, S, SR)
            else
              FillInValue(TRCK, '', SR)
         end
         else
         begin
              FillInValue(TRCKtotal, '', SR);
              FillInValue(TRCK, '', SR);
         end;

         if Id3v2.FindFirstFrame(fiPartInSet, id3Frame) then
         begin
            s := TJvID3TextFrame(id3Frame).Text;
            Q_TrimInPlace(s);
            if Q_StrScan(s, '/')>0 then
            begin
              FillInValue(TPOStotal, Q_CopyFrom(s, Q_StrScan(s, '/')+1), SR);
              s := Q_CopyLeft(s, Q_StrScan(s, '/')-1)
            end else FillInValue(TPOStotal, '', SR);
            if Q_IsInteger(s) then
              FillInValue(TPOS, S, SR)
            else
              FillInValue(TPOS, '', SR)
         end
         else
         begin
              FillInValue(TPOStotal, '', SR);
              FillInValue(TPOS, '', SR);
         end;

         //Content Groups Desc.
         if Id3v2.FindFirstFrame(fiContentGroup, id3Frame) then
            FillInValue(TIT1, TJvID3TextFrame(id3Frame).Text, SR)
         else
            FillInValue(TIT1, '', SR);

         //Title
         if Id3v2.FindFirstFrame(fiTitle, id3Frame) then
            FillInValue(TIT2, TJvID3TextFrame(id3Frame).Text, SR)
         else
            FillInValue(TIT2, '', SR);

         //Subtitle
         if Id3v2.FindFirstFrame(fiSubTitle, id3Frame) then
            FillInValue(TIT3, TJvID3TextFrame(id3Frame).Text, SR)
         else
            FillInValue(TIT3, '', SR);

         //Remixed By
         if Id3v2.FindFirstFrame(fiMixArtist, id3Frame) then
            FillInValue(TPE4, TJvID3TextFrame(id3Frame).Text, SR)
         else
            FillInValue(TPE4, '', SR);

         //Lead Artist
         id3v2Artist := '';
         if Id3v2.FindFirstFrame(fiLeadArtist, id3Frame) then
            id3v2Artist := TJvID3CustomTextFrame(id3Frame).Text;
         FillInValue(TPE1, id3v2Artist, SR);

         if not Id3v2.FindFirstFrame(fiPerformerSortOrder, id3Frame) then id3Frame := nil;
         if Assigned(id3Frame) then value := TJvID3TextFrame(id3Frame).Text;
         if Assigned(id3Frame) and not (Q_SameStr(id3v2Artist, value) or Q_SameStr(theFix(id3v2Artist), value)) then
          FillInValue(TSOP, value, SR)
         else
          FillInValue(TSOP, '', SR);

         //Band / Orchestra
         if Id3v2.FindFirstFrame(fiBand, id3Frame) then
            FillInValue(TPE2, TJvID3TextFrame(id3Frame).Text, SR)
         else
            FillInValue(TPE2, '', SR);

         //Conductor
         if Id3v2.FindFirstFrame(fiConductor, id3Frame) then
            FillInValue(TPE3, TJvID3TextFrame(id3Frame).Text, SR)
         else
            FillInValue(TPE3, '', SR);

         //Original Artist
         if Id3v2.FindFirstFrame(fiOrigArtist, id3Frame) then
           FillInValue(TOPE, TJvID3CustomTextFrame(id3Frame).Text, SR)
         else
           FillInValue(TOPE, '', SR);

         //Album
         if Id3v2.FindFirstFrame(fiAlbum, id3Frame) then
            FillInValue(TALB, TJvID3TextFrame(id3Frame).Text, SR)
         else
            FillInValue(TALB, '', SR);

        //Language
				filled := false;
        if Id3v2.FindFirstFrame(fiLanguage, id3Frame) then
				begin
        	s := TJvID3CustomTextFrame(id3Frame).Text;
          if length(s) >= 3 then
          begin
	          s := copy(s, 1, 3);
	          for x:=0 to Length(LanguageCodes)-1 do if Q_PosText(s, LanguageCodes[x]) > 0 then
	          begin
	          	FillInValue(TLAN, x, SR);
	            filled := true;
	            break
	        	end
          end
      	end;
      	if not filled then
      		FillInValue(TLAN, '', SR);

        //Year
        if Id3v2.FindFirstFrame(fiYear, id3Frame) then
          FillInValue(TYER, Integer(TJvID3NumberFrame(id3Frame).Value), SR)
        else if Id3v2.FindFirstFrame(fiRecordingTime, id3Frame) then
          FillInValue(TYER, GetYear(TJvID3TimestampFrame(id3Frame).Value), SR)
        else
          FillInValue(TYER, '', SR);

        //Composer
        if Id3v2.FindFirstFrame(fiComposer, id3Frame) then
          FillInValue(TCOM, TJvID3CustomTextFrame(id3Frame).Text, SR)
        else
          FillInValue(TCOM, '', SR);

        //Content Type / Genre
        if Id3v2.FindFirstFrame(fiContentType, id3Frame) then
        begin
          id3LstFrame := TJvID3SimpleListFrame(id3Frame);
          setLength(Sarr, id3LstFrame.List.Count);
          for x:=0 to id3LstFrame.List.Count-1 do
          begin
            if id3LstFrame.List[x] = 'RX' then
              Sarr[x] := 'remix'
            else if id3LstFrame.List[x] = 'CR' then
              Sarr[x] := 'cover'
            else
              Sarr[x] := GetGenreText (GenreToNiceGenre (id3LstFrame.List[x]));
          end;
          if length(Sarr) = 0 then
            FillInValue(TCON, '', SR)
          else
            FillInValue(TCON, Sarr, SR);
        end
        else
          FillInValue(TCON, '', SR);

        //Comments
        setLength(Iarr, 0);
        id3Frame := nil;
        while Id3v2.FindNextFrame(fiComment, id3Frame) do
        begin
          id3CntFrame := TJvID3ContentFrame(id3Frame);
          setLength(Iarr, length(Iarr)+1);
          new(commRec);
          FillChar(commRec^, SizeOf(commRec^), #0);
          commRec.Description := id3CntFrame.Description;
          commRec.Value := id3CntFrame.Text;
          commRec.Language := FindLanguage(id3CntFrame.language);
          commRec.Empty := false;
          Iarr[length(Iarr)-1] := integer(commRec);
        end;
        if length(Iarr)=0 then
          FillInValue(CommTree, '', SR)
        else
          FillInValue(CommTree, Iarr, SR);
        setLength(Iarr, 0);


        //BPM
        if Id3v2.FindFirstFrame(fiBPM, id3Frame) then
          FillInValue(TBPM, TJvID3TextFrame(id3Frame).Text, SR)
        else
          FillInValue(TBPM, '', SR);

       //Copyright
        if Id3v2.FindFirstFrame(fiCopyright, id3Frame) then
          FillInValue(TCOP, TJvID3TextFrame(id3Frame).Text, SR)
        else
          FillInValue(TCOP, '', SR);

        //Licensee
        if Id3v2.FindFirstFrame(fiFileOwner, id3Frame) then
          FillInValue(TOWN, TJvID3TextFrame(id3Frame).Text, SR)
        else
          FillInValue(TOWN, '', SR);

        //Publisher
        if Id3v2.FindFirstFrame(fiPublisher, id3Frame) then
          FillInValue(TPUB, TJvID3TextFrame(id3Frame).Text, SR)
        else
          FillInValue(TPUB, '', SR);

        //Encoded By
        if Id3v2.FindFirstFrame(fiEncodedBy, id3Frame) then
          FillInValue(TENC, TJvID3TextFrame(id3Frame).Text, SR)
        else
          FillInValue(TENC, '', SR);

        //Lyrics By
        if Id3v2.FindFirstFrame(fiLyricist, id3Frame) then
          FillInValue(TEXT, TJvId3CustomTextframe(id3Frame).Text, SR)
        else
          FillInValue(TEXT, '', SR);

        //URL
        if Id3v2.FindFirstFrame(fiWWWUser, id3Frame) then
        begin
            FillInValue(WXXX, TJvID3URLUserFrame(id3Frame).URL, SR)
        end
          else FillInValue(WXXX, '', SR);

        //Musicians
        if Id3v2.FindFirstFrame(fiMusicianCreditList, id3Frame) then
        begin
          id3DblLstFrame := TJvID3DoubleListFrame(id3Frame);
          setLength(Iarr, id3DblLstFrame.List.Count);
          for i:=0 to id3DblLstFrame.List.Count-1 do
          begin
             new(roleRec);
             roleRec.Empty := false;
             roleRec.Role := id3DblLstFrame.Names[i];
             roleRec.Name := id3DblLstFrame.Values[i];
             Iarr[i] := integer(roleRec)
          end;

          if length(Iarr)=0 then
            FillInValue(TMCL, '', SR)
          else
            FillInValue(TMCL, Iarr, SR);

          setLength(Iarr, 0)
        end
        else
          FillInValue(TMCL, '', SR);

        //Involved People list. IPLS is v3, TIPL is v4
        if Id3v2.FindFirstFrame(fiInvolvedPeople, id3Frame) or Id3v2.FindFirstFrame(fiInvolvedPeople2, id3Frame) then
        begin
          id3DblLstFrame := TJvID3DoubleListFrame(id3Frame);
          setLength(Iarr, id3DblLstFrame.List.Count);
          for i:=0 to id3DblLstFrame.List.Count-1 do
          begin
            new(roleRec);
            roleRec.Empty := false;
            roleRec.Role := id3DblLstFrame.Values[i];
            roleRec.Name := id3DblLstFrame.Names[i];
            Iarr[i] := integer(roleRec)
          end;
          
          if length(Iarr)=0 then
            FillInValue(TIPL, '', SR)
          else
            FillInValue(TIPL, Iarr, SR);

          setLength(Iarr, 0)
        end
        else
          FillInValue(TIPL, '', SR);

         //PrivateFrame

        //Lyrics (Id3V2)
        if not multipleFiles and Id3v2.FindFirstFrame(fiUnsyncedLyrics, id3Frame) then
        begin
          id3CntFrame := TJvID3ContentFrame(id3Frame);
          SR.Lyrics := trim(id3CntFrame.Text);
          SR.HasTagLyrics[tagId3v2] := length(SR.Lyrics)>0
        end;

        // Other fields
        SetLength(sDblArr, 0);
				for i:=0 to id3v2.Frames.Count-1 do
        begin
        	s := id3v2.Frames[i].FrameName;
         	if Q_SameTextL(s, 'T', 1) and not IsId3v2Control(s, self) and (id3v2.Frames[i].FrameID <> fiRecordingTime) then
          begin
          	SetLength(sDblArr, length(sDblArr)+1);
            SetLength(sDblArr[length(sDblArr)-1], 3);
            sDblArr[length(sDblArr)-1][0] := s;
            if Q_SameText(s, 'TXXX') then
            begin
            	sDblArr[length(sDblArr)-1][1] :=  TJvId3UserFrame(id3v2.Frames[i]).Description;
            	sDblArr[length(sDblArr)-1][2] :=  TJvId3UserFrame(id3v2.Frames[i]).Value;
            end
            else
            begin
	            sDblArr[length(sDblArr)-1][1] :=  '';
	            sDblArr[length(sDblArr)-1][2] := TJvId3CustomTextFrame(id3v2.Frames[i]).Text;
            end
          end
        end;
        if length(sDblArr)=0 then
          FillInValue(Id3v2OtherFields, '', SR)
        else
          FillInValue(Id3v2OtherFields, sDblArr, SR);


        if updateStats then AddToStat(Thread, SR, 'Id3v2 loaded');
      end
      else //thisHasV2Tag
        FillDummyValues(v2Components, SR);

      if not multipleFiles then
        LoadLyrics3(Fstr, SR);

      //Cleaning Up
      if Assigned(Id3v2) then Id3v2.free;
      if Assigned(Fid3v1) then FId3v1.free;
      if Assigned(FApe) then FApe.free;
      if Assigned(Fogg) then Fogg.Free;
      if Assigned(Fwma) then Fwma.Free;
      FStr.free
    finally
      EndUseId3v2
    end
  end //ReadAble
  else
  begin  // filen er not readable
    SR.HasV1 := false;
    SR.HasV2 := false;
    SR.HasApe := false;
    SR.HasWma := false;
    SR.HasOgg := false;
    SR.HasLyrics3V1 := false;
    SR.HasLyrics3V2 := false;
    for i:=tagId3v1 to tagMAX do
      SR.HasTagLyrics[i] := false;
    FillDummyValues(v1Components, SR);
    FillDummyValues(v2Components, SR);
    FillDummyValues(apeComponents, SR);
    FillDummyValues(wmaComponents, SR);
    FillDummyValues(oggComponents, SR);
    if updateStats then
      AddToStat(Thread, SR, 'Couldn''t load file')
  end
  end //FileExists
  else
  begin
    SR.HasV1 := false;
    SR.HasV2 := false;
    SR.HasApe := false;
    SR.HasWma := false;
    SR.HasOgg := false;
    SR.HasLyrics3V1 := false;
    SR.HasLyrics3V2 := false;
      for i:=tagId3v1 to tagMAX do
		SR.HasTagLyrics[i] := false;
    FillDummyValues(v1Components, SR);
    FillDummyValues(v2Components, SR);
    FillDummyValues(apeComponents, SR);
    FillDummyValues(wmaComponents, SR);
    FillDummyValues(oggComponents, SR);

    if updateStats then
      AddToStat(Thread, SR, 'File not found')
		 end;

	FillInValue(savegroups, saveGroups.state, SR);
  if updateStats and SR.FileExists and not SR.HasV1 and not SR.HasV2 and not SR.HasApe and not SR.HasWMA and not SR.HasOgg then
  	AddToStat(Thread, SR, 'No tags found')
end;

function TEditor.LoadValues: Boolean;
var     sNode : PVirtualNode;
        R : PRec;
				SR : PstatRec;
				FillInfoRec : PFillInValueProcedureInfo;
				ShowProDlg : boolean;
				ProForm : TInputbox2;
				cancelled : boolean;
				i:integer;
        th: TThread;
begin
  TagLoaded := true; //To Prevent (re)loading on show
  //Groups BEGIN

  screen.cursor := crAppStart;

  MultipleFiles := recs.count > 1;

  ShowProDlg := recs.count > 5;

  stat.beginUpdate;
  stat.RootNodeCount := recs.count;

  cancelled := false;

  if ShowProDlg then
  begin
  	MainFormInstance.showProcessDlg('Loading files', stat.RootNodeCount, true, ProForm);
  	ProForm.Show;
  	ProForm.Repaint
  end;

  SR := nil;
  sNode := stat.GetFirst;

  for i:=0 to recs.count-1 do
  begin
  	R := recs.Items[i];

  	SR := stat.GetNodeData(sNode);
  	SR.ref := R;

//   	FillInValues(R, SR, i=0); //i=0 er FirstRun          //fjernes
    new(FillInfoRec);
    FillInfoRec.Pr := r;
    FillInfoRec.pSR := SR;
    FillInfoRec.firstRun := i=0;
    FillInfoRec.updateStats := true;
    FillInfoRec.useFileWriteBeginEnd := false;

    ReadFileThread.Start(FillInfoRec);
    while ReadFileThread.Runing do
    begin
      application.ProcessMessages;
      sleep(10)
    end;

    dispose(FillInfoRec);

   if ShowProDlg then
   	ProForm.Pbar.Position := ProForm.Pbar.Position +1;

   	cancelled := ShowProDlg and ProForm.CancelPressed;
   	if cancelled then
    	break;
   	sNode := stat.GetNext(sNode)
  end;
  if ShowProDlg then
  begin
  	ProForm.release;
    FreeAndNil(ProForm)
  end;
  stat.endUpdate;

  if cancelled then
  begin
  	stat.clear;
    result := false
  end
  else
  begin
    FillValuesToBoxes;

    sNode := stat.GetFirst;
    SR := stat.GetNodeData(sNode);
    cbHasId3v2Tag.checked := SR.HasV2;
    cbHasId3v1Tag.checked := SR.HasV1;
    cbHasApeTag.Checked := SR.HasApe;
    cbHasWMATag.Checked := SR.HasWma;
    cbHasOggTag.Checked := SR.HasOgg;

    HasLyrics.checked := not multipleFiles and (SR.HasTagLyrics[tagId3v2] or SR.HasTagLyrics[tagApe] or SR.HasTagLyrics[tagWMA] or SR.HasTagLyrics[tagOgg] or SR.HasLyrics3V1 or SR.HasLyrics3V2);
    tagLyrics.Checked := HasLyrics.checked and (SR.HasTagLyrics[tagId3v2] or SR.HasTagLyrics[tagApe] or SR.HasTagLyrics[tagWMA] or SR.HasTagLyrics[tagOgg]);
    Lyrics3v1.Checked := HasLyrics.checked and SR.HasLyrics3V1;
    Lyrics3v2.Checked := HasLyrics.checked and SR.HasLyrics3V2;
    if HasLyrics.checked then
    	LyricsMemo.text := SR.lyrics;

    sNode := stat.GetNext(sNode);
    while assigned(sNode) do
    begin
      SR := stat.GetNodeData(sNode);
      if (SR.HasV1 and (cbHasId3v1Tag.state = cbUnChecked)) or ((not SR.HasV1) and (cbHasId3v1Tag.state = cbChecked)) then cbHasId3v1Tag.state := cbGrayed;
      if (SR.HasV2 and (cbHasId3v2Tag.state = cbUnChecked)) or ((not SR.HasV2) and (cbHasId3v2Tag.state = cbChecked)) then cbHasId3v2Tag.state := cbGrayed;
      if (SR.HasApe and (cbHasApeTag.state = cbUnChecked)) or ((not SR.HasApe) and (cbHasApeTag.state = cbChecked)) then cbHasApeTag.state := cbGrayed;
      if (SR.HasWMA and (cbHasWMATag.state = cbUnChecked)) or ((not SR.HasWMA) and (cbHasWMATag.state = cbChecked)) then cbHasWMATag.state := cbGrayed;
      if (SR.HasOgg and (cbHasOggTag.state = cbUnChecked)) or ((not SR.HasOgg) and (cbHasOggTag.state = cbChecked)) then cbHasOggTag.state := cbGrayed;
      sNode := stat.getNext(sNode)
    end;

    for i:=low(HasTagCheckboxes) to high(HasTagCheckboxes) do
    	HasTagCheckboxes[i].AllowGrayed := HasTagCheckboxes[i].State = cbGrayed;

    cbCompilation.AllowGrayed := cbCompilation.State = cbGrayed;
    CreateUndoIcons;
    ReadMpegInfo.Start;

    result := true
  end;

  GroupCheck.OnChecking := GroupCheckChecking;
  GroupCheck.OnChecked := GroupCheckChecked;

  CBhasId3v1Tag.OnClick := CBhasTagClick;
  CBhasId3v2Tag.OnClick := CBhasTagClick;
  CBhasApeTag.OnClick := CBhasTagClick;
  CBhasWMATag.OnClick := CBhasTagClick;
  CBhasOggTag.OnClick := CBhasTagClick;
  id3v23.Onclick := UpdateCheckBoxes;
  id3v24.Onclick := UpdateCheckBoxes;
  HasLyrics.OnClick := UpdateCheckBoxes;
  tagLyrics.OncLick := UpdateCheckBoxes;

  screen.cursor := crDefault;
  if not cancelled then
  	begin
      if Pref.ID3_AlwaysCopyFromDB.checked then     //defaults fra Preferences
        for i:=low(HasTagCheckboxes) to high(HasTagCheckboxes) do
          if HasTagCheckboxes[i].State <> cbUnchecked then
            copyTagSettings[i] := tagDB;

      if Pref.ID3_AutoGetLyrics.checked and not multipleFiles and (length(SR.Lyrics) = 0) and ConnectedToInternet then
      begin
        LyricsThread.Start(nil);
        GetFromInternet.OnClick := nil;
        GetFromInternet.Checked := true;
        GetFromInternet.OnClick := GetFromInternetClick
      end
    end
end;

procedure TEditor.CommTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
var     R : PcommRec;
begin
  R := CommTree.GetNodeData(Node);
  if R.Empty then
  	text := ' - '
  else
  case Column of
    0 :
    	if R.Language = -1 then
    		text := ' - '
    	else                                
    		text := LanguageNames[R.Language];
    1 : text := R.Description;
    2 : text := R.Value
  end;
  text := Q_ReplaceStr(text, #13, ' ');
  text := Q_ReplaceStr(text, #10, '')
end;

procedure TEditor.TMCLGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
var     R : ProleRec;
begin
  R := Sender.GetNodeData(Node);
  if R.Empty then text := ' - ' else
  case Column of
    0 : text := R.Role;
    1 : text := R.Name
  end
end;

procedure TEditor.TRCKChange(Sender: TObject);
var      modified : boolean;
begin
				if Tedit(Sender).Text = '0' then TEdit(Sender).Text := '';

        modified := ((Sender is TEdit) and TEdit(sender).modified) or not (sender is Tedit);
        if not modified then exit;

        if ((Sender as TEdit).text <> '') and (not Q_IsInteger((Sender as TEdit).text)) then
				begin
             createUndo(sender);
             doUndo(sender)
        end;
        FieldChanged(sender)
end;

procedure TEditor.ToggleTitleClick(Sender: TObject);
begin
				if ToggleTitle.tag = 0 then
                begin
                        ToggleTitle.tag := 1;
												PanelTitle.Height := 106;
												ToggleTitle.Caption := '-'
								end else
								begin
												ToggleTitle.tag := 0;
												PanelTitle.Height := 26;
												ToggleTitle.Caption := '+'
                end;
				v2Scroll.Max :=  panel2.Height;
        v2Scroll.Visible := V2scroll.PageSize < V2scroll.Max
end;

procedure TEditor.ToggleArtistClick(Sender: TObject);
begin
				if ToggleArtist.tag = 0 then
                begin
												ToggleArtist.tag := 1;
                        PanelArtist.Height := 185;
                        ToggleArtist.Caption := '-'
								end else
                begin
												ToggleArtist.tag := 0;
												PanelArtist.Height := 26;
												ToggleArtist.Caption := '+'
								end;
				v2Scroll.Max := panel2.Height;
        v2Scroll.Visible := V2scroll.PageSize < V2scroll.Max
end;

procedure TEditor.CBhasTagClick(Sender: TObject);
var
	target: Integer;
begin
	if Pref.Id3_AutoCopyFromDB.checked and (TCheckBox(Sender).State = cbChecked) then
		for target:=low(HasTagCheckboxes) to high(HasTagCheckboxes) do
			if Sender = HasTagCheckboxes[target] then
				copyTagSettings[target] := tagDB;
	UpdateCheckBoxes(sender)
end;

function TEditor.GetTagSupported(tagID: Integer; pSR: Pointer):Boolean;
begin
	case tagID of
		tagID3v1:		result := AudioTypes[PRec(PStatRec(pSR).ref).AudioType].Id3v1;
		tagID3v2:		result := AudioTypes[PRec(PStatRec(pSR).ref).AudioType].Id3v2;
		tagAPE:			result := AudioTypes[PRec(PStatRec(pSR).ref).AudioType].ApeV1 or AudioTypes[PRec(PStatRec(pSR).ref).AudioType].ApeV2;
		tagWMA:			result := AudioTypes[PRec(PStatRec(pSR).ref).AudioType].WMA;
		tagOGG:			result := AudioTypes[PRec(PStatRec(pSR).ref).AudioType].Ogg
	else result := false
	end
end;

function TEditor.GetTagSupported(tagID: Integer):boolean;
var
	aNode: PVirtualNode;
begin
	result := false;
	aNode := stat.GetFirst;
	while aNode <> nil do
	begin
		result := result or GetTagSupported(tagID, stat.GetNodeData(aNode));
		aNode := stat.GetNext(aNode)
	end
end;

Procedure TEditor.UpdateCheckBoxes(Sender: TObject);
function GetWriteable:boolean;
var
	aNode: PVirtualNode;
begin
	result := false;
	aNode := stat.GetFirst;
	while aNode <> nil do
	begin
		result := result or PStatRec(stat.GetNodeData(aNode)).writeable;
		aNode := stat.GetNext(aNode)
	end
end;
var
	i: Integer;
	wa, isMp3File, b: Boolean; //writeable
begin
	wa := GetWriteable;
	for i:=tagId3v1 to tagMAX do
		HasTagCheckboxes[i].Enabled := wa and GetTagSupported(i);

	TabId3v1.TabVisible := GetTagSupported(tagId3v1);
	TabId3v2.TabVisible := GetTagSupported(tagId3v2);
	TabId3v2X1.TabVisible := TabId3v2.TabVisible;
	TabApe.TabVisible := GetTagSupported(tagApe);
	TabWMA.TabVisible := GetTagSupported(tagWMA);
	TabOgg.TabVisible := GetTagSupported(tagOgg);

	isMp3File := PRec(PStatRec(Stat.GetNodeData(Stat.GetFirst)).ref).AudioType = 0;
	TabLyrics.TabVisible := not multipleFiles;
	HasLyrics.enabled := not multipleFiles and GetWriteable;

	b := false;
	for i:=tagId3v2 to tagMAX do
		b := b or ((HasTagCheckBoxes[i].State <> cbUnchecked) and HasTagCheckBoxes[i].Enabled);

	tagLyrics.Enabled := HasLyrics.enabled and HasLyrics.checked and b and GetWriteAble;

	Lyrics3V1.enabled := HasLyrics.enabled and HasLyrics.checked and GetWriteAble and isMp3File;
	Lyrics3V2.enabled := HasLyrics.enabled and HasLyrics.checked  and GetWriteAble and isMp3File;
	id3v23.enabled := CBHasId3V2Tag.enabled and (CBHasId3v2Tag.state <> cbUnchecked);
	id3v24.enabled := CBHasId3V2Tag.enabled and (CBHasId3v2Tag.state <> cbUnchecked);

	SaveGroups.enabled := true;//(CBHasId3v2Tag.state <> cbUnchecked) and CBHasId3V2Tag.enabled;

	LyricsBox.Visible := not multipleFiles and (PageControl1.ActivePageIndex = 7);
	GroupsBox.Visible := not LyricsBox.visible;

	UpdateImageIndexes;

	LyricsMemo.enabled := HasLyrics.checked and (tagLyrics.checked or lyrics3v1.checked or lyrics3v2.checked);

	//TMCL
	TMCL.enabled := Id3v24.checked;
	AddMusiciansBut.enabled := TMCL.enabled;
	DelMusiciansBut.enabled := TMCL.enabled;
	// eo TMCL

	UpdateCopyButtons;
	UpdateChangedCaption
end;

Procedure TEditor.ShowUndo(Sender: TObject);
var
        Comp : TComponent;
begin
	if Sender is TControl then
	begin
		Comp := Editor.FindComponent(TControl(Sender).name + 'Undo');
		if Comp <> nil then if Comp is Timage then Timage(Comp).visible := canUndo(sender)
	end
end;

function TEditor.CanUndo(sender:TObject):Boolean;
var      i:integer;
				 undoRec:PundoRec;
begin
	result := false;
	if not (Sender is TControl) then exit;

	for i:=undoList.count-1 downto 0 do
	begin
		undoRec := undoList.items[i];
		if (undoRec.Obj = sender) and (not undoRec.OrigState) then
		begin
			result := true;
			break
		end
	end
end;

function TEditor.EqualUndoRecs(p1, p2:pointer; GrayAllowedInCheckedTree: Boolean=false):boolean;
var
	i, x:integer;
  UR1, UR2:PundoRec;
  s1, s2 : String;
begin
{    Sammenligner to undoRecs
}
     result := false;
		 UR1 := p1;
     UR2 := p2;
		 if (UR1.Obj = UR2.Obj) and (UR1.Gray = UR2.Gray) then
     begin
          if (UR1.Obj Is Tedit) or (UR1.Obj Is TJvComboBox) then
          begin
               if UR1.UndoType = UTstring then s1 := PundoString(UR1.p).s else
							 if UR1.UndoType = UTinteger then if PundoInteger(UR1.p).i = -1 then s1 := '' else s1 := TJvComboBox(UR1.Obj).items[PundoInteger(UR1.p).i];

               if UR2.UndoType = UTstring then s2 := PundoString(UR2.p).s else
               if UR2.UndoType = UTinteger then if PundoInteger(UR2.p).i = -1 then s2 := '' else s2 := TJvComboBox(UR2.Obj).items[PundoInteger(UR2.p).i];

               result := Q_SameStr(s1, s2)
          end else
          if UR1.Obj Is TcheckBox then
          begin
							 result := PundoChecked(UR1.p).b = PundoChecked(UR2.p).b
					end else
          if (UR1.Obj = genre) or (UR1.Obj = TCON) then
          begin
               result := PundoGenres(UR1.p).cover = PundoGenres(UR2.p).cover;
               result := result and (PundoGenres(UR1.p).remix = PundoGenres(UR2.p).remix);
               result := result and (length(PundoGenres(UR1.p).arr) = length(PundoGenres(UR2.p).arr));
               if result then
                  for i:=0 to length(PundoGenres(UR1.p).arr)-1 do
                  begin
                       result := false;
                       for x:=0 to length(PundoGenres(UR2.p).arr)-1 do
                           result := result or Q_SameStr(PundoGenres(UR1.p).arr[i], PundoGenres(UR2.p).arr[x]);
                       if not result then break
                  end
          end else
          if UR1.Obj = CommTree then
          begin
               result := length(PundoComments(UR1.p).arr) = length(PundoComments(UR2.p).arr);
               if result then
                  for i:=0 to length(PundoComments(UR1.p).arr)-1 do
                  begin
                       result := false;
											 for x:=0 to length(PundoComments(UR2.p).arr)-1 do
													 result := result or (Q_SameStr(PcommRec(PundoComments(UR1.p).arr[i]).Description, PcommRec(PundoComments(UR2.p).arr[x]).Description) and Q_SameStr(PcommRec(PundoComments(UR1.p).arr[i]).Value, PcommRec(PundoComments(UR2.p).arr[x]).Value) and (PcommRec(PundoComments(UR1.p).arr[i]).Language = PcommRec(PundoComments(UR2.p).arr[x]).Language));
													 if not result then break
                  end
          end else
          if (UR1.Obj = TMCL) or (UR1.Obj = TIPL)  then
          begin
               result := length(PundoRoles(UR1.p).arr) = length(PundoRoles(UR2.p).arr);
               if result then
                  for i:=0 to length(PundoRoles(UR1.p).arr)-1 do
                  begin
                       result := false;
											 for x:=0 to length(PundoRoles(UR2.p).arr)-1 do
                           result := result or (Q_SameStr(ProleRec(PundoRoles(UR1.p).arr[i]).name, ProleRec(PundoRoles(UR2.p).arr[x]).name) and Q_SameStr(ProleRec(PundoRoles(UR1.p).arr[i]).role, ProleRec(PundoRoles(UR2.p).arr[x]).role));
                           if not result then break
                  end
          end else
          if UR1.Obj = GroupCheck then
          begin
							 result := length(PundoGroups(UR1.p).arr) = length(PundoGroups(UR2.p).arr);
							 if result then
									for i:=0 to length(PundoGroups(UR1.p).arr)-1 do
											result := result and ((PundoGroups(UR1.p).arr[i] = PundoGroups(UR2.p).arr[i]) or (GrayAllowedInCheckedTree and (PundoGroups(UR1.p).arr[i] = cbGrayed)))
					end
          else
          if UR1.Obj = CustomFieldTree then
          begin
          	result := true;
            	for i:=0 to length(PUndoCustomFields(UR1.p).arr) - 1 do
              	result := result and Q_SameStr(PUndoCustomFields(UR1.p).arr[i].value, PUndoCustomFields(UR2.p).arr[i].value) and (PUndoCustomFields(UR1.p).arr[i].gray = PUndoCustomFields(UR2.p).arr[i].gray)
          end
          else
          if IsOtherFieldsTree(UR1.Obj) then
          begin
          	result := length(PUndoTagFields(UR1.p).arr) = length(PUndoTagFields(UR2.p).arr);
            if result then
	            for i:=0 to length(PUndoTagFields(UR1.p).arr) - 1 do
	            	result := result and Q_SameStr(PUndoTagFields(UR1.p).arr[i].value, PUndoTagFields(UR2.p).arr[i].value) and (PUndoTagFields(UR1.p).arr[i].gray = PUndoTagFields(UR2.p).arr[i].gray)
          end
					{
					if UR1.Obj Is TVirtualStringTree then
          begin
               if PundoStream(UR1.p).s.Size = PundoStream(UR2.p).s.Size then
               begin
                    result := true;
                    PundoStream(UR1.p).s.position := 0;
                    PundoStream(UR2.p).s.position := 0;
                    while (PundoStream(UR1.p).s.position <> PundoStream(UR1.p).s.size) and result do
                    begin
                         PundoStream(UR1.p).s.Read(b1, 1);
                         PundoStream(UR2.p).s.read(b2, 1);
                         if (b1<>b2) then result := false
                    end
               end
               else result := false
          end       }
     end
end;

function TEditor.NeedOfNewUndo(sender: TObject):Boolean;
var      i:integer;
         undoRec, newUndoRec:PundoRec;
begin
{    Ser om der skal laves en ny Undo.
     I undoListen skal der ikke være dupes lige efter hinanden, dette bruges den til
}    result := true;
     if not (Sender is TControl) then exit;

     for i:=undoList.count-1 downto 0 do
     begin
					undoRec := undoList.items[i];
          if (undoRec.Obj = sender) and (sender Is Tedit) then
          begin
               result := (undoRec.Gray <> getGrayed(sender)) or not Q_SameStr(trim(Tedit(sender).text), trim(PundoString(undoRec.p).s));
               break
          end else
          if (undoRec.Obj = sender) and (sender Is TJvComboBox) then
          begin
               result := (undoRec.Gray <> getGrayed(sender)) or not Q_SameStr(trim(TJvComboBox(sender).text), trim(PundoString(undoRec.p).s));
               break
          end else
          if (undoRec.Obj = sender) and (sender Is TcheckBox) then
          begin
							 result := (undoRec.Gray <> getGrayed(sender)) or (TcheckBox(sender).state <> PundoChecked(undoRec.p).b);
							 break
          end else
					if (undoRec.Obj = sender) and (sender Is TVirtualStringTree) then
          begin
               newUndoRec := doCreateUndo(sender,undoRec.OrigState, undoRec.Gray);
							 result := (undoRec.Gray <> getGrayed(sender)) or not EqualUndoRecs(undoRec, newUndoRec);
							 doDeleteUndo(newUndoRec);
               break
					end
		 end
end;

{procedure TEditor.createUndoStream(aTree : TVirtualStringTree; const s:TStream);
var       aNode:PVirtualNode;
          b:TCheckBoxState;
begin
     if aTree = genre then
     begin
					b := genreCover.state;
					s.Write(b, sizeOf(TCheckBoxState));
          b := genreRemix.state;
          s.Write(b, sizeOf(TCheckBoxState))
     end else
     if aTree = TCON then
     begin
          b := V2Cover.state;
          s.Write(b, sizeOf(TCheckBoxState));
          b := V2Remix.state;
          s.Write(b, sizeOf(TCheckBoxState))
		 end;
     aNode := aTree.GetFirst;
     while aNode <> nil do
     begin
          s.Write(aTree.GetNodeData(aNode)^, aTree.nodeDataSize);
          aNode := aTree.getNext(aNode)
     end
end;   }

function TEditor.doCreateUndo(sender: TObject; origState:boolean; Gray:boolean): pointer;
var
  UndoRec:PundoRec;
  stringRec : PundoString;
  checkedRec : PundoChecked;
  undoGenres : PundoGenres;
  undoComments : PundoComments;
  undoRoles : PundoRoles;
  undoGroups : PundoGroups;
  undoCustomFields : PundoCustomFields;
  undoTagFields: PUndoTagFields;

  cf: PCustomFieldRec;
  tf: PTagFieldRec;

  aTree : TVirtualStringTree;
  aNode : PvirtualNode;
begin
     result := nil;
     if not (Sender is TControl) then exit;

		 if sender is TEdit then
     begin //  TEdits
          new(UndoRec);
          UndoRec.UndoType := UTstring;
          UndoRec.Obj := sender;
          UndoRec.OrigState := origState;
          UndoRec.Gray := Gray;

					new(stringRec);
					UndoRec.p := stringRec;
          stringRec.s := Tedit(sender).text;

          result := undoRec
     end else
     if sender is TJvComboBox then
     begin //  TJvComboBox
          new(UndoRec);
          UndoRec.UndoType := UTstring;
          UndoRec.Obj := sender;
          UndoRec.OrigState := origState;
          UndoRec.Gray := Gray;

          new(stringRec);
          UndoRec.p := stringRec;
          stringRec.s := TJvComboBox(sender).text;

          result := undoRec
     end else
     if sender is TCheckBox then
     begin //  TCheckBox
          new(UndoRec);
          UndoRec.UndoType := UTchecked;
          UndoRec.Obj := sender;
          UndoRec.OrigState := origState;
          UndoRec.Gray := Gray;

          new(checkedRec);
          UndoRec.p := checkedRec;
          checkedRec.b := TcheckBox(sender).state;

          result := undoRec
     end else
     if (sender = Genre) or (sender = TCON) then
		 begin
          aTree := TVirtualStringTree(sender);
          new(UndoRec);
          UndoRec.UndoType := UTgenres;
          UndoRec.Obj := sender;
          UndoRec.OrigState := origState;
          UndoRec.Gray := Gray;

					new(undoGenres);
					UndoRec.p := undoGenres;

          if sender = Genre then
          begin
               undoGenres.cover := genreCover.state;
               undoGenres.remix := genreRemix.state
          end else
          if sender = TCON then
          begin
               undoGenres.cover := V2Cover.state;
               undoGenres.remix := V2Remix.state
          end;

          setLength(undoGenres.arr, aTree.rootNodeCount);
          aNode := aTree.GetFirst;
          while aNode <> nil do
          begin
               undoGenres.arr[aNode.index] := PgenreRec(aTree.GetNodeData(aNode)).text;
               aNode := aTree.GetNext(aNode)
          end;

          result := undoRec
     end else
		 if sender = CommTree then
		 begin
					new(UndoRec);
					UndoRec.UndoType := UTcomments;
					UndoRec.Obj := sender;
					UndoRec.OrigState := origState;
					UndoRec.Gray := false;	//kan ikke graye alle

					new(undoComments);
					UndoRec.p := undoComments;

					setLength(undoComments.arr, CommTree.rootNodeCount);
          aNode := CommTree.GetFirst;
          while aNode <> nil do
          begin
               new(PcommRec(undoComments.arr[aNode.index]));
               PcommRec(undoComments.arr[aNode.index]).empty := PcommRec(CommTree.GetNodeData(aNode)).empty;
               PcommRec(undoComments.arr[aNode.index]).Description := PcommRec(CommTree.GetNodeData(aNode)).Description;
               PcommRec(undoComments.arr[aNode.index]).value := PcommRec(CommTree.GetNodeData(aNode)).value;
							 PcommRec(undoComments.arr[aNode.index]).language := PcommRec(CommTree.GetNodeData(aNode)).language;
               pcommRec(undoComments.arr[aNode.index]).Gray := PcommRec(CommTree.GetNodeData(aNode)).Gray;
							 aNode := CommTree.GetNext(aNode)
          end;

          result := undoRec
     end else
     if (sender = TMCL) or (sender = TIPL) then
     begin
          aTree := TVirtualStringTree(sender);
          new(UndoRec);
          UndoRec.UndoType := UTroles;
          UndoRec.Obj := sender;
          UndoRec.OrigState := origState;
          UndoRec.Gray := Gray;

          new(undoRoles);
          UndoRec.p := undoRoles;

          setLength(undoRoles.arr, aTree.rootNodeCount);
          aNode := aTree.GetFirst;
          while aNode <> nil do
          begin
               new(ProleRec(undoRoles.arr[aNode.index]));
               ProleRec(undoRoles.arr[aNode.index]).empty := ProleRec(aTree.GetNodeData(aNode)).empty;
							 ProleRec(undoRoles.arr[aNode.index]).name := ProleRec(aTree.GetNodeData(aNode)).name;
               ProleRec(undoRoles.arr[aNode.index]).role := ProleRec(aTree.GetNodeData(aNode)).role;
               aNode := aTree.GetNext(aNode)
          end;
          result := undoRec
     end else
  if sender = groupCheck then
  begin
    new(UndoRec);
    UndoRec.UndoType := UTgroups;
    UndoRec.Obj := sender;
    UndoRec.OrigState := origState;
    UndoRec.Gray := false;  //kan ikke graye alle

    new(undoGroups);
    UndoRec.p := undoGroups;

    setLength(undoGroups.arr, groupCheck.rootNodeCount);
    aNode := groupCheck.GetFirst;
    while aNode <> nil do
    begin
         if groupCheck.checkState[aNode] = csCheckedNormal then undoGroups.arr[aNode.index] := cbChecked else
         if groupCheck.checkState[aNode] = csUncheckedNormal then undoGroups.arr[aNode.index] := cbUnchecked else
         undoGroups.arr[aNode.index] := cbGrayed;
         aNode := groupCheck.GetNext(aNode)
    end;
    result := undoRec
  end
  else
  if sender = CustomFieldTree then
  begin
    new(UndoRec);
    UndoRec.UndoType := UTcustomFields;
    UndoRec.Obj := sender;
    UndoRec.OrigState := origState;
    UndoRec.Gray := false;  //kan ikke graye alle

    new(undoCustomFields);
    UndoRec.p := undoCustomFields;

    setLength(undoCustomFields.arr, CustomFieldTree.rootNodeCount);
    aNode := CustomFieldTree.GetFirst;
    while aNode <> nil do
    begin
    	cf := CustomFieldTree.GetNodeData(aNode);
      undoCustomFields.arr[cf.FieldIndex].FieldIndex := cf.FieldIndex;
      undoCustomFields.arr[cf.FieldIndex].gray := cf.gray;
      undoCustomFields.arr[cf.FieldIndex].value := cf.value;

      aNode := CustomFieldTree.GetNext(aNode)
    end;
    result := undoRec
	end
  else
  if IsOtherFieldsTree(sender) then
  begin
  	aTree := TVirtualStringTree(sender);
		new(UndoRec);
    UndoRec.UndoType := UTTagFields;
    UndoRec.Obj := sender;
    UndoRec.OrigState := origState;
    UndoRec.Gray := false;  //kan ikke graye alle

    new(undoTagFields);
    UndoRec.p := undoTagFields;

    setLength(undoTagFields.arr, aTree.rootNodeCount);
    aNode := aTree.GetFirst;
    while aNode <> nil do
    begin
    	tf := aTree.GetNodeData(aNode);
      undoTagFields.arr[aNode.index].FieldName := tf.FieldName;
      undoTagFields.arr[aNode.index].gray := tf.gray;
      undoTagFields.arr[aNode.index].value := tf.value;
      undoTagFields.arr[aNode.index].description := tf.description;

      aNode := aTree.GetNext(aNode)
    end;
    result := undoRec
  end
end;


{function TEditor.doCreateUndo(sender: TObject; origState:boolean; Gray:boolean): pointer;
var       UndoRec:PundoRec;
          stringRec : PundoString;
          streamRec : PundoStream;
          checkedRec : PundoChecked;
          undoGenres : PundoGenres;
begin
     result := nil;
     if not (Sender is TControl) then exit;

     if sender is TEdit then
     begin //  TEdits
					new(UndoRec);
          UndoRec.UndoType := UTstring;
          UndoRec.Obj := sender;
          UndoRec.OrigState := origState;
          UndoRec.Gray := Gray;

          new(stringRec);
          UndoRec.p := stringRec;
          stringRec.s := Tedit(sender).text;

          result := undoRec
     end else
     if sender is TJvComboBox then
     begin //  TJvComboBox
          new(UndoRec);
          UndoRec.UndoType := UTstring;
          UndoRec.Obj := sender;
          UndoRec.OrigState := origState;
          UndoRec.Gray := Gray;

					new(stringRec);
          UndoRec.p := stringRec;
          stringRec.s := TJvComboBox(sender).text;

          result := undoRec
     end else
     if sender is TCheckBox then
     begin //  TCheckBox
          new(UndoRec);
          UndoRec.UndoType := UTchecked;
          UndoRec.Obj := sender;
          UndoRec.OrigState := origState;
          UndoRec.Gray := Gray;

          new(checkedRec);
          UndoRec.p := checkedRec;
          checkedRec.b := TcheckBox(sender).state;

          result := undoRec
     end else
     if sender is TvirtualStringTree then
     begin //  TvirtualStringTree
          new(UndoRec);
					if (sender = Genre) or (sender = TCON) then
          begin
               UndoRec.UndoType := UTgenres;
               UndoRec.Obj := sender;
               UndoRec.OrigState := origState;
               UndoRec.Gray := Gray;

               new(undoGenres);
               UndoRec.p := undoGenres;

               if sender = Genre then
               begin
                    undoGenres.cover := genreCover.state

          streamRec.s := TMemorystream.create;
          createUndoStream(TVirtualStringTree(sender), streamRec.s);
          result := undoRec
     end
end;            }

procedure TEditor.setGrayed(target: TObject; value:boolean; clear:boolean=false);
var       clr:TColor;
begin
     if (target = groupCheck) or (target = CustomFieldTree) then
     	exit;
     
     if value then clr := colorGray else clr := colorWhite;
     clear := clear and value;
     if target is TEdit then
     begin
          TEdit(target).color := clr;
          if clear then TEdit(target).text := ''
     end else
     if target is TJvComboBox then
     begin
          TJvComboBox(target).color := clr;
          if clear then TJvComboBox(target).text := ''
     end else
     if target is TVirtualStringTree then
     begin
          if (target = genre) and clear then
          begin
               if genreCover.checked then genreCover.state := cbGrayed;
               if genreRemix.checked then genreRemix.state := cbGrayed
					end else
          if (target = TCON) and clear then
          begin
               if V2Cover.checked then V2Cover.state := cbGrayed;
               if V2Remix.checked then V2Remix.state := cbGrayed
          end;
          TVirtualStringTree(target).color := clr;
          if clear then TVirtualStringTree(target).rootnodecount := 0
     end else
     if target is TCheckbox then
     begin
          if value then
             TCheckbox(target).state := cbGrayed
     end
end;

function TEditor.GetGrayed(Target: TObject):boolean;
begin
  if target is TCheckbox then result := TCheckBox(target).state = cbGrayed else
  if target is TEdit then result :=  TEdit(target).color = colorGray else
  if target is TJvComboBox then result := TJvComboBox(target).color = colorGray else
  if target is TVirtualStringTree then result := TVirtualStringTree(target).color = colorGray else
  result := false
end;

Function TEditor.CreateUndo(sender: TObject; origState:boolean=false): Boolean;
var       p:pUndoRec;
begin
{    Bruges hver gang et object bliver ændret
}
     if origState or NeedOfNewUndo(sender) then
     begin
          p := doCreateUndo(sender, origState, getGrayed(sender));
          if assigned(p) then
          begin
               undoList.add(p)
          end;
          result := true
     end
     else
     	result := false
end;

procedure TEditor.doDeleteUndo(p:pointer);
var       i:integer;
begin
		 if PundoRec(p).undoType = UTstringArray then
     begin
          setLength(PundoStringArray(PundoRec(p).p).arr, 0);
					dispose(PundoStringArray(PundoRec(p).p))
     end
     else
     if PundoRec(p).undoType = UTgenres then
     begin
          setLength(PundoGenres(PundoRec(p).p).arr, 0);
          dispose(PundoGenres(PundoRec(p).p))
     end else
     if PundoRec(p).undoType = UTCustomFields then
     begin
          setLength(PundoCustomFields(PundoRec(p).p).arr, 0);
          dispose(PundoCustomFields(PundoRec(p).p))
     end else
     if PUndoRec(p).undoType = UTTagFields then
     begin
     	setLength(PundoTagFields(PundoRec(p).p).arr, 0);
      dispose(PundoTagFields(PundoRec(p).p))
     end else
     if PundoRec(p).undoType = UTgroups then
     begin
          setLength(PundoGroups(PundoRec(p).p).arr, 0);
          dispose(PundoGroups(PundoRec(p).p))
     end else
     if PundoRec(p).undoType = UTComments then
     begin
          for i:=0 to length(PundoComments(PundoRec(p).p).arr)-1 do
							 dispose(PcommRec(PundoComments(PundoRec(p).p).arr[i]));
					setLength(PundoComments(PundoRec(p).p).arr, 0);
          dispose(PundoComments(PundoRec(p).p))
     end else
     if PundoRec(p).undoType = UTroles then
     begin
          for i:=0 to length(PundoRoles(PundoRec(p).p).arr)-1 do
               dispose(ProleRec(PundoRoles(PundoRec(p).p).arr[i]));
          setLength(PundoRoles(PundoRec(p).p).arr, 0);
          dispose(PundoRoles(PundoRec(p).p))
     end else
     if PundoRec(p).undoType = UTstring then
          dispose(PundoString(PundoRec(p).p))
     else if PundoRec(p).undoType = UTchecked then
          dispose(PundoChecked(PundoRec(p).p))
     else if PundoRec(p).undoType = UTinteger then
          dispose(PundoInteger(PundoRec(p).p));

     PundoRec(p).p := nil;
     dispose(PundoRec(p))
end;

procedure TEditor.deleteUndo(index:integer);
begin
		 doDeleteUndo(undoList.items[index]);
		 undoList.delete(index)
end;

Procedure TEditor.doInternalUndo(p:pointer; updateGUI:Boolean);
var
	aNode:PvirtualNode;
  aTree:TVirtualStringTree;

  UndoRec:PundoRec;
  stringRec : PundoString;
  checkedRec : PundoChecked;
  undoGenres : PundoGenres;
  undoRoles : PundoRoles;
  undoComments : PundoComments;
  undoCustomFields: PUndoCustomFields;
  undoTagFields: PUndoTagFields;

  genreRec : PgenreRec;
  commRec : PcommRec;
  roleRec : ProleRec;
  cf: PCustomFieldRec;
  tf: PTagFieldRec;

  s:String;

  i, xpos:integer;
begin
		 if not assigned(p) then exit;
		 undoRec := p;

		 setGrayed(undoRec.Obj, undoRec.gray);

	if undoRec.Obj is TEdit then
  begin //  TEdit
  	stringRec := undoRec.p;
    try
    	if updateGUI then
    		xpos := TEdit(undoRec.Obj).selStart;
      TEdit(undoRec.Obj).text := stringRec.s;
      if updateGUI then
	      TEdit(undoRec.Obj).selStart := xpos
    Except
    end
    end else
    if undoRec.Obj is TJvComboBox then
    begin          //  TJvComboBox
    	if undoRec.UndoType = UTstring then
      begin
      	stringRec := undoRec.p;
        s := stringRec.s
      end else
      if undoRec.UndoType = UTinteger then
      begin
      	i := PundoInteger(undoRec.p).i;
        s := TJvComboBox(undoRec.Obj).items[i]
      end;
      try
      	if updateGUI then
	      	xpos := TJvComboBox(undoRec.Obj).selStart;
        TJvComboBox(undoRec.Obj).text := s;
        if updateGUI then
					TJvComboBox(undoRec.Obj).selStart := xpos;
      except
      end
    end else
    if undoRec.Obj is TcheckBox then
    begin //  TcheckBox
    	checkedRec := undoRec.p;
      TcheckBox(undoRec.Obj).state := checkedRec.b
    end else
    if undoRec.Obj = Genre then
    begin
    	undoGenres := undoRec.p;
      genre.beginupdate;
      genre.rootNodeCount := length(undoGenres.arr);
      aNode := genre.GetFirst;
      while aNode <> nil do
      begin
	      genreRec := genre.getNodeData(aNode);
	      genreRec.Text := undoGenres.arr[aNode.index];
	      aNode := genre.GetNext(aNode)
      end;
      genre.endupdate;
      genreCover.state := undoGenres.cover;
      genreRemix.state := undoGenres.remix
     end else
     if undoRec.Obj = TCON then
     begin
        undoGenres := undoRec.p;
        TCON.beginupdate;
        TCON.rootNodeCount := length(undoGenres.arr);
        aNode := TCON.GetFirst;
        while aNode <> nil do
        begin
	        genreRec := TCON.getNodeData(aNode);
	        genreRec.Text := undoGenres.arr[aNode.index];
	        aNode := TCON.GetNext(aNode)
        end;
        TCON.endupdate;
        V2Cover.state := undoGenres.cover;
        V2Remix.state := undoGenres.remix
     end else
     if undorec.Obj = CommTree then
    begin
      undoComments := undoRec.p;
      CommTree.beginupdate;
      CommTree.rootNodeCount := length(undoComments.arr);
      aNode := CommTree.GetFirst;
      while aNode <> nil do
      begin
        commRec := CommTree.getNodeData(aNode);
        commRec.empty := false;
        commRec.Description := PcommRec(undoComments.arr[aNode.index]).Description;
        commRec.Value := PcommRec(undoComments.arr[aNode.index]).Value;
        commRec.Language := PcommRec(undoComments.arr[aNode.index]).Language;
        commRec.Gray := PcommRec(undoComments.arr[aNode.index]).Gray;
        aNode := CommTree.GetNext(aNode)
      end;
      CommTree.EndUpdate
    end else
		if (undorec.Obj = TIPL) or (undorec.Obj = TMCL) then
		begin
      undoRoles := undoRec.p;
      aTree := TVirtualStringTree(undoRec.Obj);
      aTree.beginupdate;
      aTree.rootNodeCount := length(undoRoles.arr);
      aNode := aTree.GetFirst;
      while aNode <> nil do
      begin
       	roleRec := aTree.getNodeData(aNode);
       	roleRec.empty := false;
       	roleRec.name := ProleRec(undoRoles.arr[aNode.index]).name;
       	roleRec.role := ProleRec(undoRoles.arr[aNode.index]).role;
       	aNode := aTree.GetNext(aNode)
      end;
      aTree.EndUpdate
    end
		else
    if undoRec.Obj = CustomFieldTree then
    begin
			undoCustomFields := undoRec.p;

    	CustomFieldTree.Beginupdate;
      aNode := CustomFieldTree.GetFirst;
      for i:=0 to CustomFieldTree.RootNodeCount - 1 do
      begin
        cf := CustomFieldTree.GetNodeData(aNode);
        cf.gray := undoCustomFields.arr[i].gray;
        cf.value := undoCustomFields.arr[i].value;
        aNode := CustomFieldTree.GetNext(aNode)
      end;
      CustomFieldTree.EndUpdate
    end
    else
    if IsOtherFieldsTree(undoRec.Obj) then
    begin
    	undoTagFields := undoRec.p;
      aTree := TVirtualStringTree(undoRec.Obj);
      aTree.beginupdate;
      aTree.rootNodeCount := length(undoTagFields.arr);
      aNode := aTree.GetFirst;
      while aNode <> nil do
      begin
       	tf := aTree.getNodeData(aNode);
       	tf.fieldName := undoTagFields.arr[aNode.index].fieldName;
       	tf.value := undoTagFields.arr[aNode.index].value;
        tf.gray := undoTagFields.arr[aNode.index].gray;
        tf.description := undoTagFields.arr[aNode.index].description;

       	aNode := aTree.GetNext(aNode)
      end;
      aTree.EndUpdate
    end
end;

Procedure TEditor.doUndo(sender: TObject);
var       UndoRec:PundoRec;
          i:integer;
          found:boolean;
begin
{    Bruges hver gang der laves Undo på et object.
     Sender SKAL være det object der skal laves undo på.
     Den nyeste Undo skal slettes, og der den næstnyeste skal indlæses
}
  if not (Sender is TControl) then exit;
  found := false;

  for i:=undoList.count-1 downto 0 do
  begin
    undoRec := undoList.items[i];
    if undoRec.Obj = sender then
    begin
      if found then
      begin
        doInternalUndo(undoRec, true);
        break
      end else
      if not undoRec.OrigState then
      begin
        deleteUndo(i);
        found := true
      end
    end
  end;

  if syncTabs.checked and (TControl(sender).tag = tagDB) then
  begin
      if sender is TEdit then TEdit(sender).modified := true;
      FieldChanged(sender, true)
  end;
  UpdateChangedCaption
end;

Procedure TEditor.AddToStat(Thread:TBMDExecuteThread; SR:PstatRec; S:String; focus:boolean=true);
begin
  if length(SR.status)=0 then SR.Status := S else SR.Status := SR.Status + #13 + s;
  if focus then
  	Thread.Synchronize(StatFocusNode, SR)
end;

Function TEditor.GetSyncCheck(Obj: TObject; includeGenreCB:boolean=false):Boolean;
begin //retunerer true hvis Obj er et af de comp der kan synces
		 result :=
						 (Obj = track) or (Obj = Totaltracks) or (Obj = title) or (Obj = artist) or (Obj = album) or
						 (Obj = year) or (Obj = genre) or (Obj = comment) or
             (Obj = PartOfSet) or (Obj = TotalParts) or (Obj = ArtistSortOrder) or

						 (Obj = Id3v1Track) or (Obj = Id3v1Artist) or (Obj = Id3v1Title) or
						 (Obj = Id3v1Album) or (Obj = Id3v1Year) or (Obj = Id3v1Genre) or
						 (Obj = Id3v1Comment) or

						 (Obj = ApeTrack) or (Obj = ApeTotalTracks) or (Obj = ApeArtist) or (Obj = ApeTitle) or
						 (Obj = ApeAlbum) or (Obj = ApeYear) or (Obj = ApeGenre) or
						 (Obj = ApeComment) or (Obj = ApePartOfSet) or (Obj = ApeTotalParts) or (Obj = ApeArtistSortOrder) or

						 (Obj = WMATrack) or (Obj = WMAArtist) or (Obj = WMATitle) or
						 (Obj = WMAAlbum) or (Obj = WMAYear) or (Obj = WMAGenre) or
						 (Obj = WMAComment) or (Obj = WMAPartOfSet) or (Obj = WMATotalParts) or (Obj = WMAArtistSortOrder) or

						 (Obj = OggTrack) or (Obj = OggTotalTracks) or (Obj = OggArtist) or (Obj = OggTitle) or
						 (Obj = OggAlbum) or (Obj = OggYear) or (Obj = OggGenre) or
						 (Obj = OggComment) or (Obj = OggPartOfSet) or (Obj = OggArtistSortOrder) or

						 (Obj = TRCK) or (Obj = TRCKtotal)  or (Obj = TPE1) or
						 (Obj = TIT2) or (Obj = TALB) or (Obj = TYER) or
						 (Obj = TCON) or (Obj = CommTree) or (Obj = TPOS) or (Obj = TPOStotal) or (Obj = TSOP) or
             (Obj = Id3v2OtherFields)
             ;

		 result := result or (includeGenreCB and ((Obj = genreRemix) or (Obj = genreCover) or (Obj = V2remix) or (Obj = V2cover)))
end;

function TEditor.GetDbControlNamesFromId3v2Name(control: TControl):TStringArray;
var
	i: Integer;
begin
	SetLength(result, 0);
	for i:=1 to high(Id3v2ControlNames) do
		if Q_SameText(Id3v2ControlNames[i][1], control.Name) then
    begin
    	SetLength(result, Length(result)+1);
			result[Length(result)-1] := Id3v2ControlNames[i][2]
    end
end;

function TEditor.GetId3v2ControlNamesFromDatabaseName(control: String):TStringArray;
var
	i: Integer;
begin
	SetLength(result, 0);
	for i:=1 to high(Id3v2ControlNames) do
		if Q_SameText(Id3v2ControlNames[i][2], control) then
    begin
    	SetLength(result, Length(result)+1);
			result[Length(result)-1] := Id3v2ControlNames[i][1]
    end
end;

Function TEditor.GetSourceComponents(target:TComponent):TComponentArray;
var
  sourceName, targetName: TStringArray;
  i: integer;
begin
	SetLength(result, 0);

	if CopyTagSettings[target.tag] = target.tag then
  begin
  	SetLength(result, 1);
		result[0] := target
  end
	else
	begin
		if target.Tag = tagId3v2 then
			targetName := GetDbControlNamesFromId3v2Name(TControl(target))
		else
    begin
    	SetLength(targetName, 1);
    	targetName[0] := target.Name
    end;

		if not (target.Tag in [tagDB, tagId3v2]) then
    	for i:=0 to length(targetName)-1 do       //TODO: needs testing
				Q_CutLeft(targetName[i], length(TagNames[target.tag]));

		if CopyTagSettings[target.Tag] = tagId3v2 then
			SourceName := GetId3v2ControlNamesFromDatabaseName(targetName[0])
		else
    begin
    	SetLength(SourceName, Length(targetName));
      for i:=0 to Length(targetName)-1 do
	    	SourceName[i] := TagNames[CopyTagSettings[target.Tag]] + targetName[i];
    end;

    SetLength(result, Length(SourceName));
    for i:=0 to Length(SourceName)-1 do
			result[i] := self.FindComponent(SourceName[i])
	end
end;

Function TEditor.CustomFieldChanged(cfr:PCustomFieldRec; SR:PstatRec): Boolean;
var
	i: Integer;
  UR1, UR2: PUndoRec;
  ucf1, ucf2: PUndoCustomFields;
begin
  result := false;
  UR2 := SR.values[GetSRvalueIndex(CustomFieldTree, SR)];
	for i:=undolist.count-1 downto 0 do
  begin
  	UR1 := undoList.items[i];
    if (UR1.Obj = CustomFieldTree) and not UR1.OrigState then
    begin
    	ucf1 := UR1.p;
      ucf2 := UR2.p;
      result := not cfr.gray and not Q_SameStr(ucf1.arr[cfr.FieldIndex].value, ucf2.arr[cfr.FieldIndex].value);
      break
    end
  end
end;

Function TEditor.HasChanged(Sender: TObject; SR:PstatRec):Boolean;
function noGroupsChecked:boolean;
var      aNode : PvirtualNode;
begin
     result := true;
     aNode := GroupCheck.GetFirst;
     while aNode <> nil do
     begin
          result := result and (GroupCheck.CheckState[aNode] = csUncheckedNormal);
					aNode := GroupCheck.GetNext(aNode)
     end
end;
function SpecialChanged(comp:TComponent; SR:PstatRec):boolean;
var
	source : TComponentArray;
  sourceUR, targetUR, originalSourceUR, originalTargetUR : PundoRec;
  i, j : integer;
begin
	result := false;
  //finder original undoRec:
  for i:=0 to length(SR.values)-1 do
  	if PundoRec(SR.values[i]).Obj = comp then originalTargetUR := SR.values[i];

  //finder sourceRec
  source := GetSourceComponents(comp);

  for j:=0 to Length(source)-1 do
  begin
  	for i:=0 to length(SR.values)-1 do
    	if PundoRec(SR.values[i]).Obj = source[j] then originalSourceUR := SR.values[i];

    sourceUR := doCreateUndo(source[j], false, GetGrayed(source[j]));
    targetUR := doCreateUndo(comp, false, GetGrayed(comp));
    result := result or not EqualUndoRecContents(sourceUR, originalSourceUR, targetUR, originalTargetUR);
    doDeleteUndo(sourceUR);
    doDeleteUndo(targetUR);

{	  if getGrayed(source[j]) or (source[j] = CommTree) then // der skal hentes fra en statRec
	  begin
	    for i:=0 to length(SR.values)-1 do
	    	if PundoRec(SR.values[i]).Obj = source[j] then sourceUR := SR.values[i];
	    result := result or not EqualUndoRecContents(sourceUR, targetUR)
	  end
	  else
	  begin
		  sourceUR := doCreateUndo(source[j], targetUR.origState, targetUR.gray);
		  result := result or not EqualUndoRecContents(sourceUR, targetUR);
		  doDeleteUndo(sourceUR)
	  end }
  end
end;

var
	i:integer;
	UR:pUndoRec;
	b: Boolean;
begin
	// Check if there are any changes that needs saving
  if (CopyTagSettings[TComponent(sender).tag] <> TComponent(sender).tag) and
  ((TComponent(sender).tag = tagDB) or ((TComponent(sender).tag in [tagId3v1..tagMAX]) and ((HasTagCheckboxes[TComponent(sender).tag].State = cbChecked) or ((HasTagCheckboxes[TComponent(sender).tag].State <> cbUnChecked) and GetHasTag(TComponent(sender).tag, SR))))) and
  GetSyncCheck(sender) then
  	result := SpecialChanged(TComponent(sender), SR)
  else
  begin
    result := false;
    for i:=undolist.count-1 downto 0 do
    begin
         UR := undoList.items[i];
         if (UR.Obj = sender) and not UR.OrigState then
         begin
          result := not UR.gray and not EqualUndoRecs(UR, SR.values[GetSRvalueIndex(sender, SR)], Sender = GroupCheck);  //hvis den er grå skal den stadig være uændret
          //saveGroups -start
          if result and (sender = saveGroups) then
          begin
            if ((saveGroups.State = cbUnChecked) and (length(Prec(SR.ref).groups)=0) and not (rfCompilation in Prec(SR.ref).Flags)) then
              result := false
          end;
          //saveGroups -stop
          break
         end
    end;
    if sender = saveGroups then
    begin
      b := false;
      for i:=tagId3v2 to tagMAX do
        b := b or (HasTagCheckboxes[i].State = cbChecked) or ((HasTagCheckboxes[i].State <> cbUnChecked) and GetHasTag(i, SR));
      result :={ result or }((saveGroups.State <> cbUnchecked) and b and (HasChanged(CBcompilation, SR) or HasChanged(GroupCheck, SR)))
    end
  end;
  if not result and ((sender = TYER) or (sender = TCON) or (sender = TIPL)) then
	  result := ((CBhasid3V2tag.state = cbChecked) or SR.HasV2) and (
      ((not (SR.Id3V2ver in [ive2_2, ive2_3])) and id3v23.checked) or ((SR.Id3V2ver <> ive2_4) and id3v24.checked))
end;

procedure TEditor.ArtistChange(Sender: TObject);
begin
	FieldChanged(sender)
end;

Procedure TEditor.FieldChanged(Sender: TObject; skipGrayOut:boolean=false);
procedure SyncCopy(Source: TControl; undoCreated: Boolean);    //kopierer værdi fra database til de tag-værdier der måtte være muligt at skrive til
var
	CB: TCheckBox;
	tagIdx, j, i: Integer;
	targetName: TStringArray;
  s: String;
	target: TComponentArray;
  targetcomp: TComponent;
	ur: PUndoRec;
  aNode, bNode, cmNode: PVirtualNode;
  cfRec: PCustomFieldRec;
  trRec: PTagFieldRec;
  cmr: PCommRec;
  cf: PCustomField;
  found: boolean;
  aTree: TVirtualStringTree;
  tagFieldName: String;
begin
  for tagIdx:=tagId3v1 to high(TagNames) do
  begin
    CB := TCheckBox(FindComponent('CBHas' + TagNames[tagIdx] + 'Tag'));
    if CB.enabled and (CB.State <> cbUnchecked) then
    begin
      if tagIdx = tagId3v2 then
        TargetName := GetId3v2ControlNamesFromDatabaseName(Source.Name)
      else
      begin
      	SetLength(TargetName, 1);
      	TargetName[0] := TagNames[tagIdx] + Source.Name
      end;

      SetLength(Target, Length(TargetName));
      for i:=0 to Length(Target)-1 do
	      Target[i] := TControl(FindComponent(TargetName[i]));

    	for i:=0 to Length(Target)-1 do
			begin
      	if (Target[i] = CommTree) and (Source = Comment) then
          SetBoxValue(CommTree, Comment, undoCreated, true, true)
        else
        if (Target[i] = TCON) and (Source = Genre) then
        begin
          copyGenres(Genre, TCON);
          setGrayed(TCON, getGrayed(Genre));
          createUndo(TCON)
        end
        else
        if (Source = CustomFieldTree) then
        begin
          aNode := CustomFieldTree.GetFirstSelected;
          while aNode <> nil do
          begin
            cfRec := CustomFieldTree.GetNodeData(aNode);
            cf := PCustomField(FieldList.Items[cfRec.FieldIndex]);

            case tagIdx of
              tagApe:
                begin
                  aTree := ApeOtherfields;
                  tagFieldName := cf.apeFieldName
                end;
              tagOgg:
                begin
                  aTree := OggOtherfields;
                  tagFieldName := cf.oggFieldName
                end;
              tagWma:
                begin
                  aTree := WmaOtherfields;
                  tagFieldName := cf.wmaFieldName
                end;
              tagId3v2:
                begin
                  aTree := Id3v2Otherfields;
                  tagFieldName := cf.id3v2FieldName;

                  if not cfRec.gray and (length(tagFieldName) > 0) then
                  begin
                    if Q_SameText(tagFieldName, 'COMM') then
                    begin
                      //Search for a comment that matches the custom-field
                      found := false;		//Indicates exact match (also on language)
                      bNode := nil;			//Set this one if we have a circa match (diff. language but id3v2ReadAllLanguages is true)
                      cmNode := CommTree.GetFirst;
                      while cmNode <> nil do
                      begin
                        cmr := CommTree.GetNodeData(cmNode);
                        if not cmr.Empty and Q_SameText(cf.id3v2Description, cmr.Description) then
                        begin
                          if ((cmr.Language = -1) and Q_SameText(cf.id3v2DefaultLanguage, UnknownLanguageCode))
                          or ((cmr.Language >= 0) and Q_SameText(LanguageCodes[cmr.Language], cf.id3v2DefaultLanguage)) then
                          begin
                            found := true;
                            break	// break while
                          end
                          else
                          begin
                            //Language doesn't match
                            if cf.id3v2ReadAllLanguages then
                              bNode := cmNode
                          end
                        end;
                        cmNode := CommTree.GetNext(cmNode)
                      end;

                      if not found and assigned(bNode) then
                      begin
                        //inexact match found. Delete this one so that a new one is created.
                        CommTree.DeleteNode(bNode)
                      end;

                      if not found then
                      begin
                        //Create new
                        cmNode := CommTree.AddChild(nil);
                        CommTree.ReinitNode(cmNode, false);
                        cmr := CommTree.GetNodeData(cmNode)
                      end;

                      //Set values
                      cmr.Gray := false;
                      cmr.Description := cf.id3v2Description;
                      cmr.Value := cfRec.value;
                      cmr.Language := IndexOfLanguageCode(cf.id3v2DefaultLanguage);
                      cmr.Empty := false;

                      CreateUndo(CommTree);
                      tagFieldName := ''
                    end
                    else
                    begin
                      targetComp := self.FindComponent(tagFieldName);
                      if assigned(targetComp) and (targetComp.Tag = tagId3v2) and (targetComp is TControl) then
                      begin
                        SetBoxValue(targetComp, cfRec.value, true, true, false);
                        tagFieldName := ''
                      end
                    end
                  end
                end	//of tagId3v2
              else
                tagFieldName := ''
            end;

            if not cfRec.gray and (length(tagFieldName) > 0) then
            begin
              found := false;
              bNode := aTree.GetFirst;
              while bNode <> nil do
              begin
                trRec := aTree.GetNodeData(bNode);
                if Q_SameText(trRec.fieldName, tagFieldName) and ((tagIdx <> tagId3v2) or Q_SameText(trRec.description, cf.id3v2Description)) then
                begin
                  found := true;
                  if trRec.gray or not Q_SameStr(trRec.value, cfRec.value) then
                  begin
                    trRec.value := cfRec.value;
                    trRec.gray := false;
                    FieldChanged(aTree)
                  end
                end;
                bNode := aTree.GetNext(bNode)
              end;
              if not found then
              begin
                bNode := aTree.AddChild(nil);
                trRec := aTree.GetNodeData(bNode);
                trRec.gray := false;
                trRec.fieldName := tagFieldName;
                trRec.value := cfRec.value;
                if (tagIdx = tagId3v2) and Q_SameText(cf.id3v2FieldName, 'TXXX') then
                  trRec.description := cf.id3v2Description
                else
                  trRec.description := '';

                FieldChanged(aTree)
              end
            end;
            aNode := CustomFieldTree.GetNextSelected(aNode)
          end
        end
        else
        begin
          if Source = genre then
          begin
            ur := doCreateUndo(Source, false, false);
            s := getV1GenreFromUndoGenres(ur, tagIdx=tagId3v1);
            doDeleteUndo(ur);
            SetBoxValue(Target[i], s, true, true, getGrayed(Source))
          end
          else
            SetBoxValue(Target[i], cleanString(getBoxValue(Source)), true, true, getGrayed(Source))
        end
      end
    end
  end
end;
var
	modified: Boolean;
	undoCreated: Boolean;
begin
	if (sender = genreCover) or (sender = genreRemix) then
		FieldChanged(genre)
	else
	if (sender = V2Cover) or (sender = V2Remix) then
		FieldChanged(TCON)
	else
	begin
		modified := ((Sender is TEdit) and TEdit(sender).modified) or not (sender is Tedit);
		if modified then
		begin
			if not skipGrayOut then
				setGrayed(sender, false);
			undoCreated := createUndo(sender);
			ShowUndo(sender);

			if SyncTabs.Checked and (TControl(Sender).Tag = tagDB) then
				SyncCopy(TControl(Sender), undoCreated);

			UpdateChangedCaption
		end
	end
end;

function TEditor.DiffersFromOrigState(index:integer):boolean;
var      i:integer;
begin
		 result := false;
		 for i:=0 to undoList.count-1 do
		 begin
					if (PundoRec(undoList.items[i]).Obj = PundoRec(undoList.items[index]).Obj) and (PundoRec(undoList.items[i]).origState) then
					begin
							 result := not EqualUndoRecs(undoList.items[i], undoList.items[index]);
							 break
					end
		 end
end;

function TEditor.GetHasTag(TagType: Integer; pSR:pointer):Boolean;
begin
	case TagType of
		tagId3v1:	result := PStatRec(pSR).HasV1;
		tagId3v2:	result := PStatRec(pSR).HasV2;
		tagApe: 	result := PStatRec(pSR).HasApe;
		tagWMA: 	result := PStatRec(pSR).HasWMA;
		tagOgg: 	result := PStatRec(pSR).HasOgg;
	else result := false
	end
end;

function TEditor.getHasTagVerChanged(TagType: integer; pSR:pointer):boolean;
var     list:TComponentList;
				i:integer;
				SR:PstatRec;
begin
	result := false;
	SR := pSR;
	if GetTagSupported(TagType, SR) and HasTagCheckboxes[TagType].Enabled then
		if (GetHasTag(TagType, SR) and (HasTagCheckboxes[TagType].State = cbUnchecked)) or (not GetHasTag(TagType, SR) and (HasTagCheckboxes[TagType].State = cbchecked)) then
			result := true
		else
			if not (not GetHasTag(TagType, SR) and (HasTagCheckboxes[TagType].State = cbGrayed)) then
			begin
				case TagType of
					TagId3v1: list := v1Components;
					TagId3v2: list := v2Components;
					TagApe: list := ApeComponents;
					TagWMA: list := WMAcomponents;
					TagOgg: list := OggComponents;
				end;

        for i:=0 to list.Count-1 do
				begin
//        	if list.items[i] = Id3v2otherfields then
//          beep;
					result := HasChanged(list.items[i], SR);
					if result then break
				end;

				if (TagType = TagId3v2) and (SR.hasV2 or (CBhasId3v2tag.state = cbChecked)) and not result then
					result := result or (not (SR.Id3V2ver in [ive2_2, ive2_3]) and id3v23.checked) or ((SR.Id3V2ver <> ive2_4) and id3v24.checked); // different tag version selected

        //Lyrics:
				result := result or ((TagType = TagId3v2) and lyricsChanged(SR, true));
				result := result or ((TagType in [tagApe..tagMAX]) and lyricsChanged(SR));
				//Groups
				result := result or ((TagType in [tagId3v2..tagMAX]) and HasChanged(saveGroups, SR));
		end
end;

procedure TEditor.UpdateChangedCaption;
var
          aNode : PvirtualNode;
          SR : PstatRec;
begin
	aNode := stat.GetFirst;
	while aNode <> nil do
	begin
		SR := stat.GetNodeData(aNode);
		SR.V1Changed := getHasTagVerChanged(TagId3v1, SR);
		SR.V2Changed := getHasTagVerChanged(TagId3v2, SR);
		SR.ApeChanged := getHasTagVerChanged(TagApe, SR);
		SR.WMAChanged := getHasTagVerChanged(TagWMA, SR);
		SR.OggChanged := getHasTagVerChanged(TagOgg, SR);
		aNode := stat.GetNext(aNode)
	end;
	stat.repaint
end;

procedure TEditor.copyGenres(source:String; target:TVirtualStringTree);
begin
     target.Clear;
		 AddGenreToTree(target, source)
end;

procedure TEditor.copyGenres(source:TVirtualStringTree; target:TVirtualStringTree);
var       aNode : PVirtualNode;
					s:String;
					limit, selfDefPresent : boolean;
begin
		 limit := (target = TCON) and (Id3v23.checked);
		 selfDefPresent := false;
		 target.RootNodeCount := 0;
		 aNode := source.getFirst;
		 while aNode <> nil do
		 begin
					s := trim(PgenreRec(source.getNodeData(aNode)).text);
					if s <> '' then
					begin
							 if limit then
							 begin
										if selfDefPresent then
										begin
												 if IsV1Genre(s) then AddGenreToTree(target, s)
										end else
										begin
												 AddGenreToTree(target, s);
												 selfDefPresent := not IsV1Genre(s)
										end
               end
               else AddGenreToTree(target, s)
          end;
          aNode := source.getNext(aNode)
     end;
     if (source = TCON) and (target = genre) then
     begin
          genreRemix.Checked := v2Remix.checked;
          genreCover.Checked := v2Cover.checked
     end else
     if (source = genre) and (target = TCON) then
     begin
          v2Remix.Checked := genreRemix.checked;
          v2Cover.Checked := genreCover.checked
     end
end;

Function TEditor.getV1GenreFromUndoGenres(pUR:pointer; Id3v1Compatible: Boolean):String;
var      undoGenres:PundoGenres;
         i:integer;
begin
	result := '';
	undoGenres := PundoRec(pUR).p;
	for i:=0 to length(undoGenres.arr)-1 do
	if (length(undoGenres.arr[i])>0) and (not Id3v1Compatible or IsV1Genre(undoGenres.arr[i])) then
	begin
		result := undoGenres.arr[i];
		break
	end
end;

{Function TEditor.getV1GenreFromTree(aTree: TBaseVirtualTree):String;
var      aNode:pVirtualNode;
         s:String;
begin
     result := '';
     aNode := aTree.getfirst;
     while (aNode <> nil) and (result = '') do
     begin
          s := trim(PgenreRec(aTree.getNodeData(aNode)).text);
          if (s <> '') and IsV1Genre(s) then result := s;
          aNode := aTree.getNext(aNode)
		 end
end;       }

Procedure TEditor.setV1Genre(s:String);
var    i:integer;
begin
	Q_trimInPlace(s);
	Id3v1Genre.itemIndex := -1;
	if s <> '' then
		for i:=0 to Id3v1Genre.Items.Count-1 do
			if Q_SameText(Id3v1Genre.items.strings[i], s) then Id3v1Genre.ItemIndex := i
end;

Procedure TEditor.SetBoxValue(Obj: TObject; Value:String; createNewUndo:Boolean; copyGraySettings:boolean=false; graySetting:boolean=false);
var       aNode:PVirtualNode;
					r:PcommRec;
					found:boolean;
begin
  if Obj = Id3v1Genre then setV1Genre(value) else
  if Obj is TEdit then TEdit(Obj).text := Value else
  if Obj is TJvComboBox then TJvComboBox(Obj).text := Value else
  if Obj = CommTree then
  begin
    if CommTree.RootNodeCount = 0 then
    	AddCommentToTree(-1, '', value)
    else
    begin
      found:=false;
      aNode := CommTree.getFirst;
      while (aNode <> nil) and not found do
      begin
        r := CommTree.getNodeData(aNode);
        if (length(r.Description) = 0) and Q_SameStr(value, r.value) and not r.Empty then
        begin
          found := true;
          r.value := value;
          r.Gray := false;
        end;
        aNode := CommTree.getNext(aNode)
      end;
      if not found then AddCommentToTree(-1, '', value)
    end
  end;

  if copyGraySettings then setGrayed(Obj, graySetting);

  if createNewUndo then
  begin
	  createUndo(Obj);
	  showUndo(Obj)
  end
end;

Procedure TEditor.SetBoxValue(Obj: TObject; Value:Tobject; undoCreated: Boolean; createNewUndo:Boolean; copyGraySettings:boolean=false);
function getLastCommentValue(sender:TObject):string;
var      i:integer;
         undoRec:PundoRec;
         found:boolean;
         s: String;
begin
  result := '';
  found := false;
  s := TEdit(value).text;
  for i:=undoList.count-1 downto 0 do
  begin
    undoRec := undoList.Items[i];
    if (undoRec.Obj = sender) then //and not undoRec.OrigState then
      if found or not undoCreated then
      begin
      	result := pUndoString(undoRec.p).s;
        break
      end
      else
      begin
        found := true;
        result := pUndoString(undoRec.p).s
      end;
  end
end;
var       aNode:PVirtualNode;
          cr:PcommRec;
          found:boolean;
          s:string;
begin
  if (Obj = CommTree) and ((Value = comment) or (Value = Id3v1Comment)) and (length(trim(TEdit(Value).text))>0) then
  begin
    if CommTree.RootNodeCount = 0 then
	    AddCommentToTree(-1, '', TEdit(Value).text)
    else
    begin
	    found:=false;
	    s := getLastCommentValue(value);
	    aNode := CommTree.getFirst;
	    while (aNode <> nil) and not found do
	    begin
		    cr := CommTree.getNodeData(aNode);
        //Search for default comment (where description is not set. This is nescecarry so the comment is not written in any custom field!)
		    if (length(cr.Description) = 0) and (Q_SameStr(trim(s), trim(cr.value)) or Q_SameStr(trim(TEdit(value).text), trim(cr.value))) and not cr.Empty then
		    begin
		      found := true;
		      cr.value := cleanString(TEdit(value).text);
          cr.Gray := false;
		    end;
		    aNode := CommTree.getNext(aNode)
	    end;
	    if not found then
		    AddCommentToTree(-1, '', cleanString(TEdit(value).text))
    end
  end;

  if copyGraySettings then
  	setGrayed(Obj, getGrayed(value));

  if createNewUndo then
  begin
	  createUndo(Obj);
	  showUndo(Obj)
  end
end;

Function TEditor.getBoxValue(Obj: TObject):String;
begin
	if Obj is TEdit then result := TEdit(Obj).text;
  if Obj is TJvComboBox then result := TJvComboBox(Obj).text
end;

Procedure TEditor.CreateUndoIcons;
var
	i : Integer;
  Cont : TControl;
begin
  for i:=0 to Editor.ComponentCount-1 do if (Editor.Components[i] is TControl) then if (Editor.Components[i] as TControl).tag in [10..15] then
  begin
     Cont := Editor.Components[i] as TControl;
     if (Cont <> GenreCover) and (Cont <> GenreRemix) and (Cont <> V2Cover) and (Cont <> V2Remix) and (Cont <> CBcompilation) and (Cont <> saveGroups) and (Cont <> GroupCheck) then
     begin
      TImage.Create(Cont.Owner).name := Cont.Name + 'Undo';
      With TImage(FindComponent(Cont.Name + 'Undo')) do
      begin
      	Parent := Cont.Parent;
      	AutoSize := false;
      	Visible := false;
      	ShowHint := true;
      	ParentShowHint := false;
      	Transparent := true;
      	if (Cont = TPE1) or (Cont = TIT2) then
        	SetBounds(Cont.BoundsRect.Right+26, Cont.BoundsRect.top+2, 16, 16) else SetBounds(Cont.BoundsRect.Right+4, Cont.BoundsRect.top+2, 16, 16);
      	UndoImages.GetBitmap(0, Picture.Bitmap);
      	OnClick := UndoRefPictClick;
      	createUndo(Cont, true)
      end
  	end else if (Cont = CBcompilation) or (Cont = saveGroups) or (Cont = GroupCheck) then createUndo(Cont, true)
  end
end;

procedure TEditor.UndoRefPictClick(Sender: TObject);
var     s:string;
        Comp : TControl;
begin
        s := copy(TImage(Sender).name, 1, length(TImage(Sender).name) - 4);
				Comp := TControl(findcomponent(s));
        doUndo(Comp);
        Timage(sender).visible := canUndo(Comp)
end;

procedure TEditor.SaveBtnClick(Sender: TObject);
begin
	SaveBtn.Enabled := false;
  screen.Cursor := crAppStart;
  CancelBtn.ModalResult := mrNone;
  CancelBtn.Caption := GetText(TXT_Cancel);
  pBar.Position := 0;
  pBar.Max := stat.RootNodeCount;
	SaveThread.Start
end;

function TEditor.GetV2GenreToSave(p:pointer; version: TJvId3Version):String;
// Return the string to save in TCON
var     value : string;
        i:integer;
        StrLst : TStringlist;
        UR : PundoRec;
        undoGenres : PundoGenres;
begin
        UR := p;
        value := '';
        undoGenres := UR.p;

        StrLst := TStringList.create;
				for i:=0 to length(undoGenres.arr)-1 do
        	strLst.add(trim(undoGenres.arr[i]));

				//Løber listen igennen of finder Id3v1 tagsene
        i:=0;
        while i < StrLst.count do
        begin
						 if IsV1Genre(StrLst.strings[i]) then
             begin
									if (version = ive2_2) or (version = ive2_3) then value := value + '(' + inttostr(getRealV1Genre(StrLst.strings[i])) + ')';
									if version = ive2_4 then value := value + #0 + inttostr(getRealV1Genre(StrLst.strings[i]));
                  StrLst.Delete(i)
             end else inc(i)
        end;

				if undoGenres.cover = cbChecked then
        begin
             if (version = ive2_2) or (version = ive2_3) then value := value + '(CR)';
             if version = ive2_4 then value := value + #0 + 'CR'
				end;
        if undoGenres.remix = cbChecked then
        begin
             if (version = ive2_2) or (version = ive2_3) then value := value + '(RX)';
             if version = ive2_4 then value := value + #0 + 'RX'
        end;

        // add the remaining genres
        for i:=0 to StrLst.count-1 do
        begin
             if (version = ive2_2) or (version = ive2_3) then
						 begin
                  if (length(StrLst.Strings[i])>3) and (StrLst.Strings[i][1]='(') then
                     value := value + '(' + StrLst.Strings[i]
                  else value := value + StrLst.Strings[i];
                       break // only one custom genre allowed in id3v 2/3
                end;
                if version = ive2_4 then value := value + #0 + StrLst.Strings[i]
        end;
        StrLst.free;
        Q_TrimInPlace(value);

        result := value
end;

{function TEditor.GetStringFromSR(pSR:pointer; Comp:TComponent):String;
var     i:integer;
				SR : PstatRec;
        UR : PundoRec;
        StrRec : PundoString;
begin
        result := '';
        SR := pSR;
        for i:=0 to length(SR.values)-1 do
        begin
             UR := SR.values[i];
             if comp = UR.Obj then
             begin
                  StrRec := UR.p;
                  result := StrRec.s;
                  break
             end
        end
end;        }

Procedure TEditor.SaveDBGenre(SR:PstatRec; pR:pointer);
// do as in UpdateStringValueTabSync but only on genre (DB)
var      r:Prec;
         sourceUR:PundoRec;
         UG:PundoGenres;
         source:Tcomponent;
         i:integer;
         clearSourceRec:boolean;
begin
     r := pR;

		 source := GetSourceComponents(genre)[0];

		 if getGrayed(source) then // Get from Statrec
     begin
          clearSourceRec := false;
          for i:=0 to length(SR.values)-1 do
              if PundoRec(SR.values[i]).Obj = source then sourceUR := SR.values[i];
     end
     else   // Get from control
     begin
          clearSourceRec := true;
          sourceUR := doCreateUndo(source, false, false)
     end;

		 if (source = genre) or (source = TCON) then
     begin
          UG := SourceUR.p;
          setLength(r.genre, 0);
          for i:=0 to length(UG.arr)-1 do
              addGenreToRec(r, UG.arr[i]);
          if UG.cover = cbChecked then addGenreToRec(r, 'Cover');
          if UG.remix = cbChecked then addGenreToRec(r, 'Remix')
     end else

		 if (source = Id3v1Genre) or (source = ApeGenre) or (source = WMAGenre) or (source = OggGenre) then
		 begin
					setLength(r.genre, 0);
					if length(PundoString(sourceUR.p).s)>0 then
						 addGenreToRec(r, PundoString(sourceUR.p).s)
		 end;

		 if clearSourceRec then doDeleteUndo(sourceUR)
end;

Function TEditor.UpdateStringValueTabSync (SR:PstatRec; Obj:TControl; var value:string; id3v2Version: TJvId3Version = iveLowerThan2_2 ):boolean;
var
	target: Tcomponent;
  source: TComponentArray;
  sourceUR:PundoRec;
  i, j:integer;
  clearSourceRec:boolean;
begin
	//returns true if the value has changed
	result := false;
	target := Obj;
	if GetSyncCheck(Obj) then
	begin
		source := GetSourceComponents(Target);

    for j:=0 to Length(source)-1 do
    begin
			if getGrayed(source[j]) then //hent fra statrec
			begin
				clearSourceRec := false;
				for i:=0 to length(SR.values)-1 do
					if PundoRec(SR.values[i]).Obj = source[j] then sourceUR := SR.values[i];
			end
			else   // henter fra componentet
			begin
				clearSourceRec := true;
				sourceUR := doCreateUndo(source[j], false, false)
			end;

      if ((target is Tedit) and (source[j] is Tedit)) or ((target is TJvComboBox) and (source[j] is TJvComboBox)) then
      begin
        value := PundoString(sourceUR.p).s;
        result := true
      end
      else
      if (target = TCON) and (source[j] = genre) then
      begin
        Assert (id3v2Version > iveLowerThan2_2, 'Idv2Version not set');
        value := GetV2GenreToSave(sourceUR, id3v2Version);
        result := true
      end
      else
      if (target = TCON) and (source[j] = Id3v1Genre) then
      begin
        Assert (id3v2Version > iveLowerThan2_2, 'Idv2Version not set');
        if length(PundoString(sourceUR).s)>0 then
        begin
          if (id3v2Version = ive2_2) or (id3v2Version = ive2_3) then value := '(' + inttostr(getRealV1Genre(PundoString(sourceUR).s)) + ')';
          if id3v2Version = ive2_4 then value := inttostr(getRealV1Genre(PundoString(sourceUR).s))
        end else
          value := '';
        result := true
      end
      else
      if (target = TCON) and ((source[j] = ApeGenre) or (source[j] = WMAGenre) or (source[j] = OggGenre)) then
      begin
        Assert (id3v2Version > iveLowerThan2_2, 'Idv2Version not set');
        if length(PundoString(sourceUR).s)>0 then
        begin
          value := PundoString(sourceUR).s
        end else
          value := '';
        result := true
      end
      else
      if ((target = Id3v1Genre) or (target = ApeGenre) or (target = WMAGenre) or (target = OggGenre)) and ((source[j] = TCON) or (source[j] = genre)) then
      begin
        value := getV1GenreFromUndoGenres(sourceUR, target = Id3v1Genre);
        result := true
      end
      else
      if ((target = Id3v1Comment) or (target = comment) or (target = Apecomment) or (target = WMAComment) or (target = Oggcomment)) and (source[j] = CommTree) then
      begin
        value := '';
        if length(PundoComments(sourceUR.p).arr)>0 then
          value := PcommRec(PundoComments(sourceUR.p).arr[0]).value;
        result := true
      end
      else
      if (target = CommTree) and ((source[j] = comment) or (source[j] = Id3v1Comment) or (source[j] = comment) or (source[j] = Apecomment) or (source[j] = WMAComment) or (source[j] = Oggcomment)) then
      begin
        if length(PundoString(sourceUR.p).s)>0 then
          value := PundoString(sourceUR.p).s
        else
          value := '';
        result := true
      end;

      if clearSourceRec then
        doDeleteUndo(sourceUR)
    end
  end
{

                      if DBobj = Genre then
                      begin
                           if Obj = TCON then
                           begin
                                value := GetV2GenreToSave(UR2, V2Ver);
                                result := true
                           end else
                           if Obj = Id3v1Genre then
                           begin //UR2 er Genre
                                value := getV1GenreFromUndoGenres(UR2);
                                result := true
                           end
                      end else
                      if DBobj = Comment then
                      begin
                           if Obj = COMM then
                           begin
                                value := #0 + 'XXX' + #0 + PundoString(UR2.p).s;
                                result := true
                           end
                      end
                end else
                begin// bruger værdier fra db
                        if ((Obj Is Tedit) or (Obj Is TJvComboBox)) and ((DBobj Is Tedit) or (DBobj Is TJvComboBox)) then
                        begin
                             if DBobj is TJvComboBox then
                                value := TJvComboBox(DBobj).text
                             else
                                 value := TEdit(DBobj).text;
                             result := true
                        end else
                        if DBobj = Genre then
                        begin
                             if Obj = TCON then
														 begin
                                  UR := doCreateUndo(Genre, false, false);
                                  value := GetV2GenreToSave(UR, V2Ver);
                                  doDeleteUndo(UR);
																	result := true
                             end else
                             if Obj = Id3v1Genre then
                             begin
                                  value := getV1GenreFromTree(TVirtualStringTree(DBobj));
																	result := true
                             end
                        end else
                        if DBobj = Comment then
                        begin
                             if Obj = COMM then
                             begin
                                  Value := #0 + 'XXX' + #0 + comment.text;
                                  result := true
                             end
                        end
                end
          end
     end                  }
end;

Function TEditor.SaveV2Frame(id3v2: TMyId3Controller; FrameName:String; SR:PstatRec; version: TJvId3Version):Integer;

Procedure DelFrame(frameId: TJvId3FrameId);
var
  i: integer;
begin
	// delete existing frame
	i:=0;
	while i < id3v2.Frames.Count do
		if id3v2.Frames[i].FrameID = frameId then
			id3v2.Frames.Remove(id3v2.Frames[i])
		else inc(i)
end;

// Adds a non-empty string to a StringList if the string does not already exists in the list
procedure addToStrL(strL:Tstringlist; s:string);
var       i:integer;
					found:boolean;
begin
  if length(trim(s))>0 then
  begin
    found := false;
    for i:=0 to strL.count-1 do
    	if Q_SameText(trim(strL.strings[i]), trim(s)) then
      begin
      	found := true;
        break
      end;
    if not found then
    	strL.add(s)
  end
end;

var
  frameId: TJvId3FrameId;
  id3Frame: TJvId3Frame;
  cntFrame: TJvID3ContentFrame;
  dblLstFrame: TJvID3DoubleListFrame;
  userTextFrame: TJvID3UserFrame;

	bt : byte;
  i,x,k, j : Integer;
  Comp : TControl;
  Value, s, s1, s2 : String;
//  Mstr : TStream;
  aNode : PVirtualNode;
  CommRec : PcommRec;
  RoleRec : ProleRec;
//  cv: COMM;
//  sDesc, sVal: string;
  UO : PundoRoles;

  UR : PundoRec;
  StrL : TStringList;
  lst: TList;
  R : Prec;
  tfRec: PTagFieldRec;
  bArr1, bArr2: array of boolean;

  clearSourceRec: boolean;
  sourceUR:PundoRec;
  ucf: PundoCustomFields;
//  uc: PUndoComments;
  cf: PCustomField;
begin
  result := 0;
  if FrameName = 'USLT' then
   Comp := LyricsMemo
  else
    Comp := TControl(Editor.FindComponent(FrameName));

  frameId := ID3_StringToFrameID(frameName);

  if (Comp = TBPM) or (Comp = TIT2) or (Comp = TIT3) or (Comp = TIT1) or (Comp = TPE4) or (Comp = TPE3) or (Comp = TPE2) or (Comp = TPE1) or (Comp = TOPE) or (Comp = TCOM) or (Comp = TALB) or (Comp = TCOP) or (Comp = TOWN) or (Comp = TPUB) or (Comp = TENC) or (Comp = TEXT) then
  begin   //of Standard Frames
    if Comp is TEdit then Value := trim(TEdit(Comp).Text) else
    if Comp is TJvComboBox then Value := trim(TJvComboBox(Comp).Text);

    UpdateStringValueTabSync(SR, Comp, value, version);

    // remove old frame
    DelFrame(frameId);
    if length(Value) > 0 then
    begin
      TJvID3CustomTextFrame(id3v2.AddFrame(frameId)).Text := value;
    end
  end //eo Standard Frames
  else
  if Comp = TSOP then
  begin
    // performer sort order

    // Clearing old data:
    DelFrame(frameId);

    Value := trim(TSOP.Text);
    UpdateStringValueTabSync(SR, Comp, value, version);

    if length(Value) > 0 then
    begin
      // check if TSOP is equal to TPE1 - if so there's no need to store TSOP
      if not (id3v2.FindFirstFrame(fiLeadArtist, id3Frame) and Q_SameStr(theFix(value), theFix(TJvId3CustomTextFrame(id3Frame).Text))) then
      begin
        TJvID3CustomTextFrame(id3v2.AddFrame(frameId)).Text := value;
      end
    end
  end
  else
  //TRACK
  if (Comp = TRCK) then
  begin
    if id3v2.FindFirstFrame(fiTrackNum, id3Frame) then
      s := TJvId3CustomTextFrame(id3Frame).Text
    else
      s := '';

    Q_TrimInPlace(s);

    DelFrame(fiTrackNum);

    Value := trim(TRCK.text);
    UpdateStringValueTabSync(SR, Comp, value, version);

    if Q_IsInteger(Value) then
      value := MainFormInstance.GetTrackString(StrToInt(value), MainFormInstance.GetTotalTracksInt(s))
    else
      value := MainFormInstance.GetTrackString(0, MainFormInstance.GetTotalTracksInt(s));

    if length(Value) > 0 then
    begin
     TJvID3CustomTextFrame(id3v2.AddFrame(frameId)).Text := value;
    end
  end
  else     //Total Tracks
  if (Comp = TRCKtotal) then
  begin
    if id3v2.FindFirstFrame(fiTrackNum, id3Frame) then
      s := TJvId3CustomTextFrame(id3Frame).Text
    else
      s := '';

    DelFrame(fiTrackNum);

    Value := trim(TRCKtotal.text);
    UpdateStringValueTabSync(SR, Comp, value, version);

    if Q_IsInteger(Value) then
      value := MainFormInstance.GetTrackString(MainFormInstance.GetTrackNoInt(s), StrToInt(value))
    else
      value := MainFormInstance.GetTrackString(MainFormInstance.GetTrackNoInt(s), 0);

    if length(Value) > 0 then
    begin
      TJvID3CustomTextFrame(id3v2.AddFrame(fiTrackNum)).Text := value;
    end
  end
  else
  if (Comp = TPOS) then     //Part of set
  begin
    if id3v2.FindFirstFrame(fiPartInSet, id3Frame) then
      s := TJvId3CustomTextFrame(id3Frame).Text
    else
      s := '';

    Q_TrimInPlace(s);

    DelFrame(fiPartInSet);

    Value := trim(TPOS.text);
    UpdateStringValueTabSync(SR, Comp, value, version);

    bt := 0;
    MainFormInstance.SetPartOfSetFromString(bt, s);

    if Q_IsInteger(Value) then
      value := MainFormInstance.GetPartsString(StrToInt(value), MainFormInstance.GetTotalParts(bt))
    else
      value := MainFormInstance.GetPartsString(0, MainFormInstance.GetTotalParts(bt));

    if length(Value) > 0 then
    begin
      TJvID3CustomTextFrame(id3v2.AddFrame(fiPartInSet)).Text := value;
    end
  end
  else
  if (Comp = TPOStotal) then     //Total parts of set
  begin
    if id3v2.FindFirstFrame(fiPartInSet, id3Frame) then
      s := TJvId3CustomTextFrame(id3Frame).Text
    else
      s := '';

    Q_TrimInPlace(s);

    DelFrame(fiPartInSet);

    Value := trim(TPOStotal.text);
    UpdateStringValueTabSync(SR, Comp, value, version);

    bt := 0;
    MainFormInstance.SetPartOfSetFromString(bt, s);

    if Q_IsInteger(Value) then
      value := MainFormInstance.GetPartsString(MainFormInstance.GetPartOfSet(bt), StrToInt(value))
    else
      value := MainFormInstance.GetPartsString(MainFormInstance.GetPartOfSet(bt), 0);

    if length(Value) > 0 then
    begin
      TJvID3CustomTextFrame(id3v2.AddFrame(fiPartInSet)).Text := value;
    end
  end
  else    //LANGUAGE
  if Comp = TLAN then
  begin
    DelFrame(fiLanguage);
    if TLAN.text <> '' then
    begin
      value := Q_CopyRange(LanguageCodes[TLAN.ItemIndex], 1, 3);
      TJvID3CustomTextFrame(id3v2.AddFrame(fiLanguage)).Text := value;
    end
  end
  else //YEAR
  if Comp = TYER then
  begin
     //Id3v2.3 : 4 string integer value (TYER)
     //Id3v2.4 : Hence valid timestamps   (TDRC)
     //              are
     //              yyyy, yyyy-MM, yyyy-MM-dd, yyyy-MM-ddTHH, yyyy-MM-ddTHH:mm and
     //              yyyy-MM-ddTHH:mm:ss. All time stamps are UTC.
     DelFrame(fiYear);
     DelFrame(fiRecordingTime);
     if version in [ive2_3, ive2_2] then frameId := fiYear;
     if version = ive2_4 then frameId := fiRecordingTime;
     Value := trim(TYER.text);

     UpdateStringValueTabSync(SR, Comp, value, version);

     if Q_IsInteger(value) then
     begin
        if frameId = fiYear then
          TJvID3NumberFrame(id3v2.AddFrame(fiYear)).Value := StrToInt(value)
        else if frameId = fiRecordingTime then
          TJvID3TimestampFrame(id3v2.AddFrame(fiRecordingTime)).Value := EncodeDate(StrToInt(value), 1, 1)
     end
  end
  else //TCON / GENRE
  if Comp = TCON then
  begin
    DelFrame(fiContentType);

    if not UpdateStringValueTabSync(SR, Comp, value, version) then
    begin
      UR := doCreateUndo(TCON, false, false);
      value := Trim(GetV2GenreToSave(UR, version));
      doDeleteUndo(UR)
    end;

    // Done composing value
    if Length(value) > 0 then
    begin
      TJvId3CustomTextFrame(id3v2.AddFrame(fiContentType)).Text := value
    end
  end
  else //COMMENTS
  if Comp = CommTree then
  begin
    begin
      if UpdateStringValueTabSync(SR, Comp, value, version) then
      begin
      	//Find comm-field without description and (preferibly language=xxx)
      	j := -1;
        for i:=0 to id3v2.Frames.Count-1 do
        	if id3v2.Frames[i].FrameId = fiComment then
          begin
            cntFrame := TJvID3ContentFrame(id3v2.Frames[i]);
            if (length(cntFrame.Description) = 0) and (Q_SameText(cntFrame.Language, UnknownLanguageCode) or (j = -1)) then	//preferibly choose language=xxx
            	j := i
          end;

        if j = -1 then
        begin
        	cntFrame := TJvID3ContentFrame(id3v2.AddFrame(fiComment));
          cntFrame.Language := UnknownLanguageCode
        end
        else
        	cntFrame := TJvID3ContentFrame(id3v2.Frames[j]);

        if length(value) = 0 then
        	id3v2.Frames.Remove(cntFrame)
        else
        begin
	        cntFrame.Text := value
        end;

        //Now check for custom fields tree (DB). Only add or change COMM-frames, don't delete existing
        if CopyTagSettings[tagId3v2] = tagDb then
        begin
        	if getGrayed(CustomFieldTree) then //hent fra statrec
					begin
						clearSourceRec := false;
						for i:=0 to length(SR.values)-1 do
							if PundoRec(SR.values[i]).Obj = CustomFieldTree then
              	sourceUR := SR.values[i];
          end
					else   // henter fra componentet
					begin
						clearSourceRec := true;
						sourceUR := doCreateUndo(CustomFieldTree, false, false)
					end;

          ucf := sourceUR.p;

          for j:=0 to length(ucf.arr)-1 do	//Enumerate customfields in DB-tag
          begin
          	if not ucf.arr[j].gray then
	          begin
	          	cf := PCustomField(FieldList.Items[ucf.arr[j].FieldIndex]);
	          	if Q_SameText(cf.id3v2FieldName, 'COMM') then
	            begin
	              k := -1;

  	            for i:=0 to id3v2.Frames.Count-1 do	//Enumerate frames in id3v2-tag from file
                begin
                  if id3v2.Frames[i].FrameId = fiComment then
                  begin
                    cntFrame := TJvID3ContentFrame(id3v2.Frames[i]);
                    if Q_SameText(cf.id3v2Description, cntFrame.Description) then
                    begin
                      if Q_SameText(cf.id3v2DefaultLanguage, cntFrame.language) then
                      begin
                        k := i;
                        break	// break for
                      end
                      else
                      begin
                        //Language doesn't match
                        if cf.id3v2ReadAllLanguages then
                          k := i
                      end
                    end;
              		end
              	end;

	              if k = -1 then
	              begin
	              	//Create new frame
	                cntFrame := TJvID3ContentFrame(id3v2.AddFrame(fiComment))
	              end
                else
                  cntFrame := TJvID3ContentFrame(id3v2.Frames[k]);

	              cntFrame.Language := cf.id3v2DefaultLanguage;
	              cntFrame.Description := cf.id3v2Description;
	              cntFrame.Text := ucf.arr[j].value
	          	end
            end
          end;
          if clearSourceRec then
        		doDeleteUndo(sourceUR)
      	end
      end //of if UpdateStringValueTabSync(...)
      else
      begin
	      lst := TList.Create;
		    for i:=0 to id3v2.Frames.Count-1 do
		    begin
		    	if id3v2.Frames[i].FrameId = fiComment then
		      	lst.Add(pointer(i))
		    end;

				SetLength(bArr1, lst.Count);	//if false, the existing field is deleted from the tag
		    for i:=0 to length(bArr1)-1 do bArr1[i] := false;

		    SetLength(bArr2, CommTree.RootNodeCount);	//if false, a new field is added to the tag
		    for i:=0 to length(bArr2)-1 do bArr2[i] := false;

		    //Enumerate existing fields to see if any should be deleted or added
		    for i:=0 to lst.Count-1 do
		    begin
		    	j := integer(lst.Items[i]);
          cntFrame := TJvId3ContentFrame(id3v2.Frames[j]);

		      aNode := CommTree.GetFirst;
		      while aNode <> nil do
		      begin
		        commRec := CommTree.GetNodeData(aNode);
		        if ( ((CommRec.Language=-1) and Q_SameText(cntFrame.Language, UnknownLanguageCode)) or ((CommRec.Language >= 0) and Q_SameText(LanguageCodes[commRec.Language], cntFrame.Language)) )
		          and Q_SameText(cntFrame.description, CommRec.Description) then
		        begin
		          bArr1[i] := true;
		          bArr2[aNode.Index] := true;
		          if not commRec.Gray and not Q_SameStr(commRec.value, cntFrame.Text) then
		          begin
		          	cntFrame.Text := commRec.Value
		          end
		        end;
		        aNode := CommTree.GetNext(aNode)
		      end
		    end;

		    //Removing those who should be deleted
		    for i:=lst.Count-1 downto 0 do
		      if not bArr1[i] then id3v2.Frames.Remove(id3v2.Frames[integer(lst.Items[i])]);

		    //Adding new
		    aNode := CommTree.GetFirst;
		    while aNode <> nil do
		    begin
		      if not bArr2[aNode.Index] then
		      begin
		        commRec := CommTree.GetNodeData(aNode);
		        if not commRec.Gray then
		        begin
              cntFrame := TJvId3ContentFrame(id3v2.AddFrame(fiComment));
		          if commRec.Language = -1 then
		        		cntFrame.Language := UnknownLanguageCode
		          else
		          	cntFrame.Language := Q_CopyRange(LanguageCodes[commRec.Language], 1, 3);
		          cntFrame.Description := commRec.Description;
		          cntFrame.Text := commRec.Value
            end
		      end;
		      aNode := CommTree.GetNext(aNode)
		    end;

		    lst.free;
      end
    end
  end
  else //Musicians list
  if (Comp = TMCL) and (version = ive2_4) then
  begin
    DelFrame(fiMusicianCreditList);

    if TMCL.RootNodeCount > 0 then
    begin
      dblLstFrame := nil;

      aNode := TMCL.GetFirst;
      while aNode <> nil do
      begin
        RoleRec := TIPL.GetNodeData(aNode);
        if not RoleRec.Empty then
        begin
          if not Assigned(dblLstFrame) then
            dblLstFrame := TJvID3DoubleListFrame(id3v2.AddFrame(fiMusicianCreditList));
          dblLstFrame.List.Add (RoleRec.Role + '=' + RoleRec.Name);
        end;
        aNode := TMCL.GetNext(aNode)
      end
    end
  end;
  //Involved People list
  if Comp = TIPL then
  begin
    DelFrame(fiInvolvedPeople2); // TIPL
    DelFrame(fiInvolvedPeople);  // IPLS

    StrL := TstringList.create;

    value := #0;
    if TIPL.RootNodeCount > 0 then
    begin
      aNode := TIPL.GetFirst;
      while aNode <> nil do
      begin
        RoleRec := TIPL.GetNodeData(aNode);
        if not RoleRec.Empty then
          AddToStrL(StrL, RoleRec.Role + #0 + RoleRec.Name);
        aNode := TIPL.GetNext(aNode)
      end
    end;

    if (version = ive2_3) and (SR.Id3V2ver = ive2_4) then   // if saved in 2.3 it might contain musicians or IPLS
    begin
      DelFrame(fiMusicianCreditList); // this doesn't exist in 2_3
      for i:=0 to length(SR.values)-1 do //musicians
        if (PundoRec(SR.values[i]).Obj = TMCL) or (PundoRec(SR.values[i]).Obj = TIPL) then
        begin
          UO := PundoRec(SR.values[i]).P;
          for x:=0 to length(UO.arr)-1 do
            AddToStrL(StrL, ProleRec(UO.arr[x]).role + '=' + ProleRec(UO.arr[x]).name)
        end
    end;

    if strL.count >0 then
    begin
      if version = ive2_3 then dblLstFrame := TJvID3DoubleListFrame(id3v2.AddFrame(fiInvolvedPeople));
      if version = ive2_4 then dblLstFrame := TJvID3DoubleListFrame(id3v2.AddFrame(fiInvolvedPeople2));
      dblLstFrame.List.AddStrings(StrL)
    end;
    strL.Free
  end
  else    //URL
  if Comp = WXXX then
  begin
    DelFrame(fiWWWUser);

    Value := WXXX.text;
    if Length(Trim(value)) > 0 then
    begin
      with TJvID3URLUserFrame(id3v2.AddFrame(fiWWWUser))do
      begin
        Description := '';
        URL := Trim(value)
      end
    end
  end
  else //private Frame
  if Comp = SaveGroups then
  begin
    //clearing old data:
    r := PstatRec(SR).ref;
    if saveGroups.checked and ((length(r.groups)>0) or CBcompilation.checked) then
      MainFormInstance.SaveId3v2PrivateFrame(id3v2, r)
    else
      MainFormInstance.HasMexpPrivateFrame(id3v2, true) // remove private frame
  end else

  if Comp = id3v2OtherFields then
  begin
  	if CopyTagSettings[tagId3v2] = tagDb then
      begin
        //Check custom fields tree (DB). Only add or change T***-frames, don't delete existing
        if getGrayed(CustomFieldTree) then //hent fra statrec
        begin
          clearSourceRec := false;
          for i:=0 to length(SR.values)-1 do
            if PundoRec(SR.values[i]).Obj = CustomFieldTree then
              sourceUR := SR.values[i];
        end
        else   // henter fra componentet
        begin
          clearSourceRec := true;
          sourceUR := doCreateUndo(CustomFieldTree, false, false)
        end;

        ucf := sourceUR.p;

        for j:=0 to length(ucf.arr)-1 do	//Enumerate customfields in DB-tag
        begin
          if not ucf.arr[j].gray then
          begin
            cf := PCustomField(FieldList.Items[ucf.arr[j].FieldIndex]);
            if Q_SameTextL(cf.id3v2FieldName, 'T', 1) and not ( ID3_StringToFrameID(cf.id3v2FieldName) in [fiErrorFrame, fiUnknownFrame]) then
            begin
              k:=-1;

              for i:=0 to id3v2.Frames.Count-1 do	//Enumerate frames in id3v2-tag from file
              begin
                if Q_SameText(id3v2.Frames[i].FrameName, cf.id3v2FieldName) then
                begin
                  if Q_SameText(cf.id3v2FieldName, 'TXXX') then
                    userTextFrame := TJvID3UserFrame(id3v2.Frames[i]);

                  if (Q_SameText(cf.id3v2FieldName, 'TXXX') and Q_SameText(cf.id3v2Description, userTextFrame.Description)) or (not Q_SameText(cf.id3v2FieldName, 'TXXX')) then
                  begin
                    k := i;
                    break	// break for
                  end
                end
              end;

              if k = -1 then
              begin
                //Create new frame
                id3Frame := id3v2.AddFrame (ID3_StringToFrameID(cf.id3v2FieldName))
              end
              else
              begin
                id3Frame := id3v2.Frames[k];
              end;

              if id3Frame.FrameID = fiUserText then
              begin
                userTextFrame := TJvID3UserFrame (id3Frame);
                userTextFrame.Description := cf.id3v2Description;
                userTextFrame.Value := ucf.arr[j].value
              end
              else
                TJvId3CustomTextFrame (id3Frame).Text := ucf.arr[j].value;
            end
          end
        end;
        if clearSourceRec then
          doDeleteUndo(sourceUR)
      end //of if UpdateStringValueTabSync(...)
      else
      begin
		  	strl := TStringList.Create;
		    for i:=0 to id3v2.Frames.Count-1 do
		    begin
		    	s := id3v2.Frames[i].FrameName;
		      if Q_SameTextL(s, 'T', 1) {and not Q_SameText(s, 'TXXX')} and not IsId3v2Control(s, self) then
		      	strl.AddObject(s, TObject(i))
		    end;

      SetLength(bArr1, strl.Count);	//if false, the existing field is deleted from the tag
      for i:=0 to length(bArr1)-1 do bArr1[i] := false;

      SetLength(bArr2, id3v2OtherFields.RootNodeCount);	//if false, a new field is added to the tag
      for i:=0 to length(bArr2)-1 do bArr2[i] := false;

      //Enumerate existing fields to see if any should be deleted or added
      for i:=0 to strl.Count-1 do
      begin
        s := strl.Strings[i];
        j := integer(strl.Objects[i]);

        if Q_SameText(s, 'TXXX') then
        begin
          userTextFrame := TJvID3UserFrame (id3v2.Frames[j]);
          s1 := userTextFrame.Description;
          s2 := userTextFrame.Value
        end
        else
        begin
          s1 := '';
          s2 := TJvId3CustomTextFrame (id3v2.Frames[j]).Text
        end;

        aNode := id3v2OtherFields.GetFirst;
        while aNode <> nil do
        begin
          tfRec := id3v2OtherFields.GetNodeData(aNode);
          if Q_SameText(s, tfRec.fieldName) and Q_SameText(s1, tfRec.description) then
          begin
            bArr1[i] := true;
            bArr2[aNode.Index] := true;
            if not tfRec.gray and not Q_SameStr(tfRec.value, s2) then
            begin
              if Q_SameText(tfRec.fieldName, 'TXXX') then
              begin
                userTextFrame := TJvID3UserFrame (id3v2.Frames[j]);
                userTextFrame.Description := tfRec.Description;
                userTextFrame.Value := tfRec.value
              end
              else
                TJvId3CustomTextFrame (id3v2.Frames[j]).Text := tfrec.value
            end
          end;
          aNode := id3v2OtherFields.GetNext(aNode)
        end
      end;

      //Removing those who should be deleted
      for i:=strl.count-1 downto 0 do
      begin
        if not bArr1[i] then
          id3v2.Frames.Remove (id3v2.Frames[integer(strl.objects[i])]);
      end;

      //Adding new
      aNode := id3v2OtherFields.GetFirst;
      while aNode <> nil do
      begin
        if not bArr2[aNode.Index] then
        begin
          tfRec := id3v2OtherFields.GetNodeData(aNode);
          if Q_SameText(tfRec.fieldName, 'TXXX') then
          begin
            userTextFrame := TJvID3UserFrame (id3v2.AddFrame (fiUserText));
            userTextFrame.Description := tfRec.description;
            userTextFrame.Value := tfRec.value
          end
          else
          begin
            TJvId3CustomTextFrame (id3v2.AddFrame (ID3_StringToFrameID(tfRec.FieldName))).Text := tfRec.value;
          end
        end;
        aNode := id3v2OtherFields.GetNext(aNode)
      end;

      strl.free;
    end
  end
  else
  if Comp = LyricsMemo then //lyrics, USLT
  begin
    SR.HasTagLyrics[tagId3v2] := false;
    if tagLyrics.checked and (length(trim(LyricsMemo.text))>0) then
    begin
      cntFrame := TJvID3ContentFrame.FindOrCreate(id3v2, fiUnsyncedLyrics);
      cntFrame.Text := trim(LyricsMemo.text);
      SR.HastagLyrics[tagId3v2] := true;
      SR.Lyrics := trim(LyricsMemo.text)
    end
    else
      DelFrame(fiUnsyncedLyrics)
  end
end;

function TEditor.IsId3v2Control(const fieldName: string; checkFrom: TWinControl): Boolean;
var
	i: integer;
begin
	result := false;
	for i:=0 to checkFrom.ControlCount-1 do
  begin
  	if ((checkFrom.Controls[i].Tag = 12) and Q_SameText(checkFrom.Controls[i].Name, fieldName)) or ((checkFrom.Controls[i] is TWinControl) and IsId3v2Control(fieldName, TWinControl(checkfrom.Controls[i]))) then
    begin
    	result := true;
      break
    end;
  end
end;

Function TEditor.getRealV1Genre(s:String):integer;
var      i:integer;
begin
  Q_trimInPlace(s);
  result := 255;
  for i:=0 to MAXGENRES do
  	if Q_sameText(GENRES[i], s) then
    begin
     	result := i;
      break
    end
end;

Function TEditor.EqualUndoRecContents(currentSource, originalSource, currentTarget, originalTarget:PundoRec):boolean;
var
 	s1, s2: String;
 	undoGenres1, undoGenres2 : PundoGenres;
 	undoComments1, undoComments2, uc : PundoComments;
  utf: PundoTagFields;
  ucf, ucfCurr, ucfOrig: PundoCustomFields;
  cf: PCustomField;
 	CompLen:integer;
 	i, j, x:integer;
  found, hasId3v1Genre: boolean;
  p: pointer;
begin
{ can compare:
  edits/combo = edits/combo
  Genre = TCON
  Comments = COMM
	TCON = TCON
  COMM = COMM
  TMCL = TMCL
  TIPL = TIPL
	Genre = Id3v1Genre/ApeGenre/WMAGenre/OggGenre
	GroupCheck = GroupCheck
  }
  if (TComponent(originalTarget.Obj).tag = TagDB) and (currentSource.Obj <> originalTarget.Obj) then
  begin //swap
  	p := currentTarget;
    currentTarget := currentSource;
    currentSource := p;

    p := originalTarget;
    originalTarget := originalSource;
    originalSource := p
  end;

  if (currentSource.Obj Is Tedit) or (currentSource.Obj Is TJvComboBox) then
  begin
  	if currentSource.Gray then
    	s1 := trim(PundoString(originalSource.p).s)
    else
		  s1 := trim(PundoString(currentSource.p).s)
  end;

  if (originalTarget.Obj Is Tedit) or (originalTarget.Obj Is TJvComboBox) then
  begin
//  	if currentTarget.Gray then
    	s2 := trim(PundoString(originalTarget.p).s)    //Always use the original value from the file
//    else
//		  s2 := trim(PundoString(currentTarget.p).s)
  end;

  if ((currentSource.Obj Is Tedit) or (currentSource.Obj Is TJvComboBox)) and ((originalTarget.Obj Is Tedit) or (originalTarget.Obj Is TJvComboBox)) then
  begin
    if TComponent(originalTarget.Obj).tag = 11 then
    begin
      if originalTarget.Obj is TJvComboBox then
	      CompLen := TJvComboBox(originalTarget.Obj).maxlength
      else
  	    CompLen := TEdit(originalTarget.Obj).maxlength;

      if length(s1) > length(s2) then
	      s2 := Q_PadRight(s2, min(CompLen, length(s1)), ' ');
  	  result := Q_SameStrL(s1, s2, CompLen)
    end
    else
    	result := Q_SameStr(s1, s2)
  end
  else
	begin
  	if (originalTarget.Obj = Id3v1Genre) or (originalTarget.Obj = ApeGenre) or (originalTarget.Obj = WMAGenre) or (originalTarget.Obj = OggGenre) then  // sammenligner genre med Id3v1Genre (UR1 er genre)
    begin
    	if currentSource.Gray then
      	undoGenres1 := originalSource.p
    	else
	      undoGenres1 := currentSource.p;

      S2 := PundoString(originalTarget.p).s;

      hasId3v1Genre := false;

      for i:=0 to length(undoGenres1.arr)-1 do
        hasId3v1Genre := hasId3v1Genre or IsV1Genre(undoGenres1.arr[i]);

      if (length(s2)=0) and not hasId3v1Genre then
      begin
        result := true
      end else
      begin
        result := false;
        for i:=0 to length(undoGenres1.arr)-1 do
        begin
             result := result or Q_SameStr(undoGenres1.arr[i], s2);
        end
      end
    end
    else
    if (originalTarget.Obj = TCON) then   // sammenligner genre med TCON (UR1 er genre)
    begin
    	if currentSource.Gray then
      	undoGenres1 := originalSource.p
      else
      	undoGenres1 := currentSource.p;

	    undoGenres2 := originalTarget.p;

	    result := (undoGenres1.cover = undoGenres2.cover) and (undoGenres1.remix = undoGenres2.remix) and (length(undoGenres1.arr) = length(undoGenres2.arr));
	    if result then
	    begin
		    for i:=0 to length(undoGenres1.arr)-1 do
		    begin
			    result := false;
			    for x:=0 to length(undoGenres2.arr)-1 do
				    result := result or Q_SameStr(undoGenres1.arr[i], undoGenres2.arr[x]);
			    if not result then
          	break
		    end
	    end
    end
    else
    if (currentSource.Obj = CommTree) and (originalTarget.Obj = CommTree) then  // sammenligner COMM med COMM
    begin
      if currentSource.Gray then
      	undoComments1 := originalSource.p
      else
      	undoComments1 := currentSource.p;

	    undoComments2 := originalTarget.p;

      if length(undoComments1.arr) = length(undoComments2.arr) then
      begin
	      result := true;
	      for i:=0 to length(undoComments1.arr)-1 do
	      begin
		      result := false;
		      for x:=0 to length(undoComments2.arr)-1 do
			      result := result or ((PcommRec(undoComments1.arr[i]).Gray = PcommRec(undoComments2.arr[i]).Gray) and Q_SameStr(PcommRec(undoComments1.arr[i]).value, PcommRec(undoComments2.arr[i]).value) and Q_SameStr(PcommRec(undoComments1.arr[i]).Description, PcommRec(undoComments2.arr[i]).Description) and (PcommRec(undoComments1.arr[i]).language = PcommRec(undoComments2.arr[i]).language));
		      if not result then
		        break
	      end
    	end
	    else
      	result := false
    end
    else
    if (originalTarget.Obj = CommTree) and (currentSource.Obj = CustomFieldTree) then //Compares CommTree and CustomFieldData
    begin
      result := true;

      uc := originalTarget.p;
      ucfCurr := currentSource.p;
      ucfOrig := originalSource.p;
      new(ucf);
      for i:=0 to Length(ucfCurr.arr)-1 do
      begin
      	if ucfCurr.arr[i].gray then
        begin
        	//Find original
          x := -1;
          for j:=0 to Length(ucfOrig.arr)-1 do
          	if ucfCurr.arr[i].FieldIndex = ucfOrig.arr[j].FieldIndex then
            	x := j;
          if x >= 0 then
          begin
          	SetLength(ucf.Arr, Length(ucf.Arr)+1);
            ucf.arr[Length(ucf.arr)-1] := ucfOrig.arr[x]
          end
        end
        else
        begin
        	//not gray
        	SetLength(ucf.Arr, Length(ucf.Arr)+1);
          ucf.arr[Length(ucf.arr)-1] := ucfCurr.arr[i]
        end
      end;

      for i:=0 to Length(ucf.arr)-1 do
      begin
        cf := FieldList.Items[ucf.arr[i].FieldIndex];
        if Q_SameText(cf.id3v2FieldName, 'COMM') then
        begin
          x := -1;

          for j:=0 to Length(uc.arr)-1 do
          begin
            if Q_SameText(cf.id3v2Description, uc.arr[j].Description) and
            (
            (((uc.arr[j].Language = -1) and Q_SameText(cf.id3v2DefaultLanguage, UnknownLanguageCode))
                    or ((uc.arr[j].Language >= 0) and Q_SameText(LanguageCodes[uc.arr[j].Language], cf.id3v2DefaultLanguage))
            ) or ((x=-1) and cf.id3v2ReadAllLanguages)) then
              x := j;
          end;

          if x=-1 then
          begin
            //The values does not exists - they're not equal
            result := false
          end
          else
          begin
            if (ucf.arr[i].gray <> uc.arr[x].Gray) or (not uc.arr[x].Gray and not Q_SameStr(ucf.arr[i].value, uc.arr[x].Value)) then
              result := false
          end
        end
      end;
      Dispose(ucf)
    end
  	else

    if (originalTarget.Obj = Id3v2OtherFields) and (currentSource.Obj = CustomFieldTree) then //Compares Id3v2OtherFields and CustomFieldData
    begin
      result := true;

      utf := originalTarget.p;
      ucfCurr := currentSource.p;
      ucfOrig := originalSource.p;
      new(ucf);
      for i:=0 to Length(ucfCurr.arr)-1 do
      begin
      	if ucfCurr.arr[i].gray then
        begin
        	//Find original
          x := -1;
          for j:=0 to Length(ucfOrig.arr)-1 do
          	if ucfCurr.arr[i].FieldIndex = ucfOrig.arr[j].FieldIndex then
            	x := j;
          if x >= 0 then
          begin
          	SetLength(ucf.Arr, Length(ucf.Arr)+1);
            ucf.arr[Length(ucf.arr)-1] := ucfOrig.arr[x]
          end
        end
        else
        begin
        	//not gray
        	SetLength(ucf.Arr, Length(ucf.Arr)+1);
          ucf.arr[Length(ucf.arr)-1] := ucfCurr.arr[i]
        end
      end;

      for i:=0 to Length(ucf.arr)-1 do
      begin
        cf := FieldList.Items[ucf.arr[i].FieldIndex];
        if Q_SameText(cf.id3v2FieldName, 'TXXX') then
        begin
          x := -1;

          for j:=0 to Length(utf.arr)-1 do
          begin
            if Q_SameText(utf.arr[j].fieldName, 'TXXX') and Q_SameText(cf.id3v2Description, utf.arr[j].description) then
              x := j;
          end;

          if x=-1 then
          begin
            //The values does not exists - they're not equal
            result := false
          end
          else
          begin
            if (ucf.arr[i].gray <> utf.arr[x].Gray) or (not utf.arr[x].Gray and not Q_SameStr(ucf.arr[i].value, utf.arr[x].Value)) then
              result := false
          end
        end
      end;
      Dispose(ucf)
    end
  	else
    if originalTarget.Obj = CommTree then  // sammenligner comments/eCommentsV1 med COMM  (UR1.Obj er enten Comments, eCommentsV1, ApeComment, WMAComment, OggComment)
    begin
      undoComments2 := originalTarget.p;

      //Is there a comment in id3v2 with empty description?
      found := false;
      for i:=0 to length(undoComments2.arr)-1 do
        found := found or (not PcommRec(undoComments2.arr[i]).Gray and (length(PcommRec(undoComments2.arr[i]).Description) = 0));

      if found then
      begin
        result := false;
        for i:=0 to length(undoComments2.arr)-1 do
          result := result or (not PcommRec(undoComments2.arr[i]).Gray and (length(PcommRec(undoComments2.arr[i]).Description) = 0) and Q_SameStr(PcommRec(undoComments2.arr[i]).value, s1))
      end
      else
        result := length(s1)=0
    end
    else
    begin
    	if currentSource.Gray then
      	result := EqualUndoRecs(originalSource, originalTarget)
      else
      	result := EqualUndoRecs(currentSource, originalTarget)
    end
  end
end;

Function TEditor.GetSRvalueIndex(Obj:TObject; SR:PstatRec):integer;
var      i:integer;
         UR:PundoRec;
begin
     result := 0;
     for i:=0 to length(SR.values)-1 do
     begin
          UR := SR.values[i];
					if UR.Obj = Obj then
					begin
             result := i;
             break
          end
     end
end;

procedure TEditor.addGenreToRec(p:pointer; s:string);
var       i : integer;
begin
     Q_TrimInPlace(s);
     if s <> '' then
     begin
          i := MainFormInstance.GetGenreID(s);
          if (i > -1) and not MainFormInstance.hasGenre(i, p) then
          begin
               setLength(pRec(p).genre, length(pRec(p).genre)+1);
               pRec(p).genre[length(pRec(p).genre)-1] := i
          end
     end
end;

procedure TEditor.SaveLyrics3(Fstr:TStream; pSR:pointer);
function fixString(s:string):string;
begin
     result := s;
     Q_ReplaceText(result, #0, '');
     Q_ReplaceText(result, #10, '');
     Q_ReplaceText(result, #13, CRLF)
end;
function matchString(arr:array of byte; s:string):boolean;
var      i:integer;
begin
     result := length(arr) = length(s);
     if result then
     begin
     	for i:=0 to length(s)-1 do
      	result := result and (char(arr[i]) = s[i+1])
     end
end;
function toString(arr:array of byte):string;
var      i:integer;
begin
     result := '';
     for i:=0 to length(arr)-1 do
         result := result + char(arr[i])
end;

procedure readBytes(var arr:array of byte);
var       i:integer;
begin
     for i:=0 to length(arr)-1 do
         Fstr.read(arr[i], 1)
end;
procedure moveLeft(var arr:array of byte);
var       i:integer;
begin
     for i:=0 to length(arr)-2 do arr[i] := arr[i+1];
     arr[length(arr)-1] := 0
end;

function HasTimeStamp(s:String):boolean;
var      t:string;
begin
     //format : #13[ii:ii] (i:integer)
     result := false;
     if Q_PosText(#10+'[', s)>0 then
     begin
          t := Q_CopyFrom(s, Q_PosText(#10+'[', s));
          result := (length(t)>8) and Q_Isinteger(t[3]+t[4]+t[6]+t[7]) and (t[5]=':') and (t[8]=']')
     end
end;

procedure WriteL3V2Field(Fstr:Tstream; ident:string; value:String);
var       s, l:string;
begin
     s := ident;
     value := fixString(value);
     l := inttostr(length(value));
     while length(l) < 5 do
           l := '0' + l;
     s := s + l + value;
     Fstr.Write(s[1], length(s))
end;

var       SR:PstatRec;
          i:integer;
          id3v1: array[0..127] of byte;
          id3Size:integer;
          arr:array of byte;
          HasId3v1:boolean;
          startPos, endPos:integer;
					fields:array of Tlyrics3Fields;
          s, l:string;
begin
     SR := pSR;
     //gemmer id3v1
     if Fstr.size > 130 then
     begin
          FStr.position := Fstr.size-128;
          Fstr.Read(Id3v1, sizeOf(byte)*128);
          HasId3v1 := (char(Id3v1[0]) = 'T') and (char(Id3v1[1]) = 'A') and (char(Id3v1[2]) = 'G');
     end else HasId3v1 := false;

     //v1 har "LYRICSEND" lige før id3v1, v2 har "LYRICS200" lige før

     //klipper id3v1
     if HasId3v1 then Fstr.size := Fstr.size-128;
     id3Size := 0;

     Fstr.position := max(0, Fstr.size-id3Size-9);

     setLength(arr, 9);
     readBytes(arr);
     SR.HasLyrics3V1 := MatchString(arr, 'LYRICSEND');
		 SR.HasLyrics3V2 := MatchString(arr, 'LYRICS200');

     if SR.HasLyrics3V1 then
     begin
          Fstr.position := max(0, Fstr.size-5100-id3Size);
          setLength(arr, 11);
          readBytes(arr);
          startPos := -1;
          while Fstr.Position < Fstr.size-9-11-id3Size do
          begin
               if matchString(arr, 'LYRICSBEGIN') then
               begin
                    startPos := Fstr.position;
										break
               end else
               begin
                    moveLeft(arr);
                    Fstr.read(arr[length(arr)-1], sizeOf(byte))
               end
          end;

          if startPos >=0 then
          begin
							 Fstr.size := startPos-11;
               SR.HasLyrics3V1 := false;
               SR.Lyrics := ''
          end
     end; //eo SR.haslyrics3V1

     setLength(fields, 0);
     if SR.HasLyrics3V2 then
     begin
          Fstr.position := Fstr.size-9-Id3Size;
          setLength(arr, 9);
          readBytes(arr);
          if MatchString(arr, 'LYRICS200') then
          begin
               Fstr.position := Fstr.position - 9 - 6;
               endPos := Fstr.position;
               setLength(arr, 6);
               readBytes(arr);
               s := toString(arr);
               if Q_IsInteger(s) then
							 begin
                    startPos := strtoint(s);
                    Fstr.position := endPos-startPos;
                    startPos := Fstr.position;
                    //læser forbi LyricsBegin
                    setLength(arr, 11);
                    readBytes(arr);
                    if MatchString(arr, 'LYRICSBEGIN') then
                    begin
                         while Fstr.Position < endPos do
                         begin
                              setLength(fields, length(fields)+1);
                              setLength(arr, 3);
															readBytes(arr);
                              fields[length(fields)-1].ident := toString(arr);
                              setLength(arr, 5);
                              readBytes(arr);
                              s := toString(arr);
                              if Q_IsInteger(s) then
                              begin
																	 fields[length(fields)-1].length := strToInt(s);
																	 setLength(arr, strToInt(s));
                                   readBytes(arr);
                                   fields[length(fields)-1].value := trim(toString(arr))
                              end else
                              begin //der er sket en fejl, stopper med at læse flere
																		setLength(fields, length(fields)-1);
                                    break
                              end
                         end;
                         //fjerner:
                         Fstr.Size := startPos;
                         SR.HasLyrics3V2 := false;
                         SR.Lyrics := ''
                    end // else: LYRICSBEGIN findes ikke
               end
          end
     end;
     //EO slet

     LyricsMemo.text := trim(LyricsMemo.text);

     if length(LyricsMemo.text)>0 then
		 begin
          if Lyrics3v1.checked then //gemmer Lyrics3 version 1.00
          begin
               Fstr.Position := Fstr.Size;
               s := 'LYRICSBEGIN' + fixString(LyricsMemo.text) + 'LYRICSEND';
               Fstr.Write(s[1], length(s));

               SR.HasLyrics3V1 := true;
               SR.Lyrics := fixString(LyricsMemo.text)
          end else
          if Lyrics3v2.checked then //gemmer Lyrics3 version 2.00
          begin
               Fstr.Position := Fstr.Size;
							 startPos := Fstr.Position;
               s := 'LYRICSBEGININD000031'; //IND123 field: 1:LYR field in tag. 2:timestamps used. 3:randomting - skal være '0'
               if HasTimeStamp(FixString(LyricsMemo.text)) then s := s + '10' else s := s + '00';
               Fstr.write(s[1], length(s));
               //artist: EAR
               if length(getFtext(SR.ref, Fartist))>30 then
                  writeL3V2Field(Fstr, 'EAR', getFtext(SR.ref, Fartist));

               //title: ETT
               if length(getFtext(SR.ref, Ftitle))>30 then
                  writeL3V2Field(Fstr, 'ETT', getFtext(SR.ref, Ftitle));

               //album: EAL
               if length(getFtext(SR.ref, Falbum))>30 then
                  writeL3V2Field(Fstr, 'EAL', getFtext(SR.ref, Falbum));

							 //lyrics: LYR
               writeL3V2Field(Fstr, 'LYR', LyricsMemo.Text);

               //skriver gamle felter:
               for i:=0 to length(fields)-1 do
                   if not Q_SameText(fields[i].ident, 'EAR') and not Q_SameText(fields[i].ident, 'IND') and not Q_SameText(fields[i].ident, 'ETT') and not Q_SameText(fields[i].ident, 'EAL') and not Q_SameText(fields[i].ident, 'LYR') then
                      writeL3V2Field(Fstr, fields[i].ident, fields[i].value);

               l := inttostr(Fstr.size - startPos);
               while length(l) < 6 do
                     l := '0' + l;
               l := l + 'LYRICS200';
               Fstr.write(l[1], length(l));

							 SR.HasLyrics3V2 := true;
               SR.Lyrics := fixString(LyricsMemo.text)
          end
     end;
     if HasId3v1 then
        Fstr.Write(id3v1, 128);
     setLength(fields, 0) //clean
end;
/////eo ny lyrics3save

procedure TEditor.LoadLyrics3(Fstr:TStream; pSR:pointer);
function matchString(arr:array of byte; s:string):boolean;
var      i:integer;
begin
     result := length(arr) = length(s);
     if result then
     begin
          for i:=0 to length(s)-1 do
              result := result and (char(arr[i]) = s[i+1])
     end
end;
function toString(arr:array of byte):string;
var      i:integer;
begin
     result := '';
     for i:=0 to length(arr)-1 do
         result := result + char(arr[i])
end;

procedure readBytes(var arr:array of byte);
var       i:integer;
begin
		 for i:=0 to length(arr)-1 do
         Fstr.read(arr[i], 1)
end;
procedure moveLeft(var arr:array of byte);
var       i:integer;
begin
     for i:=0 to length(arr)-2 do arr[i] := arr[i+1];
     arr[length(arr)-1] := 0
end;

var       SR:PstatRec;
					i:integer;
          id3v1: array[0..127] of byte;
          id3Size:integer;
          arr:array of byte;
          HasId3v1:boolean;
          startPos, endPos:integer;
          fields:array of Tlyrics3Fields;
          s:string;
          c:char;
begin
     SR := pSR;
     //gemmer id3v1
     if Fstr.size > 130 then
		 begin
          FStr.position := Fstr.size-128;
          Fstr.Read(Id3v1, sizeOf(byte)*128);
          HasId3v1 := (char(Id3v1[0]) = 'T') and (char(Id3v1[1]) = 'A') and (char(Id3v1[2]) = 'G');
     end else HasId3v1 := false;

     //v1 har "LYRICSEND" lige før id3v1, v2 har "LYRICS200" lige før

     if HasId3v1 then id3Size := 128 else id3Size := 0;

     Fstr.position := max(0, Fstr.size-id3Size-9);

     setLength(arr, 9);
     readBytes(arr);
     SR.HasLyrics3V1 := MatchString(arr, 'LYRICSEND');
     SR.HasLyrics3V2 := MatchString(arr, 'LYRICS200');

     if SR.HasLyrics3V1 then
     begin
          Fstr.position := max(0, Fstr.size-5100-id3Size);
          setLength(arr, 11);
          readBytes(arr);
					startPos := -1;
          while Fstr.Position < Fstr.size-9-11-id3Size do
          begin
               if matchString(arr, 'LYRICSBEGIN') then
               begin
                    startPos := Fstr.position;
                    break
               end else
							 begin
                    moveLeft(arr);
                    Fstr.read(arr[length(arr)-1], sizeOf(byte))
               end
          end;

          if startPos >=0 then
          begin
               s := '';
               while Fstr.Position < Fstr.size-9-11-id3Size do
               begin
                    Fstr.read(c, 1);
                    s := s+c
							 end;
               SR.Lyrics := trim(s)
          end
     end; //eo SR.haslyrics3V1

     setLength(fields, 0);
     if SR.HasLyrics3V2 then
     begin
          Fstr.position := Fstr.size-9-Id3Size;
          setLength(arr, 9);
          readBytes(arr);
          if MatchString(arr, 'LYRICS200') then
          begin
               Fstr.position := Fstr.position - 9 - 6;
               endPos := Fstr.position;
               setLength(arr, 6);
               readBytes(arr);
               s := toString(arr);
               if Q_IsInteger(s) then
               begin
                    startPos := strtoint(s);
                    Fstr.position := endPos-startPos;
                    //læser forbi LyricsBegin
                    setLength(arr, 11);
                    readBytes(arr);
										if MatchString(arr, 'LYRICSBEGIN') then
                    begin
                         while Fstr.Position < endPos do
                         begin
                              setLength(fields, length(fields)+1);
															setLength(arr, 3);
                              readBytes(arr);
                              fields[length(fields)-1].ident := toString(arr);
                              setLength(arr, 5);
                              readBytes(arr);
                              s := toString(arr);
                              if Q_IsInteger(s) then
                              begin
                                   fields[length(fields)-1].length := strToInt(s);
                                   setLength(arr, strToInt(s));
                                   readBytes(arr);
                                   fields[length(fields)-1].value := trim(toString(arr))
                              end else
															begin //der er sket en fejl, stopper med at læse flere
                                    setLength(fields, length(fields)-1);
                                    break
                              end
                         end;
                         for i:=0 to length(fields)-1 do
                             if Q_SameText(fields[i].ident, 'LYR') then SR.Lyrics := fields[i].value
                    end // else: LYRICSBEGIN findes ikke
               end;
               setLength(fields, 0)
          end
     end
end;

procedure TEditor.FormDestroy(Sender: TObject);
begin
     if WindowShowBoolsSet and winampShowed then ShowWindow(hwnd_Winamp, SW_SHOWNORMAL);
		 if WindowShowBoolsSet and PlShowed then ShowWindow(hwnd_PL, SW_SHOWNORMAL);
     if WindowShowBoolsSet and eqShowed then ShowWindow(hwnd_EQ, SW_SHOWNORMAL);
     if WindowShowBoolsSet and mbShowed then ShowWindow(hwnd_MB, SW_SHOWNORMAL);
   {
    recs.free;

    for i:=undoList.count-1 downto 0 do deleteUndo(i);
    	undoList.Free;

    v1Components.free;
    v2Components.free;
    ApeComponents.free;
    WMAComponents.free;
    OggComponents.free;    }

    MainFormInstance.SetMainFormVisible(true);
end;

procedure TEditor.CommAddClick(Sender: TObject);
var     p:PcommRec;
begin
  if not CommTree.Enabled then exit;
  CommTree.rootnodecount := CommTree.rootnodecount + 1;
  P := CommTree.GetNodeData(CommTree.GetLast);
  P.Empty := true;
  CommTree.ReinitNode(CommTree.GetLast, false);
  CommTree.ClearSelection;
  CommTree.Selected[CommTree.GetLast] := true;
  CommTree.FocusedNode := CommTree.GetLast;
  COMMdiz.SetFocus
end;

procedure TEditor.CommTreeCreateEditor(Sender: TBaseVirtualTree;
	Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
begin
     if Column = 0 then EditLink :=  TLanguageCombo.Create else EditLink := TStringEditLink.Create
end;

procedure TEditor.CommTreeInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var     p:PcommRec;
begin
        P := Sender.GetNodeData(Node);
        if P.Empty then
        begin
             p.Description := '';
						 p.Value := '';
             p.Language := -1
				end
end;

procedure TEditor.COMMFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
 with Sender do
  begin
    if Assigned(Node) and (Node <> RootNode) then
    begin
      EditNode(Node, Column);
    end;
  end;
end;

procedure TEditor.CommTreeNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; Text: WideString);
var
	cr:PcommRec;
  oldVal: string;
begin
  cr := Sender.GetNodeData(Node);
  case Column of
    1:
	    begin
    		oldVal := cr.Description;
    		cr.Description := Text
      end;
    2:
    	begin
      	oldVal := cr.Value;
		    cr.Value := Text
      end
  end;
  if not Q_SameStr(oldVal, text) then
  	cr.Gray := false;

  cr.Empty := ((trim(cr.Description) = '-') or (trim(cr.Description) = '')) and ((trim(cr.Value) = '-') or (trim(cr.Value) = '')) and (cr.language = -1)
end;

procedure TEditor.CommDelClick(Sender: TObject);
begin
  if not CommTree.Enabled then exit;
  CommTree.DeleteSelectedNodes;
  createUndo(CommTree);
  ShowUndo(CommTree);
  COMMlanguage.enabled := false;
  COMMdiz.enabled := false;
  COMMtext.enabled := false;
  TextLabel.enabled := false;
  DizLabel.enabled := false;
  LangLabel.enabled := false
end;

procedure TEditor.AddMusiciansButClick(Sender: TObject);
var     p:PRoleRec;
begin
  if not TMCL.Enabled then exit;
  TMCL.rootnodecount := TMCL.rootnodecount + 1;
  P := TMCL.GetNodeData(TMCL.GetLast);
  P.Empty := true;
  TMCL.ReinitNode(TMCL.GetLast, false)
end;

procedure TEditor.DelMusiciansButClick(Sender: TObject);
begin
  if not TMCL.Enabled then exit;
  TMCL.CancelEditNode;
  TMCL.DeleteSelectedNodes;
  createUndo(TMCL);
  ShowUndo(TMCL)
end;

procedure TEditor.DelInvPeopleButClick(Sender: TObject);
begin
        if not TIPL.Enabled then exit;
        TIPL.CancelEditNode;
        TIPL.DeleteSelectedNodes;
        createUndo(TIPL);
        ShowUndo(TIPL)
end;

procedure TEditor.AddInvPeopleButClick(Sender: TObject);
var     p:PRoleRec;
begin
        if not TIPL.Enabled then exit;
        TIPL.rootnodecount := TIPL.rootnodecount + 1;
				P := TIPL.GetNodeData(TIPL.GetLast);
        P.Empty := true;
end;

procedure TEditor.TMCLFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
 with Sender do
  begin
    if Assigned(Node) and (Node <> RootNode) then
    begin
      EditNode(Node, Column);
    end;
	end;
end;

procedure TEditor.TIPLEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var Allowed: Boolean);
begin
        Allowed := true
end;

procedure TEditor.TIPLNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; Text: WideString);
var     p:PRoleRec;
begin
        P := Sender.GetNodeData(Node);
        case Column of
                0:p.Role := Text;
                1:p.Name := Text
        end;
        P.Empty := ((trim(p.Role) = '-') or (trim(p.Role) = '')) and ((trim(p.Name) = '-') or (trim(p.Name) = ''))
end;

procedure TEditor.TIPLInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var     p:PRoleRec;
begin
        P := Sender.GetNodeData(Node);
        if P.Empty then
                begin
                        p.Role := '';
                        p.Name := ''
								end
end;

{procedure TEditor.SaveMouseOverBackup(Obj: array of Tobject);
var       i:integer;
          p:pointer;
begin
		 if assigned(MOB) then freeAndNil(MOB);
     MOB := TList.create;
     for i:=0 to length(Obj)-1 do
     begin
          p:=doCreateUndo(Obj[i], false, false);
          if assigned(p) then MOB.add(p)
		 end
end;

procedure TEditor.LoadMouseOverBackup;
var       i:integer;
begin
     if not assigned(MOB) then exit;
     for i:=0 to MOB.count-1 do
     begin
          doInternalUndo(MOB.items[i]);
          doDeleteUndo(MOB.items[i])
     end;
		 freeAndNil(MOB);
end;

procedure TEditor.FreeMouseOverBackup(setChanged:boolean);
var       i:integer;
begin
     if not assigned(MOB) then exit;
     for i:=0 to MOB.count-1 do
     begin
          if setChanged then FieldChanged(pUndoRec(MOB.Items[i]).Obj);
          doDeleteUndo(MOB.items[i])
     end;
     freeAndNil(MOB);
end;   }

procedure TEditor.UpdateCopyButtons;
function GetAnyHasTag(tagID: Integer):boolean;
var
	aNode: PVirtualNode;
begin
	result := false;
	aNode := stat.GetFirst;
	while aNode <> nil do
	begin
		case tagID of
			tagID3v1:		result := result or PStatRec(stat.GetNodeData(aNode)).HasV1;
			tagID3v2:		result := result or PStatRec(stat.GetNodeData(aNode)).HasV2;
			tagAPE:			result := result or PStatRec(stat.GetNodeData(aNode)).HasApe;
			tagWMA:			result := result or PStatRec(stat.GetNodeData(aNode)).HasWMA;
			tagOGG:			result := result or PStatRec(stat.GetNodeData(aNode)).HasOgg;
		end;
		aNode := stat.GetNext(aNode)
	end
end;
var
	S: String;
	i, k: Integer;
	Supported: boolean;
	Component: TComponent;
begin
	for i:=low(CopyTagSettings) to high(CopyTagSettings) do
	begin
		S := 'CFROM' + InttoStr(i) + InttoStr(CopyTagSettings[i]);
		TRadioButton(FindComponent(S)).Checked := true;

		if i > tagDB then
		begin
			Supported := GetTagSupported(i) and GetAnyHasTag(i);
			for k:=low(CopyTagSettings) to high(CopyTagSettings) do
				if k <> i then
				begin
					S := 'CFROM' + inttoStr(k) + inttoStr(i);
					Component := FindComponent(S);
					if assigned(Component) then
						TRadioButton(Component).Enabled := Supported
				end
		end
	end;
	//enabler/disabler controls
	for i:=0 to componentcount-1 do
		if components[i] is Tcontrol then
			if components[i].tag >= tagDB then
//			if getSyncCheck(components[i], true) then
				Tcontrol(components[i]).enabled := CopyTagSettings[components[i].tag] = components[i].tag

{		 if not (PageControl1.ActivePageIndex in [0..2]) then exit;

		 if copyTagSettings[PageControl1.ActivePageIndex] = 0 then setBitmap(3, BtnCopyFromDB) else setBitmap(2, BtnCopyFromDB);
		 if copyTagSettings[PageControl1.ActivePageIndex] = 1 then setBitmap(3, BtnCopyFromV1) else setBitmap(2, BtnCopyFromV1);
		 if copyTagSettings[PageControl1.ActivePageIndex] = 2 then setBitmap(3, BtnCopyFromV2) else setBitmap(2, BtnCopyFromV2);

		 if copyTagSettings[1] = 0 then CBHasId3v1Tag.Caption := 'Id3v1 (database)' else
		 if copyTagSettings[1] = 2 then CBHasId3v1Tag.Caption := 'Id3v1 (Id3v2)' else
				CBHasId3v1Tag.caption := 'Id3v1';

		 if copyTagSettings[2] = 0 then CBHasId3v2Tag.Caption := 'Id3v2 (database)' else
		 if copyTagSettings[2] = 1 then CBHasId3v2Tag.Caption := 'Id3v2 (Id3v1)' else
				CBHasId3v2Tag.caption := 'Id3v2';

		 //disabler controls:

		 for i:=0 to componentcount-1 do
				 if components[i] is Tcontrol then
						if getSyncCheck(components[i], true) then
							 if getCopySettings(components[i].tag-10)>=0 then
									Tcontrol(components[i]).enabled := false else Tcontrol(components[i]).enabled := true }
end;

procedure TEditor.Lyrics3v1Click(Sender: TObject);
begin
				if Lyrics3v1.Checked then Lyrics3v2.Checked := false;
				UpdateCheckBoxes(Sender)
end;

procedure TEditor.Lyrics3v2Click(Sender: TObject);
begin
				if Lyrics3v2.Checked then Lyrics3v1.Checked := false;
				UpdateCheckBoxes(Sender)
end;

function TEditor.getFirstComment:string;
var      aNode:pVirtualNode;
         ws : WideString;
begin
     aNode := CommTree.getfirst;
     if assigned(aNode) then
     begin
          CommTreeGetText(CommTree, aNode, 2, ttNormal, ws);
          result := ws
     end
		 else
         result := ''                      
end;

procedure TEditor.COMMExit(Sender: TObject);
begin
     (sender as TVirtualStringTree).EndEditNode
end;

procedure TEditor.CommDelDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
     Accept := source = CommTree
end;

procedure TEditor.CommTreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
var     p:PcommRec;
begin
     if CommTree.Selected[Node] then
     begin
          COMMlanguage.enabled := true;
					COMMdiz.enabled := true;
          COMMtext.enabled := true;
          TextLabel.enabled := true;
          DizLabel.enabled := true;
          LangLabel.enabled := true;
          P := CommTree.GetNodeData(Node);
          COMMdiz.text := p.Description;
          COMMtext.Text := p.Value;
          if p.Language = -1 then COMMlanguage.text := '' else COMMlanguage.ItemIndex := p.language
     end
     else
     begin
          COMMlanguage.enabled := false;
          COMMdiz.enabled := false;
          COMMtext.enabled := false;
          TextLabel.enabled := false;
          DizLabel.enabled := false;
          LangLabel.enabled := false
     end
end;

procedure TEditor.COMMdizChange(Sender: TObject);
var     p:PcommRec;
        aNode : pVirtualNode;
begin
  if not CommTree.Enabled then exit;
  aNode := CommTree.getFirstSelected;
  if aNode <> nil then
  begin
    P := CommTree.GetNodeData(aNode);
    p.Description := trim(COMMdiz.text);
    P.Empty := ((trim(p.Description) = '-') or (trim(p.Description) = '')) and ((trim(p.Value) = '-') or (trim(p.Value) = '')) and (p.language = -1);
    p.Gray := false;
    CommTree.RepaintNode(aNode)
  end
end;

procedure TEditor.COMMtextChange(Sender: TObject);
var     p:PcommRec;
        aNode : pVirtualNode;
begin
  if not CommTree.Enabled then exit;
  aNode := CommTree.getFirstSelected;
  if aNode <> nil then
  begin
    P := CommTree.GetNodeData(aNode);
    p.Value := trim(COMMtext.text);
    p.Gray := false;
    P.Empty := ((trim(p.Description) = '-') or (trim(p.Description) = '')) and ((trim(p.Value) = '-') or (trim(p.Value) = '')) and (p.language = -1);
    CommTree.RepaintNode(aNode)
  end
end;

procedure TEditor.COMMlanguageClick(Sender: TObject);
var     p:PcommRec;
        aNode : pVirtualNode;
begin
  if not CommTree.Enabled then exit;
  aNode := CommTree.getFirstSelected;
  if aNode <> nil then
  begin
  	P := CommTree.GetNodeData(aNode);
	  if COMMlanguage.text = '' then
    	p.language := -1
    else
			p.language := COMMlanguage.ItemIndex;
	  P.Empty := ((trim(p.Description) = '-') or (trim(p.Description) = '')) and ((trim(p.Value) = '-') or (trim(p.Value) = '')) and (p.language = -1);
    p.Gray := false;
	  CommTree.RepaintNode(aNode)
  end
end;

procedure TEditor.COMMlanguageChange(Sender: TObject);
begin
	if trim(COMMlanguage.Text) = '' then COMMlanguageClick(sender)
end;

procedure TEditor.v2ScrollScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
     panel2.Top := scrollpos * -1
end;

procedure TEditor.ArtistExit(Sender: TObject);
begin
	setBoxValue(sender, cleanString(getBoxValue(sender)), false)
end;

procedure TEditor.TCONCreateEditor(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
begin
	EditLink := TGenresCombo.Create
end;

procedure TEditor.TCONGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
begin
     Text := PGenreRec(sender.getNodeData(Node)).text
end;

procedure TEditor.DelTCONClick(Sender: TObject);
begin
  if not TCON.Enabled then exit;
  TCON.DeleteSelectedNodes;
  createUndo(TCON);
  ShowUndo(TCON)
end;

procedure TEditor.AddTCONClick(Sender: TObject);
begin
     if not TCON.Enabled then exit;
     TCON.RootNodeCount := TCON.RootNodeCount+1;
     TCON.FocusedNode := TCON.GetLast
end;

procedure TEditor.AddGenreClick(Sender: TObject);
begin
     if not genre.Enabled then exit;
     Genre.RootNodeCount := Genre.RootNodeCount+1;
     Genre.FocusedNode := Genre.GetLast
end;

procedure TEditor.DelGenreClick(Sender: TObject);
begin
		 if not genre.Enabled then exit;
		 Genre.DeleteSelectedNodes;
		 FieldChanged(genre)
		 //createUndo(genre)
end;

procedure TEditor.GenreEdited(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
begin
		 //Denne kaldes også fra editboxene i til COMM framen, derfor er NODE og columns nil/0
	FieldChanged(sender)
end;

procedure TEditor.TCONEdited(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
begin
     FieldChanged(sender)
end;

procedure TEditor.COMMlanguageExit(Sender: TObject);
begin
	GenreEdited(CommTree, nil, 0)
end;

procedure TEditor.COMMdizExit(Sender: TObject);
begin
  ArtistExit(sender);
  FieldChanged(CommTree)
end;

procedure TEditor.genreCoverKeyPress(Sender: TObject; var Key: Char);
begin
     FieldChanged(sender)
end;

procedure TEditor.genreCoverMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     FieldChanged(sender)
end;

procedure TEditor.GroupCheckGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var Text: WideString);
begin
		 text := PgroupRec(groupList.Items[PgroupCheckRec(sender.GetNodeData(Node)).index]).name
end;

procedure TEditor.GroupCheckChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var     OldState: TCheckState;
begin
     Allowed := true;
     OldState := sender.CheckState[Node];
     if (OldState = csUnCheckedNormal) and (PgroupCheckRec(sender.getNodeData(Node)).canGray) then
        NewState := csMixedNormal
end;

procedure TEditor.StatGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
procedure StrAdd(var s:WideString; const a:String);
begin
	if length(s) > 0 then
		s := s + ', ' + a
	else s := a
end;
var     SR:PstatRec;
begin
        SR := stat.GetNodeData(Node);
        if column = 0 then CellText := getFText(SR.ref, fFname)
        else
        if column = 1 then
        begin
                if SR.readAble then CellText := 'yes/' else CellText := 'no/';
								if SR.writeAble then CellText := CellText + 'yes' else CellText := CellText + 'no'
        end
        else
        if column = 2 then
				begin
             if pos(#13, SR.Status)>0 then
                  CellText := Q_CopyFrom(SR.status, Q_PosLastStr(#13, SR.status)+1)
             else
								 CellText := SR.Status
				end
				else
        if column = 3 then //changed
        begin
						 CellText := '';
						 if SR.V1Changed then StrAdd(CellText, 'Id3v1');
						 if SR.v2Changed then StrAdd(CellText, 'Id3v2');
						 if SR.ApeChanged then StrAdd(CellText, 'Ape');
						 if SR.WMAChanged then StrAdd(CellText, 'WMA');
						 if SR.OggChanged then StrAdd(CellText, 'Ogg');
        end else
        if column = 4 then //tags
				begin
             CellText := '';
						 if SR.HasV1 then StrAdd(CellText, 'Id3v1');
						 if SR.HasV2 then StrAdd(CellText, 'Id3v2');
						 if SR.HasApe then StrAdd(CellText, 'Ape');
						 if SR.HasWMA then StrAdd(CellText, 'WMA');
						 if SR.HasOgg then StrAdd(CellText, 'Ogg');
        end
end;

procedure TEditor.StatFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var     SR : PstatRec;
        i:integer;
begin
        SR := sender.GetNodeData(Node);
        for i:=0 to length(SR.values)-1 do
            doDeleteUndo(SR.values[i]);
        setLength(SR.values, 0);
        finalize(SR^.values);
        setLength(SR.Status, 0);
        finalize(SR^)
end;

procedure TEditor.StatChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
     //hvis CancelBtn.ModalResult = mrCancel scannes der ikke, og så skal der læses!
     if (CancelBtn.ModalResult = mrCancel) and stat.Selected[Node] then
        ReadMpegInfo.Start
end;

procedure TEditor.GenreFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
     finalize(PgenreRec(sender.getNodeData(Node))^)
end;

procedure TEditor.CommTreeFreeNode(Sender: TBaseVirtualTree;
	Node: PVirtualNode);
begin
     finalize(PcommRec(sender.getNodeData(Node))^)
end;

procedure TEditor.TMCLFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
	finalize(ProleRec(sender.getNodeData(Node))^)
end;

procedure TEditor.SaveGroupsClick(Sender: TObject);
begin
		 fieldChanged(sender)
end;

procedure TEditor.GroupCheckChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
     fieldChanged(sender)
end;

procedure TEditor.LyricsListFreeNode(Sender: TBaseVirtualTree;
	Node: PVirtualNode);
begin
		 finalize(PlyricsRec(sender.GetNodeData(Node))^)
end;

procedure TEditor.LyricsThreadExecute(Sender: TObject;
  Thread: TBMDExecuteThread; var Data: Pointer);
function fixString(s:String):String;
var      i:integer;
begin
		 result := '';
		 for i:=1 to length(s) do
     begin
          if s[i]=#10 then
						 result := result + CRLF
					else if s[i]<>#13 then
               result := result + s[i]
     end
end;

function GetHttpString(const url: String; var output: String): Boolean;
begin
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

	if Thread.Terminated then
  begin
		result := false;
  	exit
  end
end;

var
	httpString, s, Surl, Sartist, Stitle, sTag, StartTag, StopTag:string;
  httpOk: Boolean;
	LR : PlyricsRec;
	aNode:PvirtualNode;
	i, j:integer;
	arr: array of TlyricParseRec;
	list: TList;
begin
	setLength(arr, 0);
  httpString := '';

  try
  	IdHttp.Disconnect;
  except
	end;

	if not ConnectedToInternet then
	begin
		netStatus.caption := 'Not connected';
		GetFromInternet.checked := false
	end
	else
	if Data = nil then
	begin
		GetFromInternet.enabled := false;
		netStatus.caption := 'Connecting...';
		// http://letssingit.com/lyrics/s/shakira/
		Stag := '<TD class=g>';

		// get songs:
		Sartist := trim(artist.text);
		Stitle := trim(title.text);

		Q_ReplaceChar(Sartist, ' ', '-');
		Q_ReplaceText(Sartist, '''', '');
		if length(Sartist)>0 then
		begin
			if Q_IsInteger(Sartist[1]) then
				Surl := ansilowercase('http://letssingit.com/lyrics/0-9/' + Sartist + '/')
			else
				Surl := ansilowercase('http://letssingit.com/lyrics/' + Sartist[1] + '/' + Sartist + '/');

      httpOk := GetHttpString(sUrl, httpString);
      if Thread.Terminated then
      	exit;

			if httpOk and (length(httpString)>0) then
			begin
				setLength(arr, length(arr)+1);
				arr[length(arr)-1].html := httpString;
				arr[length(arr)-1].url := Surl
			end;

			//vender artist om
			if not Thread.Terminated and (Q_StrScan(trim(artist.text), ' ')>0) then
			begin
				netStatus.caption := 'Searching...';
				Sartist := trim(artist.text);
				Sartist := Q_CopyFrom(Sartist, Q_StrRScan(Sartist, ' ')+1) + '-' + Q_CopyRange(Sartist, 1, Q_StrRScan(Sartist, ' ')-1);
				if Q_IsInteger(Sartist[1]) then
					 Surl := ansilowercase('http://letssingit.com/lyrics/0-9/' + Sartist + '/')
				else
						Surl := ansilowercase('http://letssingit.com/lyrics/' + Sartist[1] + '/' + Sartist + '/');
				Q_ReplaceChar(Surl, ' ', '-');

				httpOk := GetHttpString(sUrl, httpString);
      	if Thread.Terminated then
      		exit;

				if httpOk and (length(httpString)>0) then
				begin
					setLength(arr, length(arr)+1);
					arr[length(arr)-1].html := httpString;
					arr[length(arr)-1].url := Surl
				end
			end;

			if length(arr) > 0 then
			begin
				//Der er fundet nogle sange! - lister dem
				list := TList.Create;
				netStatus.caption := 'Parsing...';
				//LyricsList.beginupdate;      //må ikke være der, da det sker i en tråd!
				//LyricsList.Clear;
				for i:=0 to length(arr)-1 do
        begin
          if (length(arr[i].html)>0) and (Q_PosText(Stag, arr[i].html)>0) then
          begin
//            s := Q_CopyFrom(arr[i].html, Q_PosText(Stag, arr[i].html)+length(Stag)+1);
            j := Q_PosText(stag, arr[i].html);
            s := Q_CopyRange(arr[i].html, j, Q_PosText('</TABLE>', arr[i].html, j));
            while length(s)>0 do
            begin
              new(LR);
              LR.loaded := false;
              LR.lyrics := '';
              Q_CutLeft(s, Q_PosText('<A href="', s) +9);
              LR.URL := Q_CopyRange(s, 1, Q_StrScan(s, '"')-1);
              s := Q_CopyFrom(s, length(LR.URL)+1);
              LR.URL := 'http://letssingit.com/' + LR.URL;
              j := Q_PosText('alt="', s) + 5;
              LR.title := Q_CopyRange(s, j, Q_PosText(' - lyrics"></A>', s, j)-1);
              s := trim(Q_CopyFrom(s, length(LR.title) + j + 5));
              if Q_PosText(Stag, s) > 0 then
                s := Q_CopyFrom(s, Q_PosText(Stag, s) + length(sTag))
              else
                s:='';
              if Q_SameText(stitle, LR.title) then
                data := LR;
              list.Add(LR)
            end
          end
        end;
				Thread.Synchronize(FillLyricsList, list);
				list.free;
				if lyricsList.GetFirstSelected <> nil then
					data := lyricsList.GetNodeData(lyricsList.GetFirstSelected)
			end else
			begin
				if not httpOk then netStatus.caption := 'Couldn''t connect/not found' else netStatus.caption := 'No lyrics found';
				getFromInternet.checked := false
			end;
			GetFromInternet.enabled := true
		end
		else netStatus.caption := ''
	end;

	//getLyrics from selectedNode
	if not Thread.Terminated and assigned(data) then
	begin
		LR := data;
		if not LR.loaded then
		begin
			netStatus.caption := 'Connecting...';
      //Changed 15/6/03
			StartTag := '<TABLE width=468><TR><TD><PRE style="font:12px arial">'; //'<TABLE><TR><TD><PRE';
			StopTag := '</PRE></TD></TR></TABLE>'; //'</PRE></TD></TR></TABLE>';

      httpOk := GetHttpString(LR.URL, httpString);
      if Thread.Terminated then
      	exit;

			if httpOk and (length(httpString)>0) and (Q_PosText(StartTag, httpString)>0) then
			begin
				s := Q_CopyFrom(httpString, Q_PosText(StartTag, httpString)+length(startTag));
//				Q_CutLeft(s, Q_StrScan(s, '>'));
				s := Q_CopyRange(s, 0, Q_PosText(StopTag, s)-2);  //virker pr. 5/5-02
				s := fixString(s); //er nødvendig.. kan ikke gøres med Q_ReaplceChar * repText
				LR.lyrics := s;
				LR.loaded := true;
				netStatus.caption := 'Done';
			end
			else
				if not httpOk then
					netStatus.caption := 'Couldn''t connect'
				else
					netStatus.caption := 'Error!'
		end;

		if LR.loaded then
		begin
			aNode := lyricsList.GetFirstselected;
			if (aNode <> nil) and (data = lyricsList.GetNodeData(aNode)) then
			begin
				LyricsMemo.Text := LR.lyrics;
				HasLyrics.checked := true;
				CheckDefaultLyricsVersion
			end
		end;
		screen.Cursor := crDefault
	end;
	setLength(arr, 0)
end;

{
Old method - replaced 1/9-04
procedure TEditor.LyricsThreadExecute(Sender: TObject;
  Thread: TBMDExecuteThread; var Data: Pointer);
function fixString(s:String):String;
var      i:integer;
begin
		 result := '';
		 for i:=1 to length(s) do
     begin
          if s[i]=#10 then
						 result := result + CRLF
					else if s[i]<>#13 then
               result := result + s[i]
     end
end;

function GetHttpString(const url: String; var output: String): Boolean;
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

	if Thread.Terminated then
  begin
		result := false;
  	exit
  end
end;

var
	httpString, s, Surl, Sartist, Stitle, sTag, StartTag, StopTag:string;
  httpOk: Boolean;
	LR : PlyricsRec;
	aNode:PvirtualNode;
	i:integer;
	arr: array of TlyricParseRec;
	list: TList;
begin
	setLength(arr, 0);

  try
  	IdHttp.Disconnect;
  except
	end;

	if not ConnectedToInternet then
	begin
		netStatus.caption := 'Not connected';
		GetFromInternet.checked := false
	end
	else
	if Data = nil then
	begin
		GetFromInternet.enabled := false;
		netStatus.caption := 'Connecting...';
		// http://letssingit.com/lyrics/s/shakira/
		Stag := '<LI><A HREF=';

		// get songs:
		Sartist := trim(artist.text);
		Stitle := trim(title.text);

		Q_ReplaceChar(Sartist, ' ', '-');
		Q_ReplaceText(Sartist, '''', '');
		if length(Sartist)>0 then
		begin
			if Q_IsInteger(Sartist[1]) then
				Surl := ansilowercase('http://letssingit.com/lyrics/0-9/' + Sartist + '/')
			else
				Surl := ansilowercase('http://letssingit.com/lyrics/' + Sartist[1] + '/' + Sartist + '/');

      httpOk := GetHttpString(sUrl, httpString);
      if Thread.Terminated then
      	exit;

			if httpOk and (length(httpString)>0) then
			begin
				setLength(arr, length(arr)+1);
				arr[length(arr)-1].html := httpString;
				arr[length(arr)-1].url := Surl
			end;

			//vender artist om
			if not Thread.Terminated and (Q_StrScan(trim(artist.text), ' ')>0) then
			begin
				netStatus.caption := 'Searching...';
				Sartist := trim(artist.text);
				Sartist := Q_CopyFrom(Sartist, Q_StrRScan(Sartist, ' ')+1) + '-' + Q_CopyRange(Sartist, 1, Q_StrRScan(Sartist, ' ')-1);
				if Q_IsInteger(Sartist[1]) then
					 Surl := ansilowercase('http://letssingit.com/lyrics/0-9/' + Sartist + '/')
				else
						Surl := ansilowercase('http://letssingit.com/lyrics/' + Sartist[1] + '/' + Sartist + '/');
				Q_ReplaceChar(Surl, ' ', '-');

				httpOk := GetHttpString(sUrl, httpString);
      	if Thread.Terminated then
      		exit;

				if httpOk and (length(httpString)>0) then
				begin
					setLength(arr, length(arr)+1);
					arr[length(arr)-1].html := httpString;
					arr[length(arr)-1].url := Surl
				end
			end;

			if length(arr) > 0 then
			begin
				//Der er fundet nogle sange! - lister dem
				list := TList.Create;
				netStatus.caption := 'Parsing...';
				//LyricsList.beginupdate;      //må ikke være der, da det sker i en tråd!
				//LyricsList.Clear;
				for i:=0 to length(arr)-1 do
				if (length(arr[i].html)>0) and (Q_PosText(Stag, arr[i].html)>0) then
				begin
					s := Q_CopyFrom(arr[i].html, Q_PosText(Stag, arr[i].html)+length(Stag)+1);
					s := Q_CopyRange(s, 1, Q_PosText('</TABLE>', s));
					while length(s)>0 do
					begin
						new(LR);
						LR.loaded := false;
						LR.lyrics := '';
						LR.URL := Q_CopyRange(s, 1, Q_StrScan(s, '"')-1);
						s := Q_CopyFrom(s, length(LR.URL)+3);
						LR.URL := 'http://letssingit.com' + LR.URL;// arr[i].url + LR.URL;
						LR.title := Q_CopyRange(s, 1, Q_PosText('</A>', s)-1);
						s := trim(Q_CopyFrom(s, length(LR.title)+6));
						if Q_PosText(Stag, s) > 0 then
							s := Q_CopyFrom(s, Q_PosText(Stag, s) + length(sTag)+1)
						else
							s:='';
						if Q_SameText(stitle, LR.title) then
							data := LR;
						list.Add(LR)
					end
				end;
				Thread.Synchronize(FillLyricsList, list);
				list.free;
				if lyricsList.GetFirstSelected <> nil then
					data := lyricsList.GetNodeData(lyricsList.GetFirstSelected)
			end else
			begin
				if not httpOk then netStatus.caption := 'Couldn''t connect/not found' else netStatus.caption := 'No lyrics found';
				getFromInternet.checked := false
			end;
			GetFromInternet.enabled := true
		end
		else netStatus.caption := ''
	end;

	//getLyrics from selectedNode
	if not Thread.Terminated and assigned(data) then
	begin
		LR := data;
		if not LR.loaded then
		begin
			netStatus.caption := 'Connecting...';
      //Changed 15/6/03
			StartTag := '<TABLE width=468><TR><TD><PRE style="font:12px arial">'; //'<TABLE><TR><TD><PRE';
			StopTag := '</PRE></TD></TR></TABLE>'; //'</PRE></TD></TR></TABLE>';

      httpOk := GetHttpString(LR.URL, httpString);
      if Thread.Terminated then
      	exit;

			if httpOk and (length(httpString)>0) and (Q_PosText(StartTag, httpString)>0) then
			begin
				s := Q_CopyFrom(httpString, Q_PosText(StartTag, httpString)+length(startTag));
//				Q_CutLeft(s, Q_StrScan(s, '>'));
				s := Q_CopyRange(s, 0, Q_PosText(StopTag, s)-2);  //virker pr. 5/5-02
				s := fixString(s); //er nødvendig.. kan ikke gøres med Q_ReaplceChar * repText
				LR.lyrics := s;
				LR.loaded := true;
				netStatus.caption := 'Done';
			end
			else
				if not httpOk then
					netStatus.caption := 'Couldn''t connect'
				else
					netStatus.caption := 'Error!'
		end;

		if LR.loaded then
		begin
			aNode := lyricsList.GetFirstselected;
			if (aNode <> nil) and (data = lyricsList.GetNodeData(aNode)) then
			begin
				LyricsMemo.Text := LR.lyrics;
				HasLyrics.checked := true;
				CheckDefaultLyricsVersion
			end
		end;
		screen.Cursor := crDefault
	end;
	setLength(arr, 0)
end;}

procedure TEditor.CheckDefaultLyricsVersion;
begin
	if not tagLyrics.checked and not lyrics3v1.checked and not lyrics3v2.checked then
  	if CBhasId3v2Tag.checked then tagLyrics.checked := true else lyrics3v2.checked := true
end;

procedure TEditor.LyricsListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
begin
     CellText := PlyricsRec(sender.GetNodeData(Node)).title
end;

procedure TEditor.LyricsListDblClick(Sender: TObject);
var
	LR : PlyricsRec;
	aNode : PvirtualNode;
begin
	aNode := lyricsList.GetFirstselected;
	if aNode <> nil then
	begin
		screen.Cursor := crAppStart;
		LR := lyricsList.GetNodeData(aNode);
		LyricsThread.Start(LR)
	end
end;

procedure TEditor.LyricsListCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
begin
	result := Q_compText(PLyricsRec(sender.GetNodeData(Node1)).title, PLyricsRec(sender.GetNodeData(Node2)).title) 
end;

procedure TEditor.GetFromInternetClick(Sender: TObject);
var       aNode:PVirtualNode;
begin
	if GetFromInternet.checked then
	begin
		LyricsThread.Start(nil);
		LyricsThread.Thread.waitFor;
		aNode := lyricsList.GetFirstselected;
			if (aNode <> nil) and (length(trim(LyricsMemo.text))=0) then LyricsThread.Start(LyricsList.getNodeData(aNode))
	end
end;

procedure TEditor.PageControl1Change(Sender: TObject);
begin
	if Pref.ID3_EnableOnTabChange.checked and (PageControl1.ActivePageIndex in [tagId3v1-10..tagMAX-10]) then
		if HasTagCheckboxes[PageControl1.ActivePageIndex + 10].Enabled and (HasTagCheckboxes[PageControl1.ActivePageIndex + 10].state = cbUnchecked) then
		begin
			HasTagCheckboxes[PageControl1.ActivePageIndex + 10].State := cbChecked;
			if Pref.Id3_AutoCopyFromDB.checked then
				copyTagSettings[PageControl1.ActivePageIndex + 10] := tagDB
		end;
	UpdateCheckBoxes(sender)
end;

procedure TEditor.CancelBtnClick(Sender: TObject);
begin
	if saveThread.Runing then
  	saveThread.Thread.terminate;
  if ReadMpegInfo.Runing then
  	ReadMpegInfo.Thread.Terminate
end;

procedure TEditor.CFROM_Click(Sender: TObject);
var
	Source, Target: Integer;
	S: String;
begin
	S := TControl(Sender).Name;
	Target := StrToInt(S[6] + S[7]);
	Source := StrToInt(S[8] + S[9]);
	CopyTagSettings[Source] := Source;
	CopyTagSettings[Target] := Source;

	UpdateChangedCaption;
	UpdateCopyButtons
end;

procedure TEditor.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
	Resize := NewWidth = Width
end;

procedure TEditor.readFileThreadExecute(Sender: TObject; Thread: TBMDExecuteThread; var Data: Pointer);
var
	FillInfoRec : PFillInValueProcedureInfo;
begin
	FillInfoRec := data;
	FillInValues(Thread, FillInfoRec.Pr, FillInfoRec.pSR, FillInfoRec.firstRun, FillInfoRec.updateStats, FillInfoRec.useFileWriteBeginEnd)
end;


procedure TEditor.FillLyricsList(Sender: TBMDThread;
  Thread: TBMDExecuteThread; var Data: Pointer);
var
	list: TList;
	LR1, LR2: PlyricsRec;
	aNode, matchNode: PVirtualNode;
	i: Integer;
begin
	list := Data;
	matchNode := nil;
	with Lyricslist do
	begin
		beginupdate;
		for i:=0 to list.count-1 do
		begin
			aNode := addChild(nil);
			LR1 := list.Items[i];
			LR2 := getNodeData(aNode);
			LR2.title := LR1.title;
			LR2.URL := LR1.URL;
			LR2.loaded := LR1.Loaded;
			LR2.lyrics := LR1.Lyrics;

			if Q_SameText(LR1.title, title.text) then
				matchNode := aNode;
			dispose(LR1)
		end;
		SortTree(0, sdAscending);
		Endupdate;

		if assigned(matchNode) then
		begin
			Selected[matchNode] := true;
			FocusedNode := matchNode
		end
		else
		begin
			if RootNodeCount = 0 then
				netStatus.caption := 'No lyrics found'
			else
				netStatus.caption := 'Song not found'
		end
	end
end;

procedure TEditor.SaveThreadExecute(Sender: TObject; Thread: TBMDExecuteThread; var Data: Pointer);
procedure removeGroupFromRec(p:pointer; index:integer);
var       i,x:integer;
          r:Prec;
begin
  r := p;
  i:=0;
  while i < length(r.groups) do
  begin
    if r.Groups[i] = index then
    begin
    	for x:=i to length(r.groups)-2 do
      	r.Groups[x] := r.groups[x+1];
      setLength(r.Groups, length(r.Groups)-1)
    end
    else
    	inc(i)
  end
end;

procedure addGroupToRec(p:pointer; index:integer);
var
	found:boolean;
  i:integer;
begin
  found := false;
  for i:=0 to length(pRec(p).groups)-1 do
   found := found or (index = pRec(p).groups[i]);

  if not found then
  begin
    setLength(pRec(p).groups, length(pRec(p).groups)+1);
    pRec(p).groups[length(pRec(p).groups)-1] := index
  end
end;

procedure updateSRvalues(SR:PstatRec; useFileWriteBeginEnd: Boolean = true);
var       i:integer;
begin
  for i:=0 to length(SR.values)-1 do
    doDeleteUndo(SR.values[i]);
  setLength(SR.values, 0);
  FillInValues(Thread, SR.ref, SR, false, false, useFileWriteBeginEnd)
end;

function groupChanged(old, new : array of byte):boolean;
var      i:integer;
begin
  if length(old) = length(new) then
  begin
    result := false;
    for i:=0 to length(old)-1 do result := result or (old[i] <> new[i])
  end else result := true
end;

procedure PackValues(pSR:pointer);
var       SR:PstatRec;
          i, x:integer;
begin
  SR := pSR;
  for i:=length(SR.values)-1 downto 0 do
    if SR.values[i] = nil then
    begin
      for x:=i to length(SR.values)-2 do
          SR.values[x] := SR.values[x+1];
      setLength(SR.values, length(SR.values)-1)
    end
end;
////MAIN////    SaveThreadExecute
var
	aNode, sNode : PVirtualNode;
	temp : Word;
	DBchanged, failed, OpenFileStream : Boolean;
	Kill: array[low(HasTagCheckboxes)..high(HasTagCheckboxes)] of Boolean;
	Save: array[low(HasTagCheckboxes)..high(HasTagCheckboxes)] of Boolean;
	i, index, j, k : Integer;
	Tsize, car : Cardinal;
	Fstr, MStr : TStream;
	Ch : Char;
  bt: Byte;
	r : PRec;
	SR : PstatRec;
	genreRec : PgenreRec;
  CustomFieldRec: PCustomFieldRec;
  tfRec: PTagFieldRec;
	value, s: string;
  wsValue, ws: wideString;
	start:Dword;
	UsePadding, Existed:Boolean;
	CF:String;  //CurrentFilename
	GR : PgroupCheckRec;
	oldcompilation:boolean;
	oldGroups : array of byte;
  bArr1, bArr2: array of boolean;

  id3v2: TMyID3Controller;
  version: TJvId3Version;

begin            // SaveThreadExecute
  failed := false;
  dbChanged := false;

  try
    sNode := stat.GetFirst;
    while assigned(sNode) do
    begin
    	if Thread.Terminated then
      begin
      	failed := true;
        break
      end;

      stat.ClearSelection;
      stat.Selected[sNode] := true;
      stat.FullyVisible[sNode] := true;

      SR := stat.GetNodeData(sNode);
      R := SR.ref;
      CF := GetFtext(R, fFilename);

      //Kill:
      Kill[tagId3v1] := SR.HasV1 and (CBhasId3v1Tag.state = cbUnchecked) and SR.writeAble;
      Kill[tagId3v2] := SR.HasV2 and ((CBhasId3v2Tag.state = cbUnchecked) or (pref.StripId3v2FromUnsupported.Checked and not GetTagSupported(tagId3v2, SR))) and SR.writeAble;
      Kill[tagApe] := SR.HasApe and (CBhasApeTag.state = cbUnchecked) and SR.writeAble;
      Kill[tagWMA] := SR.HasWMA and (CBhasWMATag.state = cbUnchecked) and SR.writeAble;
      Kill[tagOgg] := SR.HasOgg and (CBhasOggTag.state = cbUnchecked) and SR.writeAble;

      //Save
      for i:=low(Save) to high(Save) do
        Save[i] := not Kill[i] and GetTagSupported(i, SR) and getHasTagVerChanged(i, SR) and SR.writeAble;

      DBchanged := false;

      BeginSetArtistAlbumFilename;
      try
        // BEGIN Save til database:
        if lyricsChanged(SR, false) then
        	if length(Trim(LyricsMemo.Text))>0 then
          	Include(r.Flags, rfHasLyrics)
          else
          	Exclude(r.Flags, rfHasLyrics);

        if HasChanged(track, SR) then
        begin
          DBchanged := true;
          value := track.text;
          UpdateStringValueTabSync(SR, track, value);
          if Q_IsInteger(value) then
          begin
          	k := strToInt(value);
            if (k >= 0) and (k < high(word)) then
	            R.track := k
          end
          else
	          R.track := 0
        end;
        if HasChanged(TotalTracks, SR) then
        begin
          DBchanged := true;
          value := totalTracks.text;
          UpdateStringValueTabSync(SR, totalTracks, value);
          if Q_IsInteger(value) then
          begin
          	k := strtoint(value);
            if (k >= 0) and (k < high(word)) then
	            R.totalTracks := k
          end
          else
	          R.totalTracks := 0
        end;
        if HasChanged(artist, SR) then
        begin
          DBchanged := true;
          value := artist.text;
          UpdateStringValueTabSync(SR, artist, value);
          MainFormInstance.setArtist(R, Value)
        end;
        if HasChanged(ArtistSortOrder, SR) then
        begin
        	DBchanged := true;
          value := ArtistSortOrder.text;
          MainFormInstance.SetArtistSortOrder(R, value)
        end;
        if HasChanged(title, SR) then
        begin
             DBchanged := true;
             value := title.text;
             UpdateStringValueTabSync(SR, title, value);
             SetPCharString(R.Title, value)
//             R.Title := value
        end;
        if HasChanged(album, SR) then
        begin
             DBchanged := true;
             value := album.text;
             UpdateStringValueTabSync(SR, album, value);
             R.Album := MainFormInstance.GetAlbumID(value)
        end;
        if HasChanged(year, SR) then
        begin
             DBchanged := true;
             value := year.text;
             UpdateStringValueTabSync(SR, year, value);
             if Q_IsInteger(value) then
              R.Year := strtoint(value) else R.year := 0
        end;
        if HasChanged(Comment, SR) then
        begin
          DBchanged := true;
          value := comment.text;
          UpdateStringValueTabSync(SR, comment, value);
          R.Comment := value
        end;
        //gemmer genre
        if HasChanged(Genre, SR) then
        begin
          DBchanged := true;
          SaveDBGenre(SR, r)
        end;

        //Part
        if HasChanged(PartOfSet, SR) then
        begin
         	DBChanged := true;
          value := PartOfSet.text;
          UpdateStringValueTabSync(SR, PartOfSet, value);
          if Q_IsInteger(value) then
          	MainFormInstance.SetPartOfSet(R, StrToInt(value))
          else
          	MainFormInstance.SetPartOfSet(R, 0)
        end;

        if HasChanged(TotalParts, SR) then
        begin
         	DBChanged := true;
          value := TotalParts.text;
          UpdateStringValueTabSync(SR, TotalParts, value);
          if Q_IsInteger(value) then
          	MainFormInstance.SetTotalParts(R, StrToInt(value))
          else
          	MainFormInstance.SetTotalParts(R, 0)
        end;

        //CustomFields
        aNode := CustomFieldTree.GetFirst;
        while aNode <> nil do
        begin
        	CustomFieldRec := CustomFieldTree.GetNodeData(aNode);
        	if CustomFieldChanged(CustomFieldRec, SR) then
          begin
          	MainFormInstance.SetCustomFieldData(R, CustomFieldRec.FieldIndex, CustomFieldRec.value);
            dbChanged := true
          end;
          aNode := CustomFieldTree.GetNext(aNode)
        end;

        DBchanged := DBchanged or HasChanged(GroupCheck, SR) or HasChanged(CBcompilation, SR);
        // Gemmer groups:
        //gamle:
        setLength(oldGroups, length(R.groups));
        for i:=0 to length(R.groups)-1 do oldGroups[i] := R.groups[i];
        //eoGamle
        aNode := groupCheck.GetFirst;
        while aNode <> nil do
        begin
          GR := groupCheck.GetNodeData(aNode);
          if (groupCheck.CheckState[aNode] = csCheckedNormal) and not MainFormInstance.hasGroup(R.groups, GR.index) then
            addGroupToRec(R, GR.index);
          if (groupCheck.CheckState[aNode] = csUnCheckedNormal) and MainFormInstance.hasGroup(R.groups, GR.index) then
            removeGroupFromRec(R, GR.index);
          aNode := groupCheck.getNext(aNode)
        end;
        if CBcompilation.State = cbChecked then Include(R.Flags, rfCompilation);
        if CBcompilation.State = cbUnChecked then Exclude(R.Flags, rfCompilation);
        //END OF save til database
      finally
        EndSetArtistAlbumFilename
      end;

      OpenFileStream := SR.WriteAble and LyricsChanged(SR);
      if SR.WriteAble then
        for i:=low(Kill) to high(Kill) do
          OpenFileStream := OpenFileStream or Kill[i] or Save[i];

      if OpenFileStream then                                
      begin
        MainFormInstance.BeginWriteToFile(r);
        FStr := TFilestream.Create(CF, fmOpenReadWrite or fmShareDenyNone)
      end
      else
        Fstr := nil;

      if Kill[tagId3v2] and SR.writeAble then
      begin
        BeginUseId3v2;
        try
          id3v2 := TMyID3Controller.Create (nil);
          id3v2.RemoveFromStream(Fstr);
          id3v2.Free;
          AddToStat(Thread, SR, 'Id3v2 stripped');
          SR.HasV2 := false;
          SR.v2Changed := false;
          Exclude(r.Flags, rfHasId3v2)
        finally
          EndUseId3v2
        end
      end;    //of KillV2

      if Save[tagId3v2] and SR.writeAble then
      begin
        BeginUseId3v2;
        try
          id3v2 := TMyID3Controller.Create(nil);
          try
            id3v2.LoadFromStream(Fstr);

            if id3v23.checked then
            begin
              version := ive2_3;
              id3v2.WriteVersionAs := ifv2_3
            end
            else if id3v24.checked then
            begin
              version := ive2_4;
              id3v2.WriteVersionAs := ifv2_4
            end
            else
            begin
              if not SR.HasV2 or not (SR.Id3V2ver in [ive2_3, ive2_4]) then
              begin
                // use 2.4 as default
                version := ive2_4;
                SR.Id3V2ver := version;
                id3v2.WriteVersionAs := ifv2_4
              end
              else
              begin
                version := SR.Id3V2ver;
                id3v2.WriteVersionAs := ifvDontCare
              end
            end;

            for i:=0 to v2Components.count-1 do
              if HasChanged(v2Components.items[i], SR) then
                SaveV2Frame (id3v2, v2Components.items[i].name, SR, version);

            if lyricsChanged(SR, true) then
              SaveV2Frame(id3v2, 'USLT', SR, version);
            if HasChanged(saveGroups, SR) then
              SaveV2Frame(id3v2, SaveGroups.Name, SR, version);

            try
              id3v2.SaveToStream(Fstr);
              AddToStat(Thread, SR, 'Id3v2 saved');

              SR.HasV2 := true;
              SR.Id3V2ver := version;
              SR.v2Changed := false;
              SR.MpegDataStartPos := id3v2.TagSize + 10;  // 10 = size of header
              Include(r.Flags, rfHasId3v2)
            except
              on ex: Exception do
                begin
                  AddToStat(Thread, SR, 'Error saving id3v2: ' + ex.Message);
                  failed := true;
                end
            end;
          finally
            id3v2.free;
          end
        finally
          EndUseId3v2
        end
      end; //of SaveV2

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											APE
      if Kill[tagApe] and SR.writeAble then
      begin
        FApe := TApeTag.Create;
        FApe.ReadFromStream(FStr);
        if FApe.RemoveFromStream(Fstr) then
        begin
          SR.HasApe := false;
          SR.ApeChanged := false;
          AddToStat(Thread, SR, 'Ape stripped');
          Exclude(r.Flags, rfHasApeTag)
        end;
        FApe.free
      end;

      if Save[tagApe] and SR.writeAble then
      begin
        FApe := TApeTag.Create;
        FApe.ReadFromStream(FStr);

        if HasChanged(ApeArtist, SR) then
        begin
          value := ApeArtist.text;
          UpdateStringValueTabSync(SR, ApeArtist, value);
          FApe.Artist    := value
        end;

        if HasChanged(ApeArtistSortOrder, SR) then
        begin
        	value := ApeArtistSortOrder.text;
          UpdateStringValueTabSync(SR, ApeArtistSortOrder, value);

					index := FApe.GetKeyIndex('ArtistSortOrder');
          if index >= 0 then
          	FApe.AddList.Delete(index);

          if (length(value) > 0) and not Q_SameStr(theFix(value), theFix(FApe.Artist)) then
						FApe.AddKeyToAddList('ArtistSortOrder', value)
        end;

        if HasChanged(ApeTitle, SR) then
        begin
          value := ApeTitle.text;
          UpdateStringValueTabSync(SR, ApeTitle, value);
          FApe.Title := value
        end;

        if HasChanged(ApeAlbum, SR) then
        begin
          value := ApeAlbum.text;
          UpdateStringValueTabSync(SR, ApeAlbum, value);
          FApe.Album    := value
        end;

        if HasChanged(ApeYear, SR) then
        begin
          value := ApeYear.text;
          UpdateStringValueTabSync(SR, ApeYear, value);
          FApe.Year    := value
        end;

        if HasChanged(ApeGenre, SR) then
        begin
          value := ApeGenre.text;
          UpdateStringValueTabSync(SR, ApeGenre, value);
          FApe.Genre    := value
        end;

        if HasChanged(ApeComment, SR) then
        begin
          value := ApeComment.text;
          UpdateStringValueTabSync(SR, ApeComment, value);
          FApe.Comment    := value
        end;

        if HasChanged(ApeTrack, SR) then
        begin
          i := MainFormInstance.GetTotalTracksInt(FApe.Track);
          value := ApeTrack.text;
          UpdateStringValueTabSync(SR, ApeTrack, value);
          if Q_Isinteger(value) then
            FApe.Track    := MainFormInstance.GetTrackString(StrToInt(Value), i)
          else
          	FApe.Track := MainFormInstance.GetTrackString(0, i)
        end;

        if HasChanged(ApeTotalTracks, SR) then
        begin
          i := MainFormInstance.GetTrackNoInt(FApe.Track);
          value := ApeTotalTracks.text;
          UpdateStringValueTabSync(SR, ApeTotalTracks, value);
          if Q_Isinteger(value) then
            FApe.Track := MainFormInstance.GetTrackString(i, StrToInt(Value))
          else
          	FApe.Track := MainFormInstance.GetTrackString(i, 0)
        end;

        //Part of set
        if HasChanged(ApePartOfSet, SR) then
        begin
//         	DBChanged := true;
          value := ApePartOfSet.text;
          UpdateStringValueTabSync(SR, ApePartOfSet, value);

          //Get existing
          bt := 0;
          index := FApe.GetKeyIndex('PartOfSet');
          if index >= 0 then
          begin
          	FApe.GetAddListKeyName(index, s);
            MainFormInstance.SetPartOfSetFromString(bt, s);
            //Remove existing
            FApe.DeleteFromAddlist(index);
          end;

          if Q_IsInteger(value) then
          	MainFormInstance.SetPartOfSet(bt, StrToInt(value))
          else
          	MainFormInstance.SetPartOfSet(bt, 0);

          if bt > 0 then
          	FApe.AddKeyToAddList('PartOfSet', MainFormInstance.GetPartsString(bt))
        end;
        //Total parts in set
        if HasChanged(ApeTotalParts, SR) then
        begin
//         	DBChanged := true;
          value := ApeTotalParts.text;
          UpdateStringValueTabSync(SR, ApeTotalParts, value);

          //Get existing
          bt := 0;
          index := FApe.GetKeyIndex('PartOfSet');
          if index >= 0 then
          begin
          	FApe.GetAddListKeyName(index, s);
            MainFormInstance.SetPartOfSetFromString(bt, s);
            //Remove existing
            FApe.DeleteFromAddlist(index);
          end;

          if Q_IsInteger(value) then
          	MainFormInstance.SetTotalParts(bt, StrToInt(value))
          else
          	MainFormInstance.SetTotalParts(bt, 0);

          if bt > 0 then
          	FApe.AddKeyToAddList('PartOfSet', MainFormInstance.GetPartsString(bt))
        end;

        if HasChanged(ApeOtherFields, SR) then
        begin
					SetLength(bArr1, FApe.AddList.Count);	//if false, the existing field is deleted from the tag
          for i:=0 to length(bArr1)-1 do bArr1[i] := false;

          SetLength(bArr2, apeOtherFields.RootNodeCount);	//if false, a new field is added to the tag
          for i:=0 to length(bArr2)-1 do bArr2[i] := false;

          //Enumerate existing fields to see if any should be deleted or added
          for i:=0 to FApe.AddList.Count-1 do
          begin
          	s := fApe.GetAddListKeyName(i, value);
            if Q_SameText(s, 'PartOfSet') or Q_SameText(s, 'ArtistSortOrder') or Q_SameText(s, ApeOggGroupIdent) or Q_SameText(s, ApeOggCompilationIdent) or Q_SameText(s, ApeOggWmaRatingIdent) then
            	bArr1[i] := true
            else
            begin
            	aNode := apeOtherFields.GetFirst;
              while aNode <> nil do
              begin
              	tfRec := apeOtherFields.GetNodeData(aNode);
                if Q_SameText(s, tfRec.fieldName) then
                begin
                	bArr1[i] := true;
                  bArr2[aNode.Index] := true;
                	if not tfRec.gray and not Q_SameStr(tfRec.value, value) then
                  	fape.SetAddListValue(i, tfRec.Value)
                end;
                aNode := apeOtherFields.GetNext(aNode)
	            end
             end
          end;

          //Removing those who should be deleted
          for i:=fape.AddList.count-1 downto 0 do
          	if not bArr1[i] then fape.DeleteFromAddlist(i);

          //Adding new
          aNode := apeOtherFields.GetFirst;
          while aNode <> nil do
          begin
            if not bArr2[aNode.Index] then
            begin
              tfRec := apeOtherFields.GetNodeData(aNode);
              fape.AddKeyToAddList(tfRec.FieldName, tfRec.Value)
            end;
            aNode := apeOtherFields.GetNext(aNode)
          end
        end;

        if lyricsChanged(SR, true) then
        begin
          FApe.Lyrics := lyricsMemo.Text;
        end;

        //checker groups + compilation
        MainFormInstance.SaveAPEprivateFrame(FApe, R, SaveGroups.Checked);

        if AudioTypes[R.AudioType].ApeV2 then
          i := 2000 //Ape version 2
        else i := 1000; //Ape version 1
        if FApe.SaveToStream(FStr, i) then
        begin
          SR.HasApe := true;
          SR.ApeChanged := false;
          AddToStat(Thread, SR, 'Ape saved');
          Include(r.Flags, rfHasApeTag)
        end
        else AddToStat(Thread, SR, 'Error saving Ape tag');
        FApe.free;
      end;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											WMA
    if Kill[tagWMA] and SR.writeAble then
      begin
        FWMA := TWMAfile.Create;
        FWMA.ReadFromStream(FStr);
        if FWMA.WriteToStream(Fstr, true) then    //removetag
        begin
          SR.HasWMA := false;
          SR.WMAChanged := false;
          AddToStat(Thread, SR, 'WMA stripped');
          Exclude(r.Flags, rfHasWmaTag)
        end;
        FWMA.free
      end;

      if Save[tagWMA] and SR.writeAble then
      begin
        FWMA := TWMAfile.Create;
        FWMA.ReadFromStream(FStr);

        if HasChanged(WMAArtist, SR) then
        begin
          value := WMAArtist.text;
          UpdateStringValueTabSync(SR, WMAArtist, value);
          FWMA.Artist    := value
        end;

        if HasChanged(WMAArtistSortOrder, SR) then
        begin
        	value := WMAArtistSortOrder.text;
          UpdateStringValueTabSync(SR, WMAArtistSortOrder, value);

					index := FWMA.GetKeyIndex('WM/ArtistSortOrder');
          if index >= 0 then
          	FWMA.AddList.Delete(index);

          if (length(value) > 0) and not Q_SameStr(theFix(value), theFix(FWMA.Artist)) then
						FWMA.AddKeyToAddList('WM/ArtistSortOrder', value)
        end;

        if HasChanged(WMATitle, SR) then
        begin
          value := WMATitle.text;
          UpdateStringValueTabSync(SR, WMATitle, value);
          FWMA.Title    := value
        end;

        if HasChanged(WMAAlbum, SR) then
        begin
          value := WMAAlbum.text;
          UpdateStringValueTabSync(SR, WMAAlbum, value);
          FWMA.Album    := value
        end;

        if HasChanged(WMAYear, SR) then
        begin
          value := WMAYear.text;
          UpdateStringValueTabSync(SR, WMAYear, value);
          FWMA.Year    := value
        end;

        if HasChanged(WMAGenre, SR) then
        begin
          value := WMAGenre.text;
          UpdateStringValueTabSync(SR, WMAGenre, value);
          FWMA.Genre    := value
        end;

        if HasChanged(WMAComment, SR) then
        begin
          value := WMAComment.text;
          UpdateStringValueTabSync(SR, WMAComment, value);
          FWMA.Comment    := value
        end;

        if HasChanged(WMATrack, SR) then
        begin
          value := WMATrack.text;
          UpdateStringValueTabSync(SR, WMATrack, value);
          if Q_Isinteger(value) then
            FWMA.Track    := StrToInt(Value)
          else FWMA.Track := 0
        end;

        if HasChanged(WMARating, SR) then
        begin
          value := WMARating.text;
          UpdateStringValueTabSync(SR, WMARating, value);
          FWMA.Rating    := value
        end;

        if HasChanged(WMACopyright, SR) then
        begin
          value := WMACopyright.text;
          UpdateStringValueTabSync(SR, WMACopyright, value);
          FWMA.Copyright    := value
        end;

        if HasChanged(WMAAlbumCover, SR) then
        begin
          value := WMAAlbumCover.text;
          UpdateStringValueTabSync(SR, WMAAlbumCover, value);
          FWMA.AlbumCoverURL    := value
        end;

        if HasChanged(WMAPromotion, SR) then
        begin
          value := WMAPromotion.text;
          UpdateStringValueTabSync(SR, WMAPromotion, value);
          FWMA.PromotionURL    := value
        end;

        //Part of set
        if HasChanged(WMAPartOfSet, SR) then
        begin
//         	DBChanged := true;
          value := WMAPartOfSet.text;
          UpdateStringValueTabSync(SR, WMAPartOfSet, value);

          //Get existing
          bt := 0;
          index := FWMA.GetKeyIndex('WM/PartOfSet');
          if index >= 0 then
          begin
          	FWMA.GetAddListKeyName(index, ws);
            MainFormInstance.SetPartOfSetFromString(bt, ws);
            //Remove existing
            FWMA.DeleteFromAddlist(index);
          end;

          if Q_IsInteger(value) then
          	MainFormInstance.SetPartOfSet(bt, StrToInt(value))
          else
          	MainFormInstance.SetPartOfSet(bt, 0);

          if bt > 0 then
          	FWMA.AddKeyToAddList('WM/PartOfSet', MainFormInstance.GetPartsString(bt))
        end;
        //Total parts in set
        if HasChanged(WMATotalParts, SR) then
        begin
//         	DBChanged := true;
          value := WMATotalParts.text;
          UpdateStringValueTabSync(SR, WMATotalParts, value);

          //Get existing
          bt := 0;
          index := FWMA.GetKeyIndex('WM/PartOfSet');
          if index >= 0 then
          begin
          	FWMA.GetAddListKeyName(index, ws);
            MainFormInstance.SetPartOfSetFromString(bt, ws);
            //Remove existing
            FWMA.DeleteFromAddlist(index);
          end;

          if Q_IsInteger(value) then
          	MainFormInstance.SetTotalParts(bt, StrToInt(value))
          else
          	MainFormInstance.SetTotalParts(bt, 0);

          if bt > 0 then
          	FWMA.AddKeyToAddList('WM/PartOfSet', MainFormInstance.GetPartsString(bt))
        end;

        if HasChanged(WmaOtherFields, SR) then
        begin
					SetLength(bArr1, Fwma.AddList.Count);	//if false, the existing field is deleted from the tag
          for i:=0 to length(bArr1)-1 do bArr1[i] := false;

          SetLength(bArr2, wmaOtherFields.RootNodeCount);	//if false, a new field is added to the tag
          for i:=0 to length(bArr2)-1 do bArr2[i] := false;

          //Enumerate existing fields to see if any should be deleted or added
          for i:=0 to FWma.AddList.Count-1 do
          begin
          	s := fWma.GetAddListKeyName(i, wsValue);
            if Q_SameText(s, 'WM/ArtistSortOrder') or Q_SameText(s, 'WM/PartOfSet') or Q_SameText(s, WmaGroupIdent) or Q_SameText(s, WmaCompilationIdent) or Q_SameText(s, ApeOggWmaRatingIdent) then
            	bArr1[i] := true
            else
            begin
            	aNode := WmaOtherFields.GetFirst;
              while aNode <> nil do
              begin
              	tfRec := WmaOtherFields.GetNodeData(aNode);
                if Q_SameText(s, tfRec.fieldName) then
                begin
                	bArr1[i] := true;
                  bArr2[aNode.Index] := true;
                	if not tfRec.gray and not Q_SameStr(tfRec.value, wsValue) then
                  	fwma.SetAddListValue(i, tfRec.Value)
                end;
                aNode := WmaOtherFields.GetNext(aNode)
	            end
             end
          end;

          //Removing those who should be deleted
          for i:=fwma.AddList.count-1 downto 0 do
          	if not bArr1[i] then fwma.DeleteFromAddlist(i);

          //Adding new
          aNode := WmaOtherFields.GetFirst;
          while aNode <> nil do
          begin
            if not bArr2[aNode.Index] then
            begin
              tfRec := WmaOtherFields.GetNodeData(aNode);
              fWma.AddKeyToAddList(tfRec.FieldName, tfRec.Value)
            end;
            aNode := WmaOtherFields.GetNext(aNode)
          end
        end;

        if lyricsChanged(SR, true) then
        begin
          FWMA.Lyrics := lyricsMemo.Text;
        end;

        MainFormInstance.SaveWMAprivateFrame(FWMA, R, SaveGroups.Checked);

        if FWMA.WriteToStream(FStr) then
        begin
          SR.HasWMA := true;
          SR.WMAChanged := false;
          AddToStat(Thread, SR, 'WMA saved');
          Include(r.Flags, rfHasWmaTag)
        end
        else AddToStat(Thread, SR, 'Error saving WMA tag');
        FWMA.free;
      end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											Ogg
    if Kill[tagOgg] and SR.writeAble then
      begin
        FOgg := TOggVorbis.Create;
        FOgg.ReadFromStream(FStr{, SR.MpegDataStartPos});
        if Fogg.ClearTag then //FOgg.SaveTag(Fstr, SR.MpegDataStartPos, true) then    //removetag
        begin
          SR.HasOgg := false;
          SR.OggChanged := false;
          AddToStat(Thread, SR, 'Ogg stripped');
          Exclude(r.Flags, rfHasOggTag)
        end;
        FOgg.free
      end;

      if Save[tagOgg] and SR.writeAble then
      begin
        FOgg := TOggVorbis.Create;
        FOgg.ReadFromStream(FStr{, SR.MpegDataStartPos});

        if HasChanged(OggArtist, SR) then
        begin
          value := OggArtist.text;
          UpdateStringValueTabSync(SR, OggArtist, value);
          FOgg.Artist    := value
        end;

        if HasChanged(OggArtistSortOrder, SR) then
        begin
        	value := OggArtistSortOrder.text;
          UpdateStringValueTabSync(SR, OggArtistSortOrder, value);

					index := FOgg.GetKeyIndex('ARTISTSORTORDER');
          if index >= 0 then
          	FOgg.AdditionalTags.Delete(index);

          if (length(value) > 0) and not Q_SameStr(theFix(value), theFix(FOgg.Artist)) then
						FOgg.AddKeyToAddList('ARTISTSORTORDER', value)
        end;

        if HasChanged(OggTitle, SR) then
        begin
          value := OggTitle.text;
          UpdateStringValueTabSync(SR, OggTitle, value);
          FOgg.Title    := value
        end;

        if HasChanged(OggAlbum, SR) then
        begin
          value := OggAlbum.text;
          UpdateStringValueTabSync(SR, OggAlbum, value);
          FOgg.Album    := value
        end;

        if HasChanged(OggYear, SR) then
        begin
          value := OggYear.text;
          UpdateStringValueTabSync(SR, OggYear, value);
          FOgg.Date    := value
        end;

        if HasChanged(OggGenre, SR) then
        begin
          value := OggGenre.text;
          UpdateStringValueTabSync(SR, OggGenre, value);
          FOgg.Genre    := value
        end;

        if HasChanged(OggComment, SR) then
        begin
          value := OggComment.text;
          UpdateStringValueTabSync(SR, OggComment, value);
          FOgg.Comment    := value
        end;

        if HasChanged(OggTrack, SR) then
        begin
          i := MainFormInstance.GetTotalTracksInt(FOgg.Track);
          value := OggTrack.text;
          UpdateStringValueTabSync(SR, OggTrack, value);
          if Q_Isinteger(value) then
            FOgg.Track    := MainFormInstance.GetTrackString(StrToInt(Value), i)
          else FOgg.Track := MainFormInstance.GetTrackString(0, i)
        end;

        if HasChanged(OggTotalTracks, SR) then
        begin
          i := MainFormInstance.GetTrackNoInt(FOgg.Track);
          value := OggTotalTracks.text;
          UpdateStringValueTabSync(SR, OggTotalTracks, value);
          if Q_Isinteger(value) then
            FOgg.Track    := MainFormInstance.GetTrackString(i, StrToInt(Value))
          else FOgg.Track := MainFormInstance.GetTrackString(i, 0)
        end;

        if HasChanged(OggVersion, SR) then
        begin
          value := OggVersion.text;
          UpdateStringValueTabSync(SR, OggVersion, value);
          FOgg.Version    := value
        end;

        if HasChanged(OggCopyright, SR) then
        begin
          value := OggCopyright.text;
          UpdateStringValueTabSync(SR, OggCopyright, value);
          FOgg.Copyright    := value
        end;

        //Part of set
        if HasChanged(OggPartOfSet, SR) then
        begin
//         	DBChanged := true;
          value := OggPartOfSet.text;
          UpdateStringValueTabSync(SR, OggPartOfSet, value);

          //Get existing
          bt := 0;
          index := FOgg.GetKeyIndex('DISCNUMBER');
          if index >= 0 then
          begin
          	FOgg.GetAddListKeyName(index, s);
            MainFormInstance.SetPartOfSetFromString(bt, s);
            //Remove existing
            FOgg.DeleteFromAddlist(index);
          end;

          if Q_IsInteger(value) then
          	MainFormInstance.SetPartOfSet(bt, StrToInt(value))
          else
          	MainFormInstance.SetPartOfSet(bt, 0);

          if bt > 0 then
          	FOgg.AddKeyToAddList('DISCNUMBER', MainFormInstance.GetPartsString(bt))
        end;

        if HasChanged(OggOtherFields, SR) then
        begin
					SetLength(bArr1, FOgg.AdditionalTags.Count);	//if false, the existing field is deleted from the tag
          for i:=0 to length(bArr1)-1 do bArr1[i] := false;

          SetLength(bArr2, OggOtherFields.RootNodeCount);	//if false, a new field is added to the tag
          for i:=0 to length(bArr2)-1 do bArr2[i] := false;

          //Enumerate existing fields to see if any should be deleted or added
          for i:=0 to FOgg.AdditionalTags.Count-1 do
          begin
          	s := fOgg.GetAddListKeyName(i, value);
            if Q_SameText(s, 'DISCNUMBER') or Q_SameText(s, 'ARTISTSORTORDER') or Q_SameText(s, ApeOggGroupIdent) or Q_SameText(s, ApeOggCompilationIdent) or Q_SameText(s, ApeOggWmaRatingIdent) then
            	bArr1[i] := true
            else
            begin
            	aNode := OggOtherFields.GetFirst;
              while aNode <> nil do
              begin
              	tfRec := OggOtherFields.GetNodeData(aNode);
                if Q_SameText(s, tfRec.fieldName) then
                begin
                	bArr1[i] := true;
                  bArr2[aNode.Index] := true;
                	if not tfRec.gray and not Q_SameStr(tfRec.value, value) then
                  	fOgg.AdditionalTags.Strings[i] := ansiUpperCase(s) + '=' + tfRec.value
                end;
                aNode := OggOtherFields.GetNext(aNode)
	            end
             end
          end;

          //Removing those who should be deleted
          for i:=fOgg.AdditionalTags.count-1 downto 0 do
          	if not bArr1[i] then fOgg.AdditionalTags.Delete(i);

          //Adding new
          aNode := OggOtherFields.GetFirst;
          while aNode <> nil do
          begin
            if not bArr2[aNode.Index] then
            begin
              tfRec := OggOtherFields.GetNodeData(aNode);
              fOgg.AddKeyToAddList(tfRec.FieldName, tfRec.Value)
            end;
            aNode := OggOtherFields.GetNext(aNode)
          end
        end;

        if lyricsChanged(SR, true) then
        begin
          FOgg.Lyrics := lyricsMemo.Text;
        end;

        MainFormInstance.SaveOGGprivateFrame(Fogg, R, SaveGroups.Checked);

        if FOgg.SaveTag then
        begin
          SR.HasOgg := true;
          SR.OggChanged := false;
          AddToStat(Thread, SR, 'Ogg saved');
          Include(r.Flags, rfHasOggTag)
        end
        else AddToStat(Thread, SR, 'Error saving Ogg tag');
        FOgg.free;
      end;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // BEGIN  ID3V1
      if Kill[tagId3v1] and SR.writeAble then
      begin
      	Fstr.Size := Fstr.size -128;
        SR.HasV1 := false;
        SR.v1Changed := false;
        AddToStat(Thread, SR, 'Id3v1 stripped');
				Exclude(r.Flags, rfHasId3v1)
      end;

      if Save[tagId3v1] and SR.writeAble then
      begin
        FId3v1 := TId3V1Tag.Create;
        FId3v1.LoadFromStream(Fstr, Fstr.Size);
        FId3V1.v1 := false; //sætter til v1.1

        if HasChanged(Id3v1Title, SR) then
        begin
             value := Id3v1Title.text;
             UpdateStringValueTabSync(SR, Id3v1Title, value);
             FId3v1.Title    := value
        end;

        if HasChanged(Id3v1Artist, SR) then
        begin
             value := Id3v1Artist.text;
             UpdateStringValueTabSync(SR, Id3v1Artist, value);
             FId3v1.Artist    := value
        end;

        if HasChanged(Id3v1Album, SR) then
        begin
             value := Id3v1Album.text;
             UpdateStringValueTabSync(SR, Id3v1Album, value);
             FId3v1.Album    := value
        end;

        if HasChanged(Id3v1Year, SR) then
        begin
             value := Id3v1Year.text;
             UpdateStringValueTabSync(SR, Id3v1Year, value);
             FId3v1.Year    := value
        end;

        if HasChanged(Id3v1Genre, SR) then
        begin
             value := Id3v1Genre.text;
             UpdateStringValueTabSync(SR, Id3v1Genre, value);
             FId3v1.GenreID    := getRealV1Genre(value)
        end;

        if HasChanged(Id3v1Track, SR) then
        begin
             value := Id3v1Track.text;
             UpdateStringValueTabSync(SR, Id3v1Track, value);
             if Q_IsInteger(value) then
             FId3v1.Track    := strToInt(value) else
             FId3v1.Track    := 0
        end;

        if HasChanged(Id3v1Comment, SR) then
        begin
             value := Id3v1Comment.text;
             UpdateStringValueTabSync(SR, Id3v1Comment, value);
             FId3v1.Comment    := value
        end;

        Mstr := TMemoryStream.Create;
        MStr.Size := 128;
        Mstr.Position := 0;
        FId3v1.SaveToStream(MStr);
        UsePadding := false;
        if Fstr.Size > 130 then
        begin
          FStr.position := FStr.size-128;

          existed := true;
          Fstr.read(Ch,1);
          Existed := Existed and (Ch = 'T');
          Fstr.read(Ch,1);
          Existed := Existed and (Ch = 'A');
          Fstr.read(Ch,1);
          Existed := Existed and (Ch = 'G')
        end else
        begin
          UsePadding := false;
          Existed := false
        end;

        if not (UsePadding or Existed) then
          Fstr.Size := FStr.Size + 128;  // overwrite old tag

        FStr.position := FStr.size-128;
        MStr.position := 0;
        for i:=1 to 128 do
        begin
          MStr.Read(Ch,1);
          FStr.write(Ch,1)
        end;

        //RF_EqualId3
        if rfHasId3v2 in r.Flags then
        begin
          beginUseId3v2;
        	try
        		id3v2 := TMyID3Controller.Create(nil);
            try
            	id3v2.loadFromStream(Fstr);
              if MainFormInstance.Id3v1EqualsId3v2(Fid3v1, id3v2) then
              	Include(r.Flags, rfEqualId3)
              else
              	Exclude(r.Flags, rfEqualId3)
            finally
              id3v2.Free;
            end
          finally
          	EndUseId3v2
          end
        end;

        Fid3v1.free;
        Mstr.free;
        SR.HasV1 := true;
        SR.v1Changed := false;
        AddToStat(Thread, SR, 'Id3v1 saved');
        Include(r.Flags, rfHasId3v1)
      end;

      if LyricsChanged(SR) then
         SaveLyrics3(Fstr, SR);

      if assigned(Fstr) then
      begin
        R.FSize := FStr.Size;
        Fstr.free;
        R.LastWriteTime := FileAge(getFtext(SR.ref, fFilename));
        updateSRvalues(SR, false);
        MainFormInstance.EndWriteToFile(r)
      end
      	else
        	if DBchanged then
          	updateSRvalues(SR);

      Thread.Synchronize(StatRecProcessed, sNode);

      sNode := stat.GetNext(sNode)
    end;  //of while assigned(sNode)
  except
  end;

  AnythingChanged := AnythingChanged or dbChanged;
  for i:=low(HasTagCheckboxes) to high(HasTagCheckboxes) do
  	AnythingChanged := AnythingChanged or save[i];

	Thread.Synchronize(doAfterSave, pointer(failed))
end;

procedure TEditor.StatRecProcessed(Sender: TBMDThread;
  Thread: TBMDExecuteThread; var Data: Pointer);
var
	aNode: PVirtualNode;
begin
	aNode := Data;
  stat.FocusedNode := aNode;
	stat.RepaintNode(aNode);
  pBar.Position := pBar.Position+1
end;

procedure TEditor.StatFocusNode(Sender: TBMDThread;
  Thread: TBMDExecuteThread; var Data: Pointer);
var
	aNode:PvirtualNode;
begin
  aNode := stat.getFirst;
  while aNode <> nil do
  begin
  	if Data = stat.GetNodeData(aNode) then
    begin
    	stat.FocusedNode := aNode;
      break
    end;
  	aNode := stat.GetNext(aNode)
  end;
  stat.repaint
end;

procedure TEditor.SetMpeginfoCaption(Sender: TBMDThread;
  Thread: TBMDExecuteThread; var Data: Pointer);
begin
	MpegInfo.Caption := String(Data^)
end;

procedure TEditor.doAfterSave(Sender: TBMDThread; Thread: TBMDExecuteThread; var Data: Pointer);
begin //data = "failed"
	stat.ClearSelection;
  stat.repaint;
  SaveBtn.Enabled := true;
  CancelBtn.ModalResult := mrCancel;
  CancelBtn.Caption := 'Close';
  screen.cursor := crDefault;
  if pref.CloseEditorAfterSave.Checked and not boolean(Data) then //and not terminated then
    modalResult := mrOk
end;

procedure TEditor.CustomFieldTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
begin
	if Column = 0 then
  	CellText := PCustomField(FieldList.Items[Node.Index]).Name
  else
  	CellText := PCustomFieldRec(Sender.GetNodeData(Node)).Value
end;

procedure TEditor.CustomFieldTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
	cf: PCustomFieldRec;
begin
	cf := Sender.GetNodeData(Node);
  FillChar(cf^, SizeOf(cf^), 0);
  cf.FieldIndex := Node.Index
end;



procedure TEditor.CustomFieldTreeEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
	allowed := Column = 1
end;

procedure TEditor.CustomFieldTreeNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
	cf: PCustomFieldRec;
  b: boolean;
  oldText: WideString;
begin
	//Get old text
  oldText := '';
  CustomFieldTreeGetText(sender, Node, Column, ttStatic, oldText);

  newText := trim(NewText);
  if newText <> oldText then
  begin
	  if length(newText) = 0 then
	  	b := true
	  else
	    case PCustomField(FieldList.Items[Node.Index]).dataType of
	      0: b := true;	//string
	      1: b := Q_IsInteger(newText);
	      2: b := Q_IsFloat(newText);
	      else b := false;
	    end;

    if b then
	  begin
	  	cf := Sender.GetNodeData(Node);
		  cf.value := Trim(NewText);
		  cf.Gray := false;

      FieldChanged(sender)
	  end
	  else
	  	MainFormInstance.ShowMessageX(GetText(TXT_InvalidFormat))
  end
end;

procedure TEditor.CustomFieldTreeFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
	allowed := NewColumn = 1
end;

procedure TEditor.CustomFieldTreeFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
 with Sender do
  begin
    if Assigned(Node) and (Node <> RootNode) and (Column = 1) then
    begin
      EditNode(Node, Column);
    end;
	end;
end;

procedure TEditor.ArtistDropDown(Sender: TObject);
begin
	if not multipleFiles and (artist.Items.Count = 0) then
    artist.Items.AddStrings(artistList);
end;

procedure TEditor.AlbumDropDown(Sender: TObject);
begin
	if not multipleFiles and (album.Items.Count = 0) then
    album.Items.AddStrings(albumlist);
end;

procedure TEditor.scrollBarOggScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
	panel5.Top := scrollpos * -1
end;

procedure TEditor.OggOtherFieldsNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
	tr: PTagFieldRec;
begin
  newText := trim(NewText);
  tr := Sender.GetNodeData(Node);
	tr.Gray := false;

  case column of
  	0: tr.fieldName := newText;
    1: tr.value := newText
  end
end;

procedure TEditor.OggOtherFieldsBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
    Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
	if PTagFieldRec(Sender.GetNodeData(Node)).Gray and (Column = 1) then
  begin
  	TargetCanvas.brush.Color := colorGray;
    TargetCanvas.FillRect(CellRect);
    TargetCanvas.brush.Color := colorWhite
  end
end;

procedure TEditor.OggOtherFieldsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
begin
	if Column = 0 then
  	CellText := PTagFieldRec(Sender.GetNodeData(Node)).FieldName
  else
  	CellText := PTagFieldRec(Sender.GetNodeData(Node)).Value
end;

procedure TEditor.btnAddOggOtherFieldClick(Sender: TObject);
begin
  if not OggOtherFields.Enabled then exit;
  OggOtherFields.AddChild(nil);
  OggOtherFields.EditNode(OggOtherFields.GetLast, 0)
end;

procedure TEditor.OggOtherFieldsEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
//var
//	tf: PTagFieldRec;
begin
//	tf := Sender.GetNodeData(Node);
 	Allowed := true
end;
       
procedure TEditor.OggOtherFieldsEdited(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
	tr: PTagFieldRec;
begin
  tr := Sender.GetNodeData(Node);

  if (length(tr.value) = 0) and (length(tr.fieldname) = 0) then
  	sender.DeleteNode(Node)
  else
  if column = 0 then
  	timFocusSecondColumn.Enabled := true;

	FieldChanged(sender)
end;

procedure TEditor.timFocusSecondColumnTimer(Sender: TObject);
var
	aTree: TVirtualStringTree;
begin
	timFocusSecondColumn.Enabled := false;
	if IsOtherFieldsTree(ActiveControl) then
  begin
  	aTree := TVirtualStringTree(ActiveControl);
    if (aTree.FocusedColumn = 0) and assigned(aTree.FocusedNode) then
    	aTree.EditNode(aTree.FocusedNode, 1)
  end
end;

procedure TEditor.btnDelOggOtherFieldClick(Sender: TObject);
begin
	if assigned(OggOtherFields.FocusedNode) then
  begin
  	OggOtherFields.DeleteNode(OggOtherFields.Focusednode);
    FieldChanged(OggOtherFields)
  end
end;

procedure TEditor.TabWMAShow(Sender: TObject);
begin
	scbWma.Max := 2 * (6 + panel6.Height - (TabWma.Height - Groupbox6.Height));
  scbWma.PageSize := scbWma.Max div 2;
end;

procedure TEditor.scbWmaScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
	panel6.Top := 6 + ScrollPos * -1
end;

procedure TEditor.Button3Click(Sender: TObject);
begin
	if not WmaOtherFields.Enabled then exit;
  WmaOtherFields.EditNode(WmaOtherFields.AddChild(nil), 0)
end;

procedure TEditor.Button4Click(Sender: TObject);
begin
	if assigned(WmaOtherFields.FocusedNode) then
  begin
  	WmaOtherFields.DeleteNode(WmaOtherFields.Focusednode);
    FieldChanged(WmaOtherFields)
  end
end;

procedure TEditor.wmaOtherFieldsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	aNode: PVirtualNode;
begin
	with TVirtualStringTree(Sender) do
  begin
  	aNode := GetNodeAt(x, y);
    if Assigned(aNode) and (aNode <> RootNode) then
    begin
      EditNode(aNode, Header.Columns.ColumnFromPosition(Point(x, y)));
    end;
	end;
end;

procedure TEditor.Button1Click(Sender: TObject);
begin
  if not ApeOtherFields.Enabled then exit;
  ApeOtherFields.AddChild(nil);
  ApeOtherFields.EditNode(ApeOtherFields.GetLast, 0)
end;


procedure TEditor.Button2Click(Sender: TObject);
begin
	if assigned(apeOtherFields.FocusedNode) then
  begin
  	apeOtherFields.DeleteNode(apeOtherFields.Focusednode);
    FieldChanged(apeOtherFields)
  end
end;

procedure TEditor.Button5Click(Sender: TObject);
begin
  if not id3v2OtherFields.Enabled then exit;
  id3v2OtherFields.AddChild(nil);
  id3v2OtherFields.EditNode(id3v2OtherFields.GetLast, 0)
end;

procedure TEditor.Button6Click(Sender: TObject);
begin
	if assigned(id3v2OtherFields.FocusedNode) then
  begin
  	id3v2OtherFields.DeleteNode(id3v2OtherFields.Focusednode);
    FieldChanged(id3v2OtherFields)
  end
end;
procedure TEditor.v2ExtraScrollScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
	panel7.Top := ScrollPos * -1
end;

procedure TEditor.TabId3v2X1Show(Sender: TObject);
begin
	v2ExtraScroll.Max := 6 + panel7.Height;
  v2ExtraScroll.PageSize := v2ExtraScroll.Height//v2ExtraScroll.Max div 2;
end;

procedure TEditor.StatGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
  var HintText: WideString);
var       SR:PstatRec;
          s:String;
          i, x:integer;
begin
     SR := sender.getNodeData(Node);
		 HintText := getFtext(SR.ref, fFilename);
     if SR.FileExists then
     begin
          HintText := HintText + #13 + '   File exists';
          if SR.Readable then
//              HintText := HintText + #13 + '     Readable'
          else
              HintText := HintText + #13 + '     Not readable';
          if SR.Writeable then
//              HintText := HintText + #13 + '     Writeable'
          else
              HintText := HintText + #13 + '     Not writeable';
          if SR.HasV1 then HintText := HintText + #13 + '       Has Iv3v1 tag';
          if SR.HasV2 then HintText := HintText + #13 + '       Has Iv3v2 tag'
     end else
     begin
          HintText := HintText + #13 + 'File does not exists'
     end;
     if length(SR.status)>0 then
     begin
          HintText := HintText + #13#13 + 'Messages:';// + #13 +  SR.status
          s := SR.status + #13;
          x := 1;
          while Q_PosStr(#13, s, x) > 0 do
          begin
               i := Q_PosStr(#13, s, x+1);
               HintText := HintText + #13 + '   ' + Q_CopyRange(s, x, i-1);
               x := i+1
          end
     end
end;

procedure TEditor.FormClose(Sender: TObject; var Action: TCloseAction);
var
	i: integer;
begin
	if Action = caFree then
  begin
		recs.free;

	  for i:=undoList.count-1 downto 0 do deleteUndo(i);
	    undoList.Free;

	  v1Components.free;
	  v2Components.free;
	  ApeComponents.free;
	  WMAComponents.free;
	  OggComponents.free;
	end
end;

procedure TEditor.CommTreeBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
    Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
	if PCommRec(Sender.GetNodeData(Node)).Gray and (Column = 2) then
  begin
  	TargetCanvas.brush.Color := colorGray;
    TargetCanvas.FillRect(CellRect);
    TargetCanvas.brush.Color := colorWhite
  end
end;

procedure TEditor.Id3v2OtherFieldsBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
    Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
	if PTagFieldRec(Sender.GetNodeData(Node)).Gray and (Column = 2) then
  begin
  	TargetCanvas.brush.Color := colorGray;
    TargetCanvas.FillRect(CellRect);
    TargetCanvas.brush.Color := colorWhite
  end
end;

procedure TEditor.Id3v2OtherFieldsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
	tf: PTagFieldRec;
begin
	tf := Sender.GetNodeData(Node);
	case column of
  	0: CellText := tf.FieldName;
    1:
    begin
    	if Q_SameText(tf.fieldName, 'TXXX') then
      	CellText := tf.description
      else
      	CellText := ' - '
    end;
    2: CellText := tf.Value;
	end
end;

procedure TEditor.Id3v2OtherFieldsNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
	tr: PTagFieldRec;
begin
  newText := trim(NewText);
  tr := Sender.GetNodeData(Node);
	tr.Gray := false;

  case column of
  	0: tr.fieldName := newText;
    1: tr.description := newText;
    2: tr.value := newText
  end
end;

procedure TEditor.Id3v2OtherFieldsEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
	tf: PTagFieldRec;
begin
	tf := Sender.GetNodeData(Node);
  if (column = 1) then
  	Allowed := Q_SameText(tf.fieldName, 'TXXX')
  else
  	Allowed := true
end;

procedure TEditor.CustomFieldTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
begin
	if PCustomFieldRec(Sender.GetNodeData(Node)).Gray and (Column = 1) then
  begin
  	TargetCanvas.brush.Color := colorGray;
    TargetCanvas.FillRect(CellRect);
    TargetCanvas.brush.Color := colorWhite
  end
end;


end.





