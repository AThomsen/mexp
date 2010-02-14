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


unit MEXPtypes;

interface
uses Windows, SysUtils, Classes, Graphics, Controls, QStringList, Jpeg;

type
  GroupCheckState = (
    GroupCheckState_Unchecked,
    GroupCheckState_Checked,
    GroupCheckState_Exclude);

type
	UpdateRecTagOption = (
  	UpdateRecTagOption_UpdateIfExists,
    UpdateRecTagOption_UpdateElseCreate,
    UpdateRecTagOption_DontUpdate);



type 	UpdateRecValuesResult = (
                UpdateRecValuesResult_Success,
                UpdateRecValuesResult_Error,
                UpdateRecValuesResult_Cancelled);


type  TTreeKind = (
								TreeKind_Harddisk,
								TreeKind_CDROM,
								TreeKind_Network,
								TreeKind_Zip,
								TreeKind_Artist,
								TreeKind_ArtistAlbum,
                TreeKind_FullArtistAlbum,
                TreeKind_PartialArtistAlbum,
								TreeKind_Album,
                TreeKind_PartialAlbum,
                TreeKind_FullAlbum,
                TreeKind_Set,
                TreeKind_YearAlbum,
                TreeKind_FullYearAlbum,
                TreeKind_PartialYearAlbum,
								TreeKind_CompilationAlbum,
								TreeKind_CompilationParent,
								TreeKind_Genre,
								TreeKind_Drive,
                TreeKind_DriveRecursive,
                TreeKind_Directory,
								TreeKind_DirectoryRecursive,
								TreeKind_TrimmedDirectory,
                TreeKind_TrimmedDirectoryRecursive,
								TreeKind_PlaylistParent,
								TreeKind_Playlist,
								TreeKind_GroupParent,
								TreeKind_Group,
								TreeKind_GroupSetting,
								TreeKind_MultGenre,
                TreeKind_CustomField,
                TreeKind_Year,
                TreeKind_Decade,
                TreeKind_FullCompilationAlbum,
                TreeKind_PartialCompilationAlbum,
                TreeKind_Rating
                );

type
	TwoPointers = record
  	str: Pointer;
    rec: Pointer;
  end;
  PTwoPointers = ^TwoPointers;

type
	PointerAndInt = record
  	p: pointer;
    i: integer;
  end;
  PPointerAndInt = ^PointerAndInt;

type
	TtreeFilterRec = packed record
	  i: Integer;
		Tag: Integer;
		Kind : TtreeKind;
  end;

{	TPointerStringRec = packed record
  	p : pointer;
    s : String;
	end;
	pPointerStringRec = ^TPointerStringRec;   }

{  TPointerPCharRec = packed record
  	p : pointer;
    pc : PChar;
	end;
	PPointerPCharRec = ^TPointerPCharRec;  }

	TTreeStructureContents = (
  	tscCompilationContainer,
    tscCompilations,
		tscArtists,
		tscAlbums,
    tscYear_Albums,
    tscArtist_albums,
		tscGenres,
    tscDrivesRecursive,
		tscDirectoriesRecursive,
    tscTrimmedDirectoriesRecursive,
    tscLocation,
    tscNone,
    tscDrives,
		tscDirectories,
    tscTrimmedDirectories,
    tscCustomField,
    tscSets,
    tscArtistsSortOrder,
    tscYears,
    tscDecades,
    tscRatings
	);

  PTreeStructureNode = ^TTreeStructureNode;
  TTreeStructureNode = Packed Record
  	Child: PTreeStructureNode;
    NextSibling: PTreeStructureNode;
//    PrevSibling: PTreeStructureNode;		//This is mostly invalid and must only be used in UpdateTree..FillTree where it is validated!
		CustomFieldIndex: Integer;
    SortColumnField: Integer;
    MinCount: Integer;
    Content: TTreeStructureContents;
    IncludeCompilation: Boolean;
  end;

  PTreeStructure = ^TTreeStructure;
  TTreeStructure = record
  	Head: PTreeStructureNode;
    Index: Integer;
    PreDefinedIndex: Integer;	//Original index from pre-defined treestructures. -1 if costum treestructure
    Text: String;
  end;

	TAudioType = record
  			 SortIndex: Integer;
				 longName : String;
				 shortName : String;
				 StopWinampWhenEdit: Boolean;
         Id3v1: boolean;
				 Id3v2: boolean;
				 Ogg  : boolean;
				 ApeV1: boolean;
				 ApeV2: boolean;
				 WMA  : boolean;
         audio: boolean;
         video: boolean;
         ext : array of String;
				 channelNames : array of String;
	end;

//TRecFlag = Word;

TSkinRec = record
	Name: String;
	Filename: String;
	Author: String;
  AuthorURL: String;
	Comment: String;
	CorrespondTo: String; //winamp skin name
  CorrespondToURL: String;
	InUse: Boolean;
end;

  TAskGroupToRecResult = (agtrrAddGroup, agtrrIgnore, agtrrRemoveGroupFromTag, agtrrRemoveGroupFromAllTags, agtrrUseExistingGroup);

	TAskGroupData = record
		GroupName: String;
    Filename: String;
    result: TAskGroupToRecResult;
		GroupIndex: Integer; //filled by method. -1 = don't use group
	end;
  PAskGroupData = ^TAskGroupData;

type
	TColSave=record
		Visible:Boolean;
		Position:Byte;
		Width:Cardinal;
	end;

type
	TFileAndText=record
  	text: String;
    filename: String
  end;
  PFileAndText = ^TFileAndText;

type TThreeStrings=array[0..2] of String;

type TStringAndInt = record
	i:integer;
  s:string;
end;
	PStringAndInt = ^TStringAndInt;

type TTwoStrings = record
	s1: String;
  s2: String;
end;
	PTwoStrings = ^TTwoStrings;


TrenameReturn = (rrOverwrite, rrDelete, rrRename, rrCancel, rrUndef);
TopType = (otMove);

TTreeShow = (
		tsArtistAlbum1,
		tsAlbum,
		tsArtistAlbum2,
		tsGenre,
		tsMultipleGenres,
		tsDir,
		tsDir2
	);

	TtagValue = record
  	field:integer;
    customFieldIndex: integer;
    value:string;
  end;
  TTagValues = array of TTagValue;
  PTagValues = ^TTagValues;

  TIntAndString = record
  	i: Integer;
  	s: String;
  end;
  PIntAndString = ^TIntAndString;

  TFNT = Record
    Fontname:String[64];
    Size:Cardinal;
    Charset:TFontCharSet;
    Color : Tcolor;
    Pitch : TFontPitch;
    Bold : Boolean;
    Italic : Boolean;
    Underline : Boolean;
    StrikeOut : Boolean
  end;

Thms    = record
				Hour    : word;
        Min     : byte;
        Sec     : byte;
        mSec    : word
end;

	TScanParameter = record
		master: Integer;
		onlyNew: boolean;
		UpdateTreeAndTabel: Boolean;
		CalculateCRC: Boolean;
    repairVBR: Boolean;
		RunAfterScan: TNotifyEvent;
    name: String;
	end;

  TScanParameters = record
  	arr: array of TScanParameter;
  end;
  PScanParameters = ^TScanParameters;



  TPlaylistFile = record
  	filename: String;
    files: TQ_Stringlist;
  end;

  TPlaylistFiles = record
  	playlists: packed array of TPlaylistFile
  end;

  PPlaylistFiles = ^TPlaylistFiles;


	TShowMessageParameters = record
		text: String;
		alignment: TAlignment;
	end;
	PShowMessageParameters = ^TShowMessageParameters;

TautoScan3ButRec = record
                 fname:String;
                 newname:string;
                 result:TrenameReturn;
end;
PautoScan3ButRec = ^TautoScan3ButRec;

TPlBoxData = record  //Playlistbox
  text:string;
  TopList:Boolean;
end;
PPlBoxData = ^TPlBoxData;

type TuseToSuggestKind = (
                       useToSuggest_unDefined,
                       useToSuggest_use,
                       useToSuggest_notuse
                       );

TPLcacheRec = Record
				Cache : packed array of pointer;
        Complete : boolean;
end;
PPLcacheRec = ^TPLcacheRec;

TCustomField = Record
	dataType: Integer;
	iconIndex: Integer;
  name: String;
  id3v2FieldName: String;
  id3v2Description: String;				//Set if id3v2FieldName = COMM or TXXX
  id3v2DefaultLanguage: String;		//Set if id3v2FieldName = COMM
  id3v2ReadAllLanguages: boolean;	//Set if id3v2FieldName = COMM
  oggFieldName: String;
  apeFieldName: String;
  wmaFieldName: String;
  Filter: Boolean;
end;
PCustomField = ^TCustomField;

TCustomFieldEntry = Packed Record
  data: Pointer;
  FieldIndex: Byte;
end;
PCustomFieldEntry = ^TCustomFieldEntry;

TStringData = Record
	value: String;
end;
PStringData = ^TStringData;

TIntegerData = Record
	value: Integer;
end;
PIntegerData = ^TIntegerData;

TRealData = Record
	value: Single;
end;
PRealData = ^TRealData;

TplRec = record
        Name:String[255];
        Filename:String[255];
        UseToSuggest:TuseToSuggestKind;
        location:integer;
        CacheRef:pointer;
end;
PplRec = ^TplRec;

type
Trec2 = packed record
				Name:String;
				Filename:String;
        Paths: array of String;
        Excl: array of String;
        Snrs:array of Integer;
        color:TColor;
				TreeStructureIndex : Integer;

        recursive:boolean;
        Loaded:Boolean;
        calculateCRC: Boolean;
        repairVBR: Boolean;

        exists:boolean;					//Specifies if one of the path in Paths exists.
        UseCustomColor:Boolean;
        Media:ShortInt;
        Order:SmallInt;
	end;
type

TRecFlags = Set of (
	rfPlaying,
  rfCompilation,
  rfHasId3v1,
	rfHasId3v2,
  rfHasApeTag,
	rfHasWmaTag,
  rfHasOggTag,
  rfHasLyrics,
  rfEqualId3,
  rfAutoScanned,
  rfDeletePending,
  rfGroupFiltered,
  rfTreeFiltered
  );

//.recdefine - husk at ændre i CopyToMyMusic hvis noget blir ændret her!
// husk også at ændre AddToStream, StaticSize i UnloadAndSaveAll

{Trec = packed record
  AudioType : byte;        //1
  Fpath:integer;           //5
  Artist:integer;          //9
  ArtistSortOrder : integer; 		 //13 {artist without THE}
{  Album:integer;           //17
  Year:SmallInt;           //19
  Track:Byte;              //20
  TotalTracks: Byte;       //21
  Kbps:SmallInt;           //22
  Length:Cardinal;    {ms} //26
 { addQuality:Word; 				 //28				additional quality. Bruges bl.a. i MusePack
  LastWriteTime:TDateTime; //36
  DatabaseTime:TDateTime;  //44
  Channels:ShortInt;       //46
  Playcount:word;          //48
  FSize:Cardinal;          //52
  Khz:word;                //54
  flags: word;             //56
	Rating: Byte;						 //57
  PartOfSet: Byte;				 //58		//første 4 bit er POS, sidste 4 bit er total POS
  CRC:LongWord;            //62

  Location:integer;           //skal ikke gemmes med
  //dateadd: Tdatetime;
	CustomFields: Array of TCustomFieldEntry;
  Genre: Array of Cardinal;
  Groups : Array of Byte;
  Fname:string;
  Title:String;
  Comment:String;
end;            }

Prec=^Trec;
Trec = packed record
  Fpath:integer;           	//4		4
  Artist:integer;          	//4		8
  ArtistSortOrder : integer;//4		12	{artist without THE}
  Album:integer;           	//4		16
  Year:SmallInt;           	//2		18
  Kbps:SmallInt;           	//2   20
  Track:Word;              	//2		22
  TotalTracks: Word;       	//2   24
  AudioType : byte;        	//1   25
  Rating: Byte;						 	//1   26
  PartOfSet: Byte;				 	//1		27	//første 4 bit er POS, sidste 4 bit er total POS
  Channels:ShortInt;       	//1   28
  Length:Cardinal;    {ms} 	//4   32
  addQuality:Word; 				 	//2		34		additional quality. Bruges bl.a. i MusePack
  Khz:word;                	//2   36
  LastWriteTime:Integer; 		//4   40
  DatabaseTime:Integer;  		//4   44
  FSize:Cardinal;          	//4   48
  Playcount:word;          	//2   50
  Flags: TRecFlags;         //2   52
  FilenameHash: LongWord;		//4		56
  CRC:LongWord;            	//4   60

  Location:integer;           //skal ikke gemmes med
	CustomFields: packed Array of TCustomFieldEntry;
  Genre: packed Array of Cardinal;
  Genree: Pointer;
  Groups : packed Array of Byte;
  Fname: PChar;
  Title: PChar;
  Comment: String;	//This could contain #0's, so don't put it in a PChar
end;

type TCoverSourceType = (
                       coverSource_imageFile,
                       coverSource_id3v2TagIndex3,
                       coverSource_id3v2TagIndex0
                       );

TCoverRecFlags = Set of (
	crfThumbnailChanged,		//Set to true to save thumbnail on save
  crfInvalidateThumb,			//Set to true to invalidate thumb
  crfDeletePending,				//Set to true to delete
  crfThumbnailVisible   	//Set to true if the thumbnail is actually visible in the tree
);     

TCoverRecState = (
	NotLoaded,
  RequestLoad,
  Loading,
  ImageLoaded,
  ErrorLoading );

TCoverRec = Packed Record
  SourceRec: Prec;
  LoadPriority: Cardinal;
  ThumbnailWidth: SmallInt;
  ThumbnailHeight: SmallInt;
  SourceType: TCoverSourceType;
  State: TCoverRecState;	//Set this to true to load the image
  Flags: TCoverRecFlags;
  Image: TJPEGImage;	//The thumbnail
  ImageFilename: String;	//Original image
  ThumbCacheFilename: String;	//only the filename excluding the path
end;
PCoverRec = ^TCoverRec;

TTreeRec = Record	//changed from Packed Record to Record to improve performance (17/7/05)
				Location:Integer;
				Tag:Integer;
        Count:Cardinal;
        SortField: Integer; //-1 is "don't change"
        Contents: TTreeStructureContents; //Size = 1
        Kind:TTreeKind;	//Size = 1

        Exists:Boolean;	//Size = 1
        Editable:Boolean; 	//Size = 1
        PathListIndex:Integer;	//bruges kun i TreeKind og TreeKind2
        TotalTime:int64;
        PlRecRef:pointer;
        CoverRec: PCoverRec;
        Text:String;
end;
PTreeRec = ^TTreeRec;

TTreeRecSave = packed Record	//Used to get size when saving/loading tree
	Location:Integer;
  Tag:Integer;
  Count:Cardinal;
  SortField: Integer; //-1 is "don't change"
  Contents: TTreeStructureContents;
	Kind:TTreeKind;
end;

TplstRec = packed record //WinPlaylist
  Playing:Boolean;
  Kill:byte;
  ShuffleValue:byte;	// 0="never played", 255="just played". dec everytime a new song is played
  EnqueueNo:byte;
  Seconds:Word;
  Rec:PRec;
  Filename:String;
  Text:String;
end;
PplstRec = ^TplstRec;

TplstUndoRec = packed record //WinPlaylist undo record
	Rec:PRec;
	Playing:Boolean;
  Kill:byte;
  ShuffleValue:byte;	// 0="never played", 255="just played". dec everytime a new song is played
  EnqueueNo:byte;
end;
PplstUndoRec = ^TplstUndoRec;

type
TplConRec = record //Playlist Contents (plCon)
	rec: PRec;
  Filename:String;
  Text:String;
  Seconds:Word;
end;
PplConRec = ^TplConRec;

TTreeData = packed record
  p: Pointer;
end;
PTreeData = ^TTreeData;

TSaveGroupRec = record
	Name : String[255];
	Checkstate : GroupCheckState; 
end;

TGroupRec = record	//Shouldn't be packed record
	Name : String;
//	Checked : Boolean;
  Checkstate : GroupCheckState;
  Selected : Boolean;		//When the group is selected in the tree
	SelectedFilesInGroup : Boolean;
end;
PGroupRec = ^TGroupRec;



TFileUndoRec = packed record
	dt:TdateTime;
  oldName:String;
  newName:string;
  canUndo:boolean; //bruges først når der skal undoes. (=fileExists(newName))
  opType:TopType;
end;
PfileUndoRec = ^TfileUndoRec;

TListSortCompareData = function (Item1, Item2: Pointer; Data: Integer): Integer;

procedure SetPCharString(var p: PChar; const newValue: String);

Procedure FreeTreeStructure(p: PTreeStructure);
procedure FreeTreeStructureNode(pNode: PTreeStructureNode);
function NewTreeStructureNode: PTreeStructureNode;	overload;
function NewTreeStructureNode(Content: TTreeStructureContents; IncludeCompilation: Boolean): PTreeStructureNode;	overload;
Procedure SaveTreeStructure(p: PTreeStructure; Stream: TStream);
Function LoadTreeStructure(Stream: TStream): PTreeStructure;
Procedure ChangeTreeStructureContent(p: PTreeStructure; FromContent, ToContent: TTreeStructureContents);

type
	TSortPartList = Class(TList)
	Public
  	procedure SortPart(Compare: TListSortCompare; FirstIndex, LastIndex: Integer);	overload;
    procedure SortPart(Compare: TListSortCompareData; FirstIndex, LastIndex, Data: Integer);	overload;
  end;

  // TVTNodeMemoryManager is a high-performance local memory manager for allocating TVirtualNode structures.
  // It is not thread-safe in itself, because it assumes that the virtual tree is being used within a single
  // thread. The local memory manager supports only fixed-length allocation requests - all requests must be of
  // the same size. The performance improvements are a result of TVTNodeMemoryManager getting 16K blocks
  // of memory from the Delphi memory manager and then managing them in a highly efficient manner.
  // A consequence is that node memory allocations/deallocations are not visible to memory debugging tools.
  //
  // The local memory manager is disabled by default - to enable it {$define UseLocalMemoryManager}. For smaller trees,
  // say less than 10,000 nodes, there is really no major performance benefit in using the local memory manager.
{    TRecMemoryManager = class
    private
      FAllocSize: Cardinal;       // The memory allocated for each node
      FBlockList: TList;          // List of allocated blocks
      FBytesAvailable: Cardinal;  // Bytes available in current block
      FNext: PRec;        // Pointer to next available node in current block
      FFreeSpace: PRec;   // Pointer to free space chain
    public
      constructor Create;
      destructor Destroy; override;

      function AllocNode(const Size: Cardinal): PRec;
      procedure FreeNode(const Node: PRec);
      procedure Clear;
    end;   }

const PreDefinedTreeStructureCount: Integer = 6;

implementation

const TreeStructureVersion: Word = 5;

procedure SetPCharString(var p: PChar; const newValue: String);
begin
	if Assigned(p) then
  	StrDispose(p);

  if (Length(newValue) = 0) then
  	p := nil
  else
  	p := StrNew(PChar(newValue))
end;

procedure FreeTreeStructureNode(pNode: PTreeStructureNode);
begin
	if assigned(pNode.Child) then
  	FreeTreeStructureNode(pNode.Child);
  if assigned(pNode.NextSibling) then
  	FreeTreeStructureNode(pNode.NextSibling);
  Dispose(pNode)
end;

Procedure FreeTreeStructure(p: PTreeStructure);
begin
	if assigned(p) then
  begin
		if assigned(p.Head) then
	  	FreeTreeStructureNode(p.Head);
	  Dispose(p)
  end
end;

Procedure ChangeTreeStructureContent(p: PTreeStructure; FromContent, ToContent: TTreeStructureContents);
procedure ChangeTreeStructureContentNode(pNode: PTreeStructureNode);
begin
  if pNode.Content = FromContent then
  	pNode.Content := ToContent;
	if assigned(pNode.Child) then
  	ChangeTreeStructureContentNode(pNode.Child);
  if assigned(pNode.NextSibling) then
  	ChangeTreeStructureContentNode(pNode.NextSibling);
end;
begin
	if assigned(p) and assigned(p.Head) then
  	ChangeTreeStructureContentNode(p.Head)
end;

function NewTreeStructureNode: PTreeStructureNode;
begin
	new(result);
  FillChar(result^, SizeOf(result^), 0);
  result.MinCount := 5;
  result.SortColumnField := -1
end;

function NewTreeStructureNode(Content: TTreeStructureContents; IncludeCompilation: Boolean): PTreeStructureNode;
begin
	result := NewTreeStructureNode;
  result.Content := Content;
  result.MinCount := 5;
  result.IncludeCompilation := IncludeCompilation
end;

Procedure SaveTreeStructure(p: PTreeStructure; Stream: TStream);
Procedure WriteNode(node: PTreeStructureNode);
var
	flags: Byte;
begin
	flags := 0;
  if assigned(node.Child) then
  	flags := flags or $1;

  if assigned(node.NextSibling) then
  	flags := flags or $2;

  if node.IncludeCompilation then
  	flags := flags or $4;

  Stream.Write(node.Content, SizeOf(node.Content));
  if node.Content = tscCustomField then
  	Stream.Write(node.CustomFieldIndex, SizeOf(node.CustomFieldIndex));

  Stream.Write(node.SortColumnField, SizeOf(node.SortColumnField));
  Stream.Write(node.MinCount, SizeOf(node.MinCount));

  Stream.Write(flags, SizeOf(flags));

  if assigned(node.Child) then
  	WriteNode(node.Child);

  if assigned(node.NextSibling) then
  	WriteNode(node.NextSibling)
end;
var
	TextSize: Word;
  hasHead: Boolean;
begin
	Stream.Write(TreeStructureVersion, SizeOf(TreeStructureVersion));
  Stream.Write(p.index, SizeOf(p.Index));

  Stream.Write(p.PreDefinedIndex, SizeOf(p.PreDefinedIndex));

  TextSize := length(p.Text);
  Stream.Write(TextSize, SizeOf(TextSize));
  if TextSize > 0 then
  	Stream.Write(p.Text[1], TextSize);

  hasHead := Assigned(p.Head);
  Stream.Write(hasHead, SizeOf(hasHead));
  if hasHead then
	  WriteNode(p.Head);
end;

Function LoadTreeStructure(Stream: TStream): PTreeStructure;
Function LoadNode(Version :Word): PTreeStructureNode;
var
	flags: Byte;
begin
	result := NewTreeStructureNode;
  Stream.Read(result.Content, SizeOf(result.Content));
  if result.Content = tscCustomField then
  	Stream.Read(result.CustomFieldIndex, SizeOf(result.CustomFieldIndex));

  if Version > 3 then
  	Stream.Read(result.SortColumnField, SizeOf(result.SortColumnField))
  else
  	result.SortColumnField := -1; // -1 = don't change

  if Version > 4 then
	  Stream.Read(result.MinCount, SizeOf(result.MinCount))
  else
  	result.MinCount := 1;

  Stream.Read(flags, SizeOf(flags));
  result.IncludeCompilation := flags and $4 > 0;
  if flags and $1 > 0 then
  	result.Child := LoadNode(version);
  if flags and $2 > 0 then
  	result.NextSibling := LoadNode(version);

  //Fix til gammel fejl (denne kan fjernes efter nogen tid)
  if result.MinCount = 0 then result.MinCount := 1;
end;
var
	TextSize, Version: Word;
  hasHead: Boolean;
begin
  new(result);
  FillChar(result^, SizeOf(result^), 0);
	Stream.Read(Version, SizeOf(Version));
  Stream.Read(result.index, SizeOf(result.Index));
  if Version >= 2 then
  begin
  	Stream.Read(result.PreDefinedIndex, SizeOf(result.PreDefinedIndex));
  end;
  Stream.Read(TextSize, SizeOf(TextSize));
  if TextSize > 0 then
  begin
  	SetLength(result.Text, TextSize);
    Stream.Read(result.Text[1], TextSize)
  end;
  Stream.Read(hasHead, SizeOf(hasHead));
  if hasHead then
		result.Head := LoadNode(version)
end;

procedure TSortPartList.SortPart(Compare: TListSortCompare; FirstIndex, LastIndex: Integer);
procedure QuickSort(L, R: Integer);
var
  I, J: Integer;
  P, T: Pointer;
begin
  repeat
    I := L;
    J := R;
    P := List^[(L + R) shr 1];
    repeat
      while Compare(List^[I], P) < 0 do
        Inc(I);
      while Compare(List^[J], P) > 0 do
        Dec(J);
      if I <= J then
      begin
        T := List^[I];
        List^[I] := List^[J];
        List^[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J);
    L := I;
  until I >= R;
end;
begin
  if LastIndex - FirstIndex > 0 then
		QuickSort(FirstIndex, LastIndex)
end;

procedure TSortPartList.SortPart(Compare: TListSortCompareData; FirstIndex, LastIndex, Data: Integer);
procedure QuickSortData(SortList: PPointerList; L, R: Integer; SCompare: TListSortCompareData; Data: Integer);
var
  I, J: Integer;
  P, T: Pointer;
begin
  repeat
    I := L;
    J := R;
    P := SortList^[(L + R) shr 1];
    repeat
      while SCompare(SortList^[I], P, Data) < 0 do
        Inc(I);
      while SCompare(SortList^[J], P, Data) > 0 do
        Dec(J);
      if I <= J then
      begin
        T := SortList^[I];
        SortList^[I] := SortList^[J];
        SortList^[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSortData(SortList, L, J, SCompare, Data);
    L := I;
  until I >= R;
end;
begin
	if LastIndex - FirstIndex > 0 then
		QuickSortData(List, FirstIndex, LastIndex, Compare, Data)
end;

//------------ TRecMemoryManager-----------------
{  const
    NodeMemoryGuard: PRec = PRec($FEEFEFFE);

  constructor TRecMemoryManager.Create;

  begin
    FBlockList := TList.Create;
  end;

  //----------------------------------------------------------------------------------------------------------------------

  destructor TRecMemoryManager.Destroy;

  begin
    Clear;
    FBlockList.Free;
  end;

  //----------------------------------------------------------------------------------------------------------------------

  function TRecMemoryManager.AllocNode(const Size: Cardinal): PRec;

  // Allocates memory for a node using the local memory manager.

  const
    BlockSize = (16 * 1024);   // Blocks larger than 16K offer no significant performance improvement.

  begin
    if FAllocSize = 0 then
      // Recalculate allocation size first time after a clear.
      FAllocSize := (Size + 3) and not 3   // Force alignment on 32-bit boundaries.
    else
      // Allocation size cannot be increased unless Memory Manager is explicitly cleared.
      Assert(Size <= FAllocSize, 'Node memory manager allocation size cannot be increased.');

    if Assigned(FFreeSpace) then
    begin
      // Assign node from free-space chain.
      Assert(FFreeSpace.NextSibling = NodeMemoryGuard, 'Memory overwrite in node memory manager free space chain.');
      Result := FFreeSpace;                // Assign node
      FFreeSpace := Result.PrevSibling;    // Point to prev node in free-space chain
    end
    else
    begin
      if FBytesAvailable < FAllocSize then
      begin
        // Get another block from the Delphi memory manager.
        GetMem(FNext, BlockSize);
        FBytesAvailable := BlockSize;
        FBlockList.Add(FNext);
      end;
      // Assign node from current block.
      Result := FNext;
      Inc(PChar(FNext), FAllocSize);
      Dec(FBytesAvailable, FAllocSize);
    end;

    // Clear the memory.
    FillChar(Result^, FAllocSize, 0);
  end;

  //----------------------------------------------------------------------------------------------------------------------

  procedure TRecMemoryManager.Clear;

  // Releases all memory held by the local memory manager.

  var
    I: Integer;

  begin
    for I := 0 to FBlockList.Count - 1 do
      FreeMem(FBlockList[I]);
    FBlockList.Clear;
    FFreeSpace := nil;
    FBytesAvailable := 0;
    FAllocSize := 0;
  end;

  //----------------------------------------------------------------------------------------------------------------------

  procedure TRecMemoryManager.FreeNode(const Node: PRec);

  // Frees node memory that was allocated using the local memory manager.

  begin
    Node.PrevSibling := FFreeSpace;         // Point to previous free node.
    Node.NextSibling := NodeMemoryGuard;    // Memory guard to detect overwrites.
    FFreeSpace := Node;                     // Point Free chain pointer to me.
  end;       }
end.


