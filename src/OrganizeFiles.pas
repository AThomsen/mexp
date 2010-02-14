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


unit OrganizeFiles;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
	StdCtrls, FileCtrl, ExtCtrls, ComCtrls, QStrings, VirtualTrees, math,
	ActiveX, ShellApi, QStringList, MexpIniFile, JvComponent,
  JvSearchFiles, Dialogs, MEXPtypes, diskspace64, JvComponentBase;

type
  TOrgFiles = class(TForm)
    pbar: TProgressBar;
    loadinglabel: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    deldirsbox: TCheckBox;
    CloseBtn: TButton;
    SU: TCheckBox;
    saveD: TSaveDialog;
    DriveOpt: TRadioGroup;
    driveTree: TVirtualStringTree;
    Label1: TLabel;
		UseCompilationPattern: TCheckBox;
    Label2: TLabel;
    ScrollBox1: TScrollBox;
    patternHelp: TLabel;
    ShowPreview: TCheckBox;
    MoveOtherFiles: TCheckBox;
		Label3: TLabel;
    patternEdit: TComboBox;
    compilationPatternEdit: TComboBox;
    FF: TJvSearchFiles;
    procedure Button1Click(Sender: TObject);

    Function GetFtextP(rec: Prec; i:integer):string;
    procedure FormCreate(Sender: TObject);
    procedure driveTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure driveTreeChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure driveTreeFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure UseCompilationPatternClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure driveTreeEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure DriveOptClick(Sender: TObject);
    procedure driveTreeNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure driveTreeDragAllowed(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure driveTreeDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure driveTreeDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure CloseBtnClick(Sender: TObject);
    procedure Label3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure driveTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
			var Ghosted: Boolean; var ImageIndex: Integer);
    procedure driveTreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
        moveCancelled:Boolean;
        undoList:Tlist;
        procedure FillDriveData(markAllUsed:boolean=false);
        function HasFilesOnDrive(pDR:Pointer; var root:string):boolean;
        procedure SetCheckType(ct:TCheckType);
    { Private declarations }
  public
        list:TList;
        function init:boolean;
    { Public declarations }
  end;

type
    TdriveRec = record
              use:boolean;
              hasFiles:boolean;
              BytesCluster:cardinal;
              currentFree:int64;
              calcFree:int64;
              freeSpaceAfter:int64;
              drive:string;
              root:string;
    end;
		PdriveRec = ^TdriveRec;

		TnewRec = record
              moved:boolean;
              ref:pointer;
              newDriveIndex:integer;
              currentDriveIndex:integer;
							newname:string
    end;
    PnewRec = ^TnewRec;

    TartistRec = record
               artist:boolean; //true:artist, false:album
               Index:integer;
               size:int64;
    end;
    PartistRec = ^Tartistrec;

    TMOFRec = record
            moved : boolean;
            size : integer;
            newDriveIndex:integer;
            currentDriveIndex:integer;
            NR : PnewRec;
            oldName : String;
            newName : String
    end;
    PMOFRec = ^TMOFRec;

    TIconRec = record
						 icon : TIcon;
             ext : string;
    end;
    PIconRec = ^TIconRec;


const
     oneMeg:cardinal=1048576;// = 1 megabytes
var
  OrgFiles: TOrgFiles;

implementation
uses MainForm, defs, FileTreePreview;
{$R *.DFM}

Function TOrgFiles.getFtextP(rec: Prec; i:integer):string;
begin
	result := MainFormInstance.getFtextP(rec, i)
end;

function SortByArtist(Item1, Item2: Pointer): Integer;
var      s1, s2:string;
begin
     with MainFormInstance do
     begin
          if OrgFiles.UseCompilationPattern.checked and (rfCompilation in Prec(item1).Flags) then
             s1 := getFtextP(Item1, fAlbum)
          else s1 := getFtextP(Item1, FArtistSortOrder);
          if OrgFiles.UseCompilationPattern.checked and (rfCompilation in Prec(item2).Flags) then
             s2 := getFtextP(Item2, fAlbum)
          else s2 := getFtextP(Item2, FArtistSortOrder);
          result := GetOneOrZero(Q_CompText(s1, s2))
     end
end;

function SortByArtistSizes(Item1, Item2: Pointer): Integer;
begin
     result := CompInt64(PartistRec(item1).size, Partistrec(item2).size)
end;

function sortStringsByLength(List: TQ_StringList; Index1, Index2: Integer): Integer;
begin
     result := length(list.strings[index2]) - length(list.strings[index1])
end;

procedure TOrgFiles.Button1Click(Sender: TObject);  //GO!
function GetDriveWithMostArtistOrAlbum(const rec:Prec; const newList, drives:TList):integer;
var      arr:array of integer;
         i:integer;
         b:boolean;
         NR:PnewRec;
begin
     setLength(arr, drives.count);
     for i:=0 to newList.count-1 do
     begin
          // finder ud af om items[i] har den rigtige artist/album, isåfald sættes b=true
          NR := newList.items[i];
          if UseCompilationPattern.Checked then
             b := ((rfCompilation in Rec.Flags) and (rfCompilation in PRec(NR.Ref).Flags) and (rec.album = Prec(NR.ref).album)) or
                  (not (rfCompilation in Rec.Flags) and not (rfCompilation in Prec(NR.Ref).Flags) and (rec.ArtistSortOrder = Prec(NR.ref).ArtistSortOrder))
          else b := rec.ArtistSortOrder = Prec(NR.ref).ArtistSortOrder;

          if b and (NR.currentDriveIndex>=0) then //finder ud af hvilket drev den tilhører
             inc(arr[NR.currentDriveIndex]);
     end;
     //finder den højeste
     result := 0;
     for i:=1 to drives.Count-1 do
         if arr[i]>arr[result] then
            result := i
end;

function DoGetUseSize(const bytes:integer; const driveRec:PdriveRec):cardinal;
begin
     result := ((bytes + driveRec.BytesCluster - 1) div driveRec.BytesCluster) * driveRec.BytesCluster
end;

function getUseSize(const rec:Prec; const driveRec:PdriveRec):cardinal;
begin
     result := doGetUseSize(rec.FSize, driveRec)
end;

function doIsOnDrive(const fn:String; const DR:PDriveRec):Boolean;
begin
     result := Q_SameTextL(DR.drive, fn, length(DR.drive))
end;

function isOnDrive(const rec:Prec; const DR:PDriveRec):boolean;
begin
     result := doIsOnDrive(getFtextP(rec, fFilePath), DR)
end;

function getDriveIndex(rec:Prec; driveList:TList):integer;
var      i:integer;
begin
     result := -1;
     for i:=0 to driveList.count-1 do
         if isOnDrive(rec, driveList.items[i]) then
         begin
              result := i;
              break
         end
end;

function getArtistsSize(const artist, useMOF:boolean; const newList, MOFlist:Tlist; const Index:integer; const DR:PdriveRec):int64;
var      i:integer;
begin
     result := 0;

     for i:=0 to newList.Count-1 do
         if (artist and (Prec(PnewRec(newList.Items[i]).ref).ArtistSortOrder = Index)) or
         (not artist and (Prec(PnewRec(newList.Items[i]).ref).album = Index)) then
            inc(result, getUseSize(PnewRec(newList.Items[i]).ref, DR));

     if useMOF then
        for i:=0 to MOFlist.count-1 do
            if (artist and (Prec(PMOFRec(MOFlist.Items[i]).NR.ref).ArtistSortOrder = Index)) or
            (not artist and (Prec(PMOFRec(MOFlist.Items[i]).NR.ref).album = Index)) then
            inc(result, doGetUseSize(PMOFRec(MOFlist.Items[i]).size, DR))
end;

function inArtistList(artist:boolean; rec:Prec; artistSizes:Tlist):boolean;
var      i, index:integer;
begin
     result := false;
     if artist then
        index := rec.ArtistSortOrder
     else index := rec.Album;
     for i:=0 to artistSizes.count-1 do
         if (PartistRec(artistSizes.items[i]).artist = artist) and (PartistRec(artistSizes.items[i]).Index = Index) then
         begin
              result := true;
              break
         end
end;

function spaceToMove(NR:PnewRec; targetDrive:PdriveRec):boolean;
begin
     if NR.newDriveIndex = NR.currentDriveIndex then
        result := true
     else
     begin
          targetDrive.currentFree := GetFreeSpace64(targetDrive.drive);
          result := targetDrive.currentFree - getUseSize(NR.ref, targetDrive) > 0
     end
end;

function MOFSpaceToMove(MOFr:PMOFRec; targetDrive:PdriveRec):boolean;
begin
     if MOFr.newDriveIndex = MOFr.currentDriveIndex then
        result := true
     else
     begin
          targetDrive.currentFree := GetFreeSpace64(targetDrive.drive[1]);
          result := targetDrive.currentFree - doGetUseSize(MOFr.size, targetDrive) > 0
     end
end;

procedure removeNewRec(NR:PnewRec; newlist:Tlist);
var       i:integer;
begin
	for i:=0 to newList.count-1 do
	if newList.items[i] = NR then
	begin
		dispose(PnewRec(newList.items[i]));
		newList.Delete(i);
		break
	end
end;

procedure removeNewRec2(rec:Prec; newlist:Tlist);
var       i:integer;
begin
	for i:=0 to newList.count-1 do
	if PnewRec(newList.items[i]).ref = rec then
	begin
		removeNewRec(PnewRec(newList.items[i]), newList);
		break
	end
end;

procedure RemoveRec(rec:Prec);
var
	i:integer;
	aNode, bNode :PVirtualNode;
begin
	Include(rec.flags, rfDeletePending);
	for i:=0 to list.Count-1 do
	if list.items[i] = rec then
	begin
		list.Delete(i);
		break
	end;

	with MainFormInstance do
	begin
		aNode := tabel.GetFirst;
		while aNode <> nil do
		begin
			if GetRec(aNode) = rec then
			begin
				bNode := tabel.getNext(aNode);
				tabel.DeleteNode(aNode);
				aNode := bNode
			end else aNode := tabel.GetNext(aNode)
		end
	end;

  MainFormInstance.releaseRecs(true, true);
  reclist.Pack
end;

function findNextToMove(NR:PnewRec; newList:Tlist):PnewRec;
var      i, x:integer;
begin
     result := nil;
     if NR = nil then
     begin
          for i:=0 to newList.Count-1 do
              if not PnewRec(newList.items[i]).moved then
              begin
                   result := newList.items[i];
                   exit
              end
     end else
     begin
          x := newList.IndexOf(NR);
          if x>=0 then
          begin
               if x = newList.count-1 then
                  x := -1; //wrapper rundt og starter forfra
               for i:=x+1 to newList.count-1 do
                   if not PnewRec(newList.items[i]).moved and (newList.items[i]<>NR) then
                   begin
                        result := newList.items[i];
                        exit
                   end;
               //når den hertil er det fordi den er kørt til enden...
               for i:=0 to newList.count-1 do
                   if not PnewRec(newList.items[i]).moved and (newList.items[i]<>NR) then
                   begin
                        result := newList.items[i];
                        exit
                   end
          end
     end
end;

function findNextMOFToMove(MOFr:PMOFRec; MOFlist:Tlist):PMOFRec;
var      i, x:integer;
begin
     result := nil;
     if MOFr = nil then
     begin
          for i:=0 to MOFlist.Count-1 do
              if not PMOFRec(MOFlist.items[i]).moved then
              begin
                   result := MOFlist.items[i];
                   exit
              end
     end else
     begin
          x := MOFlist.IndexOf(MOFr);
          if x>=0 then
          begin
               if x = MOFlist.count-1 then
                  x := -1; //wrapper rundt og starter forfra
               for i:=x+1 to MOFlist.count-1 do
                   if not PMOFRec(MOFlist.items[i]).moved and (MOFlist.items[i]<>MOFr) then
                   begin
                        result := MOFlist.items[i];
                        exit
                   end;
               //når den hertil er det fordi den er kørt til enden...
               for i:=0 to MOFlist.count-1 do
                   if not PMOFRec(MOFlist.items[i]).moved and (MOFlist.items[i]<>MOFr) then
                   begin
                        result := MOFlist.items[i];
                        exit
                   end
          end
     end
end;

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
function MOFdirInList(list:TList; NR:PnewRec):boolean;
var
   i:integer;
begin
     result := false;
     for i:=0 to list.count-1 do
         if Prec(NR.ref).Fpath = Prec(PnewRec(list.items[i]).ref).Fpath then
         begin
							result := true;
              break
         end
end;
function FnameInNewList(newlist:Tlist; const fname:string):boolean;
var
   i:integer;
begin
  result := false;
  for i:=0 to newList.count-1 do
	  if Q_SameText(Prec(PnewRec(newList.Items[i]).ref).Fname, fname) then
	  begin
	    result := true;
	    break
	  end
end;

function GetFileSize(const fn:string):integer;
var
   SearchRec: TSearchRec;
begin
  if FindFirst(fn, faAnyFile, SearchRec) = 0 then
  begin
    result := SearchRec.Size;
    FindClose(SearchRec)
  end
  else result := 0
end;
var
        i, x, k, t:integer;
        newname, DestDrive:String;
				DelDirs:TQ_StringList;
				FreeSpace, TotSpace, artistsSize, li:Int64;
				f:textfile;
				r, rec2:Prec;
				notEnoughSpace, proceed, b, NextAlreadyFound : boolean;
				drives, newList, artistSizes:Tlist;
				aNode:PVirtualNode;
				DR, DR2:PdriveRec;
				NR, NR2:PnewRec;
        AR:PartistRec;
				FPF:TFilePreviewForm;
        mr:TModalResult;
        dirList:TstringList;
        MOFlist, MOFdirList : TList;
        MOFr : PMOFRec;
				MOF : Boolean; //Move Other Files
        MOFartist, MOFalbum : integer;
        Iarr : array of TIconRec;
        ext : String;
				w : word;
begin
     MOF := MoveOtherFiles.Checked;
     DelDirs := TQ_Stringlist.create;
     DelDirs.Sorted := true;
     DelDirs.Duplicates := dupIgnore;

     if MOF then
		 begin
          MOFlist := TList.Create;
          MOFdirList := Tlist.Create
     end;

     loadingLabel.caption := 'Calculating...';
     MainFormInstance.forceRepaint(loadingLabel);

     pbar.Position := 0;
     pbar.Max := list.count-1;

     notEnoughSpace := false;
     list.Sort(SortByArtist);
     drives := Tlist.create;
     aNode := driveTree.GetFirst;
     while aNode<>nil do
     begin
          DR := driveTree.GetNodeData(aNode);
          if DR.use or ((driveOpt.ItemIndex in [0, 1]) and DR.hasFiles) then
             drives.Add(DR);
          aNode := driveTree.GetNext(aNode)
     end;

		 newList := TList.Create;
     newList.Count := list.count;
     for i:=0 to newList.Count-1 do //fylder alle
     begin
          new(NR);
					FillChar(NR^, sizeOf(NR^), #0);
          NR.ref := list.Items[i];
          NR.currentDriveIndex := getDriveIndex(NR.ref, drives); //kan være -1 hvis drevet ikke bruges!
          newList.Items[i] := NR;
          if MOF and not MOFdirInList(MOFdirlist, NR) then
             MOFdirlist.Add(NR)
     end;

     if MOF then     //finder alle ekstra filer der skal flyttes (*.jpg fx)
     begin
          loadingLabel.Caption := 'Searching extra files...';
          MainFormInstance.forceRepaint(loadingLabel);
					pBar.Position := 0;
          pBar.Max := MOFdirList.count;
          for i:=0 to MOFdirList.count-1 do
          begin
               b := true;
               //checker om alle artist / albums er det samme
               MOFartist := Prec(PnewRec(MOFdirList.Items[i]).ref).artist;
               MOFalbum := Prec(PnewRec(MOFdirList.Items[i]).ref).album;

               for k:=0 to newList.count-1 do
               begin
                    NR := newList.Items[k];
                    if Prec(NR.ref).Fpath = Prec(PnewRec(MOFdirList.Items[i]).ref).Fpath then
                       if not ((Prec(NR.ref).artist = MOFartist) or (UseCompilationPattern.Checked and (rfCompilation in Prec(NR.Ref).Flags) and (Prec(NR.ref).album = MOFalbum))) then
                       begin
                            b := false;
                            break
                       end
               end;
               if b then //artists/albums+compilation er de samme, find hvilke xtra filer der skal flyttes:
               begin
                    FF.RootDirectory := fPathList.Strings[Prec(PnewRec(MOFdirList.Items[i]).ref).Fpath];
                    FF.Search;

                    for k:=0 to FF.Files.Count-1 do
                    begin
                         if not FnameInNewList(newList, MainFormInstance.GetFilename(FF.Files.Strings[k])) then
                         begin
                              new(MOFr);
                              FillChar(MOFr^, SizeOf(MOFr^), 0);
                              MOFr.NR := MOFdirList.Items[i];
                              MOFr.size := GetFileSize(FF.Files.Strings[k]);
                              MOFr.oldName := FF.Files.Strings[k];
                              MOFlist.Add(MOFr)
                         end
                    end;
                    FF.Files.Clear
               end;
               pBar.Position := i+1
          end;
					MOFdirList.Free;
          loadingLabel.Caption := 'Calculating...';
          MainFormInstance.forceRepaint(loadingLabel)
     end;

     for i:=0 to newList.count-1 do //finder drev til hver rec
     begin
          pbar.position := pbar.position+1;
          NR := newList.Items[i];
          //finder drev
          if DriveOpt.ItemIndex in [0,1] then //keep tracks on their current drive / current dir
          begin
               NR.newDriveIndex := NR.currentDriveIndex
          end else
          if DriveOpt.ItemIndex = 2 then //same artist
          begin
               NR.newDriveIndex := GetDriveWithMostArtistOrAlbum(NR.ref, newList, drives)
          end else
          if DriveOpt.ItemIndex = 3 then //Alphabetically over drives
          begin
               //sætter alle til første drev. Resten rettes efterfølgende
               NR.newDriveIndex := 0
          end
		 end;

     //opdaterer CalcFree på drevene
     for x:=0 to drives.count-1 do
     begin
          DR := drives.items[x];
          for i:=0 to newList.Count-1 do
          begin
               NR := newList.Items[i];
               if (NR.newDriveIndex = x) and not isOnDrive(nr.ref, DR) then
               begin
                    //den skal flyttes over på drevindex x
                    dec(DR.calcFree, getUseSize(NR.ref, DR)); // afskriver fri plads på drevet
                    t := getDriveIndex(NR.ref, drives);
                    if t >= 0 then
                       inc(PdriveRec(drives.items[t]).calcFree, getUseSize(NR.ref, drives.items[t]));
                    if MOF then
										begin
                         for k:=0 to MOFlist.count-1 do
                             if PMOFRec(MOFlist.Items[k]).NR = NR then
                             begin
                                  dec(DR.calcFree, doGetUseSize(PMOFrec(MOFlist.Items[k]).size, DR));
                                  if t >= 0 then
                                     inc(PdriveRec(drives.items[t]).calcFree, doGetUseSize(PMOFrec(MOFlist.Items[k]).size, drives.items[t]))
                             end
                    end
               end
          end
     end;

     //checker om pladsen er OK, ellers skal de flyttes!
     for x:=0 to drives.count-1 do
     begin
          DR := drives.items[x];
          if DR.freeSpaceAfter > DR.calcFree then
          begin
               //der er ikke plads nok.. flytter til andre drev
               if driveOpt.ItemIndex in [0,1] then //same drive
               begin
                    NotEnoughSpace := true
							 end else
               if driveOpt.ItemIndex = 2 then //keep artist on same drive
               begin
                    artistSizes := Tlist.create;
                    //finder en artist på dette drev
                    for i:=0 to newList.count-1 do
                    begin
                         NR := newList.items[i];
                         b := not (UseCompilationPattern.Checked and (rfCompilation in PRec(NR.ref).Flags));  //b=true:artist - b=false:album
                         if (NR.newDriveIndex = x) and not inArtistList(b, NR.ref, artistSizes) then
                         begin
                              new(AR);
                              AR.artist := b;
                              if b then
                                 AR.Index := Prec(NR.ref).ArtistSortOrder
                              else AR.Index := Prec(NR.ref).album;
                              AR.size := GetArtistsSize(b, MOF, newList, MOFlist, AR.Index, DR);     //getArtistsSize(b, AR.Index, DR);
															artistSizes.Add(AR)
                         end
                    end;
                    //sorterer, så de mindste artistsizes kommer øverst
                    artistSizes.Sort(SortbyArtistSizes);

                    while (DR.freeSpaceAfter > DR.calcFree) and (artistSizes.Count > 0) and not NotEnoughSpace do
                    begin
                         proceed := false;
                         for k:=0 to drives.Count-1 do
                             if x<>k then
                             begin
                                  AR := artistSizes.Items[0];
                                  DR2 := drives.items[k];
                                  li := getArtistsSize(AR.artist, MOF, newList, MOFlist, AR.Index, DR2);
                                  if DR2.freeSpaceAfter <= DR2.calcFree - li then
                                  begin
                                       //Der er plads på DR2! flytter recs'ene til DR2
                                       //evt. MOFrecs bliver "automatisk" flyttet, da den jo henviser til NewRec'en
                                       for i:=0 to newList.Count-1 do
                                           if (PnewRec(newList.items[i]).newDriveIndex = x) and (
                                                                                       (AR.artist and (Prec(PnewRec(newList.items[i]).ref).ArtistSortOrder = AR.Index)) or
                                                                                       (not AR.artist and (Prec(PnewRec(newList.items[i]).ref).album = AR.Index))) then
																					 begin
                                                PnewRec(newList.items[i]).newDriveIndex := k;
                                                inc(DR.calcFree, getUseSize(PnewRec(NewList.Items[i]).ref, DR));
                                                dec(DR2.calcFree, getUseSize(PnewRec(NewList.Items[i]).ref, DR2));
                                                if MOF then
                                                begin
                                                     for t:=0 to MOFlist.count-1 do
                                                         if PMOFRec(MOFlist.Items[t]).NR = newList.Items[i] then
                                                         begin
                                                              inc(DR.calcFree, doGetUseSize(PMOFRec(MOFlist.Items[t]).size, DR));
                                                              dec(DR2.calcFree, doGetUseSize(PMOFrec(MOFlist.Items[t]).size, DR2))
                                                         end
                                                end
                                           end;
                                       //fjerner 1'ste artist
                                       dispose(AR);
                                       artistSizes.Delete(0);
																			 proceed := true;
                                       break //breaker for k:=0 to drives.count
                                  end
                             end;
                         NotEnoughSpace := not proceed
                    end;
                    //free'er artistsSizes
                    for i:=0 to artistSizes.count-1 do
                    begin
                         AR := artistSizes.items[i];
                         dispose(AR)
                    end;
                    artistSizes.free
               end else //of keep artist on same drive
               if DriveOpt.ItemIndex = 3 then // Alphabetically
               begin
                    //teknikken er her, at filerne skubbes over til det næste drev, startende med den sidste fil og opefter.
                    // Er det sidste drev overfyldt sættes NotEnoughSpace = true
                    if x = drives.count-1 then
                       NotEnoughSpace := true
                    else
                    begin
                         DR2 := drives.items[x+1];
												 while DR.freeSpaceAfter > DR.calcFree do
                         begin
                              for i:=newList.count-1 downto 0 do
                              begin
                                   NR := newList.Items[i];
                                   if NR.newDriveIndex = x then
                                   begin
                                        //flytter recs'ene til DR2
                                        NR.newDriveIndex := x+1;
                                        inc(DR.calcFree, getUseSize(NR.ref, DR));
                                        dec(DR2.calcFree, getUseSize(NR.ref, DR2));
                                        if MOF then
                                        begin
                                             for t:=0 to MOFlist.count-1 do
                                             if PMOFRec(MOFlist.Items[t]).NR = NR then
                                             begin
                                                  inc(DR.calcFree, doGetUseSize(PMOFRec(MOFlist.Items[t]).size, DR));
																									dec(DR2.calcFree, doGetUseSize(PMOFrec(MOFlist.Items[t]).size, DR2))
                                             end
                                        end;
                                        break //breaker for, så vi kan checke while igen
                                   end
                              end
                         end
                    end
               end
          end
     end;

     if NotEnoughSpace then
        loadingLabel.Caption := 'Not enough diskspace to complete the operation!'
     else
     begin
          //laver nye navne til alle
          if MOF then
             pBar.Max := newList.count + MOFlist.count
          else pBar.Max := newList.count;
          pBar.Position := 0;
          for i:=0 to newList.count-1 do
          begin
							 NR := newList.items[i];
               DR := drives.items[NR.newDriveIndex];	//Denne linie fejler!
               if driveopt.ItemIndex = 0 then       //Keep files in current dir
               	NR.newname := MainFormInstance.CutBS(GetFTextP(NR.ref, FFilePath)) + '\'
               else
               begin
	               NR.newname := DR.drive + '\';
	               if length(DR.root)>0 then
  	                NR.newname := NR.newname + DR.root + '\';
               end;
               if UseCompilationPattern.Checked and (rfCompilation in PRec(NR.ref).Flags) then
                  NR.newName := MainFormInstance.FilenameFromPattern(NR.ref, compilationPatternEdit.text, NR.newName)
               else NR.newName := MainFormInstance.FilenameFromPattern(NR.ref, patternEdit.text, NR.newName);

               pbar.position := pbar.position+1
          end;

          //navne til XtraFiles
          if MOF then
             for i:=0 to MOFlist.Count-1 do
             begin
                  MOFr := MOFlist.Items[i];
									MOFr.newDriveIndex := MOfr.NR.newDriveIndex;
                  MOFr.currentDriveIndex := MOFr.NR.currentDriveIndex;
                  MOFr.newName := MainFormInstance.CutBS(MainFormInstance.getFilePath(MOFr.NR.newname)) + '\' + MainFormInstance.GetFilename(MOFr.oldName);
                  pbar.position := pbar.position+1
             end;

          if ShowPreview.checked then
          begin
               loadingLabel.Caption := 'Generating preview...';
               MainFormInstance.forceRepaint(loadingLabel);
               pBar.position := 0;
               //laver Preview Tree
               Application.CreateForm(TFilePreviewForm, FPF);
               FPF.tree.BeginUpdate;

               for i:=0 to newList.count-1 do
               begin
                    FPF.forceNode(PnewRec(newList.Items[i]).NewName);
                    pbar.position := i+1
               end;

               setLength(Iarr, 0);
               if MOF then
							 begin
                    for i:=0 to MOFlist.count-1 do
                    begin
                         t:=0;
												 MOFr := MOFlist.Items[i];
                         ext := MainFormInstance.getFileExt(MOFr.oldName);
                         b := false;
                         for k:=0 to length(Iarr)-1 do
                             if Q_SameText(ext, Iarr[k].ext) then
                             begin
                                  t := k;
                                  b := true;
                                  break
                             end;

                         if not b then
                         begin
                              SetLength(Iarr, length(Iarr)+1);
															Iarr[length(Iarr)-1].ext := ext;
                              Iarr[length(Iarr)-1].icon := TIcon.Create;
                              w := 0;
                              Iarr[length(Iarr)-1].icon.handle := ExtractAssociatedIcon(self.handle, pchar(MOFr.oldName), w);
                              t := length(Iarr)-1
                         end;

                         FPF.forceNode(MOFr.newName, false, MainFormInstance.TreeImgs.Count + t);
                         pbar.position := pbar.position+1
                    end;

                    for i:=0 to length(Iarr)-1 do
                        MainFormInstance.TreeImgs.AddIcon(Iarr[i].icon)
               end;

               FPF.tree.SortTree(0, sdAscending);
               FPF.tree.endUpdate;
               FPF.ExpandAllClick(nil);
               CurrentActiveForm := FPF;
               mr := FPF.ShowModal;
               CurrentActiveForm := self;

               //freer iconer
							 for i:=0 to length(Iarr)-1 do
               begin
                    MainFormInstance.TreeImgs.Delete(MainFormInstance.TreeImgs.Count-1); //sletter den sidste icon
                    Iarr[i].icon.free
               end;
               setLength(Iarr, 0);

               FPF.Release;
               freeAndNil(FPF)
          end else mr := mrOk;

          pBar.Position := 0;
          if MOF then
             pBar.Max := newList.count + MOFlist.Count
          else pBar.Max := newList.count;

          if mr=mrOk then
					begin
               //starter flytning af filer!
               //henter undo fil
               if SU.checked then
               begin
                    saveD.InitialDir := undoDir;
                    SU.checked := saveD.Execute
               end;

               moveCancelled := false;
               closeBtn.Caption := 'Cancel';
               closeBtn.ModalResult := mrNone;
               button1.Enabled := false;
               driveTree.Enabled := false;

               NR := findNextToMove(nil, newList);
               while (NR <> nil) and not moveCancelled do
               begin
                    application.processmessages;
                    if not NR.moved and spaceToMove(NR, drives.items[NR.newDriveIndex]) then
                    begin
                         loadinglabel.Caption := getFtextP(NR.ref, fFilename) + #13 + NR.newname;
                         MainFormInstance.forceRepaint(loadingLabel);

                         if not fileexists(getFtextP(nr.ref, fFilename)) then
                         begin
                              MainFormInstance.showmessageX('File not found:' + #13 + getFtextP(NR.ref, fFilename));
                              NR.moved := true;
                              NR := findNextToMove(NR, newList);
                              pbar.Position := pbar.Position+1;
                              continue
                         end;

												 if Q_SameText(NR.newname, getFtextP(NR.ref, fFilename)) then
                         begin
                              NR.moved := true;
                              pbar.Position := pbar.Position+1
												 end
												 else
												 begin
															//mover
															proceed := true; //=cancel
															NextAlreadyFound := false;
															b := fileexists(NR.newName);
															while b do
															begin
																	 //filen eksisterer allerede..
																	 case MainFormInstance.RenameDialog('File already exists', getFtextP(NR.ref, fFilename), NR.newname) of
																				rrRename:  b := fileexists(NR.newName);
																				rrOverwrite :
																				begin
																						 b := false;
																						 rec2 := MainFormInstance.findInReclist(NR.newName);
																						 if assigned(rec2) then   //fjerner gammel instance
																						 begin
																									removeNewRec2(rec2, newlist);
																									removeRec(rec2)
																						 end
																				end;
																				rrDelete:  // Delete Source
																				begin
																						 if FileDeleteRB(getFtextP(NR.ref, fFilename)) then
																						 begin
																									NR2 := NR;
																									NR := findNextToMove(NR, newList);
																									NextAlreadyFound := true;
																									removeRec(NR2.ref);
																									removeNewRec(NR2, newlist)
																						 end else MainFormInstance.showmessageX('Could not delete file:' + #13 + getFtextP(NR.ref, fFilename));
																						 b := false;
																						 proceed := false
																				end;
																				rrCancel:
																				begin
																						 b := false;
																						 proceed := false;
																						 NR.moved := true //så den ikke spørger igen
																				end
																	 end
															end;
															if not proceed then
                              begin
																	 if not NextAlreadyFound then
																	 begin
																		NR.moved := true;
																		NR := findNextToMove(NR, newList)
																	 end;
                                   pbar.Position := pbar.Position+1;
                                   continue //næste fil
                              end;

															pbar.Position := pbar.Position+1;
                              //Flytter filen!
                              if forceDirectories(MainFormInstance.getFilepath(NR.newName)) then
																 if MoveFileX(getFtextP(NR.ref, fFilename), NR.newName, true) then
                                 begin
                                      if SU.checked then    //gem undo?
                                         undoList.add(MainFormInstance.createOpUndo(otMove, getFtextP(NR.ref, fFilename), NR.newname));

                                      if DelDirsBox.checked then
                                         AddDelDir(getFtextP(NR.ref, fFilePath), delDirs);

                                      NR.moved := true;
                                      BeginSetArtistAlbumFilename;
                                      try
                                      	setFilename(NR.ref, NR.newName, true)
                                      finally
                                      	EndSetArtistAlbumFilename
                                      end;
                                      Prec(NR.ref).LastWriteTime := FileAge(NR.newName);
                                      DR := drives.items[NR.newDriveIndex];
                                      dec(DR.calcFree, getUseSize(NR.ref, DR));
                                      if NR.currentDriveIndex > -1 then
                                      begin
                                           DR := drives.items[NR.currentDriveIndex];
                                           inc(DR.calcFree, getUseSize(NR.ref, DR))
                                      end;
                                      NR.currentDriveIndex := NR.newDriveIndex
																 end else
																 begin
																			NR.moved := true;
																			MainFormInstance.showmessageX('Could not move' + #13 + getFtextP(NR.ref, fFilename) + #13 + 'to' + #13 + NR.newName + #13#13 + SysErrorMessage(GetLastError))
                                 end
                              else
                              begin
                                   NR.moved := true;
                                   MainFormInstance.showmessageX('Could not move' + #13 + getFtextP(NR.ref, fFilename) + #13 + 'to' + #13 + NR.newName + #13 + 'Could not create directory' + #13 + MainFormInstance.getFilepath(NR.newName))
                              end
                         end
                    end;
										NR := findNextToMove(NR, newList)
               end;
               if MOF then     //flytter MOF filer
               begin
                    MOFr := findNextMOFToMove(nil, MOFlist);
                    while (MOFr <> nil) and not moveCancelled do
                    begin
                         application.processmessages;
                         if not MOFr.moved and MOFSpaceToMove(MOFr, drives.items[MOFr.newDriveIndex]) then
                         begin
                              loadinglabel.Caption := MOFr.oldName + #13 + MOFr.newname;
                              MainFormInstance.forceRepaint(loadingLabel);

                              if not fileexists(MOFr.oldName) then
                              begin
                                   MainFormInstance.showmessageX('File not found:' + #13 + MOFr.oldName);
                                   MOFr.moved := true;
                                   MOFr := findNextMOFToMove(MOFr, MOFlist);
                                   pbar.Position := pbar.Position+1;
                                   continue
                              end;

                              if Q_SameText(MOFr.oldName, MOFr.newName) then     //det nye og gamle navn er det samme...
                              begin
                                   MOFr.moved := true;
                                   pbar.Position := pbar.Position+1
                              end
                              else
                              begin
                                   //filen skal flyttes
                                   proceed := true; //=cancel
                                   b := fileexists(MOFr.newName);
                                   while b do //filen eksisterer allerede..
                                   begin
                                        case MainFormInstance.RenameDialog('File already exists', MOFr.oldName, MOFr.newname) of
                                             rrRename:     b := fileexists(MOFr.newName);
                                             rrOverwrite : b := false;
                                             rrDelete:  // Delete Source
                                                        begin
                                                             if not FileDeleteRB(MOFr.oldName) then
                                                                MainFormInstance.showmessageX('Could not delete file:' + #13 + MOFr.oldName);
                                                             b := false;
                                                             proceed := false
                                                        end;
                                             rrCancel:
                                                      begin
                                                           b := false;
                                                           proceed := false;
                                                           MOFr.moved := true //så den ikke spørger igen
                                                      end
                                             end
                                   end;
                                   if not proceed then
                                   begin
                                        MOFr.moved := true;
                                        MOFr := findNextMOFToMove(MOFr, MOFlist);
                                        pbar.Position := pbar.Position+1;
                                        continue //næste fil
                                   end;

                                   pbar.Position := pbar.Position+1;
                                   //Flytter filen!
																	 if forceDirectories(MainFormInstance.getFilepath(MOFr.newName)) then
																			if MoveFileX(MOFr.oldName, MOFr.newName, true) then
                                      begin    //filen er flyttet på HD'en
                                           if SU.checked then    //gem undo?
                                              undoList.add(MainFormInstance.createOpUndo(otMove, MOFr.oldName, MOFr.newname));

                                           MOFr.moved := true;
                                           DR := drives.items[MOFr.newDriveIndex];
                                           dec(DR.calcFree, doGetUseSize(MOFr.size, DR));
                                           if MOFr.currentDriveIndex > -1 then
                                           begin
                                                DR := drives.items[MOFr.currentDriveIndex];
                                                inc(DR.calcFree, doGetUseSize(MOFr.size, DR))
                                           end;
                                           MOFr.currentDriveIndex := MOFr.newDriveIndex
                                      end else
                                      begin
                                           MOFr.moved := true;
                                           MainFormInstance.showmessageX('Could not move' + #13 + MOFr.oldName + #13 + 'to' + #13 + MOFr.newName  + #13#13 + SysErrorMessage(GetLastError))
                                      end
                                   else
                                   begin
                                        MOFr.moved := true;
																				MainFormInstance.showmessageX('Could not move' + #13 + MOFr.oldName + #13 + 'to' + #13 + MOFr.newName + #13 + 'Could not create directory' + #13 + MainFormInstance.getFilepath(MOFr.newName))
                                   end
                              end //old + newname er det samme
                         end;
                         MOFr := findNextMOFToMove(MOFr, MOFlist)
                    end //of while
               end;
               if SU.checked then
                  MainFormInstance.saveOpUndos(undoList, saveD.FileName);
               if (DelDirs.count>0) and not moveCancelled then
               begin
                    loadingLabel.caption := 'Deleting empty directories...';
                    MainFormInstance.forceRepaint(loadingLabel);
                    delDirs.Sorted := false;
                    delDirs.CustomSort(sortStringsByLength);
                    pBar.Max := DelDirs.Count;
                    for i:=0 to deldirs.count-1 do
                    begin
                         pBar.Position := i+1;
                         if not MainFormInstance.DirInAutoScanList(delDirs.strings[i]) then
                            RemoveDir(delDirs.strings[i]) //sletter biblioteket, men kun hvis det er tomt
                    end
               end
          end
     end;

     //free'er new list
     for i:=0 to newList.count-1 do   // de skal ikke disposes, det gør træet
     begin
          NR := newList.Items[i];
          dispose(NR)
     end;

     if MOF then
     begin
          for i:=0 to MOFlist.count-1 do
              dispose(PMOFRec(MOFlist.Items[i]));
          MOFlist.free
     end;
     newList.free;
     drives.free;
     delDirs.free;

     closeBtn.Caption := 'Close';
     closeBtn.ModalResult := mrCancel;
     button1.Enabled := true;
     driveTree.Enabled := true;

     if moveCancelled then
        loadingLabel.caption := 'Cancelled'
     else loadingLabel.caption := 'Done';
     fillDriveData
end;

function TOrgFiles.init:boolean;
var
	ld : DWORD;
	i, u:integer;
  aNode:PVirtualNode;
	p:PdriveRec;
  s: string;
  found: boolean;
begin
	//fylder DriveRec
  ld := GetLogicalDrives;
  for u := 2 to 25 do
  begin
	  if ((ld and (1 shl u)) <> 0) and (GetDriveType(pchar(Char(Ord('A') + u) + ':\')) in [DRIVE_FIXED, DRIVE_REMOTE, DRIVE_REMOVABLE]) then
		  if DrivePresent(Char(Ord('A') + u)) then
		  begin
			  aNode := driveTree.AddChild(nil);
			  p := driveTree.GetNodeData(aNode);
			  fillChar(P^, sizeof(p^), #0);
			  p.use := false;
			  p.freeSpaceAfter := 0;
			  p.drive := Char(Ord('A') + u) + ':'
		  end
  end;

  //Fill network paths etc.
  for i:=0 to list.Count -1 do
  begin
  	s := GetFTextP(list.items[i], FfilePath);
    if Q_SameStrL(s, '\\', 2) then
			Q_CutRight(s, length(s) - Q_StrScan(s, '\', Q_StrScan(s, '\', 3)+1))
    else
	    Q_CutRight(s, length(s) - Q_StrScan(s, '\', 3));

    found := false;
    aNode := driveTree.GetFirst;
    while aNode <> nil do
    begin
    	p := driveTree.GetNodeData(aNode);
      if Q_SameText(p.drive + '\', s) then
      begin
      	found := true;
        break
      end;
      aNode := driveTree.GetNext(aNode)
    end;

    if not found then
    begin
    	aNode := driveTree.AddChild(nil);
      p := driveTree.GetNodeData(aNode);
      fillChar(P^, sizeof(p^), #0);
      p.use := false;
      p.freeSpaceAfter := 0;
      p.drive := Q_CopyRange(s, 1, length(s)-1) //remove trailing \
    end;
  end;

  if list.count>0 then
  begin
    result := true;
    fillDriveData(true)
  end else result := false
end;

procedure TOrgFiles.FormCreate(Sender: TObject);
begin
  //henter indstillinger
  with Settings do
  begin
    if ValueExists('OFUseCompilation') then
       UseCompilationPattern.Checked := ReadBool('OFUseCompilation');
    if ValueExists('OFDelDirs') then
       DelDirsBox.Checked := ReadBool('OFDelDirs');
    if ValueExists('OFsaveUndos') then
       SU.Checked := ReadBool('OFsaveUndos');
    if ValueExists('OFshowPreview') then
       ShowPreview.Checked := ReadBool('OFshowPreview');
    if ValueExists('OFmoveOther') then
       MoveOtherFiles.Checked := ReadBool('OFmoveOther')
  end;

  Icon := MainFormInstance.Icon1.picture.icon;
  driveTree.NodeDataSize := SizeOf(TdriveRec);

  list := Tlist.create;
  undoList := Tlist.Create;
  patternHelp.Caption := PatternHelpText + #13;
  if fileexists(settingsdir + 'patternList1.dat') then
  patternEdit.Items.LoadFromFile(settingsdir + 'patternList1.dat');
  if patternEdit.Items.Count > 0 then
  begin
  if patternEdit.Items.IndexOf(patternEdit.Text) = -1 then
  patternEdit.Items.Add(patternEdit.Text);
  patternEdit.ItemIndex := 0
  end;
  if fileexists(settingsdir + 'patternList2.dat') then
  compilationPatternEdit.Items.LoadFromFile(settingsdir + 'patternList2.dat');
  if compilationPatternEdit.Items.Count > 0 then
  begin
  if compilationPatternEdit.Items.IndexOf(compilationPatternEdit.Text) = -1 then
  compilationPatternEdit.Items.Add(compilationPatternEdit.Text);
  compilationPatternEdit.ItemIndex := 0
  end;
end;

procedure TOrgFiles.FillDriveData(markAllUsed:boolean=false);
	function GetClusterSize(drivepath:string):cardinal;
	var
		secPrCl, nr1, nr2 : cardinal;
	begin
		GetDiskFreeSpace(pchar(drivePath), secPrCl, result, nr1, nr2)
	end;

var
	aNode: PVirtualNode;
  p: PdriveRec;
  root: String;
begin
  aNode := driveTree.GetFirst;
  while aNode <> nil do
  begin
    p := driveTree.GetNodeData(aNode);
    p.currentFree := diskSpace64.GetFreeSpace64(p.drive); //DiskFree(Ord(p.drive[1])-Ord('A')+1);
    p.calcFree := p.currentFree;
    p.BytesCluster := GetClusterSize(p.drive + '\');
    p.hasFiles := HasFilesOnDrive(p, root);
    if markAllUsed then
       p.root := root;
    p.use := p.use or (markAllUsed and p.hasFiles);
    if p.use then
       driveTree.CheckState[aNode] := csCheckedNormal
    else driveTree.CheckState[aNode] := csUnCheckedNormal;
    aNode := driveTree.GetNext(aNode)
  end
end;

function TOrgFiles.HasFilesOnDrive(pDR:pointer; var root:string):boolean;
function sameTextLength(const s:String):integer;
var      l:integer;
begin
    result := 1;
    l := min(length(root), length(s));
    while (result<=l) and (Q_CharUpper(root[result])=Q_CharUpper(s[result])) do
          inc(result);
    dec(result)
end;
var
	DR:PdriveRec;
	driveStr: String;
  i, x, rootLength, driveLength :integer;
begin
     DR := pDR;
     driveLength := length(DR.drive)+1;
     driveStr := DR.drive + '\';

     //finder den første root
     root := '';
     for i:=0 to list.count-1 do
         if Q_SameTextL(driveStr, getFtextP(list.items[i], fFilePath), driveLength) then
         begin
              root := getFtextP(list.items[i], fFilePath);
              break
         end;

     rootLength := length(root);

     for i:=0 to list.count-1 do
     if Q_SameTextL(driveStr, getFtextP(list.items[i], fFilePath), driveLength) then
     begin
          x := sameTextLength(getFtextP(list.items[i], fFilePath));
          if x <> rootLength then
          begin
               Q_CutRight(root, rootLength-x);
               rootLength := x
          end;
          if rootLength=0 then
             break
     end;                                                                                                        
     Q_CutRight(root, rootLength-Q_StrRScan(root, '\'));
     root := MainFormInstance.cutBS(root);
     result := length(root)>0;

     //fjerner drive fra root
     if length(root) > 0 then
	     Q_CutLeft(root, length(driveStr))
end;

procedure TOrgFiles.driveTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var   p:PdriveRec;
begin
     p := Sender.GetNodeData(Node);
     case column of
          0: CellText := ''; //use
          1: CellText := p.drive; //drive
          2: CellText := p.root; //rootdir
          3: CellText := inttostr(p.currentFree div oneMeg); //calcfree
          4: CellText := inttostr(p.freeSpaceAfter div oneMeg)
     end
end;

procedure TOrgFiles.driveTreeChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var   p:PdriveRec;
begin
     p := Sender.GetNodeData(Node);
     p.use := Sender.CheckState[Node]=csCheckedNormal
end;

procedure TOrgFiles.driveTreeFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
     finalize(PdriveRec(Sender.GetNodeData(Node))^)
end;

procedure TOrgFiles.UseCompilationPatternClick(Sender: TObject);
begin
     compilationPatternEdit.Enabled := UseCompilationPattern.Checked
end;

procedure TOrgFiles.FormDestroy(Sender: TObject);
function AddToStrLst(const cb: TComboBox; const StrLst: TStringList):Boolean;
var
	i:integer;
begin
	StrLst.Clear;
	StrLst.Add(cb.Text);
	for i:=0 to cb.Items.Count-1 do
		if StrLst.IndexOf(cb.Items[i]) = -1 then
			StrLst.Add(cb.Items[i]);
	result := StrLst.Count > 0
end;
var
	StrLst: TStringList;
begin
	//gemmer indstillinger
	with Settings do
	begin
		WriteBool('OFUseCompilation', UseCompilationPattern.Checked);
		WriteBool('OFDelDirs', DelDirsBox.Checked);
		WriteBool('OFsaveUndos', SU.Checked);
		WriteBool('OFshowPreview', ShowPreview.Checked);
		WriteBool('OFmoveOther', MoveOtherFiles.Checked)
	end;
	list.free;
	undoList.free;

	StrLst := TStringList.Create;
	if AddToStrLst(patternEdit, StrLst) then
		StrLst.SaveToFile(settingsdir + 'patternList1.dat');
	if AddToStrLst(CompilationPatternEdit, StrLst) then
		StrLst.SaveToFile(settingsdir + 'patternList2.dat');
	StrLst.free
end;

procedure TOrgFiles.driveTreeEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
     allowed := column in [2, 4]
end;

procedure TOrgFiles.setCheckType(ct:TCheckType);
var       aNode:PvirtualNode;
          DR:PdriveRec;
begin
     aNode := driveTree.GetFirst;
     while aNode <> nil do
     begin
          driveTree.CheckType[aNode] := ct;
          if ct = ctCheckBox then
          begin
               DR := driveTree.GetNodeData(aNode);
               if DR.use then
                  driveTree.CheckState[aNode] := csCheckedNormal
               else driveTree.CheckState[aNode] := csUncheckedNormal
          end;
          aNode := driveTree.GetNext(aNode)
     end
end;

procedure TOrgFiles.DriveOptClick(Sender: TObject);
begin
	driveTree.Enabled := driveOpt.ItemIndex <> 0;
	with driveTree.Header.Columns[0] do
    if driveOpt.ItemIndex in [0, 1] then
    begin
	    options := options - [coEnabled];
	    setCheckType(ctNone)
    end else
    begin
  	  options := options + [coEnabled];
	    setCheckType(ctCheckBox)
    end
end;

procedure TOrgFiles.driveTreeNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var     DR:PdriveRec;
begin
     DR := Sender.GetNodeData(Node);
     if column = 2 then //Root Directory
     begin
          DR.root := NewText;
          if Q_StrScan(DR.root, ':')>0 then
             Q_CutLeft(DR.root, Q_StrScan(DR.root, ':')+1);
          DR.root := MainFormInstance.cutBS(DR.root)
     end else
     if (column = 4) and Q_IsInteger(NewText) then  //free space after
        DR.freeSpaceAfter := oneMeg*strToInt(NewText)
end;

procedure TOrgFiles.driveTreeDragAllowed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
     allowed := true
end;

procedure TOrgFiles.driveTreeDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
   Attachmode: TVTNodeAttachMode;
begin
      case Mode of
      dmAbove:  AttachMode := amInsertBefore;
      dmOnNode: AttachMode := amInsertAfter;
      dmBelow:  AttachMode := amInsertAfter;
      else AttachMode := amNowhere;
      end;
      sender.MoveTo(sender.GetFirstSelected, sender.DropTargetNode, AttachMode, false)
end;

procedure TOrgFiles.driveTreeDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
     accept := true
end;

procedure TOrgFiles.CloseBtnClick(Sender: TObject);
begin
     moveCancelled := true
end;

procedure TOrgFiles.Label3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     MoveOtherFiles.Checked := not MoveOtherfiles.Checked
end;

procedure TOrgFiles.driveTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
	if Column = 2 then
		ImageIndex := 16
end;

procedure TOrgFiles.driveTreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	aNode: PVirtualNode;
	DR: PdriveRec;
	cx: Integer;
	dir: String;
begin
	aNode := driveTree.GetNodeAt(x, y);
	cx := driveTree.Header.Columns[2].Left;
	if assigned(aNode) and (x > cx) and (x < cx + 20) then
	begin
		DR := driveTree.GetNodeData(aNode);
		dir := DR.drive + '\' + DR.root;
		if SelectDirectory('Select "root" direcory', DR.Drive + '\', dir) then
			if Q_SameTextL(DR.Drive, dir, length(DR.Drive)) then
				DR.root := Q_CopyFrom(dir, length(DR.Drive)+2)
			else
				MainFormInstance.Showmessagex('Please select a directory from drive ' + DR.drive)
	end
end;

end.


