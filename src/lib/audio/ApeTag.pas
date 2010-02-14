{ *************************************************************************** }
{                                                                             }
{ Audio Tools Library (Freeware)                                              }
{ Class TAPEtag - for manipulating with APE tags                              }
{                                                                             }
{ Copyright (c) 2001,2002 by Jurgen Faul                                      }
{ E-mail: jfaul@gmx.de                                                        }
{ http://jfaul.de/atl                                                         }
{                                                                             }
{ Version 1.0 (21 April 2002)                                                 }
{   - Reading & writing support for APE 1.0 tags                              }
{   - Reading support for APE 2.0 tags (UTF-8 decoding)                       }
{   - Tag info: title, artist, album, track, year, genre, comment, copyright  }
{                                                                             }
{ *************************************************************************** }

unit APEtag;

interface

uses
	Classes, SysUtils, QStrings, uniCode;

type
  { Class TAPEtag }
  TAPEtag = class(TObject)
    private
      { Private declarations }
      FExists: Boolean;
      FVersion: Integer;
			FSize: Integer;
			FTitle: WideString;
			FArtist: WideString;
			FAlbum: WideString;
      FTrack: String;
			FYear: WideString;
			FGenre: WideString;
			FComment: WideString;
			FCopyright: WideString;
			FLyrics: WideString;
			FAddList: TList;
			procedure FSetTitle(const NewTitle: WideString);
			procedure FSetArtist(const NewArtist: WideString);
			procedure FSetAlbum(const NewAlbum: WideString);
      procedure FSetTrack(const NewTrack: String);
			procedure FSetYear(const NewYear: WideString);
			procedure FSetGenre(const NewGenre: WideString);
			procedure FSetComment(const NewComment: WideString);
			procedure FSetCopyright(const NewCopyright: WideString);

			function doRemoveFromStream(const FStr: TStream; var TStr: TStream; ApplyDatashift: Boolean): Boolean;  { Delete tag }
    public
      { Public declarations }
			constructor Create;                                     { Create object }
			destructor Destroy;
      procedure ResetData;                                   { Reset all data }
			function ReadFromFile(const FileName: string): Boolean;      { Load tag }
			function ReadFromStream(const Fstr: TStream): Boolean;      { Load tag }
			function RemoveFromFile(const FileName: String): Boolean;  { Delete tag }
			function RemoveFromStream(const FStr: TStream): Boolean;  { Delete tag }
			function SaveToFile(const FileName: string; Version: Integer): Boolean;        { Save tag }
			function SaveToStream(const FStr: TStream; Version: Integer): Boolean;
      function GetKeyIndex(const key: String): integer;
			function GetAddListKeyName(FStr: TStream; var value: String):String;  overload;
      function GetAddListKeyName(index: Integer; var value: String):String; overload;
			procedure AddKeyToAddList(key: String; value: String);
      procedure SetAddListValue(index: integer; value: String);
      Procedure DeleteFromAddlist(index: integer);
			property Exists: Boolean read FExists;              { True if tag found }
      property Version: Integer read FVersion;                  { Tag version }
      property Size: Integer read FSize;                     { Total tag size }
			property Title: WideString read FTitle write FSetTitle;        { Song title }
			property Artist: WideString read FArtist write FSetArtist;    { Artist name }
			property Album: WideString read FAlbum write FSetAlbum;       { Album title }
      property Track: String read FTrack write FSetTrack;        { Track number }
			property Year: WideString read FYear write FSetYear;         { Release year }
			property Genre: WideString read FGenre write FSetGenre;        { Genre name }
			property Comment: WideString read FComment write FSetComment;     { Comment }
			property Copyright: WideString read FCopyright write FSetCopyright;   { (c) }
			property Lyrics: WideString read FLyrics write FLyrics;   { (c) }
			property AddList: TList read FAddList;
  end;

implementation

const
  { Tag ID }
	ID3V1_ID = 'TAG';                                                   { ID3v1 }
	APE_ID = 'APETAGEX';                                                  { APE }

  { Size constants }
  ID3V1_TAG_SIZE = 128;                                           { ID3v1 tag }
	APE_TAG_FOOTER_SIZE = 32;                                  { APE tag footer }
	APE_TAG_HEADER_SIZE = 32;                                  { APE tag header }

  { First version of APE tag }
	APE_VERSION_1_0 = 1000;
	APE_VERSION_2_0 = 2000;

  { Max. number of supported tag fields }
	APE_FIELD_COUNT = 9;

  { Names of supported tag fields }
	APE_FIELD: array [1..APE_FIELD_COUNT] of string =
		('Title', 'Artist', 'Album', 'Track', 'Year', 'Genre',
		 'Comment', 'Copyright', 'Lyrics');

type
  { APE tag data - for internal use }
	TagInfo = record
    { Real structure of APE footer }
    ID: array [1..8] of Char;                             { Always "APETAGEX" }
    Version: Integer;                                           { Tag version }
    Size: Integer;                                { Tag size including footer }
    Fields: Integer;                                       { Number of fields }
    Flags: Integer;                                               { Tag flags }
    Reserved: array [1..8] of Char;                  { Reserved for later use }
    { Extended data }
    DataShift: Byte;                                { Used if ID3v1 tag found }
    FileSize: Integer;                                    { File size (bytes) }
		Field: array [1..APE_FIELD_COUNT] of WideString;    { Information from fields }
  end;

{ ********************* Auxiliary functions & procedures ******************** }

procedure ClearAddList(AddList: TList);
var
	i: Integer;
begin
	for i:=0 to AddList.count-1 do
		TStream(AddList.Items[i]).free
end;

function ReadFooter(const FStr: TStream; var Tag: TagInfo): Boolean;
var
  TagID: array [1..3] of Char;
  Transferred: Integer;
begin
	{ Load footer from file to variable }
  try
    Result := true;
		{ Set read-access and open file }
		Tag.FileSize := FStr.Size;
		{ Check for existing ID3v1 tag }
		Fstr.Position := Tag.FileSize - ID3V1_TAG_SIZE;
		FStr.Read(TagID, SizeOf(TagID));
		if TagID = ID3V1_ID then Tag.DataShift := ID3V1_TAG_SIZE;
		{ Read footer data }
		FStr.Position := Tag.FileSize - (Tag.DataShift + APE_TAG_FOOTER_SIZE);
		Transferred := FStr.Read(Tag, APE_TAG_FOOTER_SIZE);
		{ if transfer is not complete }
		if Transferred < APE_TAG_FOOTER_SIZE then Result := false;
  except
    { Error }
    Result := false;
  end;
end;

{ --------------------------------------------------------------------------- }

{function ConvertFromUTF8(const Source: string): string;
var
	Iterator, SourceLength, FChar, NChar: Integer;
begin
	{ Convert UTF-8 string to ANSI string }
{  Result := '';
  Iterator := 0;
  SourceLength := Length(Source);
  while Iterator < SourceLength do
  begin
    Inc(Iterator);
    FChar := Ord(Source[Iterator]);
    if FChar >= $80 then
		begin
      Inc(Iterator);
			if Iterator > SourceLength then break;
      FChar := FChar and $3F;
      if (FChar and $20) <> 0 then
      begin
        FChar := FChar and $1F;
        NChar := Ord(Source[Iterator]);
        if (NChar and $C0) <> $80 then  break;
        FChar := (FChar shl 6) or (NChar and $3F);
        Inc(Iterator);
        if Iterator > SourceLength then break;
      end;
      NChar := Ord(Source[Iterator]);
      if (NChar and $C0) <> $80 then break;
      Result := Result + WideChar((FChar shl 6) or (NChar and $3F));
    end
    else
      Result := Result + WideChar(FChar);
  end;
end;      }

{ --------------------------------------------------------------------------- }

function SetTagItem(const FieldName: String; FieldValue: ansiString; var Tag: TagInfo):boolean;
var
  Iterator: Byte;
begin
	result := false;
	{ Set tag item if supported field found }
	for Iterator := 1 to APE_FIELD_COUNT do
		if UpperCase(FieldName) = UpperCase(APE_FIELD[Iterator]) then
		begin
			result := true;
			if Tag.Version > APE_VERSION_1_0 then
				Tag.Field[Iterator] := UTF8ToWideString(FieldValue)
			else
				Tag.Field[Iterator] := FieldValue
		end
end;

{ --------------------------------------------------------------------------- }

{function ReadStringFromStream(FStr: TStream; len:integer):String;
var
	arr: array[0..255] of Char;
	Transferred: Integer;
begin
	Result := '';

	while len > 0 do
	begin
		if len > SizeOf(arr) then
			Transferred := FStr.Read(arr, SizeOf(arr))
		else
			Transferred := FStr.Read(arr, len);
		dec(len, Transferred);
		Result := Result + copy(arr, 1, Transferred)
	end;
end;    }

procedure ReadFields(FStr: TStream; var Tag: TagInfo; AddList: TList);
var
	i, ItemSize, FieldFlags: Integer;
	c: Char;
	FieldName: String;
	FieldValue: AnsiString;
	MStr : TStream;
begin
	try
    ClearAddList(AddList);
		FStr.Position := Tag.FileSize - Tag.DataShift - Tag.Size;
		for i:=1 to tag.Fields do
		begin
			FStr.Read(ItemSize, 4);
			FStr.Read(FieldFlags, 4);
			FieldName := '';
			repeat
				FStr.Read(c, 1);
				if c = #0 then            //#0 er terminator for fieldName
					break
				else FieldName := FieldName + c
			until false;
			SetLength(FieldValue, ItemSize);
			if ItemSize > 0 then
				FStr.ReadBuffer(FieldValue[1], ItemSize);
			if not SetTagItem(FieldName, FieldValue, Tag) and assigned(AddList) then
			begin
				MStr := TMemoryStream.Create;
				MStr.Write(ItemSize, 4);
				MStr.Write(FieldFlags, 4);
				c := #0;
				MStr.Write(FieldName[1], Length(FieldName));
				MStr.Write(c, 1);
				MStr.Write(FieldValue[1], ItemSize);
				AddList.Add(Mstr)
			end
		end
		except
		end
end;

{procedure ReadFields(const FileName: string; var Tag: TagInfo);
var
  SourceFile: file;
  FieldName: string;
  FieldValue: array [1..250] of Char;
	NextChar: Char;
	Iterator, ValueSize, ValuePosition, FieldFlags: Integer;
begin
  try
    { Set read-access, open file }
	 { AssignFile(SourceFile, FileName);
    FileMode := 0;
    Reset(SourceFile, 1);
		Seek(SourceFile, Tag.FileSize - Tag.DataShift - Tag.Size);
		{ Read all stored fields }
	{  for Iterator := 1 to Tag.Fields do
    begin
      FillChar(FieldValue, SizeOf(FieldValue), 0);
      BlockRead(SourceFile, ValueSize, SizeOf(ValueSize));
      BlockRead(SourceFile, FieldFlags, SizeOf(FieldFlags));
      FieldName := '';
      repeat
        BlockRead(SourceFile, NextChar, SizeOf(NextChar));
        FieldName := FieldName + NextChar;
      until Ord(NextChar) = 0;
      ValuePosition := FilePos(SourceFile);
			BlockRead(SourceFile, FieldValue, ValueSize mod SizeOf(FieldValue));
			SetTagItem(Trim(FieldName), Trim(FieldValue), Tag);
      Seek(SourceFile, ValuePosition + ValueSize);
    end;
    CloseFile(SourceFile);
	except
  end;
end;}

{ --------------------------------------------------------------------------- }

function GetTrack(TrackString: string): Byte;
var
  Index, Value, Code: Integer;
begin
	// Get track from string
	TrackString := Trim(TrackString);
	if (length(TrackString)>2) and (TrackString[1] = '(') and (TrackString[length(TrackString)] = ')') then
		TrackString := copy(TrackString, 2, length(TrackString)-2);
	Index := Pos('/', TrackString);
  if Index = 0 then Val(TrackString, Value, Code)
  else Val(Copy(TrackString, 1, Index - 1), Value, Code);
	if Code = 0 then Result := Value
  else Result := 0;
end;

{ --------------------------------------------------------------------------- }

{function TruncateFile(const FileName: string; TagSize: Integer): Boolean;
var
	SourceFile: file;
begin
	try
    Result := true;
		{ Allow write-access and open file }
{		FileSetAttr(FileName, 0);
    AssignFile(SourceFile, FileName);
    FileMode := 2;
    Reset(SourceFile, 1);
		{ Delete tag }
 {   Seek(SourceFile, FileSize(SourceFile) - TagSize);
    Truncate(SourceFile);
		CloseFile(SourceFile);
  except
		{ Error }
 {		Result := false;
	end;
end;    }

{ --------------------------------------------------------------------------- }

procedure BuildFooter(var Tag: TagInfo);
var
	Iterator: Integer;
begin
  { Build tag footer }
	Tag.ID := APE_ID;
	Tag.Version := APE_VERSION_1_0;
	Tag.Size := APE_TAG_FOOTER_SIZE;
	for Iterator := 1 to APE_FIELD_COUNT do
		if Tag.Field[Iterator] <> '' then
    begin
			Inc(Tag.Size, Length(APE_FIELD[Iterator] + Tag.Field[Iterator]) + 10);
			Inc(Tag.Fields);
		end;
end;

{ --------------------------------------------------------------------------- }

function AddToFile(const FileData: TStream; TagData: TStream): Boolean;
begin
  try
		{ Add tag data to file }
    FileData.Seek(0, soFromEnd);
    TagData.Seek(0, soFromBeginning);
		FileData.CopyFrom(TagData, TagData.Size);
		Result := true;
  except
    { Error }
    Result := false;
  end;
end;

{ --------------------------------------------------------------------------- }

function SaveTag(const FStr: TStream; Tag: TagInfo; AddList: TList; version: integer): Boolean;
var
	TagData: TStream;
	Iterator, ValueSize, Flags, i: Integer;
	s: ansiString;
	b: Byte;
begin
	{ Build and write tag fields and footer to stream }
	TagData := TMemoryStream.Create;
	if Version = APE_VERSION_2_0 then
	begin
		//skriver v2 header
		TagData.Write(APE_ID[1], Length(APE_ID));
		i := APE_VERSION_2_0;
		TagData.Write(i, SizeOf(i));
		i := 0;
		TagData.Write(i, SizeOf(i)); //tag sizen, skrives først til sidst
		TagData.Write(i, SizeOf(i)); //tag item count, skrives først til sidst
		i := $A0000000; //flag: contains header and footer, this is the header - the rest is 0
		TagData.Write(i, SizeOf(i));
		i := 0;
		TagData.Write(i, SizeOf(i)); //64 bit reserved
		TagData.Write(i, SizeOf(i)); //64 bit reserved
	end;

	Tag.Size := APE_TAG_FOOTER_SIZE;
	Tag.Fields :=  0;

	b := 0;
	for Iterator := 1 to APE_FIELD_COUNT do
	begin
		if Version = APE_VERSION_2_0 then //UTF-8 strings are not zero terminated !
			s := WideStringToUTF8(Tag.Field[Iterator])
		else s := Tag.Field[Iterator];
		if length(s) > 0 then
		begin
      if Version = APE_VERSION_2_0 then
				ValueSize := Length(s)
      else
      	ValueSize := Length(s)+1;
			Flags := 0;
			TagData.Write(ValueSize, SizeOf(ValueSize));
			TagData.Write(Flags, SizeOf(Flags));
			TagData.Write(APE_FIELD[Iterator][1], Length(APE_FIELD[Iterator]));
			TagData.Write(b, 1);
			TagData.Write(s[1], length(s));
      if Version = APE_VERSION_2_0 then
        Inc(Tag.Size, Length(APE_FIELD[Iterator] + s) + 9)
      else
      begin
        TagData.Write(b, 1);
        Inc(Tag.Size, Length(APE_FIELD[Iterator] + s) + 10)
      end;
			Inc(Tag.Fields)
		end
	end;
	for i:=0 to AddList.Count-1 do
	begin
		TStream(AddList.Items[i]).Position := 0;
		TagData.CopyFrom(TStream(AddList.Items[i]), TStream(AddList.Items[i]).Size);
		Inc(Tag.Size, TStream(AddList.Items[i]).Size);
		Inc(Tag.Fields)
	end;

	if Version = APE_VERSION_2_0 then
	begin
		//skriver headeren færdig
		TagData.Position := 12;
		TagData.Write(Tag.Size, SizeOf(Tag.Size)); //tag sizen, skrives først til sidst
		TagData.Write(Tag.Fields, SizeOf(Tag.Fields)); //tag item count, skrives først til sidst
	end;

	//skriver v1/v2 footer
	TagData.Position := TagData.Size;
	TagData.Write(APE_ID[1], Length(APE_ID));
	i := Version;
	TagData.Write(i, SizeOf(i));
	TagData.Write(Tag.Size, SizeOf(Tag.Size)); //tag sizen, skrives først til sidst
	TagData.Write(Tag.Fields, SizeOf(Tag.Fields)); //tag item count, skrives først til sidst
	if Version = APE_VERSION_2_0 then
		i := $80000000 //flag: contains header and footer, this is the footer - the rest is 0
	else i := 0; //flag: contains only footer, this is the footer
	TagData.Write(i, SizeOf(i));
	i := 0;
	TagData.Write(i, SizeOf(i)); //64 bit reserved
	TagData.Write(i, SizeOf(i)); //64 bit reserved

	{ Add created tag to file }
	Result := AddToFile(FStr, TagData);
	TagData.Free;
end;

{ ********************** Private functions & procedures ********************* }

procedure TAPEtag.FSetTitle(const NewTitle: WideString);
begin
  { Set song title }
  FTitle := Trim(NewTitle);
end;

{ --------------------------------------------------------------------------- }

procedure TAPEtag.FSetArtist(const NewArtist: WideString);
begin
  { Set artist name }
	FArtist := Trim(NewArtist);
end;

{ --------------------------------------------------------------------------- }

procedure TAPEtag.FSetAlbum(const NewAlbum: WideString);
begin
  { Set album title }
  FAlbum := Trim(NewAlbum);
end;

{ --------------------------------------------------------------------------- }

procedure TAPEtag.FSetTrack(const NewTrack: String);
begin
  { Set track number }
	FTrack := NewTrack;
end;

{ --------------------------------------------------------------------------- }

procedure TAPEtag.FSetYear(const NewYear: WideString);
begin
  { Set release year }
  FYear := Trim(NewYear);
end;

{ --------------------------------------------------------------------------- }

procedure TAPEtag.FSetGenre(const NewGenre: WideString);
begin
  { Set genre name }
  FGenre := Trim(NewGenre);
end;

{ --------------------------------------------------------------------------- }

procedure TAPEtag.FSetComment(const NewComment: WideString);
begin
  { Set comment }
  FComment := Trim(NewComment);
end;

{ --------------------------------------------------------------------------- }

procedure TAPEtag.FSetCopyright(const NewCopyright: WideString);
begin
  { Set copyright information }
  FCopyright := Trim(NewCopyright);
end;

{ ********************** Public functions & procedures ********************** }

constructor TAPEtag.Create;
begin
	{ Create object }
	inherited;
	FAddList := TList.Create;
	ResetData
end;

destructor TAPEtag.Destroy;
begin
	ClearAddList(FAddList);
	FAddList.free;
	inherited
end;
{ --------------------------------------------------------------------------- }

function TAPEtag.GetKeyIndex(const key: String): integer;
var
	i: Integer;
  Str: TStream;
  s: String;
  c: Char;
begin
	result := -1;

  for i:=0 to FAddList.Count-1 do
  begin
  	Str := TStream(FAddList.Items[i]);
    Str.Position := 8;
    s := '';
    repeat
			Str.Read(c, 1);
			if c = #0 then            //#0 er terminator for fieldName
				break
			else s := s + c
		until false;

    if Q_SameText(key, s) then
    begin
    	result := i;
      break;
    end;
  end;
end;

function TAPEtag.GetAddListKeyName(index: Integer; var value: String):String;
begin
	result := GetAddListKeyName(TStream(FAddList.Items[index]), value);
end;

function TAPEtag.GetAddListKeyName(FStr: TStream; var value: String):String;
var
	ItemSize, FieldFlags: Integer;
	c: Char;
begin
	FStr.Position := 0;
	FStr.Read(ItemSize, 4);
	FStr.Read(FieldFlags, 4);
	Result := '';
	repeat
		FStr.Read(c, 1);
		if c = #0 then            //#0 er terminator for fieldName
			break
		else Result := Result + c
	until false;
	SetLength(value, ItemSize);
	FStr.ReadBuffer(Pointer(value)^, ItemSize);
	value := trim(value)
end;

procedure TAPEtag.AddKeyToAddList(key: String; value: String);
var
	MStr: TStream;
	i: Integer;
begin
	MStr := TMemoryStream.Create;
	value := WideStringToUTF8(value);
	i := length(value)+1;
	MStr.WriteBuffer(i, SizeOf(i));
	i := 0;
	MStr.WriteBuffer(i, SizeOf(i));
	key := key + #0 + value + #0;
	Mstr.WriteBuffer(key[1], length(key));
	FAddList.Add(MStr)
end;

procedure TAPEtag.SetAddListValue(index: integer; value: String);
var
	MStr: TStream;
  key, dummy: String;
	i: Integer;
begin
	mStr := TStream(FAddlist.Items[index]);
  key := GetAddListKeyName(mStr, dummy);
  mStr.Size := 0;
  value := WideStringToUTF8(value);
	i := length(value)+1;
	MStr.WriteBuffer(i, SizeOf(i));
	i := 0;
	MStr.WriteBuffer(i, SizeOf(i));
	key := key + #0 + value + #0;
	Mstr.WriteBuffer(key[1], length(key))
end;

Procedure TAPEtag.DeleteFromAddlist(index: integer);
begin
	TStream(FAddlist.items[index]).Free;
  FAddlist.Delete(index);
end;

procedure TAPEtag.ResetData;
begin
  { Reset all variables }
	FExists := false;
  FVersion := 0;
  FSize := 0;
  FTitle := '';
  FArtist := '';
  FAlbum := '';
  FTrack := '';
  FYear := '';
  FGenre := '';
  FComment := '';
	FCopyright := '';
	FLyrics := '';
	ClearAddList(FAddList)
end;

{ --------------------------------------------------------------------------- }

function TAPEtag.ReadFromFile(const FileName: string): Boolean;
var
	FStr : TStream;
begin
	{ Reset data and load footer from file to variable }
	try
		FStr := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
		Result := ReadFromStream(FStr);
		{ Process data if loaded and footer valid }
		FStr.free
	except
	result := false
	end
end;

function TAPEtag.ReadFromStream(const Fstr: TStream): Boolean;      { Load tag }
var
	Tag: TagInfo;
begin
	{ Reset data and load footer from file to variable }
	result := false;
	ResetData;
	FillChar(Tag, SizeOf(Tag), 0);
	try
		Result := ReadFooter(FStr, Tag);
		{ Process data if loaded and footer valid }
		if (Result) and (Tag.ID = APE_ID) then
		begin
			FExists := true;
			{ Fill properties with footer data }
			FVersion := Tag.Version;
			FSize := Tag.Size;
			{ Get information from fields }
			ReadFields(FStr, Tag, FAddList);
			FTitle := Tag.Field[1];
			FArtist := Tag.Field[2];
			FAlbum := Tag.Field[3];
			FTrack := Tag.Field[4];
			FYear := Tag.Field[5];
			FGenre := Tag.Field[6];
			FComment := Tag.Field[7];
			FCopyright := Tag.Field[8];
			FLyrics := Tag.Field[9]
		end
	except
	result := false
	end
end;

{ --------------------------------------------------------------------------- }

function TAPEtag.RemoveFromStream(const FStr: TStream): Boolean;  { Delete tag }
var
	TStr: TStream;
begin
	TStr := nil;
	result := doRemoveFromStream(FStr, TStr, true);
	if assigned(TStr) then
		TStr.free
end;

function TAPEtag.doRemoveFromStream(const FStr: TStream; var TStr: TStream; ApplyDatashift: Boolean): Boolean;  { Delete tag }
var
	Tag: TagInfo;
begin
	result := true;
	try
		{ Remove tag from file if found }
		FillChar(Tag, SizeOf(Tag), 0);
		if ReadFooter(FStr, Tag) then
		begin
			if Tag.ID <> APE_ID then Tag.Size := 0;
			if (Tag.Flags shr 31) > 0 then Inc(Tag.Size, APE_TAG_HEADER_SIZE);
			if Tag.DataShift > 0 then
			begin
				TStr := TMemoryStream.Create;
				FStr.Position := FStr.Size - Tag.Datashift;
				TStr.CopyFrom(FStr,Tag.DataShift);
				TStr.Position := 0
			end else TStr := nil;
			FStr.Size := Fstr.Size - Tag.DataShift - Tag.Size;
			if ApplyDataShift and assigned(TStr) then
			begin
				FStr.Position := FStr.Size;
				FStr.CopyFrom(TStr, TStr.Size)
			end
		end
	except
		Result := false;
	end
end;


function TAPEtag.RemoveFromFile(const FileName: String): Boolean;
var
	FStr: TStream;
begin
	try
		FStr := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyWrite);
		result := RemoveFromStream(FStr);
		FStr.free
	except
	result := false
	end
end;

{ --------------------------------------------------------------------------- }

function TAPEtag.SaveToFile(const FileName: string; Version: Integer): Boolean;
var
	FStr: TStream;
begin
	try
		FStr := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyWrite);
		result := SaveToStream(FStr, Version);
		FStr.free
	except
	result := false
	end
end;

function TAPEtag.SaveToStream(const FStr: TStream; Version: Integer): Boolean;
var
	Tag: TagInfo;
	TStr: TStream;
begin
  { Prepare tag data and save to file }
	FillChar(Tag, SizeOf(Tag), 0);
	Tag.Field[1] := FTitle;
  Tag.Field[2] := FArtist;
	Tag.Field[3] := FAlbum;
  Tag.Field[4] := FTrack;
	Tag.Field[5] := FYear;
  Tag.Field[6] := FGenre;
	Tag.Field[7] := FComment;
	Tag.Field[8] := FCopyright;
	Tag.Field[9] := FLyrics;
	{ Delete old tag if exists and write new tag }
	TStr := nil;
	if doRemoveFromStream(FStr, TStr, false) then
	begin
		result := SaveTag(Fstr, Tag, FAddList, Version);
		if assigned(TStr) then
		begin
			FStr.Position := FStr.Size;
			FStr.CopyFrom(TStr, TStr.Size);
			TStr.Free
		end
	end
	else
		Result := false
end;

end.

