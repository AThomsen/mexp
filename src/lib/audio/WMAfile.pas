{ *************************************************************************** }
{                                                                             }
{ Audio Tools Library (Freeware)                                              }
{ Class TWMAfile - for extracting information from WMA file header            }
{                                                                             }
{ Copyright (c) 2001,2002 by Jurgen Faul                                      }
{ E-mail: jfaul@gmx.de                                                        }
{ http://jfaul.de/atl                                                         }
{                                                                             }
{ Version 1.0 (29 April 2002)                                                 }
{   - File info: file size, channel mode, sample rate, duration, bit rate     }
{   - WMA tag info: title, artist, album, track, year, genre, comment         }
{                                                                             }
{ *************************************************************************** }

unit WMAfile;

interface

uses
	Classes, SysUtils, StreamCopier, QStrings, JclUnicode, JclWideStrings;

const
  { Channel modes }
	WMA_CM_UNKNOWN = 0;                                               { Unknown }
  WMA_CM_MONO = 1;                                                     { Mono }
  WMA_CM_STEREO = 2;                                                 { Stereo }

  { Channel mode names }
  WMA_MODE: array [0..2] of string = ('Unknown', 'Mono', 'Stereo');

type
	{ Class TWMAfile }
	TWMAfile = class(TObject)
    private
      { Private declarations }
      FValid: Boolean;
      FFileSize: Integer;
      FChannelModeID: Byte;
      FSampleRate: Integer;
      FDuration: Double;
      FBitRate: Integer;
			FTitle: WideString;
			FArtist: WideString;
      FAlbum: WideString;
			FTrack: Integer;
			FYear: WideString;
			FGenre: WideString;
			FComment: WideString;
			FPromotionURL: WideString;
			FRating: WideString;
			FCopyright: WideString;
			FAlbumCoverURL: WideString;
			FLyrics: WideString;
			FAddList : TList;
			procedure FResetData;
			function FGetChannelMode: string;
			procedure ClearAddlist;
		public
			{ Public declarations }
			constructor Create;                                     { Create object }
			destructor Destroy;
			function ReadFromFile(const FileName: string): Boolean;     { Load data }
			function ReadFromStream(const FStr: TStream): Boolean;
			function WriteToFile(const FileName: String): Boolean;
			function WriteToStream(const FStr: TStream; Removetag: Boolean = false): Boolean;
			function GetAddListKeyName(FStr: TStream; var value: WideString):WideString; overload;
      function GetAddListKeyName(index: integer; var value: WideString):WideString; overload;
      function GetKeyIndex(const key: WideString): integer;
      procedure DeleteFromAddlist(index:integer);
			procedure AddKeyToAddList(key: WideString; value: WideString);
      procedure SetAddListValue(index: integer; value: WideString);
			property Valid: Boolean read FValid;               { True if valid data }
      property FileSize: Integer read FFileSize;          { File size (bytes) }
      property ChannelModeID: Byte read FChannelModeID;   { Channel mode code }
      property ChannelMode: string read FGetChannelMode;  { Channel mode name }
      property SampleRate: Integer read FSampleRate;       { Sample rate (hz) }
      property Duration: Double read FDuration;          { Duration (seconds) }
      property BitRate: Integer read FBitRate;              { Bit rate (kbit) }
			property Title: WideString read FTitle write FTitle;                    { Song title }
			property Artist: WideString read FArtist write FArtist;                 { Artist name }
			property Album: WideString read FAlbum write FAlbum;                    { Album name }
			property Track: Integer read FTrack write FTrack;                     { Track number }
			property Year: WideString read FYear write FYear;                            { Year }
			property Genre: WideString read FGenre write FGenre;                    { Genre name }
			property Comment: WideString read FComment write FComment;   { Comment }
			property PromotionURL: WideString read FPromotionURL write FPromotionURL;
			property Rating: WideString read FRating write FRating;
			property Copyright: WideString read FCopyright write FCopyright;
			property AlbumCoverURL: WideString read FAlbumCoverURL write FAlbumCoverURL;
			property Lyrics: WideString read FLyrics write FLyrics;
			property AddList: TList read FAddList;
	end;

implementation

const
	{ Object IDs }
  WMA_HEADER_ID =
    #48#38#178#117#142#102#207#17#166#217#0#170#0#98#206#108;
  WMA_FILE_PROPERTIES_ID =
		#161#220#171#140#71#169#207#17#142#228#0#192#12#32#83#101;
  WMA_STREAM_PROPERTIES_ID =
		#145#7#220#183#183#169#207#17#142#230#0#192#12#32#83#101;
	WMA_CONTENT_DESCRIPTION_ID =
		#51#38#178#117#142#102#207#17#166#217#0#170#0#98#206#108;
	WMA_EXTENDED_CONTENT_DESCRIPTION_ID =
		#064#164#208#210#007#227#210#017#151#240#000#160#201#094#168#080;
	WMA_PADDING_ID =
		#116#212#006#024#223#202#009#069#186#164#232#170#150#203#171#154;
//		1806D474-CADF-4509-A4BA-9AABCB96AAE8

	{ Max. number of supported comment fields }
	WMA_FIELD_COUNT = 13;

  { Names of supported comment fields }
	WMA_FIELD_NAME: array [1..WMA_FIELD_COUNT] of WideString =     // WM/TRACK is 0-based. WM/TRACKNUMBER is 1-based
		('WM/TITLE', 'WM/AUTHOR', 'WM/ALBUMTITLE', 'WM/TRACK', 'WM/YEAR',
		 'WM/GENRE', 'WM/DESCRIPTION', 'WM/COPYRIGHT', 'WM/RATING', 'WM/PromotionURL',
		 'WM/AlbumCoverURL', 'WM/TRACKNUMBER', 'WM/LYRICS');

	{ Max. number of characters in tag field }
	WMA_MAX_STRING_SIZE = 250;

type
  { Object ID }
	ObjectID = array [1..16] of Char;

	{ Tag data }
	TagData = array [1..WMA_FIELD_COUNT] of WideString;

  { File data - for internal use }
	FileData = record
		FileSize: Integer;                                    { File size (bytes) }
    MaxBitRate: Integer;                                { Max. bit rate (bps) }
		Channels: Word;                                      { Number of channels }
    SampleRate: Integer;                                   { Sample rate (hz) }
    ByteRate: Integer;                                            { Byte rate }
		Tag: TagData;                                       { WMA tag information }
	end;

	Header = record
		Id : array [1..16] of Char;
		ObjectSize1 : Longword	;
		ObjectSize2 : Longword	;
		ObjectCount : Longword	;
		Reserved1 : byte;
		Reserved2 : byte;
	end;

{ ********************* Auxiliary functions & procedures ******************** }

function ReadFieldString(const Source: TStream; DataSize: Word): WideString;      //læser unicode
var
	Iterator, StringSize: Integer;
	FieldData: array [1..WMA_MAX_STRING_SIZE * 2] of Byte;
begin
	{ Read field data and convert to unicode string }
	Result := '';
	StringSize := DataSize div 2;
	if StringSize > WMA_MAX_STRING_SIZE then StringSize := WMA_MAX_STRING_SIZE;
	Source.ReadBuffer(FieldData, StringSize * 2);
	Source.Seek(DataSize - StringSize * 2, soFromCurrent);
	for Iterator := 1 to StringSize do
		Result := Result +
			WideChar(FieldData[Iterator * 2 - 1] + (FieldData[Iterator * 2] shl 8));
end;

{ --------------------------------------------------------------------------- }

procedure ReadTagStandard(const Source: TStream; var Tag: TagData);
var
  Iterator: Integer;
	FieldSize: array [1..5] of Word;
  FieldValue: WideString;
begin
	{ Read standard tag data }
	Source.ReadBuffer(FieldSize, SizeOf(FieldSize));    //læser Title Length, Author Length, Copyright  Length, Description Length, Rating Length
	for Iterator := 1 to 5 do
		if FieldSize[Iterator] > 0 then
		begin
      { Read field value }
      FieldValue := ReadFieldString(Source, FieldSize[Iterator]);
			{ Set corresponding tag field if supported }
			case Iterator of
				1: Tag[1] := FieldValue;         //title
        2: Tag[2] := FieldValue;         //author / artist
				3: Tag[8] := FieldValue;         //Copyright
				4: Tag[7] := FieldValue;         //Description
				5: Tag[9] := FieldValue;         //Rating
      end;
		end;
end;

{ --------------------------------------------------------------------------- }

procedure ReadTagExtended(const Source: TStream; var Tag: TagData; const AddObjects: TList; AddToTagData: Boolean);
var
	Iterator1, Iterator2, FieldCount, DataSize, NameSize, DataType: Word;
	FieldName, FieldNameTrimmed, FieldValue: WideString;
	AddObj : TStream;
	Added : Boolean;
	position : integer;
begin
	{ Read extended tag data }
	Source.ReadBuffer(FieldCount, SizeOf(FieldCount));
	for Iterator1 := 1 to FieldCount do
	begin
		Added := false;
		{ Read field name }
		Source.ReadBuffer(NameSize, SizeOf(NameSize));
		FieldName := ReadFieldString(Source, NameSize);
		FieldNameTrimmed := WideTrim(FieldName);
		{ Read value data type }
		Source.ReadBuffer(DataType, SizeOf(DataType));
		{ Read size of the Content Discriptor }
		Source.ReadBuffer(DataSize, SizeOf(DataSize));
		Position := Source.Position;
		{ Read field value only if string }
		if (DataType = 0) or ((DataType = 3) and ((StrICompW(PWideChar(FieldNameTrimmed), PWideChar(WMA_FIELD_NAME[4])) = 0) or (StrICompW(PWideChar(FieldNameTrimmed), PWideChar(WMA_FIELD_NAME[12]))=0))) then
		begin
			FieldValue := ReadFieldString(Source, DataSize);
			{ Set corresponding tag field if supported }
			for Iterator2 := 1 to WMA_FIELD_COUNT do
				if StrICompW(PWideChar(FieldNameTrimmed), PWideChar(WMA_FIELD_NAME[Iterator2])) = 0 then
				begin
					//if not assigned(AddObjects) then
					if AddToTagData then
						Tag[Iterator2] := FieldValue;
					Added := true
				end
		end
		else
			Source.Seek(DataSize, soFromCurrent);
		if not Added and assigned(AddObjects) then
		begin
			AddObj := TMemoryStream.Create;
			AddObj.WriteBuffer(NameSize, SizeOf(NameSize));
			if NameSize > 0 then
				AddObj.WriteBuffer(FieldName[1], NameSize);
			AddObj.WriteBuffer(DataType, SizeOf(DataType));
			AddObj.WriteBuffer(DataSize, SizeOf(DataSize));
			if DataSize > 0 then
			begin
				Source.Position := Position;
				AddObj.CopyFrom(Source, DataSize)
			end;
			AddObjects.Add(AddObj)
		end
  end;
end;

{ --------------------------------------------------------------------------- }

procedure ReadObject(const ID: ObjectID; Source: TStream; var Data: FileData; AddList: TList);
begin
  { Read data from header object if supported }
	if ID = WMA_FILE_PROPERTIES_ID then
	begin
    { Read file properties }
		Source.Seek(80, soFromCurrent);
		Source.ReadBuffer(Data.MaxBitRate, SizeOf(Data.MaxBitRate));
	end else
	if ID = WMA_STREAM_PROPERTIES_ID then
	begin
		{ Read stream properties }
		Source.Seek(60, soFromCurrent);
		Source.ReadBuffer(Data.Channels, SizeOf(Data.Channels));
		Source.ReadBuffer(Data.SampleRate, SizeOf(Data.SampleRate));
		Source.ReadBuffer(Data.ByteRate, SizeOf(Data.ByteRate));
	end else
	if ID = WMA_CONTENT_DESCRIPTION_ID then
	begin
		{ Read standard tag data }
		Source.Seek(4, soFromCurrent);   //læser forbi de resterende 32 bit af sizen
		ReadTagStandard(Source, Data.Tag);
	end else
	if ID = WMA_EXTENDED_CONTENT_DESCRIPTION_ID then
	begin
		{ Read extended tag data }
		Source.Seek(4, soFromCurrent);    //læser forbi de resterende 32 bit af sizen
		ReadTagExtended(Source, Data.Tag, AddList, true);
	end
end;

{ --------------------------------------------------------------------------- }

function ReadData(const Source: TStream; var Data: FileData; AddList: TList): Boolean;
var
	ID: ObjectID;
	Iterator, ObjectCount, ObjectSize, Position: Integer;
begin
	{ Read file data }
	try
		Source.Position := 0;
		Data.FileSize := Source.Size;
		{ Check for existing header }
		Source.ReadBuffer(ID, SizeOf(ID));
		if ID = WMA_HEADER_ID then
		begin
			Source.Seek(8, soFromCurrent);    //springer over "Object Size" = Size of header object
			Source.ReadBuffer(ObjectCount, SizeOf(ObjectCount));      //se i specs side 8
			Source.Seek(2, soFromCurrent);       //reserved 1 + reserved 2
			{ Read all objects in header and get needed data }
			for Iterator := 1 to ObjectCount do
			begin
				Position := Source.Position;
				Source.ReadBuffer(ID, SizeOf(ID));       //læser 128 bbit / 16 byte
				Source.ReadBuffer(ObjectSize, SizeOf(ObjectSize));    //32 bit / 4 bit (læser kun halvdelen af sizen)
				ReadObject(ID, Source, Data, AddList);
				Source.Seek(Position + ObjectSize, soFromBeginning);
			end;
    end;
		Result := true;
	except
		Result := false;
  end;
end;

function GetText(const ws: WideString; DataType: word):WideString;
begin
	if DataType = 0 then
	begin
		Result := WideTrim(ws);
		if length(Result)>0 then
			Result := Result + #0
	end else result := ws
end;

procedure WriteTextLength(const Str : TStream; const ws : WideString; DataType: word=0); //0 = unicode
var
	w : word;
begin
	w := length(GetText(ws, DataType)) * 2;
	Str.WriteBuffer(w, SizeOf(w))
end;

procedure WriteText(const Str : TStream; ws : WideString; DataType: word=0); //0 = unicode
begin
	ws := GetText(ws, DataType);
	if length(ws) > 0 then
		Str.WriteBuffer(ws[1], length(ws)*2)
end;

function WriteTag(const FStr: TStream; Data: FileData; Removetag: Boolean; AddList:TList): Boolean;
	procedure WriteTextLengthIndex(const Str : TStream; const index : integer; DataType: word=0); //0 = unicode
	begin
		WriteTextLength(Str, Data.Tag[index], DataType)
	end;

	procedure WriteTextIndex(const Str : TStream; const index : integer; DataType: word=0); //0 = unicode
	begin
		WriteText(Str, Data.Tag[index], DataType)
	end;

	function WriteContentDiscriptionObject(const Mstr: TStream):integer; //retunerer størrelsen på objectet
	var
		Obj : TStream;
		k : integer;
	begin
		k := 0;
		Obj := TMemoryStream.Create;
		Obj.WriteBuffer(WMA_CONTENT_DESCRIPTION_ID[1], Length(WMA_CONTENT_DESCRIPTION_ID));
		Obj.WriteBuffer(k, SizeOf(k)); //size, skrives til sidst
		Obj.WriteBuffer(k, SizeOf(k));
		WriteTextLengthIndex(Obj, 1);
		WriteTextLengthIndex(Obj, 2);
		WriteTextLengthIndex(Obj, 8);
		WriteTextLengthIndex(Obj, 7);
		WriteTextLengthIndex(Obj, 9);

		WriteTextIndex(Obj, 1);
		WriteTextIndex(Obj, 2);
		WriteTextIndex(Obj, 8);
		WriteTextIndex(Obj, 7);
		WriteTextIndex(Obj, 9);

		k := Obj.Size;
		Obj.Position := Length(WMA_CONTENT_DESCRIPTION_ID);
		Obj.Write(k, SizeOf(k));
		Obj.Position := 0;

		MStr.CopyFrom(Obj, Obj.Size);
		result := Obj.Size;
		Obj.free
	end;

	function WriteExtContentDescriptor(const Str : TStream; index : integer):integer; //retunerer 1 hvis noget er skrevet, ellers 0
	var
		DataType : word;
	begin
		result := 0;
    //Track skal også være unicode: http://msdn.microsoft.com/library/default.asp?url=/library/en-us/wmform/htm/wmtracknumber.asp
		if index in [4, 12] then //track, tracknumber ?
			DataType := 3    //DWORD, til Track
		else
    	DataType := 0;        //UNICODE
		if (length(GetText(Data.Tag[index], DataType)) > 0) and (not (index in [4, 12]) or (GetText(Data.Tag[Index], DataType) <> '0'))  then
		begin
			WriteTextLength(Str, WMA_FIELD_NAME[index]); //Name Length
			WriteText(Str, WMA_FIELD_NAME[index]);	//Name
			Str.WriteBuffer(DataType, SizeOf(DataType)); //Value Data Type (0=Unicode)
			WriteTextLengthIndex(Str, index, DataType);	//Value Length
			WriteTextIndex(Str, index, DataType); //Value
			result := 1
		end
	end;

	function WriteExtContentDiscriptionObject(const Mstr: TStream; AddList: TList):integer; //retunerer størrelsen på objectet
	var
		Obj : TStream;
		k, i : integer;
		DiscripterCount : word;
	begin
		k := 0;  //dummy
		DiscripterCount := 0;

		Obj := TMemoryStream.Create;
		Obj.WriteBuffer(WMA_EXTENDED_CONTENT_DESCRIPTION_ID[1], Length(WMA_EXTENDED_CONTENT_DESCRIPTION_ID));
		//Object Size skrives først til sidst!
		//Content Discripter Count skrives først til sidst!
		Obj.Size := Obj.Size + 10;    //springer over ObjectSize og DizCount  (8 + 2)
		Obj.Position := Obj.Size;

		inc(DiscripterCount, WriteExtContentDescriptor(Obj, 3));
		inc(DiscripterCount, WriteExtContentDescriptor(Obj, 4));
		inc(DiscripterCount, WriteExtContentDescriptor(Obj, 5));
		inc(DiscripterCount, WriteExtContentDescriptor(Obj, 6));
		inc(DiscripterCount, WriteExtContentDescriptor(Obj, 10));
		inc(DiscripterCount, WriteExtContentDescriptor(Obj, 11));
		inc(DiscripterCount, WriteExtContentDescriptor(Obj, 12));
		inc(DiscripterCount, WriteExtContentDescriptor(Obj, 13));

		if assigned(AddList) then
			for i:=0 to AddList.Count-1 do
			begin
				TStream(AddList.Items[i]).Position := 0;
				Obj.CopyFrom(TStream(AddList.Items[i]), TStream(AddList.Items[i]).Size);
				inc(DiscripterCount)
			end;

		result := Obj.Size;
		//skriver ObjectSize og DiscripterCount
		Obj.Position := Length(WMA_EXTENDED_CONTENT_DESCRIPTION_ID);
		Obj.Write(result, SizeOf(result));
		Obj.Write(k, SizeOf(k));
		Obj.Write(DiscripterCount, SizeOf(DiscripterCount));

		Obj.Position := 0;
		Mstr.CopyFrom(Obj, Obj.Size);
		Obj.free
	end;

	procedure WritePaddingObject(Const Str: TStream; ObjectSize: integer); //Object size SKAL være større end 24
	var
		i: integer;
		b: byte;
	begin
		i := 0;
		b := 0;
		Str.WriteBuffer(WMA_PADDING_ID[1], length(WMA_PADDING_ID));
		Str.WriteBuffer(ObjectSize, SizeOf(ObjectSize));
		Str.WriteBuffer(i, SizeOf(i));
		for i:=24 to ObjectSize-1 do
			Str.WriteBuffer(b, SizeOf(b))
	end;

var
	Mstr : TStream;
	head : Header;
	i, originalHeaderSize : integer;
	ID: ObjectID;
	ObjectSize, size : integer;
	HasDescriptionWritten, HasExtendedDescriptionWritten : boolean;
	delta, PaddingObjectSize : integer;
	BytesMoved: Cardinal;
begin
	result := true;
	HasDescriptionWritten := false;
	HasExtendedDescriptionWritten := false;
	PaddingObjectSize := 0;
	Mstr := nil;
	try
	//Fylder alle objecter/headers inden tag over i Mstr
	Fstr.Position := 0;
	Fstr.Read(head, sizeOf(Header));
	Fstr.Seek(-2, soFromCurrent);
	except
		result := false;
	end;

	originalHeaderSize := head.ObjectSize1;

	MStr := TMemoryStream.create;
	try
	MStr.Size := sizeOf(Header)-2;
	Mstr.Position := sizeOf(Header)-2;

	for i:=1 to head.ObjectCount do
	begin
		Fstr.ReadBuffer(ID, SizeOf(ID));       //læser 128 bbit / 16 byte
		Fstr.ReadBuffer(ObjectSize, SizeOf(ObjectSize));    //32 bit / 4 byte
		Fstr.Seek(4, soFromCurrent);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if ID = WMA_CONTENT_DESCRIPTION_ID then      { standard tag data }
		begin
			Fstr.Seek(ObjectSize - SizeOf(ID) - 8, soFromCurrent); //læser forbi tagget i filen
			dec(head.ObjectSize1, ObjectSize);
			HasDescriptionWritten := true;

			if not Removetag and ((length(Data.Tag[1])>0) or (length(Data.Tag[2])>0) or (length(Data.Tag[8])>0) or (length(Data.Tag[7])>0) or (length(Data.Tag[9])>0)) then //er det nødvendigt at have dette objekt?
			begin
				size := WriteContentDiscriptionObject(Mstr);
				inc(head.ObjectSize1, Size)
			end else dec(head.ObjectCount)
		end else
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if ID = WMA_EXTENDED_CONTENT_DESCRIPTION_ID then
		begin
			dec(head.ObjectSize1, ObjectSize);
			HasExtendedDescriptionWritten := true;
			ReadTagExtended(Fstr, Data.Tag, nil, false);  //de ekstra data er allerede læst ind i AddList

			//tag index der skal skrives: 3, 4, 5, 6, 10, 11
			if not Removetag and ((AddList.Count>0) or (length(Data.Tag[3])>0) or (length(Data.Tag[4])>0) or (length(Data.Tag[5])>0) or (length(Data.Tag[6])>0) or (length(Data.Tag[10])>0) or (length(Data.Tag[11])>0) or (length(Data.Tag[12])>0) or (length(Data.Tag[13])>0)) then
			begin
				size := WriteExtContentDiscriptionObject(Mstr, AddList);
				inc(head.ObjectSize1, Size)
			end else dec(head.ObjectCount)
		end else
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if ID = WMA_PADDING_ID then
		begin
			//Fstr.ReadBuffer(PaddingObjectSize, SizeOf(PaddingObjectSize));
			//Fstr.Seek(PaddingObjectSize - 20, soFromCurrent); // de fire er resten af sizen, som er 64 bit
			Fstr.Seek(ObjectSize - SizeOf(ID) - 8, soFromCurrent); //læser forbi tagget i filen
			dec(head.ObjectSize1, ObjectSize);
			dec(head.ObjectCount)
		end else
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		begin
			Fstr.Seek(-24, soFromCurrent);
			Mstr.CopyFrom(Fstr, ObjectSize)
		end
	end; // of for i:= to objectcount

	if not Removetag and not HasDescriptionWritten and ((length(Data.Tag[1])>0) or (length(Data.Tag[2])>0) or (length(Data.Tag[8])>0) or (length(Data.Tag[7])>0) or (length(Data.Tag[9])>0)) then //er det nødvendigt at have dette objekt?
	begin
		size := WriteContentDiscriptionObject(Mstr);
		inc(head.ObjectSize1, Size);
		inc(head.ObjectCount)
	end;

	if not Removetag and not HasExtendedDescriptionWritten and ((length(Data.Tag[3])>0) or (length(Data.Tag[4])>0) or (length(Data.Tag[5])>0) or (length(Data.Tag[6])>0) or (length(Data.Tag[10])>0) or (length(Data.Tag[11])>0) or (length(Data.Tag[12])>0) or (length(Data.Tag[13])>0)) then
	begin
		size := WriteExtContentDiscriptionObject(Mstr, AddList);
		inc(head.ObjectSize1, Size);
		inc(head.ObjectCount)
	end;

	//Alle objekter er nu skrevet (undtagen padding objekt)
	// delta er hvor meget den gamle header er større end den nye
	delta := originalHeaderSize - Mstr.Size;
	if delta > 24 then //den gamle er større end den nye, men vi padder os ud af problemet : )
	begin
		//skriver ny padding:
		WritePaddingObject(Mstr, delta);
		inc(head.ObjectSize1, delta);
		inc(head.ObjectCount)
	end else
	if delta <> 0 then //den nye er større end den gamle, eller der er ikke plads til padding-object-id'et
	begin
		// filen skal udvides. Der skrives 3 kb padding også.
		PaddingObjectSize := 3072 + 24; //3 kb og 24 til index
		Mstr.Position := Mstr.Size;
		WritePaddingObject(Mstr, PaddingObjectSize);
		inc(head.ObjectSize1, PaddingObjectSize);
		inc(head.ObjectCount);

		BytesMoved := 0;

		delta := Mstr.Size - originalHeaderSize;

		MoveStreamContents(FStr, delta)
	end;

	{ Skriver headeren }
	Mstr.Position := 0;
	head.Reserved1 := 1;
	head.Reserved2 := 2;
	Mstr.Write(head, 30);
	{ Skriver headeren og alle header-objekter til Filen }
	MStr.Position := 0;
	Fstr.Position := 0;
	Fstr.CopyFrom(Mstr, Mstr.Size);
	MStr.Free;
	Mstr := nil;
	except
		try
		begin
			result := false;
			if assigned(Mstr) then
				Mstr.free
		end
		except end	end
end;
{ --------------------------------------------------------------------------- }

function IsValid(const Data: FileData): Boolean;
begin
  { Check for data validity }
  Result :=
    (Data.MaxBitRate > 0) and (Data.MaxBitRate < 480000) and
    ((Data.Channels = WMA_CM_MONO) or (Data.Channels = WMA_CM_STEREO)) and
		(Data.SampleRate >= 8000) and (Data.SampleRate <= 96000) and
    (Data.ByteRate > 0) and (Data.ByteRate < 48000);
end;

{ --------------------------------------------------------------------------- }

function ExtractTrack(const TrackString: WideString): integer;
begin
	{ Extract track from string }
	if length(TrackString) = 2 then
		Result := (word(TrackString[2]) shl 16) or word((TrackString[1]))
	else
  	if Q_IsInteger(TrackString) then
			Result := strtoint(TrackString)
    else
    	Result := 0
end;

//Encode track do DWORD
function EncodeTrack(const Track: integer): WideString;
begin
	Result := WideString(WideChar(Track and $FFFF)) + WideString(WideChar(Track shr 16))
end;

{ ********************** Private functions & procedures ********************* }

function TWMAfile.GetKeyIndex(const key: WideString): integer;
var
	i: Integer;
  Str: TStream;
  s: String;
  NameLength: word;
begin
	result := -1;

  for i:=0 to FAddList.Count-1 do
  begin
  	Str := TStream(FAddList.Items[i]);
    Str.Position := 0;
    Str.Read(NameLength, 2);
    s := WideTrim(ReadFieldString(Str, NameLength));

    if Q_SameText(key, s) then
    begin
    	result := i;
      break;
    end;
  end;
end;

function TWMAfile.GetAddListKeyName(FStr: TStream; var value: WideString):WideString;
var
	NameLength, DataType: word;
begin
	FStr.Position := 0;
	FStr.Read(NameLength, 2);
	result := WideTrim(ReadFieldString(Fstr, NameLength));
	FStr.Read(DataType, 2);
	if DataType = 0 then
	begin
		FStr.Read(NameLength, 2);
		value := ReadFieldString(Fstr, NameLength)
	end
	else value := '';
	value := trim(value)
end;

function TWMAfile.GetAddListKeyName(index: integer; var value: WideString):WideString;
begin
	result := GetAddListKeyName(TStream(FAddlist.Items[index]), value);
end;

procedure TWMAfile.DeleteFromAddlist(index:integer);
begin
	TStream(FAddlist.Items[index]).Free;
  FAddlist.Delete(index);
end;

procedure TWMAfile.AddKeyToAddList(key: WideString; value: WideString);
var
	MStr: TStream;
	w: word;
begin
	w := 0;//unicode
	MStr := TMemoryStream.Create;
	WriteTextLength(MStr, key); //Name Length
	WriteText(MStr, key);	//Name
	MStr.WriteBuffer(w, SizeOf(w)); //Value Data Type (0=Unicode)
	WriteTextLength(MStr, value);	//Value Length
	WriteText(MStr, value); //Value
	FAddList.Add(MStr)
end;

procedure TWMAFile.SetAddListValue(index: integer; value: WideString);
var
	MStr: TStream;
	w: word;
  key, dummy: WideString;
begin
	mStr := TStream(FAddlist.Items[index]);
  key := GetAddListKeyName(mStr, dummy);
  mStr.Size := 0;
  w := 0;//unicode
	WriteTextLength(MStr, key); //Name Length
	WriteText(MStr, key);	//Name
	MStr.WriteBuffer(w, SizeOf(w)); //Value Data Type (0=Unicode)
	WriteTextLength(MStr, value);	//Value Length
	WriteText(MStr, value) //Value
end;

procedure TWMAfile.FResetData;
begin
  { Reset variables }
  FValid := false;
  FFileSize := 0;
  FChannelModeID := WMA_CM_UNKNOWN;
  FSampleRate := 0;
  FDuration := 0;
	FBitRate := 0;
  FTitle := '';
  FArtist := '';
  FAlbum := '';
  FTrack := 0;
  FYear := '';
	FGenre := '';
	FComment := '';
	FPromotionURL := '';
	FRating := '';
	FCopyright := '';
	FAlbumCoverURL := '';
	FLyrics := '';
	ClearAddlist
end;

{ --------------------------------------------------------------------------- }

function TWMAfile.FGetChannelMode: string;
begin
  { Get channel mode name }
  Result := WMA_MODE[FChannelModeID];
end;

{ ********************** Public functions & procedures ********************** }

constructor TWMAfile.Create;
begin
  { Create object }
	inherited;
	FAddList := TList.Create;
	FResetData
end;

destructor TWMAfile.Destroy;
begin
	{ Object destructor }
	ClearAddlist;
	FAddList.free;
	inherited;
end;

procedure TWMAfile.ClearAddlist;
var
	i: Integer;
begin
	for i:=0 to FAddList.Count-1 do
		TStream(FAddList.Items[i]).free
end;
{ --------------------------------------------------------------------------- }

function TWMAfile.ReadFromFile(const FileName: string): Boolean;
var
	Fstr : TSTream;
begin
	try
		FStr := TFileStream.Create(FileName, fmOpenRead	or fmShareDenyNone);
		result := ReadFromStream(FStr);
		Fstr.free
	except
		result := false
	end
end;

function TWMAfile.ReadFromStream(const FStr: TStream): Boolean;
var
	Data: FileData;
begin
	{ Reset variables and load file data }
	FResetData;
	try
		FillChar(Data, SizeOf(Data), 0);
		Result := ReadData(FStr, Data, FAddList);
		{ Process data if loaded and valid }
		if Result and IsValid(Data) then
		begin
			FValid := true;
			{ Fill properties with loaded data }
			FFileSize := Data.FileSize;
			FChannelModeID := Data.Channels;
			FSampleRate := Data.SampleRate;
			FDuration := Data.FileSize * 8 / Data.MaxBitRate;
			FBitRate := Data.ByteRate * 8 div 1000;
			FTitle := WideTrim(Data.Tag[1]);
			FArtist := WideTrim(Data.Tag[2]);
			FAlbum := WideTrim(Data.Tag[3]);

			if (length(Data.Tag[12]) > 0) and (ExtractTrack((Data.Tag[12])) <> 0) then
				FTrack := ExtractTrack((Data.Tag[12]))
			else
			if (Length(Data.Tag[4]) > 0) then
				FTrack := ExtractTrack((Data.Tag[4]))+1
			else FTrack := 0;

			FYear := WideTrim(Data.Tag[5]);
			FGenre := WideTrim(Data.Tag[6]);
			FComment := WideTrim(Data.Tag[7]);
			FCopyright := WideTrim(Data.Tag[8]);
			FRating := WideTrim(Data.Tag[9]);
			FPromotionURL := WideTrim(Data.Tag[10]);
			FAlbumCoverURL := WideTrim(Data.Tag[11]);
			FLyrics := Data.Tag[13]
		end
	except
		result := false
	end
end;

function TWMAfile.WriteToFile(const FileName: String): Boolean;
var
	Data : FileData;
	Fstr: TStream;
begin
	FillChar(Data, SizeOf(Data), 0);
	try
		Fstr := TFileStream.Create(FileName, fmOpenReadWrite	or fmShareDenyWrite);
		result := WriteToStream(Fstr);
		FStr.Free
	except
		result := false
	end
end;

function TWMAfile.WriteToStream(const FStr: TStream; Removetag: Boolean = false): Boolean;
var
	Data : FileData;
begin
	FillChar(Data, SizeOf(Data), 0);
	try
		result := ReadData(Fstr, Data, nil);
		if result and FValid then
		begin
			if Removetag then
			begin
				FillChar(Data.Tag, SizeOf(Data.Tag), 0);
				ClearAddList
			end
			else
			begin
				//opdaterer Data.Tag værdier
				Data.Tag[1] := WideTrim(FTitle);
				Data.Tag[2] := WideTrim(FArtist);
				Data.Tag[3] := WideTrim(FAlbum);
				Data.Tag[5] := WideTrim(FYear);
				Data.Tag[6] := WideTrim(FGenre);
				Data.Tag[7] := WideTrim(FComment);
				Data.Tag[8] := WideTrim(FCopyright);
				Data.Tag[9] := WideTrim(FRating);
				Data.Tag[10] := WideTrim(FPromotionURL);
				Data.Tag[11] := WideTrim(FAlbumCoverURL);
				Data.Tag[13] := FLyrics;
        //Track:
        if FTrack <= 0 then
        begin
        	Data.Tag[4] := '';
          Data.Tag[12] := ''
        end
        else
        begin
        	Data.Tag[4] := EncodeTrack(FTrack-1);
          Data.Tag[12] := EncodeTrack(FTrack)
        end
			end;
			Result := WriteTag(FStr, Data, Removetag, FAddlist)
		end
	except
		result := false
	end
end;

end.
