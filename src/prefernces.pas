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


//HUSK at alle componenter der skal gemmes/loades skal have TAG = 1  !!!
//Ændres en gennem fx MainForm, skal TAG = 2 - så gemmes den uden der trykkes save
{.$define ScanInMainThread}
unit prefernces;

interface

uses
	
	Windows, SysUtils, Classes, Graphics, Controls, Forms,
	StdCtrls, ExtCtrls, Menus,  FPUrlLabel,
	ShellAPI, filectrl, ShlObj, ActiveX,
	ColorPickerButton, QStrings,
	VirtualTrees, ColorConv,
	snap, ComCtrls, BMDThread, MexpIniFile, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, JvComponent, JvSearchFiles,
  JvColorCombo, Spin, JvListBox, JvCtrls, MEXPtypes, Dialogs, ExtDlgs,
  CheckLst, JvCombobox, JvComponentBase, JvExStdCtrls, JvTextListBox;

type
  Tpref = class(TForm)
    scanpopup: TPopupMenu;
    Scan1: TMenuItem;
    Scannewremovedeadfiles1: TMenuItem;
    pbar: TProgressBar;
    Panel1: TPanel;
    SaveButton: TButton;
    CloseButton: TButton;
    Label555: TLabel;
    FPUrlLabel2: TFPUrlLabel;
    FPUrlLabel1: TFPUrlLabel;
    PrefTree: TVirtualStringTree;
    PC: TPageControl;
		TSMyMusic: TTabSheet;
    loadinglabel: TLabel;
    TSId3: TTabSheet;
    TSShortCuts: TTabSheet;
    TSUsers: TTabSheet;
    TSabout: TTabSheet;
    Label89: TLabel;
    Label90: TLabel;
    Label92: TLabel;
    FPUrlLabel3: TFPUrlLabel;
    TSDailyScan: TTabSheet;
		TSFontsColors: TTabSheet;
    TSid3Editor: TTabSheet;
    Label2: TLabel;
    harddisk: TEdit;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    GroupBox9: TGroupBox;
    Label9: TLabel;
    Button10: TButton;
    Button9: TButton;
    MyMusicTextColor: TGroupBox;
    Cpanel: TColorPickerButton;
    ScanPlay: TCheckBox;
    AaddGroups: TCheckBox;
    Label11: TLabel;
    unknown: TEdit;
    Convertunder: TCheckBox;
		removeBrackets: TCheckBox;
    Label10: TLabel;
    correcttitle: TCheckBox;
    advTrackCalc: TCheckBox;
    Label84: TLabel;
    UseSubAlbum: TCheckBox;
    HotTree: TVirtualStringTree;
    AllowMU: TCheckBox;
		usernamel: TLabel;
    Label5: TLabel;
    userdir: TLabel;
    Label105: TLabel;
    AutoScanSub: TCheckBox;
    OnlyScanOnceADay: TCheckBox;
    Bevel3: TBevel;
    Label108: TLabel;
    AutoScanMoveToPath: TEdit;
    Button5: TButton;
    Panel16: TPanel;
    FontColorPanel: TPanel;
    Label19: TLabel;
    FontColor: TColorPickerButton;
    Backgroundcolorpanel: TPanel;
    Label101: TLabel;
    Backgroundcolor: TColorPickerButton;
    SelTextColorPanel: TPanel;
    Label22: TLabel;
    SelTextColor: TColorPickerButton;
		SelBarFocusedPanel: TPanel;
    Label23: TLabel;
    SelBarFocused: TColorPickerButton;
    SelBarUnFocusedPanel: TPanel;
    Label24: TLabel;
    SelBarUnfocused: TColorPickerButton;
    playingtxtcolorpanel: TPanel;
    Label95: TLabel;
    playingtextcolor: TColorPickerButton;
    headerColorPanel: TPanel;
    Label115: TLabel;
    headerColor: TColorPickerButton;
    HeaderTextColorPanel: TPanel;
    Label116: TLabel;
    HeaderTextColor: TColorPickerButton;
    FB: TJvFontComboBox;
    Label8: TLabel;
    FontSize: TSpinEdit;
    Label21: TLabel;
    MainListColorNote: TLabel;
		GroupBox22: TGroupBox;
    Id3_autoformatNewText: TCheckBox;
    Id3_SyncTabs: TCheckBox;
    Id3_SaveGroups: TCheckBox;
    Id3_AutoCopyFromDB: TCheckBox;
    ID3_AlwaysCopyFromDB: TCheckBox;
    ID3_AutoGetLyrics: TCheckBox;
    ID3_EnableOnTabChange: TCheckBox;
    Label36: TLabel;
    Bevel12: TBevel;
    Label7: TLabel;
    SearchFontColorPanel: TPanel;
    Label25: TLabel;
    SearchFontColor: TColorPickerButton;
    repairVBRCB: TCheckBox;
    AutoScanPaths: TCheckListBox;
    Button12: TButton;
    Button16: TButton;
    KillTextColorPanel: TPanel;
		Label38: TLabel;
    KillTextColor: TColorPickerButton;
    Button17: TButton;
    TScheckNewVer: TTabSheet;
    Button18: TButton;
    BtnGotoHomepage: TButton;
    CheckNewVerLabel: TLabel;
		UserPanel: TPanel;
    userlist: TCheckListBox;
    Label106: TLabel;
    Label43: TLabel;
    FPUrlLabel8: TFPUrlLabel;
    TScredits: TTabSheet;
    Button19: TButton;
		FontBold: TCheckBox;
    FontItalic: TCheckBox;
    GroupBox8: TGroupBox;
		MainListUpdateTags: TCheckBox;
    Label55: TLabel;
    forceId3v1: TCheckBox;
    forceId3v2: TCheckBox;
    forceApe: TCheckBox;
    ForceOgg: TCheckBox;
    ForceWMA: TCheckBox;
    CorrectCasing: TCheckBox;
    StripId3v2FromUnsupported: TCheckBox;
    GroupBox12: TGroupBox;
    specialKeyAlt: TCheckBox;
    specialKeyCtrl: TCheckBox;
    SpecialKeyShift: TCheckBox;
    UseEnterKeyBtn: TButton;
    UseSpaceKeyBtn: TButton;
    TSgeneralSettings: TTabSheet;
    GroupBox17: TGroupBox;
    savesearch: TCheckBox;
    savetreeselection: TCheckBox;
    GroupBox20: TGroupBox;
		Label102: TLabel;
    Label103: TLabel;
    Label54: TLabel;
    dragplaylist: TRadioButton;
    dragfiles: TRadioButton;
    TSmainListSettings: TTabSheet;
    loadon: TRadioGroup;
    GroupBox4: TGroupBox;
    GroupBox11: TGroupBox;
    Panel15: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    autoquery: TSpinEdit;
		SearchMode: TRadioGroup;
    dblclick: TRadioGroup;
    DeOp: TRadioGroup;
    TStreeSettings: TTabSheet;
    GroupBox7: TGroupBox;
    Label88: TLabel;
    GroupBox10: TGroupBox;
    Label12: TLabel;
    Button8: TButton;
    Button7: TButton;
    Aatw: TCheckBox;
    GroupBox16: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
		resettime: TSpinEdit;
    enablereset: TCheckBox;
    treeviceversa: TCheckBox;
    TSwaPlaylist: TTabSheet;
    GroupBox15: TGroupBox;
    Label57: TLabel;
    Label58: TLabel;
    WinPlayTitleFormatEdit: TEdit;
    WinPlayCompilationTitleFormatEdit: TEdit;
    WinPlayCompilationEnabled: TCheckBox;
    GroupBox2: TGroupBox;
    Label40: TLabel;
    updateContPlayOnFilter: TCheckBox;
    ignoreDuplicatesSettings: TRadioGroup;
    GroupBox18: TGroupBox;
    FollowPlayingWA: TCheckBox;
    GroupBox19: TGroupBox;
    FollowPlayingML: TCheckBox;
    TSquickList: TTabSheet;
    QuicklistClick: TRadioGroup;
		GroupBox13: TGroupBox;
    Label13: TLabel;
    toplist: TCheckBox;
    topnr: TSpinEdit;
    topcountshow: TCheckBox;
    CloseEditorAfterSave: TCheckBox;
    HideOnEdit: TCheckBox;
    TSskin: TTabSheet;
    Panel2: TPanel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label49: TLabel;
    Label48: TLabel;
    Label53: TLabel;
    fzcol: TRadioGroup;
    SRcol: TRadioGroup;
		ColumnsGroupBox: TGroupBox;
    AutoResizeColumns: TCheckBox;
    AutoResizeColumnHeaders: TCheckBox;
    HideInfoShownInTree: TCheckBox;
    GroupBox21: TGroupBox;
    Label26: TLabel;
    HotKey1: THotKey;
    Button11: TButton;
    GroupBox3: TGroupBox;
    Label41: TLabel;
    ControlPlaylist: TCheckBox;
    GroupBox6: TGroupBox;
    sit: TCheckBox;
    IconInSystray: TCheckBox;
    showhide: TCheckBox;
    TrayIconOptions: TRadioGroup;
    GroupBox14: TGroupBox;
    showhnt: TCheckBox;
    Scrollbars: TRadioGroup;
    GroupBox23: TGroupBox;
		SkinBox: TListBox;
    SkinAuthorLabel: TLabel;
    SkinCorrespondingWinampLabel: TLabel;
    SkinCommentsLabelValue: TLabel;
    GroupBox24: TGroupBox;
    AutoChangeSkin: TCheckBox;
    EditSkinBtn: TButton;
    AllowColorOverride: TCheckBox;
    ScanButton: TButton;
    TSpartyMode: TTabSheet;
    GroupBox25: TGroupBox;
    LockAltTab: TCheckBox;
    LockCtrlAltDel: TCheckBox;
    GroupBox26: TGroupBox;
    DisableTagging: TCheckBox;
    DisableDeleteFromHD: TCheckBox;
    DisableOrganizeDuplicateFiles: TCheckBox;
    DisableEditQuicklist: TCheckBox;
    DisableEditPlaylist: TCheckBox;
    DisableDeleteMoveWinampPlaylist: TCheckBox;
		DisableDBmanagement: TCheckBox;
    AlwaysEnqueueToWP: TCheckBox;
    AlwaysEnableKill: TCheckBox;
    WarningHotLabel: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label16: TLabel;
    MyMusicPattern: TEdit;
    Button14: TButton;
    GroupBox27: TGroupBox;
    ShowGroupsInTree: TCheckBox;
    ShowGroupsAtFilter: TCheckBox;
    ShowGroupSettingsInTree: TCheckBox;
    GroupBox28: TGroupBox;
    TreeTagging: TCheckBox;
    Label27: TLabel;
		TreeTagShowConfirm: TCheckBox;
    SelectionRectangle: TRadioGroup;
    EnterInSearchfield: TRadioGroup;
    TreeTagAltPressed: TCheckBox;
    partyDisableRemote: TCheckBox;
    CalcCRCcb: TCheckBox;
    DblClkTree: TRadioGroup;
    PartyDisableVolumeControl: TCheckBox;
    PartyDisablePlaybackControls: TCheckBox;
    PartyAllKeySearches: TCheckBox;
    PartyLockColumns: TCheckBox;
    GroupBox30: TGroupBox;
    WinplayShowColumns: TCheckBox;
    Label28: TLabel;
    IdHttp: TIdHTTP;
    GroupBox31: TGroupBox;
    SaveDB: TCheckBox;
    saveDBNote: TLabel;
    SkipId3v1Genre: TCheckBox;
    CaseSensitiveSort: TCheckBox;
    TSshowCover: TTabSheet;
    GroupBox32: TGroupBox;
    ShowCover: TCheckBox;
    CoverShowHideMB: TCheckBox;
    dontAddIfExistsInWinplay: TCheckBox;
    dontAddIfExistsInWinplayText: TLabel;
    UserFileFind: TJvSearchFiles;
    GetMoreSkinsLabel: TFPUrlLabel;
    TSfileTypes: TTabSheet;
    FileTypeList: TListBox;
    FTDeleteSelectedBtn: TButton;
    FTSaveAsNewBtn: TButton;
    PartyLimitMouse: TCheckBox;
    CorrectTags: TCheckBox;
    paths: TJvTextListBox;
    excl: TJvTextListBox;
    TStreeViewModes: TTabSheet;
    TreeStructureTree: TVirtualStringTree;
    TreeStructureList: TVirtualStringTree;
    DeleteTreeStructureBtn: TButton;
    NewTreeStructureBtn: TButton;
    NewTreeStructureNodeBtn: TButton;
    DeleteTreeStructureNodeBtn: TButton;
    RevertSelectedTreeStructureBtn: TButton;
    RevertAllTreeStructuresBtn: TButton;
    IndividualSO: TCheckBox;
    ViewModesLabel: TLabel;
    TreeStructureLabel: TLabel;
    TSfields: TTabSheet;
    AddFieldButton: TButton;
    RemoveFieldButton: TButton;
    SelectedFieldGroupBox: TGroupBox;
    FieldName: TEdit;
    Name: TLabel;
    FieldTree: TVirtualStringTree;
    FieldIcon: TComboBox;
    Label39: TLabel;
    SearchInFields: TCheckListBox;
    lblEmail: TLabel;
    txtEmail: TEdit;
    cbShowTotalDurationLabel: TCheckBox;
    cbUseCustomDbColor: TCheckBox;
    skinAuthorLink: TFPUrlLabel;
    SkinWinampLink: TFPUrlLabel;
    lblSkinComment: TLabel;
    GroupBox29: TGroupBox;
    txtBackgroundImageFilename: TEdit;
    btnBrowseBackgroundFile: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    CompilationPlacement: TRadioGroup;
    Label52: TLabel;
    GroupBox37: TGroupBox;
    RelativePaths: TCheckBox;
    GroupBoxSelectedTreeViewNode: TGroupBox;
    Label6: TLabel;
    seTreeMinCount: TSpinEdit;
    Label32: TLabel;
    TreeStructureNodeContent: TComboBox;
    TreeStructureNodeIncludeCompilationsCB: TCheckBox;
    cbTreeSort: TComboBox;
    Label42: TLabel;
    Label56: TLabel;
    Label59: TLabel;
    GroupBoxSelectedFiletype: TGroupBox;
    Label29: TLabel;
    LongNameEdit: TEdit;
    Label30: TLabel;
    ShortNameEdit: TEdit;
    FileExtEdit: TEdit;
    Label31: TLabel;
    FTAudioCB: TCheckBox;
    FTVideoCB: TCheckBox;
    SupportsId3v2: TCheckBox;
    SupportsId3v1: TCheckBox;
    SupportsApeV1: TCheckBox;
    SupportsApeV2: TCheckBox;
    Label60: TLabel;
    KeepPlaylistAtMaximum: TCheckBox;
    KeepPlaylistAtNumber: TSpinEdit;
    Label61: TLabel;
    TStreeCovers: TTabSheet;
    GroupBox38: TGroupBox;
    treeCoverWidth: TSpinEdit;
    treeCoverHeight: TSpinEdit;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    treeCoverBorder: TSpinEdit;
    Label67: TLabel;
    cbTreeCoverIncludeAlbumName: TCheckBox;
    chkLoadThumbsInBackground: TCheckBox;
    cbShowCoverInTree: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Label34: TLabel;
    FieldOggName: TEdit;
    FieldWmaName: TEdit;
    Label37: TLabel;
    Label35: TLabel;
    FieldApeName: TEdit;
    FPUrlLabel11: TFPUrlLabel;
    rbtId3v2FieldType: TRadioGroup;
    Panel3: TPanel;
    pnlId3v2FieldFrameName: TPanel;
    FieldId3v2Name: TEdit;
    Label33: TLabel;
    pnlId3v2FieldDefaultLanguage: TPanel;
    Label68: TLabel;
    pnlId3v2FieldDescription: TPanel;
    Label69: TLabel;
    FieldId3v2Description: TEdit;
    cbId3v2FieldLanguage: TComboBox;
    chkFieldId3v2ReadFromAllLanguages: TCheckBox;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure Scan1Click(Sender: TObject);
		procedure Scannewremovedeadfiles1Click(Sender: TObject);
		procedure RunAfterScan(Sender: TObject); 	//hentes fra tråden
    procedure FormShow(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure TabSheet4Exit(Sender: TObject);
		procedure hideifheightChange(Sender: TObject);
    procedure Shape5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label7Click(Sender: TObject);
    procedure Label88Click(Sender: TObject);
    procedure Label93Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure AllowMUClick(Sender: TObject);
    procedure Label102Click(Sender: TObject);
    procedure Label103Click(Sender: TObject);
    procedure TSUsersShow(Sender: TObject);
    procedure SearchModeClick(Sender: TObject);
    procedure TSsettingsShow(Sender: TObject);
    procedure SearchModeEnter(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Label84Click(Sender: TObject);
		procedure HotTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
    procedure PrefTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var Text: WideString);
    procedure PCChange(Sender: TObject);
    procedure TSFontsColorsShow(Sender: TObject);
    procedure FBChange(Sender: TObject);
    procedure PrefTreeFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure PrefTreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
//    procedure PrefTreePaintText(Sender: TBaseVirtualTree;
//      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
//      TextType: TVSTTextType);
    procedure pathsClick(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure HotTreeChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure Label40Click(Sender: TObject);
		procedure ControlPlaylistClick(Sender: TObject);
    procedure Label41Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure BtnGotoHomepageClick(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Label56Click(Sender: TObject);
    procedure UseEnterKeyBtnClick(Sender: TObject);
    procedure ScanThreadExecute(Sender: TObject; Thread: TBMDExecuteThread;
      var Data: Pointer);
//    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WinPlayCompilationEnabledClick(Sender: TObject);
    procedure TSskinShow(Sender: TObject);
		procedure SkinBoxClick(Sender: TObject);
    procedure EditSkinBtnClick(Sender: TObject);
    procedure AllowColorOverrideClick(Sender: TObject);
    procedure ScanButtonClick(Sender: TObject);
    procedure ShowGroupsInTreeClick(Sender: TObject);
    procedure TStreeSettingsShow(Sender: TObject);
    procedure Label27Click(Sender: TObject);
		procedure TreeTaggingClick(Sender: TObject);
    procedure TSmainListSettingsShow(Sender: TObject);
    procedure WinplayShowColumnsClick(Sender: TObject);
    procedure ShowCoverClick(Sender: TObject);
    procedure TSshowCoverShow(Sender: TObject);
    procedure dontAddIfExistsInWinplayTextClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FileTypeListClick(Sender: TObject);
    procedure FTSaveToSelectedBtnClick(Sender: TObject);
    procedure FTSaveAsNewBtnClick(Sender: TObject);
    procedure FTDeleteSelectedBtnClick(Sender: TObject);
    procedure TreeStructureListGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure TreeStructureListFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure NewTreeStructureBtnClick(Sender: TObject);
    procedure TreeStructureListChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure TreeStructureNodeContentChange(Sender: TObject);
    procedure TreeStructureNodeIncludeCompilationsCBClick(Sender: TObject);
    procedure TreeStructureTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure TreeStructureTreeChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure NewTreeStructureNodeBtnClick(Sender: TObject);
    procedure DeleteTreeStructureNodeBtnClick(Sender: TObject);
    procedure TreeStructureTreeMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DeleteTreeStructureBtnClick(Sender: TObject);
    procedure TreeStructureListEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure TreeStructureListNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure TreeStructureListDragOver(Sender: TBaseVirtualTree;
      Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
      Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure TreeStructureListDragDrop(Sender: TBaseVirtualTree;
      Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
      Shift: TShiftState; Pt: TPoint; var Effect: Integer;
      Mode: TDropMode);
    procedure TreeStructureTreeDragDrop(Sender: TBaseVirtualTree;
      Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
      Shift: TShiftState; Pt: TPoint; var Effect: Integer;
      Mode: TDropMode);
    procedure TreeStructureTreeDragOver(Sender: TBaseVirtualTree;
      Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
      Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
    procedure RevertSelectedTreeStructureBtnClick(Sender: TObject);
    procedure RevertAllTreeStructuresBtnClick(Sender: TObject);
    procedure TSfieldsShow(Sender: TObject);
    procedure AddFieldButtonClick(Sender: TObject);
    procedure FieldTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure FieldIconDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure RemoveFieldButtonClick(Sender: TObject);
    procedure SearchInFieldsClickCheck(Sender: TObject);
//    procedure CustomFieldNodeContentChange(Sender: TObject);
    procedure TStreeViewModesShow(Sender: TObject);
    procedure cbTreeSortChange(Sender: TObject);
    procedure seTreeMinCountChange(Sender: TObject);
    procedure cbUseCustomDbColorClick(Sender: TObject);
    procedure TSMyMusicShow(Sender: TObject);
    procedure btnBrowseBackgroundFileClick(Sender: TObject);
    procedure LongNameEditChange(Sender: TObject);
    procedure rbtId3v2FieldTypeClick(Sender: TObject);
    procedure FieldTreeFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);

  private
    Rname,Rkey:string;
    FFileTypeSettingsLoading: Boolean;
    FTreeViewCustomFieldStartIndex: integer;
    Procedure ExpandTree;
    Procedure CreatePrefTree;
    Procedure CreateHotTree;
		Procedure LoadLanguageGUI;
    Function BeforeScan(onlyNew: Boolean): Boolean; //returnerer ny OnlyNew
    Procedure InitFileTypeList;
    procedure AudioTypeFileExtFromString(index: Integer; s: String);
    Procedure SaveTreeStructureTreeToTreeStructure(p: PTreeStructure);
    Procedure SaveTreeStructureTreeToSelectedTreeStructure;
    Function GetIndexFromTreeStructureContent(tsc: TTreeStructureContents; customFieldIndex:integer): Integer;
    Function GetTreeStructureContentFromIndex(index: Integer; var customFieldIndex:integer): TTreeStructureContents;

    Procedure SaveCustomFieldFromNode(node: PVirtualNode);
//    procedure UpdateTreeViewModeCustomFieldCombobox;
    { Private declarations }
  public
				webURL : string;
				Procedure UpdateSkinInfoLabels;
				procedure SaveSettings(onlyQuitsave:boolean);
		{ Public declarations }
  end;

Const
        Cmainlist=0;
        Ctree=1;
        Cquicklist=2;
				Cquicklistsongs=3;
        CPlaylist=4;
        Csplitters=5;
				Ccaptionbarbuttons=6;
				CplayingLabel=7;

Type
  THotRec = Record
    Obj : Tobject
  end;
  PHotRec = ^THotRec;

type
	TTreeStructureTreeNode = Record
  	Content: TTreeStructureContents;
    CustomFieldIndex: Integer;
    SortColumnField: Integer;
    MinCount: Integer;
    IncludeCompilation: Boolean;
  end;
 	PTreeStructureTreeNode = ^TTreeStructureTreeNode;

Type
  Tpt = Record
    Text : String;
    Tab : TTabSheet;
    Tag : Byte;
    Expanded : boolean;
  end;
  Ppt = ^Tpt;
var
	pref: Tpref;

implementation

uses MainForm, defs, languageConstants;

var  re : string;

{$R *.DFM}

Procedure TPref.LoadLanguageGUI;
var
	s: String;
  i: Integer;
begin
  caption :=                 appName + '  -  ' + getText(TXT_guiPreferences);

  SaveButton.Caption					:= GetText(TXT_Save);
  CloseButton.Caption					:= GetText(TXT_Close);

  Scan1.Caption							 := GetText(TXT_ScanAllFiles);
  Scannewremovedeadfiles1.Caption := GetText(TXT_ScanNewFiles);

  //My Music
  label2.caption             := GetText(TXT_guiPrimDBname);
  groupBox5.caption          := GetText(TXT_guiMp3PathsGB)+' ';
  label1.caption             := GetText(TXT_guiMp3sToScanNote);
  Button1.Caption            := GetText(TXT_Add);
  Button2.Caption            := GetText(TXT_Remove);
  MyMusicTextColor.Caption   := GetText(TXT_TextColor)+' ';
  ScanPlay.Caption           := GetText(TXT_guiScanPlaylists);
  AaddGroups.Caption         := GetText(TXT_guiAutoAddGroups);
  repairVBRCB.Caption          := GetText(TXT_guiRepairVBR);
  CalcCRCcb.Caption 				 := GetText(TXT_CalcCRC);
  ScanButton.Caption         := GetText(TXT_guiScan);
  Button19.Caption					 := GetText(TXT_HelpGuide);
  GroupBox9.Caption          := GetText(TXT_guiExcludeList);
  label9.Caption             := GetText(TXT_guiExludeListText);
  Button10.Caption           := GetText(TXT_add);
  Button9.Caption            := GetText(TXT_Remove);
  GroupBox1.Caption          := GetText(TXT_guiCopyToMyMusicGB)+' ';
  Label3.Caption             := GetText(TXT_guiCopyToMyMusicText1);
  label16.Caption            := GetText(TXT_guiCopyToMyMusicText2);
  button14.Caption           := GetText(TXT_Patterns);
  cbUseCustomDbColor.Caption := GetTExt(TXT_UseCustomDatabaseColor);
  //eo My Music

  //General settings
  loadOn.Caption             := GetText(TXT_LoadDatabase)+' ';
  loadOn.Items[0]            := GetText(TXT_OnWinampStartup);
  loadOn.Items[1]            := GetText(TXT_OnFirstTimeShowed);

  GroupBox17.Caption         := GetText(TXT_guiSaveSearch);
  SaveSearch.Caption         := GetText(TXT_guiSaveSearcString);
  saveTreeSelection.Caption  := GetText(TXT_guiSaveSearchTreeSel);

  Scrollbars.Caption         := GetText(TXT_guiScrollBar);
  Scrollbars.Items[0]        := GetText(TXT_guiRegular);
  SCrollbars.Items[1]        := GetText(TXT_guiFlat);
  Scrollbars.Items[2]        := GetText(TXT_guiWinampStyle);

  GroupBox27.Caption				:= GetText(TXT_Groups);
  ShowGroupsAtFilter.Caption			:= GetText(TXT_ShowGroupsAtFilter);
	ShowGroupsInTree.Caption			:= GetText(TXT_ShowGroupsInTree);
	ShowGroupSettingsInTree.Caption			:= GetText(TXT_ShowGroupSettingsInTree);

  SelectionRectangle.Caption	:= GetText(TXT_SelectionRectangle);
  SelectionRectangle.Items[0]	:= GetText(TXT_OutLined);
  SelectionRectangle.Items[1]	:= GetText(TXT_Solid);

  GroupBox6.Caption          := GetText(TXT_guiProgramIcons);
  sit.Caption                := GetText(TXT_guiProgramIcons1);
  showHide.Caption           := GetText(TXT_guiProgramIcons2);

  GroupBox20.Caption         := GetText(TXT_guiDragNDrop);
  dragPlaylist.Caption       := GetText(TXT_guiDragNDrop11);
  label103.Caption           := GetText(TXT_guiDragNDrop12);
  dragFiles.Caption          := GetText(TXT_guiDragNDrop21);
  Label102.Caption           := GetText(TXT_guiDragNDrop22);
  Label54.Caption						 := GetText(TXT_ThisCanBeToggledWithALT);

  TrayIconOptions.Caption		:= GetText(TXT_guiTrayIconOptions);
  TrayIconOptions.Items[0]	:= GetText(TXT_guiTrayIconOptions1);
  TrayIconOptions.Items[1]	:= GetText(TXT_guiTrayIconOptions2);

  GroupBox14.Caption				:= GetText(TXT_guiShowHints);
  showhnt.Caption						:= GetText(TXT_guiShowHintsToolTip);
  //eo General Settings

  //Main list settings
  GroupBox11.Caption         := GetText(TXT_AutoSearch)+' ';
  SearchMode.Caption         := GetText(TXT_SearchMode)+' ';
  SearchMode.Items[0]        := GetText(TXT_Searchasyoutype);
  SearchMode.Items[1]        := GetText(TXT_SearchAfterXXXtime);
  SearchMode.Items[2]        := GetText(TXT_SearchOnEnter);
  label14.Caption            := GetText(TXT_SearchModeText);

  GroupBox4.Caption          := GetText(TXT_guiFreeTextFields) + ' ';

  SearchInFields.Items.Clear;
  SearchInFields.Items.Add(GetText(TXT_ColumnArtist));
  SearchInFields.Items.Add(GetText(TXT_ColumnTitle));
  SearchInFields.Items.Add(GetText(TXT_ColumnAlbum));
  SearchInFields.Items.Add(GetText(TXT_ColumnComment));
  SearchInFields.Items.Add(GetText(TXT_ColumnGenre));
  SearchInFields.Items.Add(GetText(TXT_ColumnFilePath));
  SearchInFields.Items.Add(GetText(TXT_ColumnFileName));
  for i:=0 to PREDEFINED_SEARCHINFIELDCOUNT - 1 do
  	if settings.ValueExists('SearchInField' + IntToStr(i)) then
    	SearchInfields.Checked[i] := Settings.ReadBool('SearchInField' + IntToStr(i))
    else
    	SearchInfields.Checked[i] := true;
  for i:=0 to FieldList.Count - 1 do
  begin
  	SearchInFields.Items.Add(PCustomField(FieldList.Items[i]).name);
    SearchInFields.Checked[SearchInFields.Items.Count - 1] := PCustomField(FieldList.Items[i]).Filter
  end;

  DeOp.Caption               := GetText(TXT_guiDefaultOperator);
  DeOp.Items[0]              := GetText(TXT_guiDefaultOperator1);
  DeOp.Items[1]              := GetText(TXT_guiDefaultOperator2);

  EnterInSearchfield.Caption	:= GetText(TXT_PressingEnterInSearchField);
  EnterInSearchfield.Items[0]	:= GetText(TXT_Nothing);
  EnterInSearchfield.Items[1]	:= GetText(TXT_PlayAll);
  EnterInSearchfield.Items[2]	:= GetText(TXT_EnqueueAll);

  dblclick.Caption						:= GetText(TXT_DoubleclickingTheList);
  dblclick.Items[0]						:= GetText(TXT_Play);
  dblclick.Items[1]						:= GetText(TXT_Enqueue);
  dblclick.Items[2]						:= GetText(TXT_EnqueueAndPlay);
  dblclick.Items[3]						:= GetText(TXT_PunchIn);
  dblclick.Items[4]						:= GetText(TXT_PunchInAndPlay);

  dontAddIfExistsInWinplayText.Caption	:= GetText(TXT_dontAddIfExistsInWinplay);

  GroupBox19.Caption					:= GetText(TXT_FocusPlayingSongOnChange);
  FollowPlayingML.Caption			:= GetText(TXT_Enabled);

  ColumnsGroupBox.Caption		:= GetText(TXT_Columns);
  AutoResizeColumns.Caption  := GetText(TXT_guiAutoResizeColumns);
  AutoResizeColumnHeaders.Caption	:= GetText(TXT_guiAutoResizeColumnHeaders);
  HideInfoShownInTree.Caption	:= GetText(TXT_guiHideInfoShownInTree);

  fzCol.Caption              := GetText(TXT_guiFileSizeCol);
  fzCol.Items[0]             := GetText(TXT_guiFileSizeCol1);
  fzCol.Items[1]             := GetText(TXT_guiFileSizeCol2);

  SRcol.Caption              := GetText(TXT_guiSampleRateCol);
  SRcol.Items[0]             := GetText(TXT_guiSampleRateCol1);
  SRcol.Items[1]             := GetText(TXT_guiSampleRateCol2);
  CaseSensitiveSort.Caption	 := GetText(TXT_CaseSensitiveSort);
  cbShowTotalDurationLabel.Caption := GetText(TXT_ShowTotalDurationLabel);
  //eo Main list setttings

  //Tree settings
  GroupBox7.Caption				:= GetText(TXT_guiTree);
//  Label6.Caption					:= GetText(TXT_NumberOfTitlesWithSameArtist);
	Label88.Caption					:= GetText(TXT_AutoAdjustTreeOnResize);
//	Label110.Caption				:= GetText(TXT_TheFixNote);
//	TheFix.Caption					:= GetText(TXT_TheFix);
	IndividualSO.Caption		:= GetText(TXT_IndividualSO);

  DblClkTree.Caption						:= GetText(TXT_DblClkTree);
  DblClkTree.Items[0]						:= GetText(TXT_Toggle);
  DblClkTree.Items[1]						:= GetText(TXT_PlayAll);
  DblClkTree.Items[2]						:= GetText(TXT_EnqueueAll);

  GroupBox28.Caption						:= GetText(TXT_Tagging);
  Label27.Caption								:= GetText(TXT_AllowXxxOnDrop);
	TreeTagAltPressed.Caption			:= GetText(TXT_TreeTagAltPressed);
	TreeTagShowConfirm.Caption		:= GetText(TXT_TreeTagShowConfirm);

  GroupBox16.Caption         := GetText(TXT_guiAutoResetSearch);
  Label17.Caption            := GetText(TXT_guiEnableReset);
  Label20.Caption            := GetText(TXT_guiTreeViceVersa);

  CompilationPlacement.Caption	:= GetText(TXT_CompilationPlacement);
  CompilationPlacement.Items[0]	:= GetText(TXT_Before);
  CompilationPlacement.Items[1]	:= GetText(TXT_MergeWithOtherNodes);
  CompilationPlacement.Items[2]	:= GetText(TXT_After);

  RelativePaths.Caption					:= GetText(TXT_RelativePlaylistPath);
  //eo Tree settings

  //Winplaylist settings
  GroupBox15.Caption						:= GetText(TXT_winplaylistEntryFormatting);
  Label58.Caption								:= GetText(TXT_CompilationFiles);
  WinPlayCompilationEnabled.Caption	:= GetText(TXT_enabled);
  Label57.Caption								:= GetText(TXT_UsePattern);

  GroupBox3.Caption							:= GetText(TXT_ControlWinampPlaylist);
  label41.Caption								:= GetText(TXT_ControlWinampPlaylistText);
  ignoreDuplicatesSettings.Caption						:= GetText(TXT_IgnoreDuplicates);
  ignoreDuplicatesSettings.Items[0]					:= GetText(TXT_IgnoreNew);
  ignoreDuplicatesSettings.Items[1]					:= GetText(TXT_ReplaceExisting);

  GroupBox18.Caption						:= GetText(TXT_FocusPlayingSongOnChange);
  FollowPlayingWA.Caption				:= GetText(TXT_Enabled);

  GroupBox2.Caption							:= GetText(TXT_ContinuousPlay);
  Label40.Caption								:= GetText(TXT_ContinuousPlayText);

  GroupBox30.Caption						:= GetText(TXT_WinplayShowColumns);
  Label28.Caption								:= GetText(TXT_WinplayShowColumnsNote);
  //eo Winplaylist settings

  //Quicklist settings
  GroupBox13.Caption         := GetText(TXT_guiTopList);
  toplist.Caption            := GetText(TXT_guiToplist);
  label13.Caption            := GetText(TXT_guiNrOfSongsInToplist);
  topCountShow.Caption       := GetText(TXT_guiShowPlayCount);
  QuicklistClick.Caption		 := GetText(TXT_DblClickQuicklist);
  QuicklistClick.Items[0]		 := GetText(TXT_AddEntireListAndPlaySel);
  QuicklistClick.Items[1]		 := GetText(TXT_PlaySelSong);
  QuicklistClick.Items[2]		 := GetText(TXT_EnqueueSelSong);
  QuicklistClick.Items[3]		 := GetText(TXT_PunchInSelSong);
  //eo Quicklist settings

  //Skin settings
  GroupBox23.Caption				 := GetText(TXT_SelectSkin);
  EditSkinBtn.Caption				 := GetText(TXT_EditSkin);
  GroupBox24.Caption				 := GetText(TXT_guiSettings);
  AutoChangeSkin.Caption		:= GetText(TXT_AutoChangeSkin);
  AllowColoroverride.Caption:= GetText(TXT_AllowColorOverride);
  GetMoreSkinsLabel.Caption	:= GetText(TXT_GetMoreSkinsHere);
  lblSkinComment.Caption := GetText(TXT_ColumnComment) +  ':';
  //eo Skin settings

  //Party Mode settings
  DisableDBmanagement.Caption			:= GetText(TXT_DisableDBmanagement);
	DisableTagging.Caption			:= GetText(TXT_DisableTagging);
	DisableDeleteFromHD.Caption			:= GetText(TXT_DisableDeleteFromHD);
	DisableOrganizeDuplicateFiles.Caption			:= GetText(TXT_DisableOrganizeDuplicateFiles);
	DisableEditQuicklist.Caption			:= GetText(TXT_DisableEditQuicklist);
	DisableEditPlaylist.Caption			:= GetText(TXT_DisableEditPlaylist);
	DisableDeleteMoveWinampPlaylist.Caption			:= GetText(TXT_DisableDeleteMoveWinampPlaylist);
	AlwaysEnqueueToWP.Caption			:= GetText(TXT_AlwaysEnqueueToWP);
	PartyLockColumns.Caption			:= GetText(TXT_PartyLockColumns);
	PartyAllKeySearches.Caption			:= GetText(TXT_PartyAllKeySearches);
	PartyDisablePlaybackControls.Caption			:= GetText(TXT_PartyDisablePlaybackControls);
	PartyDisableVolumeControl.Caption			:= GetText(TXT_PartyDisableVolumeControl);
	partyDisableRemote.Caption			:= GetText(TXT_partyDisableRemote);
	AlwaysEnableKill.Caption			:= GetText(TXT_AlwaysEnableKill);
  GroupBox26.Caption						:= GetText(TXT_LimitMEXP);
  GroupBox25.Caption						:= GetText(TXT_LockWindows);
	LockAltTab.Caption			:= GetText(TXT_LockAltTab);
	LockCtrlAltDel.Caption			:= GetText(TXT_LockCtrlAltDel);
  PartyLimitMouse.Caption			:= GetText(TXT_LockMouse);
  //eo Party Mode settings

  //Tag Correcting
  Label7.Caption             := GetText(TXT_guiTagCorretingText);
  Label11.Caption            := GetText(TXT_guiIfArtistUndef);
  ConvertUnder.Caption       := GetText(TXT_guiConvert_to);
  RemoveBrackets.Caption     := GetText(TXT_guiRemoveBrackets);
  Label10.Caption            := GetText(TXT_guiTitleCropFilename);
  advTrackCalc.Caption       := GetText(TXT_guiAdvancedTrackCalc);
  Label84.Caption            := GetText(TXT_guiUseSubDirs);
  CorrectCasing.Caption			 := GetText(TXT_CorrectCasing);
  SkipId3v1Genre.Caption		 := GetText(TXT_SkipId3v1Genre);
  CorrectTags.Caption				 := GetText(TXT_CorrectTags);
  //eo Tag Correcting

  //ShowCover settings
  GroupBox32.Caption				:= GetText(TXT_ShowCoverText);
  ShowCover.Caption					:= GetText(TXT_Enabled);
  CoverShowHideMB.Caption		:= GetText(TXT_ShowCoverShowHideMB);
  //eo ShowCover

  //Keyboard shortcuts
  HotTree.Header.Columns[0].Text := GetText(TXT_guiShortTree1);
  HotTree.Header.Columns[1].Text := GetText(TXT_guiShortTree2);
  groupBox21.Caption 				 := GetText(TXT_AssignShortcut);
  Label26.Caption            := GetText(TXT_guiEnterNewShortcut);
  Button11.Caption           := GetText(TXT_guiApplyToSelected);
  groupBox12.Caption				:= GetText(TXT_SpecialKeys);
  UseEnterKeyBtn.Caption		:= GetText(TXT_UseEnterKey);
  UseSpaceKeyBtn.Caption		:= GetText(TXT_UseSpaceKey);
  //eo Keyboard Shortcuts
  //Users
  AllowMU.Caption            := GetText(TXT_guiEnableMultipleUsers);
  Label5.Caption             := GetText(TXT_guiUserDBSavedIn);
  Label106.Caption           := GetText(TXT_guiUsersText);
  s := SettingsDir;
  Q_CutRight(s, 1);
  s := MainFormInstance.GetFileName(s, false);
  Label105.Caption           := GetText(TXT_RestartSettings, s);
  //eo User

  //Auto Scan
  label43.Caption            := GetText(TXT_AutoScanText);
  AutoScanSub.Caption        := GetText(TXT_AutoScanScanSub);
  OnlyScanOnceADay.Caption   := GetText(TXT_AutoScanOnceADay);
  Label108.Caption           := GetText(TXT_AutoScanMoveText);
  Button17.Caption           := GetText(TXT_Patterns);
  Button12.Caption           := GetText(TXT_Add);
  Button16.Caption           := GetText(TXT_Remove);
  //eo Auto Scan

  //Fonts & Colors
  Label36.Caption            := GetText(TXT_FontColorsCaption);
  label8.Caption             := GetText(TXT_FontColorsFontName);
  label21.Caption            := GetText(TXT_FontColorsFontSize);
  fontBold.Caption					:= GetText(TXT_Bold);
  fontItalic.Caption				:= GetText(TXT_Italic);
  MainListcolorNote.Caption  := GetText(TXT_FontColorsNote);

  label19.Caption            := GetText(TXT_FontColorsFontColor);
  label101.Caption           := GetTExt(TXT_FontColorsBackgroundColor);
  label22.Caption            := GetText(TXT_FontColorsSelectedTextColor);
  label23.Caption            := GetText(TXT_FontColorsSelectionBarColorFoc);
  label24.Caption            := GetText(TXT_FontColorsSelectionBarColorUnFoc);
  label116.Caption           := GetText(TXT_FontColorsHeaderTextColor);
  label25.Caption            := GetText(TXT_FontColorsSearchFieldFontColor);
  label115.Caption           := GetText(TXT_FontColorsHeaderColor);
  label95.Caption            := GetText(TXT_FontColorsPlayingTextColor);
  label38.Caption            := GetText(TXT_FontColorsKillTextColor);
  //eo Fonts & Colors

  //Id3-editor
  GroupBox22.Caption				:= GetText(TXT_DefaultSettings);
	Id3_autoformatNewText.Caption			:= GetText(TXT_autoformatNewText);
	Id3_SyncTabs.Caption			:= GetText(TXT_SyncTabs);
	Id3_SaveGroups.Caption			:= GetText(TXT_SaveGroups);
	ID3_EnableOnTabChange.Caption			:= GetText(TXT_EnableOnTabChange);
	ID3_AlwaysCopyFromDB.Caption			:= GetText(TXT_AlwaysCopyFromDB);
	Id3_AutoCopyFromDB.Caption			:= GetText(TXT_AutoCopyFromDB);
	ID3_AutoGetLyrics.Caption			:= GetText(TXT_AutoGetLyrics);
	CloseEditorAfterSave.Caption			:= GetText(TXT_CloseEditorAfterSave);
	HideOnEdit.Caption			:= GetText(TXT_HideOnEdit);
	StripId3v2FromUnsupported.Caption			:= GetText(TXT_StripId3v2FromUnsupported);
  GroupBox8.Caption				:= GetText(TXT_EditingValuesInMainList);
  MainListUpdateTags.Caption		:= GetText(TXT_UpdateFileTags);
  Label55.Caption					 := GetText(TXT_UpdateFileTagsNote);
  GroupBox31.Caption			 := GetText(TXT_SaveDatabase);
  saveDB.Caption					 := GetText(TXT_SaveDBText);
  saveDBNote.Caption			 := GetText(TXT_SaveDBNote);
	//eo Id3-editor
  
  ViewModesLabel.Caption := GetText(TXT_ViewModes);
  TreeStructureLabel.Caption := GetText(TXT_SelectedViewMode);

  NewTreeStructureBtn.Caption := GetText(TXT_Add);
  DeleteTreeStructureBtn.Caption := GetText(TXT_Remove);
  RevertSelectedTreeStructureBtn.Caption := GetText(TXT_RevertSelectedViewMode);
  RevertAllTreeStructuresBtn.Caption := GetText(TXT_RevertAllViewModes);


  NewTreeStructureNodeBtn.Caption := GetText(TXT_NewNode);
  DeleteTreeStructureNodeBtn.Caption := GetText(TXT_DeleteNode);
  TreeStructureNodeIncludeCompilationsCB.Caption := GetText(TXT_IncludeCompilations);


  //Check for new version
  Button18.Caption						:= GetText(TXT_CheckForNewVersion);
	BtnGotoHomepage.Caption			:= GetText(TXT_GotoHomepage);
  //eo Check for new version
end;

Procedure TPref.CreatePrefTree;
Function Add(ParentNode:PVirtualNode; Text:String; Tab:TTabSheet; Expanded:boolean=false; Tag:Byte=0):PVirtualNode;
var
	P: Ppt;
begin
	result := preftree.AddChild(ParentNode);
	P := preftree.GetNodeData(result);
	P.text := text;
	P.tab := tab;
	P.Tag := tag;
	P.Expanded := Expanded
end;
var
	aNode, bNode: PVirtualNode;
begin
	preftree.nodedatasize := sizeof(Tpt);
	preftree.beginupdate;
  preftree.clear;

	aNode := Add(nil, GetText(TXT_MusicDatabase), TSMyMusic, true);
  	Add(aNode, GetText(TXT_CustomFields), TSfields);
  	if WinampVersion >= $2900 then
    	Add(aNode, GetText(TXT_FileTypes), TSFileTypes);
		Add(aNode, GetText(TXT_AutoScan), TSdailyscan);
		Add(aNode, GetText(TXT_TagCorrecting), TSid3);

	aNode := Add(nil, GetText(TXT_guiSettings), TSgeneralSettings, true);
		Add(aNode, GetText(TXT_guiMainList), TSmainListSettings);
		bNode := Add(aNode, GetText(TXT_guiTree), TStreeSettings);
    	Add(bNode, GetText(TXT_ViewModes), TStreeViewModes);
      Add(bNode, GetText(TXT_TreeCover), TStreeCovers);

		Add(aNode, GetText(TXT_guiQuicklist), TSquickList);
		Add(aNode, GetText(TXT_guiPlaylist), TSwaPlaylist);
		Add(aNode, GetText(TXT_TagEditor), TSId3Editor);
		Add(aNode, GetText(TXT_guiKeyboardShortcuts), TSshortcuts);
		Add(aNode, GetText(TXT_Partymode), TSpartyMode);
    Add(aNode, GetText(TXT_ShowImages), TSshowCover);
		Add(aNode, GetText(TXT_Skins), TSskin);

		aNode := Add(aNode, GetText(TXT_FontsAndColors), nil);
			Add(aNode, GetText(TXT_guiMainList), TSfontsColors, false, cMainList);
			Add(aNode, GetText(TXT_guiTree), TSfontsColors, false, cTree);
			Add(aNode, GetText(TXT_guiQuicklist), TSfontsColors, false, cQuicklist);
			Add(aNode, GetText(TXT_guiQuicklistPLCON), TSfontsColors, false, cQuicklistSongs);
			Add(aNode, GetText(TXT_guiPlaylist), TSfontsColors, false, cPlaylist);
			Add(aNode, GetText(TXT_SplitterCaptionBars), TSfontsColors, false, cSplitters);
			Add(aNode, GetText(TXT_Captionbarbuttons), TSfontsColors, false, Ccaptionbarbuttons);
			Add(aNode, GetText(TXT_Playingtext), TSfontsColors, false, CplayingLabel);

		Add(nil, GetText(TXT_Users), TSusers);
		Add(nil, GetText(TXT_Checkforupdate), TScheckNewVer);
		Add(nil, GetText(TXT_About), TSabout);
		Add(nil, GetText(TXT_Credits), TScredits);

		preftree.endupdate
end;

Procedure TPref.ExpandTree;
var       aNode:PVirtualNode;
begin
     aNode := PrefTree.GetFirst;
     while aNode <> nil do
     begin
          if Ppt(PrefTree.GetNodeData(aNode)).Expanded then PrefTree.Expanded[aNode] := true;
          aNode := PrefTree.GetNext(aNode)
     end
end;

Procedure TPref.CreateHotTree;
procedure AddMenuItem(mi:TMenuItem; parentNode:PVirtualNode);
var       aNode:PVirtualNode;
          i:integer;
begin
     if (mi.tag>=0) and (assigned(mi.onClick) or (mi.Count>0)) then
     begin
          aNode := hotTree.addChild(parentNode);
					PHotRec(hotTree.GetNodeData(aNode)).Obj := mi;
          for i:=0 to mi.count-1 do
							AddMenuItem(mi.items[i], aNode)
     end
end;
procedure AddMenu(menu:TPopUpMenu);
var       i:integer;
          aNode:PVirtualNode;
begin
     aNode := hotTree.addChild(nil);
     PHotRec(hotTree.GetNodeData(aNode)).Obj := menu;
     for i:=0 to menu.items.Count-1 do
         AddMenuItem(menu.items[i], aNode)
end;
begin
     HotTree.beginupdate;
     HotTree.clear;
     AddMenu(MainFormInstance.filespopup);
     AddMenu(MainFormInstance.treepop);
     AddMenu(MainFormInstance.plBoxPopUp);
     AddMenu(MainFormInstance.qlSongsPop);
		 AddMenu(MainFormInstance.WinplayPop);
		 AddMenu(MainFormInstance.Global); //GLOBAL SKAL LIGGE NEDERST!! ELLERS KIKSER DET NÅR DEN ASSIGNER
     HotTree.endupdate
end;

procedure Tpref.FormCreate(Sender: TObject);
var
	i: Integer;
begin
	rName := '';
	rKey := '';
	LoadLanguageGUI;
  TreeStructureList.NodeDataSize := SizeOf(TTreeData);
	TreeStructureTree.NodeDataSize := SizeOf(TTreeStructureTreeNode);
	HotTree.NodeDataSize := SizeOf(THotRec);
	CreatePrefTree;
	PC.ActivePage := TSabout;
	Icon := MainFormInstance.Icon1.picture.icon;


  cbId3v2FieldLanguage.Items.AddObject(GetText(TXT_Unknown), TObject(UnknownLanguageCode));	//unknown
  FillLanguagesToTStrings(cbId3v2FieldLanguage.Items);

	AllowColorOverride.OnClick := nil;

	try
		begin
			for i:=0 to pref.ComponentCount-1 do
				if pref.Components[i].tag in [1,2] then
				begin
					if (pref.Components[i] is Tcheckbox) and Settings.ValueExists(pref.Components[i].name) then
						(pref.Components[i] as Tcheckbox).checked := Settings.ReadBool(pref.Components[i].name) else
					if (pref.Components[i] is TEdit) and Settings.ValueExists(pref.Components[i].name) then
						(pref.Components[i] as TEdit).text := Settings.ReadString(pref.Components[i].name) else
					if (pref.Components[i] is TSpinEdit) and Settings.ValueExists(pref.Components[i].name) then
						(pref.Components[i] as TSpinEdit).value := Settings.ReadInteger(pref.Components[i].name) else
					if (pref.Components[i] is TRadioButton) and Settings.ValueExists(pref.Components[i].name) then
						(pref.Components[i] as TRadioButton).checked := Settings.ReadBool(pref.Components[i].name);
					if (pref.Components[i] is TRadioGroup) and Settings.ValueExists(pref.Components[i].name) then
						(pref.Components[i] as TRadioGroup).itemindex := Settings.ReadInteger(pref.Components[i].name)
				end
		end;
		except
		end;

		AllowColorOverride.OnClick := AllowColorOverrideClick;

		MainFormInstance.autoresettabel.Interval := resettime.value*1000;
		MainFormInstance.autoresettree.Interval := resettime.value*1000;
		MainFormInstance.filtertimer.Interval := autoquery.Value;

		MainFormInstance.tree.showhint := showhnt.checked;
		MainFormInstance.tabel.showhint := showhnt.checked;
		MainFormInstance.winplaylist.showhint := showhnt.checked;
		MainFormInstance.plcon.showhint := showhnt.checked;
		MainFormInstance.playlistbox.showhint := showhnt.checked;
		MainFormInstance.searchlabel.showhint := showhnt.checked;
		MainFormInstance.f0.showhint := showhnt.checked;
    MainFormInstance.SetTreeCoverSize(TreeCoverWidth.Value, TreeCoverHeight.Value, treeCoverBorder.Value);

		CreateHotTree;
end;

Procedure Tpref.InitFileTypeList;
var
	i:Integer;
begin
	if FileTypeList.Items.Count = 0 then
  begin
  	FileTypeList.Items.BeginUpdate;
		for i:=0 to length(AudioTypes)-1 do
	    FileTypeList.Items.Add(AudioTypes[i].longName);
    FileTypeList.Items.EndUpdate;
    FileTypeListClick(nil)
  end
end;

procedure Tpref.Button1Click(Sender: TObject);
var
	TitleName : string;
	lpItemID : PItemIDList;
	BrowseInfo : TBrowseInfo;
	DisplayName : array[0..MAX_PATH] of char;
	TempPath : array[0..MAX_PATH] of char;
begin
	FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  BrowseInfo.hwndOwner := pref.Handle;
  BrowseInfo.pszDisplayName := @DisplayName;
  TitleName := GetText(TXT_SpecifyDir);
  BrowseInfo.lpszTitle := PChar(TitleName);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  lpItemID := SHBrowseForFolder(BrowseInfo);
	if lpItemId <> nil then
	begin
		SHGetPathFromIDList(lpItemID, TempPath);
		paths.Items.add(TempPath);

		if (length(MainFormInstance.CutBS(TempPath))>0) and (length(MyMusicPattern.text)=0) then
			 MyMusicPattern.text := MainFormInstance.CutBS(TempPath) + '\%artist%\%album%\'
	end;
	//free'er
	GlobalFreePtr(lpItemID);
	button2.enabled := paths.Items.count <> 0
end;

procedure Tpref.Button2Click(Sender: TObject);
var       i:integer;
begin
     i:=0;
     while i < paths.items.count do
           if paths.selected[i] then
              paths.items.delete(i)
           else i:= i+1;
     button2.enabled := paths.Items.count <> 0
end;

procedure TPref.SaveSettings(onlyQuitsave:boolean);
var
	 i,x:integer;
begin
	//Save SearchInFields
  for i:=0 to SearchInFields.Items.Count - 1 do
  	if i < PREDEFINED_SEARCHINFIELDCOUNT then
  		settings.WriteBool('SearchInField' + IntToStr(i), SearchInFields.Checked[i])
    else
    	PCustomField(FieldList.Items[i - PREDEFINED_SEARCHINFIELDCOUNT]).Filter := SearchInFields.Checked[i];

	try
		begin
			for i:=0 to pref.ComponentCount-1 do
				if (pref.Components[i].tag = 2) or (not onlyQuitSave and (pref.Components[i].tag=1)) then
				begin
					if (pref.Components[i] is Tcheckbox) then
						Settings.WriteBool(pref.Components[i].name,(pref.Components[i] as Tcheckbox).checked) else
					if (pref.Components[i] is TEdit) then
						Settings.WriteString(pref.Components[i].name,(pref.Components[i] as TEdit).text) else
					if (pref.Components[i] is TSpinEdit) then
					begin
						x:=(pref.Components[i] as TSpinEdit).value;
						Settings.WriteInteger(pref.Components[i].name,x);
					end;
					if (pref.Components[i] is TRadioButton) then
						Settings.WriteBool(pref.Components[i].name,(pref.Components[i] as TRadioButton).checked) else
					if (pref.Components[i] is TRadioGroup) then
						Settings.WriteInteger(pref.Components[i].name,(pref.Components[i] as TRadioGroup).itemindex)
				end
			end;
		except
		end;
end;

procedure Tpref.SaveButtonClick(Sender: TObject);
procedure writeusedefFile(path:string);
var
	f:textfile;
begin
	if not fileexists(path + UseDefaultDummyFile) then
	begin
		assignfile(f,path + UseDefaultDummyFile);
		Filemode := 2;
		rewrite(f);
		WriteLn(f, DummyFileContents);
		closefile(f)
	end
end;
var
	i: Integer;
	dbindex:integer;
begin
	BasicSettings.WriteBool('MultipleUsers', pref.allowMU.checked);

	//Gemmer default user fil
	for i:=0 to userlist.items.count-1 do
	begin
		if fileexists(plugindir + AppName + '\Users\' + userlist.items[i] + '\' + UseDefaultDummyFile) and not userlist.Checked[i] then
			deletefile(plugindir + AppName + '\Users\' + userlist.items[i] + '\' + UseDefaultDummyFile);
		if (not fileexists(plugindir + AppName + '\Users\' + userlist.items[i] + '\' + UseDefaultDummyFile)) and userlist.Checked[i] then
			writeusedefFile(plugindir + AppName + '\Users\' + userlist.items[i] + '\')
	end;
	//EO Gemmer default user fil

	for i:=0 to paths.items.count-1 do
		if (length(paths.items[i])>1) and (paths.items[i][1]='1') then
			paths.items[i] := Q_CopyFrom(paths.items[i],2);

  if not IndividualSO.Checked and (length(dbs) > 0) then
  	for i:=1 to length(dbs)-1 do
    	dbs[i].TreeStructureIndex := dbs[0].TreeStructureIndex;

	SaveSettings(false);

  if Assigned(FieldTree.FocusedNode) then
		SaveCustomFieldFromNode(FieldTree.FocusedNode);

  MainFormInstance.SetTreeCoverSize(TreeCoverWidth.Value, TreeCoverHeight.Value, treeCoverBorder.Value);

	MainFormInstance.autoresettree.Interval := resettime.value*1000;
	MainFormInstance.autoresettabel.Interval := resettime.value*1000;
	MainFormInstance.filtertimer.Interval := autoquery.Value;
	MainFormInstance.tree.showhint := showhnt.checked;
	MainFormInstance.tabel.showhint := showhnt.checked;
	MainFormInstance.winplaylist.showhint := showhnt.checked;
	MainFormInstance.plcon.showhint := showhnt.checked;
	MainFormInstance.playlistbox.showhint := showhnt.checked;
	MainFormInstance.searchlabel.showhint := showhnt.checked;
	MainFormInstance.f0.showhint := showhnt.checked;

{	if AutoResizeColumns.Checked then             //removed - don't think anyone's using it (18/07-05)
		MainFormInstance.tabel.Header.Options := MainFormInstance.tabel.Header.Options + [hoAutoResize]
  else
  	MainFormInstance.tabel.Header.Options := MainFormInstance.tabel.Header.Options - [hoAutoResize];  }

        for i:=0 to MainFormInstance.ComponentCount-1 do if MainFormInstance.Components[i].ClassType = TVirtualStringTree then
        with (MainFormInstance.Components[i] as TVirtualStringTree) do begin
        if Scrollbars.ItemIndex in [0, 1] then scrollbaroptions.ScrollBars := ssBoth;
        case Scrollbars.ItemIndex of
                0: scrollbaroptions.ScrollBarStyle := sbmRegular;
                1: scrollbaroptions.ScrollBarStyle := sbmFlat;
                2: scrollbaroptions.ScrollBars := ssNone;
				end end;

        dbindex := -1;
        for i:=0 to length(dbs)-1 do if dbs[i].Media = media_harddisk then dbindex := i;
        if dbindex <> -1 then
        begin
             if not dbs[dbindex].Loaded then
             	MainFormInstance.LoadDB(dbindex);
             if not Q_SameText(dbs[dbindex].name, trim(harddisk.text)) then
             begin
                  dbs[dbindex].name := trim(harddisk.text);
                  deleteFile(settingsdir + dbs[dbindex].filename);
                  dbs[dbindex].Filename := ''
             end;
             setLength(dbs[dbindex].paths, paths.items.count);
             setLength(dbs[dbindex].snrs, paths.items.count);
             setLength(dbs[dbindex].excl, excl.items.count);

             for i:=0 to paths.Items.count-1 do
             begin
                  dbs[dbindex].paths[i] := paths.items[i];
                  dbs[dbindex].Snrs[i] := 0
             end;
						 for i:=0 to excl.Items.count-1 do
                 dbs[dbindex].excl[i] := excl.items[i];
             dbs[dbindex].name := harddisk.text;
             dbs[dbindex].media :=0;
						 dbs[dbindex].recursive := true;
						 dbs[dbindex].exists :=true;
             dbs[dbindex].color := Cpanel.SelectionColor;
             dbs[dbindex].UseCustomColor := cbUseCustomDbColor.Checked;
             dbs[dbindex].calculateCRC := CalcCRCcb.Checked;
             dbs[dbindex].repairVBR := repairVBRCB.Checked
        end;

        case DeOp.itemindex of
								0:MainFormInstance.searchlabel.caption := GetText(TXT_SearchOr) + ' ';
								1:MainFormInstance.searchlabel.caption := GetText(TXT_SearchAnd) + ' '
        end;

				MainFormInstance.CreateDirSpys;

				if showhide.Checked then
		    begin
		     	if winamp5Window = 0 then
						i := hwnd_Winamp
		      else
		      	i := winamp5Window
		    end
    		else
		    	i := 0;

        MainFormInstance.ApplyTabelColumnsVisible;

				MainFormInstance.SetSlidersAndPanelFonts;
				TSnapWin(FSnap.GetSnapWin(MainFormInstance.handle)).ShowHideWith := i;
        MainFormInstance.SaveAllNoRelease(false);

        if assigned(sender) then
					modalresult := mrok
end;

Function TPref.BeforeScan(onlyNew: Boolean): Boolean; //returnerer ny OnlyNew
var
	dbIndex, i: Integer;
begin
  loadinglabel.caption := GetText(TXT_PleaseWait);
  screen.Cursor := crAppStart;
  CloseButton.Caption := GetText(TXT_CancelScan);
  CloseButton.Cancel := false;
  SaveButton.enabled := false; //save button
  prefTree.enabled := false;
  TSmymusic.Enabled := false;
  SaveButtonClick(nil);   //save settings

  dbindex := -1;
  for i:=0 to length(dbs)-1 do
  	if dbs[i].Media = media_harddisk then
    	dbindex := i;

    if dbindex = -1 then
    begin
      setlength(dbs,length(dbs)+1);
      dbindex := length(dbs)-1;
      dbs[dbIndex].TreeStructureIndex := MainFormInstance.GetDefaultTreeStructureIndex
    end;
    begin
      if not dbs[dbindex].Loaded then
      	MainFormInstance.LoadDB(dbindex);

      if not Q_SameText(dbs[dbindex].name, trim(harddisk.text)) then
      begin
        dbs[dbindex].name := trim(harddisk.text);
        deleteFile(settingsdir + dbs[dbindex].filename);
        dbs[dbindex].Filename := ''
      end;
      setLength(dbs[dbindex].paths, paths.items.count);
      setLength(dbs[dbindex].snrs, paths.items.count);
      setLength(dbs[dbindex].excl, excl.items.count);
      for i:=0 to paths.Items.count-1 do
      begin
      	dbs[dbindex].paths[i] := paths.items[i];
        dbs[dbindex].Snrs[i] := 0
      end;
      for i:=0 to excl.Items.count-1 do
      	dbs[dbindex].excl[i] := excl.items[i];
      dbs[dbindex].media := 0;
      dbs[dbindex].recursive := true;
      dbs[dbindex].exists :=true;
      dbs[dbindex].color := Cpanel.SelectionColor;
      dbs[dbindex].UseCustomColor := cbUseCustomDbColor.Checked;
      if onlyNew and CalcCRCcb.Checked and not dbs[dbindex].CalculateCRC then
    		onlyNew := false;
      dbs[dbindex].CalculateCRC := CalcCRCcb.Checked;
      dbs[dbindex].repairVBR := repairVBRcb.Checked;
      dbs[dbindex].Loaded := true
    end;
  result := onlyNew
end;

procedure Tpref.Scan1Click(Sender: TObject);
var
	ScanParams: PScanParameters;
begin
	if MainFormInstance.ScanThread.Runing then
  	loadinglabel.Caption := GetText(TXT_AlreadyScanning)
  else
  begin
    BeforeScan(false);
    new(ScanParams);
    SetLength(ScanParams.arr, 1);
    ScanParams.arr[0].master := 0;
    ScanParams.arr[0].name := pref.Harddisk.text;
    ScanParams.arr[0].onlyNew := false;
    ScanParams.arr[0].UpdateTreeAndTabel := true;
    ScanParams.arr[0].RunAfterScan := RunAfterScan;
    ScanParams.arr[0].CalculateCRC := CalcCRCcb.Checked;
    ScanParams.arr[0].repairVBR := repairVBRCB.Checked;
    {$ifndef ScanInMainThread}
    MainFormInstance.ScanThread.Start(ScanParams)
    {$else}
    MainFormInstance.ScanThreadExecute(nil, nil, Pointer(ScanParams));
    {$endif}
  end
end;

procedure TPref.RunAfterScan(Sender: TObject);
begin
 	TSmymusic.enabled := true;
	CloseButton.Cancel := true;
  CloseButton.Caption := GetText(TXT_Close);
	SaveButton.enabled := true;
	prefTree.enabled := true;
end;

procedure Tpref.Scannewremovedeadfiles1Click(Sender: TObject);
var
	ScanParams: PScanParameters;
	onlyNew: boolean;
begin
	if MainFormInstance.ScanThread.Runing then
  	loadinglabel.Caption := GetText(TXT_AlreadyScanning)
  else
  begin
    onlyNew := BeforeScan(true);
    new(ScanParams);
    SetLength(ScanParams.arr, 1);
    ScanParams.arr[0].master := 0;
    ScanParams.arr[0].name := pref.Harddisk.text;
    ScanParams.arr[0].onlyNew := onlyNew;
    ScanParams.arr[0].CalculateCRC := calcCRCcb.Checked;
    ScanParams.arr[0].repairVBR := repairVBRcb.Checked;
    ScanParams.arr[0].UpdateTreeAndTabel := true;
    ScanParams.arr[0].RunAfterScan := RunAfterScan;
    MainFormInstance.ScanThread.Start(ScanParams)
  end
end;

procedure Tpref.FormShow(Sender: TObject);
var     i,k:integer;
begin
        TSmymusic.enabled := true;
        label555.caption := AppName + ' ' + ver;
        button2.enabled := paths.Items.count <> 0;
        loadinglabel.caption :='';
        pbar.Position := 0;
        ExpandTree;
        InitFileTypeList;
        for i:=0 to length(dbs)-1 do
            if dbs[i].media = 0 then
						begin
								 paths.items.clear;
								 excl.items.clear;
								 harddisk.Text := dbs[i].name;
								 CalcCRCcb.Checked := dbs[i].calculateCRC;
                 repairVBRcb.Checked := dbs[i].repairVBR;
                 Cpanel.SelectionColor := dbs[i].color;
                 cbUseCustomDbColor.Checked := dbs[i].UseCustomColor;
                 for k:=0 to length(dbs[i].paths)-1 do
                      paths.items.add(dbs[i].paths[k]);

                 for k:=0 to length(dbs[i].excl)-1 do
                     excl.items.add(dbs[i].excl[k])
            end;

        CheckNewVerLabel.Caption := '';
        BtnGotoHomepage.Visible := false;
end;

procedure Tpref.Button10Click(Sender: TObject);
var
   s:string;
begin
	s := '';
  if MainFormInstance.InputBoxx(GetText(TXT_AddText), GetText(TXT_Prompt), S) then
  	if trim(s) <> '' then
    	excl.items.add(s)
end;

procedure Tpref.Button9Click(Sender: TObject);
var i:integer;
begin
        i:=0;
        while i <> excl.items.count do if excl.selected[i] then excl.items.delete(i) else inc(i)
end;

procedure Tpref.Button11Click(Sender: TObject);
var       Obj:TObject;
          aNode, bNode:PVirtualNode;
begin
	if hottree.SelectedCount = 0 then
		exit;

	Obj := PHotRec(HotTree.GetNodeData(HotTree.GetFirstSelected))^.Obj;
	if not (Obj is TMenuitem) then exit;
	aNode:=hottree.GetFirstSelected;
	while HotTree.GetNodeLevel(aNode)>0 do
		aNode := aNode.Parent;

	WarningHotLabel.Visible := false;

	bNode := aNode.NextSibling;
	aNode := aNode.FirstChild;

	//Checker om den er assigned i forvejen!
	while aNode <> bNode do
	begin
		if ((TObject(PHotRec(HotTree.GetNodeData(aNode))^.Obj) as TMenuitem).ShortCut = hotkey1.hotkey) and (HotTree.Selected[aNode] = false) and (shortcuttotext((TObject(PHotRec(HotTree.GetNodeData(aNode))^.Obj) as TMenuitem).ShortCut) <> '')  then
		begin
			MainFormInstance.showmessageX(GetText(TXT_ShortcutAlreadyAssignedTo, [shortcuttotext(hotkey1.hotkey), (TObject(PHotRec(HotTree.GetNodeData(aNode))^.Obj) as TMenuitem).Caption + '"']));
			exit
		end;
		aNode := HotTree.GetNext(aNode)
	end;

	//Checker global

	if assigned(bNode) then //checker, om den aktualle popupmenu er "Global"
	begin //det er den ikke
		//sætter bNode til Global
		while assigned(bNode.NextSibling) do
			bNode := bNode.NextSibling;

		aNode := bNode.FirstChild;
		while assigned(aNode) do
		begin
			if ((TObject(PHotRec(HotTree.GetNodeData(aNode))^.Obj) as TMenuitem).ShortCut = hotkey1.hotkey) and (HotTree.Selected[aNode] = false) and (shortcuttotext((TObject(PHotRec(HotTree.GetNodeData(aNode))^.Obj) as TMenuitem).ShortCut) <> '')  then
			begin
				WarningHotLabel.Caption := GetText(TXT_ShortcutAlreadyAssignedToGlobal, [shortcuttotext(hotkey1.hotkey), (TObject(PHotRec(HotTree.GetNodeData(aNode))^.Obj) as TMenuitem).Caption]);
				WarningHotLabel.Visible := true;
				//exit ingen exit, den skal assigne alligevel
			end;
			aNode := HotTree.GetNext(aNode)
		end
	end;

	(TObject(PHotRec(HotTree.GetNodeData(HotTree.GetFirstSelected))^.Obj) as TMenuitem).ShortCut := Hotkey1.HotKey;
	HotTree.repaint
end;

procedure Tpref.CancelBtnClick(Sender: TObject);
begin
//        timer1.enabled:=false;
//        httpver.Abort;
        if re ='' then re :='doneerror';
end;

procedure Tpref.TabSheet4Exit(Sender: TObject);
begin
        CancelBtnClick(sender)
end;

procedure Tpref.hideifheightChange(Sender: TObject);
var i:integer;
        s:string;
begin
        s:='';
        if (sender as Tedit).text = '' then exit;
        for i:=1 to length((sender as Tedit).text) do if ord((sender as Tedit).text[i]) in [48..57] then s := s + (sender as Tedit).text[i];
        (sender as Tedit).text := s
end;

procedure Tpref.Shape5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//        lay1.checked := true
end;

procedure Tpref.Label7Click(Sender: TObject);
begin
        showhnt.checked := not showhnt.checked
end;

procedure Tpref.Label88Click(Sender: TObject);
begin
        aatw.checked := not aatw.checked
end;

procedure Tpref.Label93Click(Sender: TObject);
var
	DocFileName : string;
  DocFileDir : string;
begin
  DocFileName := plugindir + AppName + '\MEXPregistrationform.txt';
  DocFileDir := ExtractFileDir(DocFileName);
	ShellExecute(pref.Handle,
							 nil,
							 pChar(DocFileName),
							 nil,
							 pChar(DocFileDir),
							 SW_SHOWNORMAL)
end;


procedure Tpref.Label20Click(Sender: TObject);
begin
        treeviceversa.checked := not treeviceversa.checked
end;

procedure Tpref.Label17Click(Sender: TObject);
begin
        enablereset.checked := not enablereset.checked
end;


procedure Tpref.AllowMUClick(Sender: TObject);
begin
	UserPanel.visible := allowMU.checked;
	if allowMU.checked then
		userdir.caption := Plugindir + AppName + '\Users\' + username
	else
		userdir.caption := Plugindir + AppName + '\Users\standard';
//	settingsdir := userdir.caption +'\' //skal ikke ske endnu
end;

procedure Tpref.Label102Click(Sender: TObject);
begin
        dragfiles.Checked := true
end;

procedure Tpref.Label103Click(Sender: TObject);
begin
        dragplaylist.checked := true
end;

procedure Tpref.TSUsersShow(Sender: TObject);
var
	i:integer;
begin
	UserPanel.visible := allowMU.checked;
	UserFileFind.RootDirectory := plugindir + AppName + '\Users\';
	UserFileFind.Directories.Clear;
	userlist.Clear;
	UserFileFind.Search;
	for i:=0 to UserFileFind.Directories.count -1 do
	begin
		userlist.Items.Add(extractfilename(UserFileFind.Directories.strings[i]));
		if Q_SameText(extractfilename(UserFileFind.Directories.strings[i]), 'Standard') then
			userlist.checked[i] := true
		else
			userlist.Checked[i] := fileexists(plugindir + AppName + '\Users\' + extractfilename(UserFileFind.Directories.strings[i]) + '\' + UseDefaultDummyFile)
	end
end;

procedure Tpref.SearchModeClick(Sender: TObject);
begin
	panel15.visible := SearchMode.itemindex = 1;
	EnterInSearchfield.Enabled := SearchMode.ItemIndex <> 2
end;

procedure Tpref.TSsettingsShow(Sender: TObject);
begin
        panel15.visible := SearchMode.itemindex = 1
end;

procedure Tpref.SearchModeEnter(Sender: TObject);
begin
        panel15.visible := SearchMode.itemindex = 1
end;

procedure Tpref.Button5Click(Sender: TObject);
var
  TitleName : string;
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  BrowseInfo.hwndOwner := pref.Handle;
  BrowseInfo.pszDisplayName := @DisplayName;
  TitleName := GetText(TXT_SpecifyDir);
  BrowseInfo.lpszTitle := PChar(TitleName);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then begin
    SHGetPathFromIDList(lpItemID, TempPath);
    AutoScanMoveToPath.text := TempPath;
    GlobalFreePtr(lpItemID);
  end
end;

procedure Tpref.Label84Click(Sender: TObject);
begin
	UseSubAlbum.checked := not UseSubAlbum.checked
end;

procedure Tpref.HotTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
	var Text: WideString);
const
	andText: String = 'sdflkweloq';
begin
	If TObject(PHotRec(HotTree.GetNodeData(node))^.Obj) is TMenuitem then
	Case column of
		0: Text := (TObject(PHotRec(HotTree.GetNodeData(node))^.Obj) as TMenuitem).Caption;
		1: Text := ShortCutToText((TObject(PHotRec(HotTree.GetNodeData(node))^.Obj) as TMenuitem).ShortCut)
	end else
	Case (TObject(PHotRec(HotTree.GetNodeData(node))^.Obj) as TPopUpMenu).Tag of
		1 : Text := GetText(TXT_guiMainList);
		3 : Text := GetText(TXT_guiTree);
		2 : Text := GetText(TXT_guiPlaylist);
		4 : Text := GetText(TXT_guiQuicklist);
		5: Text := GetText(TXT_guiGlobalShortCuts);
		6 : Text := GetText(TXT_guiQuicklistPLcon)
	end;

	text := Q_ReplaceText(text, '&&', andText);
	text := Q_ReplaceText(text, '&', '');
	text := Q_ReplaceText(text, andText, '&')
end;

procedure Tpref.PrefTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var Text: WideString);
begin
        text := Ppt(preftree.getnodedata(node))^.text
end;

procedure Tpref.PCChange(Sender: TObject);
var     aNode : PvirtualNode;
begin
  preftree.beginupdate;
  aNode := preftree.getfirst;
  while aNode <> nil do
  begin
    if (Ppt(preftree.GetNodeData(aNode))^.Tab <> nil) and (Ppt(preftree.GetNodeData(aNode))^.Tab = PC.activepage) then
    begin
      if Ppt(preftree.GetNodeData(aNode))^.tab = TSFontsColors then
        break;
      preftree.clearselection;
      preftree.isvisible[aNode] := true;
      preftree.Selected[aNode] := true;
      break
    end;
    aNode := preftree.getnext(aNode)
  end;
  preftree.endupdate
end;

procedure Tpref.TSFontsColorsShow(Sender: TObject);
	procedure SetOnChangeValue(wc: TWinControl; Value: TNotifyEvent);
	var
		i: Integer;
	begin
		for i:=0 to wc.ControlCount -1 do
		begin
			if wc.Controls[i] is TJvFontComboBox then TJvFontComboBox(wc.Controls[i]).OnChange := value else
			if wc.Controls[i] is TSpinEdit then TSpinEdit(wc.Controls[i]).OnChange := value else
			if wc.Controls[i] is TCheckBox then TCheckBox(wc.Controls[i]).OnClick := value else
			if wc.Controls[i] is TColorPickerButton then TColorPickerButton(wc.Controls[i]).OnChange := value else
			if wc.Controls[i] is TPanel then SetOnChangeValue(TPanel(wc.Controls[i]), value)
		end
	end;

var     Obj:Integer;
begin
				if Ppt(preftree.getnodedata(preftree.getfirstselected))^.tab <> TSfontsColors then exit;
				SetOnChangeValue(TSFontsColors, nil);
				Label36.Caption := GetText(TXT_FontsAndColors) + '   -  ' +  Ppt(preftree.getnodedata(preftree.getfirstselected))^.text + ' ';
				Obj := Ppt(preftree.getnodedata(preftree.getfirstselected))^.Tag;
				FontColorPanel.visible          := AllowColorOverride.Checked and (Obj in [Ctree, Cquicklist, Cquicklistsongs, CPlaylist, Csplitters, Ccaptionbarbuttons, CplayingLabel]);
				SelTextColorPanel.visible       := AllowColorOverride.Checked and (Obj in [cMainList, cTree, cQuicklist, Cquicklistsongs, CPlaylist]);
				SelBarFocusedPanel.visible      := AllowColorOverride.Checked and (Obj in [cMainList, cTree, cQuicklist, Cquicklistsongs, CPlaylist]);
				SelBarUnFocusedPanel.visible    := AllowColorOverride.Checked and (Obj in [cMainList, cTree, cQuicklist, Cquicklistsongs, CPlaylist]);
				PlayingTxtColorPanel.visible    := AllowColorOverride.Checked and (Obj in [cPlaylist]);
				KillTextColorPanel.visible      := AllowColorOverride.Checked and (Obj in [cPlaylist]);
				HeaderColorPanel.visible        := AllowColorOverride.Checked and (Obj in [cMainList]);
				Backgroundcolorpanel.visible    := AllowColorOverride.Checked and (not (Obj in [Ccaptionbarbuttons, CplayingLabel]));
				MainListColorNote.visible       := AllowColorOverride.Checked and (Obj in [cMainList, cTree]);
				HeaderTextColorPanel.visible    := AllowColorOverride.Checked and (Obj = cMainList);
				FontBold.Visible								:= AllowColorOverride.Checked and (not (Obj in [cMainList, cPlaylist]));
				Fontitalic.Visible							:= AllowColorOverride.Checked and (not (Obj in [cMainList, cPlaylist]));
				SearchFontColorPanel.visible := AllowColorOverride.Checked and (Obj = CcaptionBarButtons);


        case Obj of
                cMainList       :       begin
                                                FB.FontName := MainFormInstance.tabel.Font.Name;
																								FontSize.value := MainFormInstance.tabel.font.size;
																								FontBold.Checked := false; //fsBold in MainFormInstance.tabel.font.Style;
																								FontItalic.Checked := false; //fsItalic in MainFormInstance.tabel.font.Style;
																								BackgroundColor.SelectionColor := MainFormInstance.tabel.color;
																								SelTextColor.SelectionColor := MainFormInstance.tabelSelTextColor;
																								SelBarFocused.selectioncolor := MainFormInstance.tabel.colors.FocusedSelectionColor;
																								SelBarUnFocused.selectioncolor := MainFormInstance.tabel.colors.UnFocusedSelectionColor;
                                                HeaderColor.selectioncolor := MainFormInstance.tabel.Header.Background;
                                                HeaderTextColor.selectioncolor := MainFormInstance.tabel.Header.font.color;
                                        end;

                cTree           :       begin
																								FB.FontName := MainFormInstance.tree.font.name;
																								FontSize.value := MainFormInstance.tree.font.size;
																								FontBold.Checked := fsBold in MainFormInstance.tree.font.Style;
																								FontItalic.Checked := fsItalic in MainFormInstance.tree.font.Style;
																								FontColor.selectioncolor := MainFormInstance.tree.font.color;
                                                BackgroundColor.SelectionColor := MainFormInstance.tree.color;
                                                SelTextColor.SelectionColor := MainFormInstance.TreeSelTextColor;
                                                SelBarFocused.selectioncolor := MainFormInstance.tree.colors.FocusedSelectionColor;
                                                SelBarUnFocused.selectioncolor := MainFormInstance.tree.colors.UnFocusedSelectionColor
                                        end;

								cQuicklist      :       begin
																								FB.FontName := MainFormInstance.playlistbox.font.name;
																								FontSize.value := MainFormInstance.playlistbox.font.size;
																								FontBold.Checked := fsBold in MainFormInstance.playlistbox.font.Style;
																								FontItalic.Checked := fsItalic in MainFormInstance.playlistbox.font.Style;
																								FontColor.selectioncolor := MainFormInstance.playlistbox.font.color;
																								BackgroundColor.SelectionColor := MainFormInstance.playlistbox.color;
																								SelTextColor.SelectionColor := MainFormInstance.PlaylistboxSelTextColor;
																								SelBarFocused.selectioncolor := MainFormInstance.playlistbox.colors.FocusedSelectionColor;
																								SelBarUnFocused.selectioncolor := MainFormInstance.playlistbox.colors.UnFocusedSelectionColor
                                        end;

                Cquicklistsongs:        begin
                                                FB.FontName := MainFormInstance.plcon.font.name;
																								FontSize.value := MainFormInstance.plcon.font.size;
																								FontBold.Checked := fsBold in MainFormInstance.plcon.font.Style;
																								FontItalic.Checked := fsItalic in MainFormInstance.plcon.font.Style;
                                                FontColor.selectioncolor := MainFormInstance.plcon.font.color;
																								BackgroundColor.SelectionColor := MainFormInstance.plcon.color;
																								SelTextColor.SelectionColor := MainFormInstance.plconSelTextColor;
																								SelBarFocused.selectioncolor := MainFormInstance.plcon.colors.FocusedSelectionColor;
																								SelBarUnFocused.selectioncolor := MainFormInstance.plcon.colors.UnFocusedSelectionColor
																				end;

                cPlaylist:              begin
																								FB.FontName := MainFormInstance.winplaylist.font.name;
																								FontSize.value := MainFormInstance.winplaylist.font.size;
																								FontBold.Checked := false; //fsBold in MainFormInstance.tabel.font.Style;
																								FontItalic.Checked := false; //fsItalic in MainFormInstance.tabel.font.Style;
																								FontColor.selectioncolor := MainFormInstance.winplaylist.font.color;
																								BackgroundColor.SelectionColor := MainFormInstance.winplaylist.color;
                                                SelTextColor.SelectionColor := MainFormInstance.winplaylistSelTextColor;
                                                SelBarFocused.selectioncolor := MainFormInstance.winplaylist.colors.FocusedSelectionColor;
                                                SelBarUnFocused.selectioncolor := MainFormInstance.winplaylist.colors.UnFocusedSelectionColor;
                                                PlayingTextColor.selectioncolor := MainFormInstance.Winplayingcolor;
                                                KillTextColor.selectioncolor := MainFormInstance.WinKillcolor
                                        end;

                Csplitters      :       begin
                                                FB.Fontname := MainFormInstance.panel1.font.name;
																								Fontsize.value := MainFormInstance.panel1.font.size;
																								FontBold.Checked := fsBold in MainFormInstance.panel1.font.Style;
																								FontItalic.Checked := fsItalic in MainFormInstance.panel1.font.Style;
                                                fontcolor.selectioncolor := MainFormInstance.panel1.font.color;
                                                BackgroundColor.selectioncolor := MainFormInstance.panel1.color
                                        end;

								Ccaptionbarbuttons:     begin
																								FB.Fontname := MainFormInstance.CollapseButton.font.name;
																								Fontsize.value := MainFormInstance.CollapseButton.font.size;
																								FontBold.Checked := fsBold in MainFormInstance.CollapseButton.font.Style;
																								FontItalic.Checked := fsItalic in MainFormInstance.CollapseButton.font.Style;
																								fontcolor.selectioncolor := MainFormInstance.CollapseButton.font.color;
//                                                ShuffleRepeatEnabledColor.SelectionColor := MainFormInstance.ShuffleRepeatEnabledClr;
//                                                ShuffleRepeatDisabledColor.SelectionColor := MainFormInstance.ShuffleRepeatDisabledClr;
                                                SearchFontColor.SelectionColor := MainFormInstance.f0.Font.color
																				end;
								CplayingLabel:					begin
																								FB.Fontname := MainFormInstance.FCurPlayBitmap.Canvas.font.name;
																								Fontsize.value := MainFormInstance.FCurPlayBitmap.Canvas.font.size;
																								FontBold.Checked := fsBold in MainFormInstance.FCurPlayBitmap.Canvas.font.Style;
																								FontItalic.Checked := fsItalic in MainFormInstance.FCurPlayBitmap.Canvas.font.Style;
																								fontcolor.selectioncolor := MainFormInstance.FCurPlayBitmap.Canvas.font.color
																				end

								end;
	SetOnChangeValue(TSFontsColors, FBChange);
end;

procedure Tpref.FBChange(Sender: TObject);
Procedure RenderFont(F:Tfont);
begin
     F.Name := FB.fontname;
		 F.Size := FontSize.value;
		 if FontBold.Checked then
			F.Style := F.Style + [fsBold]
		 else F.Style := F.Style - [fsBold];
		 if FontItalic.Checked then
			F.Style := F.Style + [fsItalic]
		 else F.Style := F.Style - [fsItalic];
     if fontcolorpanel.visible then f.color := fontcolor.selectioncolor
end;
var
	Obj:Integer;
begin
        Obj := Ppt(preftree.getnodedata(preftree.getfirstselected))^.Tag;

				case Obj of
                cMainList       :       begin
                                                RenderFont(MainFormInstance.tabel.font);
																								MainFormInstance.tabel.color := BackgroundColor.SelectionColor;
																								MainFormInstance.tabelSelTextColor := SelTextColor.SelectionColor;
																								MainFormInstance.tabel.colors.FocusedSelectionColor := SelBarFocused.selectioncolor;
																								MainFormInstance.tabel.colors.UnFocusedSelectionColor := SelBarUnFocused.selectioncolor;
																								MainFormInstance.tabel.header.background := headerColor.selectioncolor;
																								MainFormInstance.tabel.header.font.color := headerTextColor.selectioncolor;
																								//MainFormInstance.AdjustNodeHeight(MainFormInstance.tabel)
																				end;

								cTree           :       begin
                                                RenderFont(MainFormInstance.tree.font);
																								MainFormInstance.tree.color := BackgroundColor.SelectionColor;
																								MainFormInstance.TreeSelTextColor := SelTextColor.SelectionColor;
																								MainFormInstance.tree.colors.FocusedSelectionColor := SelBarFocused.selectioncolor;
																								MainFormInstance.tree.colors.UnFocusedSelectionColor := SelBarUnFocused.selectioncolor;
																								//MainFormInstance.AdjustNodeHeight(MainFormInstance.tree)
																				end;

								cQuicklist      :       begin
																								RenderFont(MainFormInstance.playlistbox.font);
																								MainFormInstance.playlistbox.color := BackgroundColor.SelectionColor;
																								MainFormInstance.PlaylistboxSelTextColor := SelTextColor.SelectionColor;
																								MainFormInstance.playlistbox.colors.FocusedSelectionColor := SelBarFocused.selectioncolor;
																								MainFormInstance.playlistbox.colors.UnFocusedSelectionColor := SelBarUnFocused.selectioncolor;
																								//MainFormInstance.AdjustNodeHeight(MainFormInstance.playlistbox)
                                        end;

								Cquicklistsongs:        begin
                                                RenderFont(MainFormInstance.plcon.font);
                                                MainFormInstance.plcon.color := BackgroundColor.SelectionColor;
																								MainFormInstance.plconSelTextColor := SelTextColor.SelectionColor;
																								MainFormInstance.plcon.colors.FocusedSelectionColor := SelBarFocused.selectioncolor;
																								MainFormInstance.plcon.colors.UnFocusedSelectionColor := SelBarUnFocused.selectioncolor;
																								//MainFormInstance.AdjustNodeHeight(MainFormInstance.plcon)
																				end;

                cPlaylist:              begin
																								RenderFont(MainFormInstance.winplaylist.font);
																								MainFormInstance.winplaylist.color := BackgroundColor.SelectionColor;
																								MainFormInstance.winplaylistSelTextColor := SelTextColor.SelectionColor;
																								MainFormInstance.winplaylist.colors.FocusedSelectionColor := SelBarFocused.selectioncolor;
																								MainFormInstance.winplaylist.colors.UnFocusedSelectionColor := SelBarUnFocused.selectioncolor;
                                                MainFormInstance.Winplayingcolor := PlayingTextColor.selectioncolor;
                                                MainFormInstance.WinKillcolor := KillTextColor.SelectionColor;
																								//MainFormInstance.AdjustNodeHeight(MainFormInstance.winplaylist)

																				end;

								Csplitters      :       begin
																								RenderFont(MainFormInstance.panel1.font);
																								MainFormInstance.panel1.color:=BackgroundColor.SelectionColor;
																								{MainFormInstance.panel1.height := abs(MainFormInstance.panel1.Font.Height) + 3;
																								RenderFont(MainFormInstance.treeplbar.Font);
																								MainFormInstance.treeplbar.height := abs(MainFormInstance.treeplbar.Font.Height) + 3;
                                                RenderFont(MainFormInstance.plconbar.Font);
                                                MainFormInstance.plconbar.height := abs(MainFormInstance.plconbar.Font.Height) + 3;
                                                RenderFont(MainFormInstance.filterbar.Font);
                                                MainFormInstance.filterbar.height := abs(MainFormInstance.filterbar.Font.Height) + 3;
                                                RenderFont(MainFormInstance.WPbar.Font);
																								MainFormInstance.WPbar.height := abs(MainFormInstance.WPbar.Font.Height) + 3;
																								Renderfont(MainFormInstance.WPbarLow.Font);
																								Renderfont(MainFormInstance.winplaylistTimeLabel.Font);
																								MainFormInstance.WPbarLow.height := abs(MainFormInstance.WPbarLow.Font.Height) + 3;    

																								RenderFont(MainFormInstance.MinimizeQ1.font);
																								RenderFont(MainFormInstance.MinimizeQ2.font);
																								RenderFont(MainFormInstance.MinimizeWinplay.font);       

																								MainFormInstance.UpdateSizesTreePanel(MainFormInstance.WPbar)  }
																				end;

								Ccaptionbarbuttons:     begin
																								RenderFont(MainFormInstance.CollapseButton.font);
																								{RenderFont(MainFormInstance.AllButton.font);
																								RenderFont(MainFormInstance.searchlabel.font);
																								RenderFont(MainFormInstance.grouplabel.font);
																								RenderFont(MainFormInstance.clearButton.font);  

																								RenderFont(MainFormInstance.repLabel.Font);
																								RenderFont(MainFormInstance.shuLabel.Font); }
//																								MainFormInstance.ShuffleRepeatEnabledClr := ShuffleRepeatEnabledColor.selectioncolor;
//																								MainFormInstance.ShuffleRepeatDisabledClr := ShuffleRepeatDisabledColor.selectioncolor;
																								MainFormInstance.F0Textcolor := SearchFontColor.SelectionColor;
																				end;
							CplayingLabel:						begin
																								RenderFont(MainFormInstance.FCurPlayBitmap.Canvas.Font);
//																								MainFormInstance.CurrentPlayingTextColor := MainFormInstance.curPlayLabel.Font.Color
																				end
								end;
	MainFormInstance.SetSlidersAndPanelFonts
end;

procedure Tpref.PrefTreeFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
     finalize(Ppt(preftree.getnodedata(node))^)
end;

procedure Tpref.PrefTreeChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
	if not sender.Selected[Node] then
		exit;

	if Ppt(preftree.GetNodeData(Node))^.Tab <> nil then
		PC.activepage := Ppt(preftree.GetNodeData(Node))^.Tab;
		
	if PC.activepage = TSFontsColors then
		TSFontsColorsShow(nil)
end;

procedure Tpref.pathsClick(Sender: TObject);
begin
	button2.enabled := paths.Items.count <> 0
end;

procedure Tpref.Button14Click(Sender: TObject);
begin
     MainFormInstance.showmessageX(PatternHelpText, taLeftJustify)
end;

procedure Tpref.Button12Click(Sender: TObject);
var
  TitleName : string;
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  BrowseInfo.hwndOwner := pref.Handle;
  BrowseInfo.pszDisplayName := @DisplayName;
  TitleName := GetText(TXT_SpecifyDir);
  BrowseInfo.lpszTitle := PChar(TitleName);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then begin
    SHGetPathFromIDList(lpItemID, TempPath);
    AutoScanPaths.items.add(TempPath);
    GlobalFreePtr(lpItemID);
  end
end;

procedure Tpref.Button16Click(Sender: TObject);
var       i:integer;
begin
     i:=0;
     while i < AutoScanPaths.items.count do
           if AutoScanPaths.selected[i] then
              AutoScanPaths.items.delete(i)
           else i:= i+1;
     button16.enabled := AutoScanPaths.Items.count <> 0
end;

procedure Tpref.HotTreeChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var     Obj:TObject;
begin
     if sender.Selected[Node] then
     begin
          Obj := PHotRec(sender.GetNodeData(Node)).Obj;
          Hotkey1.enabled := (Obj is TMenuItem) and (TMenuItem(Obj).count=0);
          button11.enabled := Hotkey1.enabled;
          if Hotkey1.enabled then
             Hotkey1.HotKey := TMenuItem(Obj).Shortcut
     end
end;

procedure Tpref.Label40Click(Sender: TObject);
begin
	updateContPlayOnFilter.checked := not updateContPlayOnFilter.checked;
end;

procedure Tpref.ControlPlaylistClick(Sender: TObject);
begin
	if not initializing then
  begin
   if ControlPlaylist.checked then
      MainFormInstance.ValidateWinPlaylist(-1)
   else
   begin
        MainFormInstance.deltaPlaylist := 0;
        MainFormInstance.winplaysave
   end
  end
end;

procedure Tpref.Label41Click(Sender: TObject);
begin
     ControlPlaylist.Checked := not ControlPlaylist.Checked;
     //ControlPlaylistClick(nil) køres automatisk når ovenstående linie udføres
end;

procedure Tpref.Button18Click(Sender: TObject);
function GetHttpString(const url: String; var output: String): Boolean;
var
	server, username, password: String;
  port: Integer;
begin
  if MainFormInstance.GetProxySettingsFromWinamp(Server, Port, username, password) then
  begin
  	IdHttp.ProxyParams.ProxyServer := server;
    IdHttp.ProxyParams.ProxyPort := port;
    IdHttp.ProxyParams.ProxyUsername := username;
    IdHttp.ProxyParams.ProxyPassword := password
  end;

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
//  result := GetHTML(handle, url, 'Downloading...', output)
end;
var
	s, returnedString:string;
  failed : boolean;
begin
     screen.cursor := crHourglass;
     CheckNewVerLabel.caption := GetText(TXT_Connecting);
     application.processmessages;
     failed := true;
     if GetHttpString(VerFileURL, returnedString) then
     if (Q_PosText('ENDURL', returnedString)>0) then
     begin
          s := Q_CopyRange(returnedString, 1, Q_StrScan(returnedString, #10)-1);
          Q_TrimInPlace(s);
          if (length(s)>0) and not Q_SameText(ver, s) then
          begin
               webURL := Q_CopyFrom(returnedString, Q_PosText('http://', returnedString));
               webURL := Q_CopyRange(webURL, 1, Q_PosText('ENDURL', webURL)-1);
               if length(webURL)>0 then
               begin
                    CheckNewVerLabel.Caption := GetText(TXT_NewVersionAvailable) + #13 + s;
                    BtnGotoHomepage.Visible := true;
                    failed := false;
                    //checker om der er en xtra besked
                    s := trim(Q_CopyFrom(returnedString, Q_PosText('ENDURL', returnedString)+6));
                    if length(s)>0 then
                        MainFormInstance.showmessageX(CheckNewVerLabel.Caption + #13#13 + s, taLeftJustify)

               end
          end else if Q_SameText(ver, trim(s)) then
          begin
               CheckNewVerLabel.Caption := GetText(TXT_NoNewAvailable);
               failed := false
          end
     end;
     if failed then
        CheckNewVerLabel.Caption := GetText(TXT_ErrorConnecting);
     screen.cursor := crDefault
end;

procedure Tpref.BtnGotoHomepageClick(Sender: TObject);
begin
	shellexecute(handle,'open',pchar(webURL),nil,nil,sw_shownormal)
end;

procedure Tpref.Button19Click(Sender: TObject);
begin
		 shellexecute(handle,'open',pchar(plugindir + AppName + '\help-guide\help-guide.htm'),nil,nil,sw_shownormal)
end;

procedure Tpref.Label56Click(Sender: TObject);
begin
	individualSO.Checked := not individualSO.Checked
end;

procedure Tpref.UseEnterKeyBtnClick(Sender: TObject);
var
	st: TShiftState;
begin
	st := [];
	if specialKeyAlt.checked then
		st := [ssAlt];
	if specialKeyCtrl.checked then
		st := st + [ssCtrl];
	if specialKeyShift.checked then
		st := st + [ssShift];
	if Sender = UseEnterKeyBtn then
		HotKey1.HotKey := Shortcut(VK_RETURN, st)
	else
	if Sender = UseSpaceKeyBtn then
		HotKey1.HotKey := Shortcut(VK_SPACE, st);
	Button11Click(nil)
end;

procedure Tpref.ScanThreadExecute(Sender: TObject;
	Thread: TBMDExecuteThread; var Data: Pointer);
var
	ScanParams: PScanParameters;
  i: integer;
begin
	ScanParams := data;
  for i:=0 to length(ScanParams.arr)-1 do
		MainFormInstance.Scan(ScanParams.arr[i].master, ScanParams.arr[i].name, Thread, ScanParams.arr[i].onlyNew, ScanParams.arr[i].CalculateCRC, ScanParams.arr[i].repairVBR, ScanParams.arr[i].UpdateTreeAndTabel);

  for i:=0 to length(ScanParams.arr)-1 do
		if assigned(ScanParams.arr[i].RunAfterScan) then
			ScanParams.arr[i].RunAfterScan(nil);

  SetLength(ScanParams.arr, 0);
  Dispose(ScanParams)
end;

    {
procedure Tpref.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	if MainFormInstance.ScanThread.Runing then
		Action := caNone
end;    }

procedure Tpref.WinPlayCompilationEnabledClick(Sender: TObject);
begin
	WinPlayCompilationTitleFormatEdit.Enabled := WinPlayCompilationEnabled.Checked
end;

procedure Tpref.TSskinShow(Sender: TObject);
var
	i: Integer;
begin
	MainFormInstance.RefreshSkinArray;
	SkinBox.Items.Clear;

	for i:=0 to Length(SkinArray)-1 do
	begin
		SkinBox.Items.Add(SkinArray[i].Name);
		if SkinArray[i].InUse then
			SkinBox.ItemIndex := i
	end;
	UpdateSkinInfoLabels;

	EditSkinBtn.Visible := fileexists(SkinnerFileName)
end;

procedure Tpref.SkinBoxClick(Sender: TObject);
var
	i, oldIndex: Integer;
begin
	oldIndex := -1;
	if SkinBox.ItemIndex >= 0 then
	begin
		for i:=0 to Length(SkinArray)-1 do
		begin
			if Q_SameText(SkinArray[i].Name, CurrentSkin) then
				oldIndex := i;
			SkinArray[i].InUse := i = SkinBox.ItemIndex
		end;

		CurrentSkin := SkinArray[SkinBox.ItemIndex].Name;
		MainFormInstance.LoadSkin(SkinBox.ItemIndex, oldIndex);
		MainFormInstance.SetSlidersAndPanelFonts;
		MainFormInstance.repaint
	end;
	UpdateSkinInfoLabels
end;

Procedure TPref.UpdateSkinInfoLabels;
function FixUrl(url: string): String;
begin
	if Q_SameTextL('http://', url, 7) then
  	Q_CutLeft(url, 7);
  result := url
end;
begin
	SkinAuthorLabel.Caption := GetText(TXT_Author) + ': ' + SkinArray[SkinBox.ItemIndex].Author;
  skinAuthorLink.Caption := FixUrl(SkinArray[SkinBox.itemIndex].AuthorURL);
  skinAuthorLink.URL := FixUrl(SkinArray[SkinBox.itemIndex].AuthorURL);
  skinWinampLink.Caption := FixUrl(SkinArray[SkinBox.itemIndex].CorrespondToURL);
  skinWinampLink.URL := FixUrl(SkinArray[SkinBox.itemIndex].CorrespondToURL);

	if SkinArray[SkinBox.ItemIndex].CorrespondTo = '' then
		SkinCorrespondingWinampLabel.Caption := ''
	else
		SkinCorrespondingWinampLabel.Caption := GetText(TXT_CorrespondTo) + ': ' + SkinArray[SkinBox.ItemIndex].CorrespondTo;

  if length(Trim(SkinArray[SkinBox.ItemIndex].Comment)) > 0 then
  begin
  	lblSkinComment.Visible := true;
	  SkinCommentsLabelValue.Caption := SkinArray[SkinBox.ItemIndex].Comment
  end else
  begin
  	lblSkinComment.Visible := false;
  	SkinCommentsLabelValue.Visible := false;
  end
end;

procedure Tpref.EditSkinBtnClick(Sender: TObject);
begin
	WinExec(pchar(SkinnerFileName + ' "' + SkinArray[SkinBox.ItemIndex].Filename + '"'), SW_SHOWNORMAL);
end;

procedure Tpref.AllowColorOverrideClick(Sender: TObject);
var
	i, k: Integer;
begin
	k := -1;
	AllowColorOverride.OnClick := nil;
	for i:=0 to Length(SkinArray)-1 do
		if SkinArray[i].InUse then
			k := i;

  if k >= 0 then
  begin
		//ja, det skal være så bøvlet...
		AllowColorOverride.Checked := not AllowColorOverride.Checked;
		MainFormInstance.LoadSkin(k, k);
		AllowColorOverride.Checked := not AllowColorOverride.Checked;
		MainFormInstance.LoadSkin(k, -1);
		AllowColorOverride.OnClick := AllowColorOverrideClick
  end
end;

procedure Tpref.ScanButtonClick(Sender: TObject);
var
	i:integer;
	pt:Tpoint;
begin
  if paths.Items.count = 0 then
  begin
    MainFormInstance.showmessageX(GetText(TXT_BeforeScanningAdd));
    exit
  end;

  i:=0;
  while i < paths.items.count do
  begin
    if not directoryexists(paths.items[i]) then
      paths.items.delete(i)
    else
      i:= i+1
  end;

  button2.enabled := paths.Items.count <> 0;
  pt := TSMyMusic.ClientToScreen(point(ScanButton.left,ScanButton.top));
  if reclist.Count > 0 then
    scanpopup.Popup(pt.x, pt.y+ScanButton.height)
  else
    Scan1Click(sender)
end;

procedure Tpref.ShowGroupsInTreeClick(Sender: TObject);
begin
	ShowGroupSettingsInTree.Enabled := ShowGroupsInTree.Checked
end;

procedure Tpref.TStreeSettingsShow(Sender: TObject);
begin
	TreeTaggingClick(nil)
end;

procedure Tpref.Label27Click(Sender: TObject);
begin
	treeTagging.Checked := not treeTagging.Checked
end;

procedure Tpref.TreeTaggingClick(Sender: TObject);
begin
	TreeTagShowConfirm.Enabled := treeTagging.Checked;
	TreeTagAltPressed.Enabled := treeTagging.Checked
end;

procedure Tpref.TSmainListSettingsShow(Sender: TObject);
begin
	SearchModeClick(nil)
end;

procedure Tpref.WinplayShowColumnsClick(Sender: TObject);
begin
	MainFormInstance.SetWinplayColumns(false)
end;

procedure Tpref.ShowCoverClick(Sender: TObject);
begin
	CoverShowHideMB.Enabled := ShowCover.Checked
end;

procedure Tpref.TSshowCoverShow(Sender: TObject);
begin
	CoverShowHideMB.Enabled := ShowCover.Checked
end;

procedure Tpref.dontAddIfExistsInWinplayTextClick(Sender: TObject);
begin
	dontAddIfExistsInWinplay.Checked := not dontAddIfExistsInWinplay.Checked
end;

procedure Tpref.CloseButtonClick(Sender: TObject);
begin
	if CloseButton.Cancel then
  	ModalResult := mrCancel
  else
  	MainFormInstance.StopScanning
end;

procedure Tpref.FileTypeListClick(Sender: TObject);
function GetExtString(index: Integer): String;
var
	i: Integer;
begin
	result := '';
  for i:=0 to length(AudioTypes[index].Ext)-1 do
  	result := result + AudioTypes[index].Ext[i] + '; ';
  if length(result) > 0 then
  	Q_CutRight(result, 2)
end;
var
	index: Integer;
begin
	FFileTypeSettingsLoading := true;
	Index := FileTypeList.ItemIndex;
  if index >= 0 then
  begin
  	LongNameEdit.Text := AudioTypes[index].longName;
    ShortNameEdit.Text := AudioTypes[index].shortName;
    FileExtEdit.Text := GetExtString(index);
    SupportsId3v1.Checked := AudioTypes[index].Id3v1;
    SupportsId3v2.Checked := AudioTypes[index].Id3v2;
    SupportsApeV1.Checked := AudioTypes[index].ApeV1;
    SupportsApeV2.Checked := AudioTypes[index].ApeV2;
    FTAudioCB.Checked := AudioTypes[index].audio;
    FTVideoCB.Checked := AudioTypes[index].video;
  end
  else
  begin
  	LongNameEdit.Text := '';
    ShortNameEdit.Text := '';
    FileExtEdit.Text := '';
    SupportsId3v1.Checked := false;
    SupportsId3v2.Checked := false;
    SupportsApeV1.Checked := false;
    SupportsApeV2.Checked := false;
    FTAudioCB.Checked := false;
    FTVideoCB.Checked := false;
  end;
//	FTSaveToSelectedBtn.Enabled := (index < 0) or (index >= PREDEFINED_AUDIOTYPESCOUNT);
  FTDeleteSelectedBtn.Enabled := index >= PREDEFINED_AUDIOTYPESCOUNT;
  GroupBoxSelectedFiletype.Visible := FileTypeList.ItemIndex >= 0;
  FFileTypeSettingsLoading := false
end;

procedure TPref.AudioTypeFileExtFromString(index: Integer; s: String);
var
	d: String;
begin
	SetLength(AudioTypes[index].Ext, 0);
	Q_TrimInPlace(s);
  while length(s) > 0 do
  begin
  	if Q_StrScan(s, ';') > 0 then
    begin
    	d := Q_CopyRange(s, 1, Q_StrScan(s, ';')-1);
      Q_CutLeft(s, Q_StrScan(s, ';'))
    end
    else
    begin
    	d := s;
      s := ''
    end;
    Q_TrimInPlace(d);
    if length(d) > 1 then
    begin
    	if d[1] = '*' then
      	Q_CutLeft(d, 1);
      if d[1] <> '.' then
      	d := '.' + d;

     	SetLength(AudioTypes[index].Ext, length(AudioTypes[index].Ext)+1);
      AudioTypes[index].Ext[length(AudioTypes[index].Ext)-1] := d
    end;
  	Q_TrimInPlace(s)
  end
end;

procedure Tpref.FTSaveToSelectedBtnClick(Sender: TObject);
var
	index: Integer;
begin
	if FFileTypeSettingsLoading then
  	exit;
    
	Index := FileTypeList.ItemIndex;
  if index >= 0 then
  begin
  	AudioTypes[index].longName := Trim(LongNameEdit.Text);
    AudioTypes[index].shortName := Trim(ShortNameEdit.Text);
    AudioTypeFileExtFromString(index, FileExtEdit.Text);
    AudioTypes[index].Id3v1 := SupportsId3v1.Checked;
    AudioTypes[index].Id3v2 := SupportsId3v2.Checked;
    AudioTypes[index].ApeV1 := SupportsApeV1.Checked;
    AudioTypes[index].ApeV2 := SupportsApeV2.Checked;
    AudioTypes[index].audio := FTAudioCB.Checked;
	  AudioTypes[index].video := FTVideoCB.Checked
  end;
  MainFormInstance.FixAudioTypesSortOrder
end;

procedure Tpref.FTSaveAsNewBtnClick(Sender: TObject);
var
	index: Integer;
begin
  SetLength(AudioTypes, Length(AudioTypes)+1);
  FileTypeList.Items.Add(GetText(TXT_NewTreeStructure));
  index := length(AudioTypes)-1;
  AudioTypes[index].longName := GetText(TXT_NewTreeStructure);
  AudioTypes[index].shortName := GetText(TXT_NewTreeStructure);
  FileExtEdit.Text := '';
  AudioTypes[index].Id3v1 := false;
  AudioTypes[index].Id3v2 := false;
  AudioTypes[index].ApeV1 := false;
  AudioTypes[index].ApeV2 := false;
  AudioTypes[index].audio := false;
  AudioTypes[index].video := false;
  FileTypeList.ItemIndex := index;
  FileTypeListClick(sender);
  MainFormInstance.FixAudioTypesSortOrder
end;

procedure Tpref.FTDeleteSelectedBtnClick(Sender: TObject);
var
	i, j, atIndex: Integer; //AudioType-index
	list: TList;
  rec: PRec;
begin
	atIndex := FileTypeList.ItemIndex;

	if (atIndex >= 0) and MainFormInstance.YesNoBoxx(GetText(TXT_DeleteFileTypeQ, [AudioTypes[atIndex].longName]), GetText(TXT_DeleteFileTypeQText), GetText(TXT_Yes), GetText(TXT_No), 2) then
	begin
		screen.Cursor := crhourglass;

  	MainFormInstance.tabel.beginupdate;

    //Fylder alle recs over i listen - vær sikker på ingen kommer dobbelt!
    list := TList.Create;
    list.Capacity := reclist.Count + addreclist.Count;
    for i:=0 to reclist.Count-1 do
    	if list.IndexOf(reclist.List^[i]) = -1 then
	    	list.Add(reclist.List^[i]);
    for i:=0 to addreclist.Count-1 do
    	if list.IndexOf(addreclist.List^[i]) = -1 then
	    	list.Add(addreclist.List^[i]);

	  for i:=list.Count-1 downto 0 do
	  begin
    	rec := list.Items[i];
      if rec.AudioType = atIndex then
      begin
        //Fjern fra reclist'erne
        j := reclist.IndexOf(rec);
        while j >= 0 do
        begin
        	reclist.Items[j] := nil;
          j := reclist.IndexOf(rec)
        end;

        j := addreclist.IndexOf(rec);
        while j >= 0 do
        begin
        	addreclist.Items[j] := nil;
          j := addreclist.IndexOf(rec)
        end;

        //Release/dispose
        Include(rec.Flags, rfDeletePending)
//        MainFormInstance.ReleaseRec(rec, false);
//		  	MainFormInstance.DisposeRec(rec);
      end
      else
      if rec.AudioType > atIndex then
      	dec(rec.AudioType)
  	end;

    MainFormInstance.ReleaseRecs(false, true);
    reclist.Pack;
    addreclist.Pack;

    //Fjern AudioType
    MainFormInstance.RemoveAudioType(atIndex);

  	MainFormInstance.reclisttotabel(false, true);
  	MainFormInstance.ShowHideNodes;

	  MainFormInstance.tabel.endupdate;

	  MainFormInstance.UpdateTree(false);
	  MainFormInstance.SaveAllNoRelease(true);

    FileTypeList.Clear;
    InitFileTypeList;
    MainFormInstance.FixAudioTypesSortOrder;

	  screen.cursor := crdefault
  end;

end;

procedure Tpref.TreeStructureListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
begin
	CellText := PTreeStructure(PTreeData(Sender.GetNodeData(Node)).p).Text
end;

procedure Tpref.TreeStructureListFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
	TreeStructure: PTreeStructure;
begin
	TreeStructure := PTreeData(Sender.GetNodeData(Node)).p;
  FreeTreeStructure(TreeStructure)
end;

procedure Tpref.NewTreeStructureBtnClick(Sender: TObject);
var
	TreeStructure: PTreeStructure;
begin
  TreeStructureList.BeginUpdate;
	New(TreeStructure);
	FillChar(TreeStructure^, SizeOf(TreeStructure^), 0);

  PTreeData(TreeStructureList.GetNodeData(TreeStructureList.AddChild(nil))).p := TreeStructure;

  TreeStructure.Index := TreeStructureList.RootNodeCount-1;
  TreeStructure.PreDefinedIndex := -1;
  TreeStructure.Text := GetText(TXT_NewTreeStructure);
  TreeStructureList.EndUpdate
end;

procedure Tpref.TreeStructureListChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
procedure AddToTreeStructureTree(tsNode: PTreeStructureNode; ParentNode: PVirtualNode);
var
	aNode: PVirtualNode;
  tstNode: PTreeStructureTreeNode;
begin
	aNode := TreeStructureTree.AddChild(parentNode);
  tstNode := TreeStructureTree.GetNodeData(aNode);
  tstNode.Content := tsNode.Content;
  tstNode.IncludeCompilation := tsNode.IncludeCompilation;
  tstNode.CustomFieldIndex := tsNode.CustomFieldIndex;
  tstNode.SortColumnField := tsNode.SortColumnField;
  tstNode.MinCount := tsNode.MinCount;

  if Assigned(tsNode.Child) then
  	AddToTreeStructureTree(tsNode.Child, aNode);

  if Assigned(tsNode.NextSibling) then
  	AddToTreeStructureTree(tsNode.NextSibling, ParentNode);

  TreeStructureTree.Expanded[aNode] := true
end;

var
  TS: PTreeStructure;
begin
	TreeStructureTree.BeginUpdate;
	TreeStructureTree.Clear;

	if Sender.Selected[Node] then
  begin
  	TS := PTreeData(Sender.GetNodeData(Node)).p;
    RevertSelectedTreeStructureBtn.Enabled := TS.PreDefinedIndex >= 0;
    if Assigned(TS.Head) then
    	AddToTreeStructureTree(TS.Head, nil)
  end
  else
  	RevertSelectedTreeStructureBtn.Enabled := false;

  NewTreeStructureNodeBtn.Enabled := Sender.Selected[Node];
  DeleteTreeStructureBtn.Enabled := Sender.Selected[Node] and (TreeStructureList.RootNodeCount > 1);

  TreeStructureTree.EndUpdate
end;

Procedure Tpref.SaveTreeStructureTreeToTreeStructure(p: PTreeStructure);
Function SaveNode(Node: PVirtualNode): PTreeStructureNode;
var
	tstNode: PTreeStructureTreeNode;
  aNode: PVirtualNode;
begin
	tstNode := TreeStructureTree.GetNodeData(Node);
  Result := NewTreeStructureNode(tstNode.Content, tstNode.IncludeCompilation);
  Result.CustomFieldIndex := tstNode.CustomFieldIndex;
  Result.SortColumnField := tstNode.SortColumnField;
  result.MinCount := tstNode.MinCount;

  aNode := TreeStructureTree.GetFirstChild(Node);
  if Assigned(aNode) then
  	Result.Child := SaveNode(aNode);

  aNode := TreeStructureTree.GetNextSibling(Node);
  if Assigned(aNode) then
  	Result.NextSibling := SaveNode(aNode)
end;

var
	aNode: PVirtualNode;
begin
	if Assigned(p.Head) then
  	FreeTreeStructureNode(p.Head);
  p.Head := nil;

  aNode := TreeStructureTree.GetFirst;
	if Assigned(aNode) then
	  p.Head := SaveNode(TreeStructureTree.GetFirst)
end;

Procedure Tpref.SaveTreeStructureTreeToSelectedTreeStructure;
var
	aNode: PVirtualNode;
begin
	aNode := TreeStructureList.GetFirstSelected;
  if Assigned(aNode) then
		SaveTreeStructureTreeToTreeStructure(PTreeData(TreeStructureList.GetNodeData(aNode)).p)
end;

Function Tpref.GetIndexFromTreeStructureContent(tsc: TTreeStructureContents; customFieldIndex:integer): Integer;
var
	i, testTsc: integer;
begin
	result := 0;

  for i:=0 to TreeStructureNodeContent.Items.Count-1 do
  begin
  	testTsc := integer(TTreeStructureContents(TreeStructureNodeContent.Items.Objects[i]));
    if ((i < FTreeViewCustomFieldStartIndex) and (testTsc = integer(tsc)))
    or ((i >= FTreeViewCustomFieldStartIndex) and (testTsc = integer(tscCustomField)+customFieldIndex)) then
    begin
    	result := i;
      break
    end
  end

	{case tsc of
  	tscCompilationContainer	:	result := 0;
    tscCompilations         : result := 1;
    tscArtistsSortOrder			: result := 2;
		tscArtists							: result := 3;
		tscAlbums								: result := 4;
    tscYear_Albums				 	: result := 5;
    tscArtist_albums				: result := 6;
    tscYears								: result := 7;
    tscDecades 							: result := 8;
    tscSets									: result := 9;
		tscGenres								: result := 10;
    tscDrives								: result := 11;
    tscDrivesRecursive			: result := 12;
		tscDirectories					: result := 13;
    tscDirectoriesRecursive	: result := 14;
    tscTrimmedDirectories		: result := 15;
    tscTrimmedDirectoriesRecursive		: result := 16;
    tscRatings								: result := 17;
    tscCustomField					: result := TreeViewCustomFieldStartIndex + customFieldIndex;
  end  }
end;

Function Tpref.GetTreeStructureContentFromIndex(index: Integer; var customFieldIndex:integer): TTreeStructureContents;
var
	testTsc: integer;
begin
  testTsc := integer(TTreeStructureContents(TreeStructureNodeContent.Items.Objects[index]));

  if index < FTreeViewCustomFieldStartIndex then
  begin
  	result := TTreeStructureContents(testTsc);
    customFieldIndex := -1
  end
  else
  begin
  	result := tscCustomField;
    customFieldIndex := testTsc - integer(tscCustomField)
  end

{	if index < TreeViewCustomFieldStartIndex then
  begin
  	customFieldIndex := -1;
		case index of
      0: result := tscCompilationContainer;
      1: result := tscCompilations;
      2: result := tscArtistsSortorder;
      3: result := tscArtists;
      4: result := tscAlbums;
      5: result := tscYear_Albums;
      6: result := tscArtist_albums;
      7: result := tscYears;
      8: result := tscDecades;
      9: result := tscSets;
      10: result := tscGenres;
      11: result := tscDrives;
      12: result := tscDrivesRecursive;
      13: result := tscDirectories;
      14: result := tscDirectoriesRecursive;
      15: result := tscTrimmedDirectories;
      16: result := tscTrimmedDirectoriesRecursive;
      17: result := tscRatings
    end
  end else
  begin
  	result := tscCustomField;
    customFieldIndex := index - TreeViewCustomFieldStartIndex
  end  }
end;

procedure Tpref.TreeStructureNodeContentChange(Sender: TObject);
var
	tstn: PTreeStructureTreeNode;
begin
//	UpdateTreeViewModeCustomFieldCombobox;

	tstn := TreeStructureTree.GetNodeData(TreeStructureTree.GetFirstSelected);
  tstn.Content := GetTreeStructureContentFromIndex(TreeStructureNodeContent.ItemIndex, tstn.CustomFieldIndex);
  TreeStructureTree.InvalidateNode(TreeStructureTree.GetFirstSelected);
	SaveTreeStructureTreeToSelectedTreeStructure
end;

procedure Tpref.TreeStructureNodeIncludeCompilationsCBClick(Sender: TObject);
var
	tstn: PTreeStructureTreeNode;
begin
	tstn := TreeStructureTree.GetNodeData(TreeStructureTree.GetFirstSelected);
  tstn.IncludeCompilation := TreeStructureNodeIncludeCompilationsCB.Checked;
	SaveTreeStructureTreeToSelectedTreeStructure
end;

procedure Tpref.TreeStructureTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
	pts: PTreeStructureTreeNode;
begin
	pts := Sender.GetNodeData(Node);
	CellText := TreeStructureNodeContent.Items[GetIndexFromTreeStructureContent(pts.Content, pts.CustomFieldIndex)]
end;

procedure Tpref.TreeStructureTreeChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
	tstn: PTreeStructureTreeNode;
  i: Integer;
begin
	if Sender.Selected[Node] then
  begin
  	tstn := Sender.GetNodeData(Node);
    TreeStructureNodeContent.ItemIndex := GetIndexFromTreeStructureContent(tstn.Content, tstn.CustomFieldIndex);
    TreeStructureNodeIncludeCompilationsCB.OnClick := nil;
    TreeStructureNodeIncludeCompilationsCB.Checked := tstn.IncludeCompilation;
		TreeStructureNodeIncludeCompilationsCB.OnClick := TreeStructureNodeIncludeCompilationsCBClick;
    seTreeMinCount.Value := tstn.MinCount;

    cbTreeSort.ItemIndex := 0;
    for i:=0 to cbTreeSort.Items.Count-1 do
    	if integer(cbTreeSort.Items.Objects[i])-100 = tstn.SortColumnField then
      begin
      	cbTreeSort.ItemIndex := i;
        break
      end;
  end;

  GroupBoxSelectedTreeViewNode.Visible := Sender.Selected[Node];
	DeleteTreeStructureNodeBtn.Enabled := Sender.Selected[Node]
end;

procedure Tpref.NewTreeStructureNodeBtnClick(Sender: TObject);
var
	aNode: PVirtualNode;
  tstn: PTreeStructureTreeNode;
begin
	aNode := TreeStructureTree.AddChild(TreeStructureTree.GetFirstSelected);
  tstn := TreeStructureTree.GetNodeData(aNode);
  FillChar(tstn^, SizeOf(tstn^), 0);
  tstn.SortColumnField := -1;
  tstn.IncludeCompilation := true;
  tstn.MinCount := 5;
  if TreeStructureTree.SelectedCount > 0 then
  begin
  	TreeStructureTree.Expanded[TreeStructureTree.GetFirstSelected] := true;
	  TreeStructureTree.ClearSelection
  end;
  TreeStructureTree.Selected[aNode] := true;
  SaveTreeStructureTreeToSelectedTreeStructure
end;

procedure Tpref.DeleteTreeStructureNodeBtnClick(Sender: TObject);
var
	aNode: PVirtualNode;
begin
	aNode := TreeStructureTree.GetFirstSelected;
  if Assigned(aNode) then
  	TreeStructureTree.DeleteNode(aNode);
  SaveTreeStructureTreeToSelectedTreeStructure
end;

procedure Tpref.TreeStructureTreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if not Assigned(TreeStructureTree.GetNodeAt(x, y)) then
  	TreeStructureTree.ClearSelection
end;

procedure Tpref.DeleteTreeStructureBtnClick(Sender: TObject);
var
	i: Integer;
  aNode: PVirtualNode;
  TS: PTreeStructure;
begin
	anode := TreeStructureList.GetFirstSelected;
  TS := PTreeData(TreeStructureList.GetNodeData(aNode)).p;
  for i:=0 to length(dbs)-1 do
  	if (dbs[i].TreeStructureIndex >= TS.Index) and (dbs[i].TreeStructureIndex > 0) then
    	Dec(dbs[i].TreeStructureIndex);

  TreeStructureList.DeleteNode(aNode);
  aNode := TreeStructureList.GetFirst;
  while aNode <> nil do
  begin
 		TS := PTreeData(TreeStructureList.GetNodeData(aNode)).p;
    TS.Index := aNode.Index;
    aNode := TreeStructureList.GetNext(aNode)
  end
end;

procedure Tpref.TreeStructureListEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
	Allowed := true
end;

procedure Tpref.TreeStructureListNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
	TS: PTreeStructure;
begin
	ts := PTreeData(Sender.GetNodeData(Node)).p;
  ts.Text := NewText
end;

procedure Tpref.TreeStructureListDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
	Accept := Source = Sender
end;

procedure Tpref.TreeStructureListDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
	i: Integer;
  AttachMode: TVTNodeAttachMode;
  aNode: PVirtualNode;
  ts: PTreeStructure;
  arr: array of Integer;
begin
  case Mode of
  	dmAbove:
	    AttachMode := amInsertBefore;
	  dmOnNode:
	    AttachMode := amInsertAfter;
	  dmBelow:
	    AttachMode := amInsertAfter;
	  else
		  AttachMode := amNowhere;
  end;

  Sender.MoveTo(Sender.GetFirstSelected, Sender.DropTargetNode, AttachMode, false);

  SetLength(arr, TreeStructureList.RootNodecount);

  aNode := Sender.GetFirst;
  while aNode <> nil do
  begin
  	ts := PTreeData(Sender.GetNodeData(aNode)).p;
    arr[ts.Index] := aNode.Index;
    ts.Index := aNode.Index;
    aNode := Sender.GetNext(aNode)
  end;

  for i:=0 to length(dbs)-1 do
  	dbs[i].TreeStructureIndex := arr[dbs[i].TreeStructureIndex]
end;

procedure Tpref.TreeStructureTreeDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  AttachMode: TVTNodeAttachMode;
begin
  case Mode of
  	dmAbove:
	    AttachMode := amInsertBefore;
	  dmOnNode:
	    AttachMode := amAddChildLast;
	  dmBelow:
	    AttachMode := amInsertAfter;
	  else
		  AttachMode := amNowhere;
  end;
  Sender.MoveTo(Sender.GetFirstSelected, Sender.DropTargetNode, AttachMode, false);
  SaveTreeStructureTreeToSelectedTreeStructure
end;

procedure Tpref.TreeStructureTreeDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);

function IsChildOf(Child, Parent: PVirtualNode): Boolean;
begin
	result := false;
	while Assigned(Child) do
  begin
		if Child.Parent = Parent then
    	result := true;
    Child := Child.Parent
  end
end;
begin
	Accept := (Source = Sender) and not IsChildOf(Sender.DropTargetNode, Sender.GetFirstSelected)
end;

procedure Tpref.RevertSelectedTreeStructureBtnClick(Sender: TObject);
var
	aNode: PVirtualNode;
	TS: PTreeStructure;
  index: Integer;
begin
	if MainFormInstance.YesNoBoxx(GetText(TXT_RevertSelectedViewMode), GetText(TXT_RevertSelectedViewModeMsg), GetText(TXT_Yes), GetText(TXT_No), 0) then
  begin
	  aNode := TreeStructureList.GetFirstSelected;
		ts := PTreeData(TreeStructureList.GetNodeData(aNode)).p;
	  if ts.PreDefinedIndex >= 0 then
	  begin
	    index := ts.PreDefinedIndex;
	  	FreeTreeStructure(ts);
	    ts := MainFormInstance.GetPreDefinedTreeStructureFromIndex(index);
	    ts.Index := aNode.Index;
	    PTreeData(TreeStructureList.GetNodeData(aNode)).p := ts;
	    TreeStructureList.InvalidateNode(aNode);
	    TreeStructureListChange(TreeStructureList, aNode)
	  end
  end
end;

procedure Tpref.RevertAllTreeStructuresBtnClick(Sender: TObject);
var
	aNode: PVirtualNode;
	TS: PTreeStructure;
  i, index: Integer;
  exists: Array of Boolean;
begin
	if MainFormInstance.YesNoBoxx(GetText(TXT_RevertAllViewModes), GetText(TXT_RevertAllViewModesMsg), GetText(TXT_Yes), GetText(TXT_No), 0) then
  begin
    TreeStructureList.BeginUpdate;
    SetLength(Exists, PreDefinedTreeStructureCount);

    aNode := TreeStructureList.GetFirst;
    while aNode <> nil do
    begin
      ts := PTreeData(TreeStructureList.GetNodeData(aNode)).p;
      if ts.PreDefinedIndex >= 0 then
      begin
        index := ts.PreDefinedIndex;

        Exists[index] := true;
        FreeTreeStructure(ts);
        ts := MainFormInstance.GetPreDefinedTreeStructureFromIndex(index);
        ts.Index := aNode.Index;
        PTreeData(TreeStructureList.GetNodeData(aNode)).p := ts;
        TreeStructureList.InvalidateNode(aNode);
        TreeStructureListChange(TreeStructureList, aNode)
      end;
      aNode := TreeStructureList.GetNext(aNode)
    end;

    for i:=0 to length(Exists)-1 do
      if not Exists[i] then
      begin
        aNode := TreeStructureList.AddChild(nil);
        ts := MainFormInstance.GetPreDefinedTreeStructureFromIndex(i);
        ts.Index := aNode.Index;
        PTreeData(TreeStructureList.GetNodeData(aNode)).p := ts
      end;

    TreeStructureList.EndUpdate
  end
end;

procedure Tpref.TSfieldsShow(Sender: TObject);
var
	i: Integer;
begin
	FieldTree.RootNodeCount := FieldList.count;
  FieldIcon.Items.Clear;
  for i:=0 to MainFormInstance.TreeImgs.Count-1 do
  	FieldIcon.Items.Add('')
end;

procedure Tpref.AddFieldButtonClick(Sender: TObject);
var
  name: String;
	SelectedDataType: Integer;
	cf: PCustomField;
  VTcolumn: TVirtualTreeColumn;
begin
	if MainFormInstance.InputBoxx(GetText(TXT_NewCustomField), GetText(TXT_SpecifyCustomName), name) and (length(trim(name)) > 0) then
  begin
		SelectedDataType := MainFormInstance.YesNoBox3Btn(GetText(TXT_NewCustomField), GetText(TXT_SelectDataType), GetText(TXT_Text), GetText(TXT_Integer), GetText(TXT_Floatingpointnumber), 0);
    SelectedDataType := SelectedDataType-1;
		new(cf);
	  FillChar(cf^, SizeOf(cf^), 0);
    cf.name := Trim(name);
	  cf.dataType := SelectedDataType;
		FieldList.Add(cf);

    SearchInFields.Items.Add(cf.name);

		vtColumn := MainFormInstance.tabel.Header.Columns.Add;
	  vtColumn.Text := CF.Name;
	  vtColumn.Style := vsOwnerDraw;
	  vtColumn.Tag := FCustomField + FieldList.Count-1;

	  SetLength(MainFormInstance.TabelColumnsVisible, MainFormInstance.tabel.header.Columns.Count);
    MainFormInstance.TabelColumnsVisible[Length(MainFormInstance.TabelColumnsVisible) - 1] := true;

	  FieldTree.ClearSelection;
	  FieldTree.FocusedNode := FieldTree.AddChild(nil);
	  FieldTree.Selected[FieldTree.FocusedNode] := true
  end
end;

procedure Tpref.FieldTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
begin
	CellText := PCustomField(FieldList.Items[Node.Index]).name
end;

procedure Tpref.FieldIconDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
	With TComboBox(Control) do
  begin
    Canvas.FillRect(rect);
  	MainFormInstance.TreeImgs.Draw(canvas, rect.left, rect.top, index)
	end
end;

procedure Tpref.RemoveFieldButtonClick(Sender: TObject);
procedure RemoveFromTreeViewMode(var node: PTreeStructureNode; FieldIndex: Integer);
begin
	if node.Content = tscCustomField then
  begin
  	if node.CustomFieldIndex = FieldIndex then
    begin
    	FreeTreeStructureNode(node);
      node := nil
    end
    else
    begin
    	if node.CustomFieldIndex > FieldIndex then
      	Dec(node.CustomFieldIndex);
      if Assigned(node.Child) then
      	RemoveFromTreeViewMode(node.Child, FieldIndex);
      if Assigned(node.NextSibling) then
      	RemoveFromTreeViewMode(node.NextSibling, FieldIndex)
    end
  end;

  if assigned(node) then
  begin
  	//Sort-order
    if node.SortColumnField >= FieldIndex then
    begin
			if node.SortColumnField = FieldIndex then
      	node.SortColumnField := -1
      else
      	dec(node.SortColumnField)
    end;

	  if Assigned(node.Child) then
	    RemoveFromTreeViewMode(node.Child, FieldIndex);
	  if Assigned(node.NextSibling) then
	    RemoveFromTreeViewMode(node.NextSibling, FieldIndex)
  end
end;
var
	FieldIndex, i, j, tableColumnIndex: Integer;
  aNode: PVirtualNode;
  TS: PTreeStructure;
begin
  if Assigned(FieldTree.focusedNode) then
  begin
    FieldIndex := FieldTree.focusedNode.Index;

		//Clear tree in MainFormInstance
    MainFormInstance.tree.Clear;

    //Removing table columns
    TableColumnIndex := -1;
    i := 0;
    with MainFormInstance.tabel.Header do
      while i < Columns.Count do
      begin
      	if Columns[i].Tag > FieldIndex + FCustomfield then
        begin
        	Columns[i].Tag := Columns[i].Tag - 1;
          Inc(i)
        end
        else
        if Columns[i].Tag = FieldIndex + FCustomfield then
        begin
          for j:=i to length(MainFormInstance.TabelColumnsVisible) -2 do
            MainFormInstance.TabelColumnsVisible[j] := MainFormInstance.TabelColumnsVisible[j+1];
          Columns.Delete(i);
          TableColumnIndex := i;
          SetLength(MainFormInstance.TabelColumnsVisible, Columns.Count)
        end
        else
        	Inc(i)
      end;

    MainFormInstance.FMLSortedCol := -1;
    MainFormInstance.FMLSortedCol1 := -1;

    TableColumnIndex := -1;
    i := 0;
    with MainFormInstance.Winplaylist.Header do
      while i < Columns.Count do
      	if Columns[i].Tag > FieldIndex + FCustomfield then
        begin
        	Columns[i].Tag := Columns[i].Tag - 1;
          Inc(i)
        end
        else
        if Columns[i].Tag = FieldIndex + FCustomfield then
        begin
          Columns.Delete(i);
          TableColumnIndex := i
        end
        else
        	Inc(i);

    if MainFormInstance.FWPSortedCol = TableColumnIndex then
      MainFormInstance.FWPSortedCol := -1
    else
    if MainFormInstance.FWPSortedCol > TableColumnIndex then
      Dec(MainFormInstance.FWPSortedCol);

    if MainFormInstance.FWPSortedCol1 = TableColumnIndex then
      MainFormInstance.FWPSortedCol1 := -1
    else
    if MainFormInstance.FWPSortedCol1 > TableColumnIndex then
      Dec(MainFormInstance.FWPSortedCol1);

    MainFormInstance.SaveWinPlayColumns;

    for i:=0 to AddReclist.Count-1 do
      MainFormInstance.RemoveCustomFieldEntry(AddReclist.List^[i], FieldIndex, true);

    for i:=0 to reclist.Count-1 do
      MainFormInstance.RemoveCustomFieldEntry(reclist.List^[i], FieldIndex, true);

    SearchInFields.Items.Delete(PREDEFINED_SEARCHINFIELDCOUNT + FieldIndex);

    //Tree View Modes
    TreeStructureList.ClearSelection;
    aNode := TreeStructureList.GetFirst;
    while aNode <> nil do
    begin
    	TS := PTreeData(TreeStructureList.GetNodeData(aNode)).p;
      if Assigned(TS.Head) then
      	RemoveFromTreeViewMode(TS.Head, FieldIndex);
      anode := TreeStructureList.GetNext(aNode)
    end;

    FieldList.Delete(FieldIndex);
    FieldTree.DeleteNode(FieldTree.FocusedNode);

    //Rebuild tree
    MainFormInstance.updatetree(false)
  end
end;

procedure Tpref.SearchInFieldsClickCheck(Sender: TObject);
var
	i: Integer;
begin
	for i:=PREDEFINED_SEARCHINFIELDCOUNT to SearchInFields.Items.Count - 1 do
  	PCustomField(FieldList.Items[i - PREDEFINED_SEARCHINFIELDCOUNT]).Filter := SearchInFields.Checked[i]
end;

{procedure Tpref.CustomFieldNodeContentChange(Sender: TObject);
var
	tstn: PTreeStructureTreeNode;
begin
	tstn := TreeStructureTree.GetNodeData(TreeStructureTree.GetFirstSelected);
  tstn.CustomFieldIndex := CustomFieldNodeContent.ItemIndex;
  TreeStructureTree.InvalidateNode(TreeStructureTree.GetFirstSelected);
	SaveTreeStructureTreeToSelectedTreeStructure
end;    }

procedure Tpref.TStreeViewModesShow(Sender: TObject);
var
	i, ii: integer;
begin
	cbTreeSort.Items.Clear;
  i := -1+100;
  cbTreeSort.Items.AddObject(GetText(TXT_DontChange), pointer(i));

  //add columns in tabel
  for i:=0 to MainFormInstance.tabel.Header.Columns.Count-1 do
  	cbTreeSort.Items.AddObject(MainFormInstance.tabel.Header.Columns[i].Text, TObject(MainFormInstance.tabel.Header.Columns[i].Tag + 100));

  cbTreeSort.ItemIndex := 0;

  //Tree-Structures
  ii := TreeStructureNodeContent.ItemIndex;
  TreeStructureNodeContent.Items.Clear;
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_CompilationContainer), TObject(tscCompilationContainer));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Compilations), TObject(tscCompilations));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_ArtistsSortOrder), TObject(tscArtistsSortOrder));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Artists), TObject(tscArtists));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Albums), TObject(tscAlbums));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Year_Albums), TObject(tscYear_Albums));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Artist_albums), TObject(tscArtist_albums));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Years), TObject(tscYears));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Decades), TObject(tscDecades));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Sets), TObject(tscSets));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Genres), TObject(tscGenres));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Ratings), TObject(tscRatings));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Drives), TObject(tscDrives));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Drives) + ' ' + GetText(TXT_RecursiveFilter), TObject(tscDrivesRecursive));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Directories), TObject(tscDirectories));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_Directories) + ' ' + GetText(TXT_RecursiveFilter), TObject(tscDirectoriesRecursive));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_TrimmedDirectories), TObject(tscTrimmedDirectories));
  TreeStructureNodeContent.Items.AddObject(GetText(TXT_TrimmedDirectories) + ' ' + GetText(TXT_RecursiveFilter), TObject(tscTrimmedDirectoriesRecursive));

  FTreeViewCustomFieldStartIndex := TreeStructureNodeContent.Items.Count;

  for i:=0 to FieldList.Count-1 do
  	TreeStructureNodeContent.Items.AddObject(PCustomField(FieldList.Items[i]).name, TObject(integer(tscCustomField) + i));

  TreeStructureNodeContent.ItemIndex := ii

  //if FieldList.Count > 0 then TreeStructureNodeContent.Items.Add(GetText(TXT_CustomField));
end;

procedure Tpref.cbTreeSortChange(Sender: TObject);
var
	tstn: PTreeStructureTreeNode;
begin
	tstn := TreeStructureTree.GetNodeData(TreeStructureTree.GetFirstSelected);
  tstn.SortColumnField := Integer(cbTreeSort.Items.Objects[cbTreeSort.ItemIndex]) - 100;
	SaveTreeStructureTreeToSelectedTreeStructure
end;

procedure Tpref.seTreeMinCountChange(Sender: TObject);
var
	tstn: PTreeStructureTreeNode;
begin
	tstn := TreeStructureTree.GetNodeData(TreeStructureTree.GetFirstSelected);
  try
	  tstn.MinCount := seTreeMinCount.Value;
		SaveTreeStructureTreeToSelectedTreeStructure
  except
  end
end;

procedure Tpref.cbUseCustomDbColorClick(Sender: TObject);
begin
	cPanel.Enabled := cbUseCustomDbColor.Checked
end;

procedure Tpref.TSMyMusicShow(Sender: TObject);
begin
	cbUseCustomDbColorClick(nil)
end;

procedure Tpref.btnBrowseBackgroundFileClick(Sender: TObject);
begin
	if OpenPictureDialog1.Execute then
  	txtBackgroundImageFilename.Text := OpenPictureDialog1.FileName
end;

procedure Tpref.LongNameEditChange(Sender: TObject);
begin
	FTSaveToSelectedBtnClick(sender)
end;

procedure Tpref.rbtId3v2FieldTypeClick(Sender: TObject);
begin
	pnlId3v2FieldFrameName.Visible := rbtId3v2FieldType.ItemIndex = 3;
  pnlId3v2FieldDescription.Visible := rbtId3v2FieldType.ItemIndex in [1, 2];
  pnlId3v2FieldDefaultLanguage.Visible := rbtId3v2FieldType.ItemIndex = 1;

  pnlId3v2FieldDefaultLanguage.BringToFront;
  pnlId3v2FieldDefaultLanguage.BringToFront;
  pnlId3v2FieldFrameName.BringToFront;
end;

Procedure Tpref.SaveCustomFieldFromNode(node: PVirtualNode);
var
	cf: PCustomField;
begin
	if assigned(node) then
  begin
  	cf := PCustomField(FieldList.Items[FieldTree.FocusedNode.Index]);

    cf.Name := Trim(FieldName.Text);
    cf.iconIndex := FieldIcon.ItemIndex;
	  FieldTree.InvalidateNode(FieldTree.FocusedNode);
    MainFormInstance.UpdateCustomFieldName(FieldTree.FocusedNode.Index);

    //Id3v2
    	//reset values
    cf.id3v2ReadAllLanguages := false;
    cf.id3v2DefaultLanguage := '';
    cf.id3v2Description := '';
    cf.id3v2FieldName := '';

    case rbtId3v2FieldType.ItemIndex of
      1, 2:	//COMM, TXXX
      begin
      	case rbtId3v2FieldType.ItemIndex of
        	1:	//COMM
          begin
		      	cf.id3v2FieldName := 'COMM';
		      	cf.id3v2ReadAllLanguages := chkFieldId3v2ReadFromAllLanguages.Checked;
            if cbId3v2FieldLanguage.ItemIndex >= 0 then
			    		cf.id3v2DefaultLanguage := string(cbId3v2FieldLanguage.Items.Objects[cbId3v2FieldLanguage.ItemIndex])
            else
            	cf.id3v2DefaultLanguage := UnknownLanguageCode
          end;

          2:	//TXXX
        		cf.id3v2FieldName := 'TXXX';
        end;
        cf.id3v2Description := Trim(FieldId3v2Description.Text)
      end;

      3: //T***
      	cf.id3v2FieldName := Trim(FieldId3v2Name.Text);
    end;	//of case

    //Ogg
		cf.oggFieldName := UpperCase(Trim(FieldOggName.Text));

		//Ape
    cf.ApeFieldName := Trim(FieldApeName.Text);

		///WMA
    cf.WmaFieldName := Trim(FieldWmaName.Text);
  end
end;

procedure Tpref.FieldTreeFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
var
	cf: PCustomField;
begin
	if Assigned(OldNode) then
  	SaveCustomFieldFromNode(OldNode);

  if Assigned(NewNode) then
  begin
  		//Load node
  	SelectedFieldGroupBox.Visible := true;
    RemoveFieldButton.Enabled := true;
  	cf := FieldList.Items[NewNode.Index];
    FieldName.Text := cf.name;
    FieldIcon.ItemIndex := cf.iconIndex;

    FieldId3v2Name.Text := cf.id3v2FieldName;
    FieldId3v2Description.text := cf.id3v2Description;
    cbId3v2FieldLanguage.ItemIndex := cbId3v2FieldLanguage.Items.IndexOf(GetLanguageNameFromLanguageCode(cf.id3v2DefaultLanguage));
    chkFieldId3v2ReadFromAllLanguages.Checked := cf.id3v2ReadAllLanguages;

    FieldOggName.Text := cf.oggFieldName;
    FieldApeName.Text := cf.apeFieldName;
    FieldWmaName.Text := cf.wmaFieldName;

    if length(cf.id3v2FieldName) = 0 then
    	rbtId3v2FieldType.ItemIndex := 0
    else
    if Q_SameText(cf.id3v2FieldName, 'COMM') then
    	rbtId3v2FieldType.ItemIndex := 1
    else
    if Q_SameText(cf.id3v2FieldName, 'TXXX') then
    	rbtId3v2FieldType.ItemIndex := 2
    else
    	rbtId3v2FieldType.ItemIndex := 3;	//other T***

    if (rbtId3v2FieldType.ItemIndex = 1) and (cbId3v2FieldLanguage.ItemIndex < 0) then
			cbId3v2FieldLanguage.ItemIndex := cbId3v2FieldLanguage.Items.IndexOf(GetText(TXT_Unknown))
  end
  else
  begin
  	//Clear fields
  	SelectedFieldGroupBox.Visible := false;
    RemoveFieldButton.Enabled := false;
    FieldName.Text := '';
    FieldIcon.ItemIndex := -1;

    FieldId3v2Name.Text := '';
    FieldId3v2Description.text := '';
    cbId3v2FieldLanguage.ItemIndex := -1;
    chkFieldId3v2ReadFromAllLanguages.Checked := true;

    FieldOggName.Text := '';
    FieldApeName.Text := '';
    FieldWmaName.Text := ''
  end
end;



end.

