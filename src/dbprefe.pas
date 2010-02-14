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


unit dbprefe;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, 
  StdCtrls, ExtCtrls, ComCtrls, ShlObj, Menus, filectrl, ColorPickerButton,
  QStrings, JvListBox, JvCtrls, MEXPtypes, JvExStdCtrls, JvTextListBox;

type
  Tdbpref = class(TForm)
    loadinglabel: TLabel;
    pbar: TProgressBar;
    Panel1: TPanel;
    Scanbut: TButton;
    Button2: TButton;
    Panel2: TPanel;
    Button3: TButton;
    scanpopup: TPopupMenu;
    Scan1: TMenuItem;
		Scannewremovedeadfiles1: TMenuItem;
    clrlabel: TTimer;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Color: TLabel;
    Cpanel: TColorPickerButton;
    name: TEdit;
    recsub: TCheckBox;
    readonly: TRadioButton;
    notreadonly: TRadioButton;
    Button1: TButton;
    Button4: TButton;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    Button6: TButton;
    Button7: TButton;
    network: TRadioButton;
		CalcCRCcb: TCheckBox;
    repairVBRCB: TCheckBox;
    path: TJvTextListBox;
    excl: TJvTextListBox;
    cbUseCustomColor: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ScanbutClick(Sender: TObject);
    procedure pathChange(Sender: TObject);
    procedure Scan1Click(Sender: TObject);
		procedure Scannewremovedeadfiles1Click(Sender: TObject);
		procedure RunAfterScan(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Function Save:boolean;
    procedure clrlabelTimer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure cbUseCustomColorClick(Sender: TObject);
  private
    { Private declarations }

	public
		AddLocationForm : boolean;
		Procedure LoadLanguageGUI;

    { Public declarations }
	end;

var
  dbpref: Tdbpref;

implementation

uses defs, MainForm, languageConstants;

var
        origname : string;

{$R *.DFM}

Procedure Tdbpref.LoadLanguageGUI;
Begin
	CalcCRCcb.Caption 					:= GetText(TXT_CalcCRC);
  repairVBRCB.Caption 				:= GetText(TXT_guirepairVBR);
  cbUseCustomColor.Caption 		:= GetText(TXT_UseCustomDatabaseColor)
end;

procedure Tdbpref.Button1Click(Sender: TObject);
var
  TitleName : string;
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
  VolumeName, FileSystemName     : array [0..MAX_PATH-1] of Char;
  MaxComponentLength,FileSystemFlags    : Dword;

begin
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  BrowseInfo.hwndOwner := dbpref.Handle;
  BrowseInfo.pszDisplayName := @DisplayName;
  TitleName := 'Please specify a directory';
  BrowseInfo.lpszTitle := PChar(TitleName);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then
  begin
    SHGetPathFromIDList(lpItemID, TempPath);
    path.items.add(TempPath);
    GlobalFreePtr(lpItemID);

    GetVolumeInformation(pchar(copy(temppath,1,3)),VolumeName,MAX_PATH,@VolumeSerialNo,MaxComponentLength,FileSystemFlags,FileSystemName,MAX_PATH);

    if AddLocationForm and (length(name.text) = 0) then
    begin
      name.text := volumename;
      if name.text <> '' then
        name.text := ansiuppercase(volumename)[1] + copy(ansilowercase(volumename),2,255)
    end
  end
end;

procedure Tdbpref.Button2Click(Sender: TObject);
begin
	if MainFormInstance.ScanThread.Runing then
		MainFormInstance.StopScanning
	else
		dbpref.modalresult := mrcancel
end;

procedure Tdbpref.ScanbutClick(Sender: TObject);
var
	VolumeName, FileSystemName     : array [0..MAX_PATH-1] of Char;
	MaxComponentLength,FileSystemFlags    : Dword;
	dbindex,i:integer;
	ScanParams: PScanParameters;
begin
	if MainFormInstance.ScanThread.Runing then
  	loadinglabel.Caption := GetText(TXT_AlreadyScanning)
  else
  begin
		if AddLocationForm then
     begin
           if name.text = '' then
                begin
												loadinglabel.caption := 'Please enter a name...';	// TODO: translate
												clrlabel.enabled := true;
												exit
								end;
				if path.items.count = 0 then
								begin
												loadinglabel.caption := 'Please specify a directory...';  // TODO: translate
                        clrlabel.enabled := true;
                        exit
                end;

        for i:=0 to path.items.count-1 do
						if not directoryexists(path.items[i]) then
            begin
								 loadinglabel.caption := 'The path ' + path.items[i] + ' could not be found'; // TODO: translate
                 clrlabel.enabled := true;
                 exit
            end;

				dbindex := MainFormInstance.LocateDBname(name.text);
        if dbindex = -1 then
        begin
             setlength(dbs,length(dbs)+1);
             dbs[length(dbs)-1].TreeStructureIndex := MainFormInstance.GetDefaultTreeStructureIndex;
             dbs[length(dbs)-1].name := name.text;
             dbs[length(dbs)-1].media :=integer(readonly.checked) + (integer(notreadonly.checked) *2) + (integer(network.checked) *3);
             dbs[length(dbs)-1].color := Cpanel.SelectionColor;
             dbs[length(dbs)-1].UseCustomColor := cbUseCustomColor.checked;
             dbs[length(dbs)-1].filename := '';  //laves i unloadsaveall
             dbs[length(dbs)-1].loaded := true;
						 dbs[length(dbs)-1].recursive := true;
						 dbs[length(dbs)-1].calculateCRC := CalcCRCcb.Checked;
             dbs[length(dbs)-1].repairVBR := repairVBRCB.Checked;
             setLength(dbs[length(dbs)-1].paths, path.items.count);
             setLength(dbs[length(dbs)-1].snrs, path.items.count);
             setLength(dbs[length(dbs)-1].excl, excl.items.count);
             for i:=0 to excl.items.count-1 do
                 dbs[length(dbs)-1].excl[i] := excl.items[i];
             for i:=0 to path.items.count-1 do
						 begin
									dbs[length(dbs)-1].paths[i] := path.items[i];
                  if GetVolumeInformation(pchar(copy(path.items[i],1,3)),VolumeName,MAX_PATH,@VolumeSerialNo,MaxComponentLength,FileSystemFlags,FileSystemName,MAX_PATH) then
                     dbs[length(dbs)-1].snrs[i] := integer(VolumeSerialNo)
									else dbs[length(dbs)-1].snrs[i] := 0
             end
				end else
        begin
						 loadinglabel.caption := 'A database by that name already exists!'; 	// TODO: translate
             clrlabel.enabled := true;
             exit
        end;
				MainFormInstance.enabled := false;
        screen.Cursor := crHourglass;
        New(ScanParams);
				SetLength(ScanParams.arr, 1);
//    		new(ScanParams.arr[0]);
				ScanParams.arr[0].master := 1;
				ScanParams.arr[0].name := name.text;
				ScanParams.arr[0].onlyNew := false;
				ScanParams.arr[0].UpdateTreeAndTabel := true;
				ScanParams.arr[0].CalculateCRC := CalcCRCcb.Checked;
        ScanParams.arr[0].repairVBR := repairVBRCB.Checked;
				ScanParams.arr[0].RunAfterScan := RunAfterScan;
				MainFormInstance.ScanThread.Start(ScanParams)
		 end
     else
     begin
          //DBpref - form
          if path.items.count=0 then
          begin
							 loadinglabel.caption := 'Please specify a directory...';   // TODO: translate
               clrlabel.enabled := true
          end else
              scanpopup.Popup(mouse.cursorpos.x, mouse.cursorpos.y)
     end
	end
end;

procedure Tdbpref.pathChange(Sender: TObject);
begin
     if path.items.count > 0 then
     begin
          if Q_PosText('\\', path.items[0])>0 then
             network.checked := true
          else
					case GetDriveType(pchar(extractfiledrive(path.items[0])+'\')) of
                //0              : MainFormInstance.showmessageX('The drive type cannot be determined');
                //1              : MainFormInstance.showmessageX('The root directory does not exist');
                DRIVE_REMOVABLE:notreadonly.checked := true;
                DRIVE_FIXED    : notreadonly.checked := true;
                DRIVE_REMOTE   : notreadonly.checked := true;
                DRIVE_CDROM    : readonly.checked := true;
                //DRIVE_RAMDISK  : MainFormInstance.showmessageX('The drive is a RAM disk');
                else readonly.checked := true
				end
		 end
end;

procedure Tdbpref.Scan1Click(Sender: TObject);
var
	ScanParams: PScanParameters;
begin
	if MainFormInstance.ScanThread.Runing then
  	loadinglabel.Caption := GetText(TXT_AlreadyScanning)
  else
  begin
    loadinglabel.caption := GetText(TXT_PleaseWait);
    if not save then
      begin
        loadinglabel.caption := '';
        dbpref.Enabled := true;
        exit
      end;
    dbpref.Enabled := false;
    MainFormInstance.Enabled := false;
    screen.Cursor := crAppStart;

    new(ScanParams);
    SetLength(ScanParams.arr, 1);
    ScanParams.arr[0].master := 2;
    ScanParams.arr[0].name := origName;
    ScanParams.arr[0].onlyNew := false;
    ScanParams.arr[0].UpdateTreeAndTabel := true;
    ScanParams.arr[0].CalculateCRC := CalcCRCcb.Checked;
    ScanParams.arr[0].repairVBR := repairVBRcb.Checked;
    ScanParams.arr[0].RunAfterScan := RunAfterScan;
    MainFormInstance.ScanThread.Start(ScanParams)
  end
end;

procedure Tdbpref.Scannewremovedeadfiles1Click(Sender: TObject);
var
	ScanParams: PScanParameters;
	onlyNew: Boolean;
	index: integer;
begin
	if MainFormInstance.ScanThread.Runing then
  	loadinglabel.Caption := GetText(TXT_AlreadyScanning)
  else
  begin
    loadinglabel.caption := 'Please wait...';   // TODO: translate

    index := MainFormInstance.locateDBname(origname);
    if not dbs[index].calculateCRC and CalcCRCcb.Checked then
      onlyNew := false
    else
      onlyNew := true;

    if not save then
    begin
      loadinglabel.caption := '';
      dbpref.Enabled := true;
      exit
    end;

    dbpref.enabled := false;
    MainFormInstance.enabled := false;
    screen.Cursor := crAppStart;

    new(ScanParams);
    SetLength(ScanParams.arr, 1);
    ScanParams.arr[0].master := 2;
    ScanParams.arr[0].name := origName;
    ScanParams.arr[0].onlyNew := onlyNew;
    ScanParams.arr[0].UpdateTreeAndTabel := true;
    ScanParams.arr[0].CalculateCRC := CalcCRCcb.Checked;
    ScanParams.arr[0].repairVBR := repairVBRCB.Checked;
    ScanParams.arr[0].RunAfterScan := RunAfterScan;
    MainFormInstance.ScanThread.Start(ScanParams)
  end
end;

procedure TdbPref.RunAfterScan(Sender: TObject);
begin
	dbpref.enabled := true;
	MainFormInstance.enabled := true;
	dbpref.modalresult := mrok
end;

procedure Tdbpref.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	if not quitting then
	begin
		dbpref.hide;
		MainFormInstance.SetMainFormVisible(true)
	end
end;

procedure Tdbpref.FormShow(Sender: TObject);
begin
        if AddLocationForm then
        begin
             scanBut.Caption := 'Scan';
             Button3.Visible := false;
						 Button2.Left := ScanBut.Width
        end;
        pbar.position := 0;
        origname := name.text;
        cbUseCustomColorClick(nil)
end;

Function Tdbpref.Save:boolean;
var
        b:boolean;
        VolumeName, FileSystemName     : array [0..MAX_PATH-1] of Char;
        MaxComponentLength,FileSystemFlags    : Dword;
        i, newIndex,index:integer;
begin
        for i:=0 to path.items.count-1 do
            if not directoryexists(path.items[i]) then
            begin
								 loadinglabel.caption := 'The path ' + path.items[i] + ' could not be found';       // TODO: translate
                 clrlabel.enabled := true;
								 result := false;
                 exit
            end;

				index := MainFormInstance.locateDBname(origname);
				newIndex := MainFormInstance.locateDBname(name.text);
        b := newIndex > -1;
        if not b or (newIndex = Index) then
        begin
             setLength(dbs[index].paths, path.items.count);
             setLength(dbs[index].snrs, path.items.count);
             setLength(dbs[index].excl, excl.items.count);
             for i:=0 to excl.items.count-1 do
                 dbs[index].excl[i] := excl.items[i];
             for i:=0 to path.items.count-1 do
             begin
                  dbs[index].paths[i] := path.items[i];
                  if GetVolumeInformation(pchar(copy(path.items[i],1,3)),VolumeName,MAX_PATH,@VolumeSerialNo,MaxComponentLength,FileSystemFlags,FileSystemName,MAX_PATH) then
                     dbs[index].snrs[i] := integer(VolumeSerialNo)
                  else dbs[index].snrs[i] := 0
             end;
             if not Q_SameText(dbs[index].name, trim(name.text)) then
             begin
                  deleteFile(settingsdir + dbs[index].Filename);
                  dbs[index].Filename := '';
                  dbs[index].name := name.text
             end;
             dbs[index].media :=integer(readonly.checked) + (integer(notreadonly.checked) *2) + (integer(network.checked) *3);
						 dbs[index].color := Cpanel.selectioncolor;
             dbs[index].UseCustomColor := cbUseCustomColor.checked;
						 dbs[index].recursive := recsub.checked;
						 dbs[index].calculateCRC := CalcCRCcb.Checked;
             dbs[index].repairVBR := repairVBRCB.Checked;
						 result := true
        end else
        begin
						 loadinglabel.caption := 'There already is a database with that name, please delete this one first or select another name';     // TODO: translate
             clrlabel.enabled := true;
						 result := false
        end;
				origname := name.text
end;

procedure Tdbpref.Button3Click(Sender: TObject);
Begin
  if save then
  begin
    dbpref.modalresult := mrok;
    MainFormInstance.Updatetree(false)
  end
end;

procedure Tdbpref.FormCreate(Sender: TObject);
begin
	icon := MainFormInstance.Icon1.Picture.Icon;
  LoadLanguageGUI
end;

procedure Tdbpref.clrlabelTimer(Sender: TObject);
begin
        loadinglabel.caption :='';
        clrlabel.enabled := false
end;


procedure Tdbpref.Button4Click(Sender: TObject);
var       i:integer;
begin
     for i:=path.Items.count-1 downto 0 do
         if path.Selected[i] then
            path.items.Delete(i)
end;

procedure Tdbpref.Button7Click(Sender: TObject);
var       s:string;
begin
     s := '';
     if MainFormInstance.InputBoxx('Add string', 'Prompt', S) then if trim(s) <> '' then excl.items.add(s)
end;

procedure Tdbpref.Button6Click(Sender: TObject);
var       i:integer;
begin
     for i:=excl.Items.count-1 downto 0 do
         if excl.Selected[i] then
            excl.items.Delete(i)
end;

procedure Tdbpref.cbUseCustomColorClick(Sender: TObject);
begin
	cpanel.Enabled := cbUseCustomColor.checked
end;

end.
