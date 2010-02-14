{ *************************************************************************** }
{                                                                             }
{ Audio Tools Library (Freeware)                                              }
{ Class TOggVorbis - for manipulating with Ogg Vorbis file information        }
{                                                                             }
{ Copyright (c) 2001,2002 by Jurgen Faul                                      }
{ E-mail: jfaul@gmx.de                                                        }
{ http://jfaul.de/atl                                                         }
{                                                                             }
{ Fixed by Anders Thomsen 30/4-03                                             }

{ Version 1.6 (2 October 2002)                                                }
{   - Writing support for Vorbis tag                                          }
{   - Changed several properties                                              }
{   - Fixed bug with long Vorbis tag fields                                   }
{                                                                             }
{ Version 1.2 (18 February 2002)                                              }
{   - Added property BitRateNominal                                           }
{   - Fixed bug with Vorbis tag fields                                        }
{                                                                             }
{ Version 1.1 (21 October 2001)                                               }
{   - Support for UTF-8                                                       }
{   - Fixed bug with vendor info detection                                    }
{                                                                             }
{ Version 1.0 (15 August 2001)                                                }
{   - File info: file size, channel mode, sample rate, duration, bit rate     }
{   - Vorbis tag: title, artist, album, track, date, genre, comment, vendor   }
{                                                                             }
{ *************************************************************************** }

unit OggVorbis;

interface

uses
  Classes, SysUtils, QStrings, dialogs;

const
  { Used with ChannelModeID property }
  VORBIS_CM_MONO = 1;                                    { Code for mono mode }
  VORBIS_CM_STEREO = 2;                                { Code for stereo mode }

  { Channel mode names }
  VORBIS_MODE: array [0..2] of string = ('Unknown', 'Mono', 'Stereo');

    { Max. number of supported comment fields }
	VORBIS_FIELD_COUNT = 12;

  { Names of supported comment fields }
  VORBIS_FIELD: array [1..VORBIS_FIELD_COUNT] of string =
    ('TITLE', 'ARTIST', 'ALBUM', 'TRACKNUMBER', 'DATE', 'GENRE', 'COMMENT',
		'PERFORMER', 'DESCRIPTION', 'COPYRIGHT', 'LYRICS', 'VERSION');


type
	  { Ogg page header }
	OggHeader = packed record
    ID: array [1..4] of Char;                                 { Always "OggS" }
    StreamVersion: Byte;                           { Stream structure version }
    TypeFlag: Byte;                                        { Header type flag }
    AbsolutePosition: Int64;                      { Absolute granule position }
    Serial: Integer;                                   { Stream serial number }
    PageNumber: Integer;                               { Page sequence number }
    Checksum: Integer;                                        { Page checksum }
    Segments: Byte;                                 { Number of page segments }
    LacingValues: array [1..$FF] of Byte;     { Lacing values - segment sizes }
  end;

  { Vorbis parameter header }
  VorbisHeader = packed record
    ID: array [1..7] of Char;                          { Always #1 + "vorbis" }
    BitstreamVersion: array [1..4] of Byte;        { Bitstream version number }
		ChannelMode: Byte;                                   { Number of channels }
    SampleRate: Integer;                                   { Sample rate (hz) }
    BitRateMaximal: Integer;                           { Bit rate upper limit }
    BitRateNominal: Integer;                               { Nominal bit rate }
    BitRateMinimal: Integer;                           { Bit rate lower limit }
    BlockSize: Byte;                   { Coded size for small and long blocks }
    StopFlag: Byte;                                                { Always 1 }
  end;

	{ Vorbis tag data }
	VorbisTag = record
		ID: array [1..7] of Char;                          { Always #3 + "vorbis" }
    Fields: Integer;                                   { Number of tag fields }
		FieldData: array [0..VORBIS_FIELD_COUNT] of string;      { Tag field data }
		AdditionalTags: TStringList;
  end;

  { File data }
	FileInfo = record
    FPage, SPage, LPage: OggHeader;             { First, second and last page }
    Parameters: VorbisHeader;                       { Vorbis parameter header }
		Tag: VorbisTag;                                         { Vorbis tag data }
    FileSize: Integer;                                    { File size (bytes) }
    Samples: Integer;                               { Total number of samples }
    ID3v2Size: Integer;                              { ID3v2 tag size (bytes) }
    SPagePos: Integer;                          { Position of second Ogg page }
    VorbisTagPageCount: Integer;		 { Number of Ogg pages the tag spans over }
    AdditionalVorbisHeaderLength: Integer; { Number of bytes in the last OggS page that the tag is in, that is filled with add. Vorbis header data. }
    TagEndPos: Integer;                                    { Tag end position }
  end;

	{ Class TOggVorbis }
	TOggVorbis = class(TObject)
		private
			{ Private declarations }
      FSource: TStream;
      FInfo: FileInfo;
			FFileSize: Integer;
			FChannelModeID: Byte;
			FSampleRate: Word;
			FBitRateNominal: Word;
			FSamples: Integer;
			FID3v2Size: Integer;
			FTitle: string;
			FArtist: string;
			FAlbum: string;
			FTrack: String;
			FDate: string;
			FGenre: string;
			FComment: string;
			FVendor: string;
//			FPerformer: String;
//			FDescription: String;
			FCopyright: String;
			FLyrics: String;
			Fversion: String;
			FAdditionalTags: TStringList;
			procedure FResetData;
			function FGetChannelMode: string;
			function FGetDuration: Double;
			function FGetBitRate: Word;
			function FHasID3v2: Boolean;
			function FIsValid: Boolean;

      procedure ReadTag(ReadAdditionalTags: Boolean);
      function GetInfo(ReadAdditionalTags: Boolean): Boolean;
		public
			{ Public declarations }
			constructor Create;                                     { Create object }
			destructor Destroy; override;                          { Destroy object }
			function GetAddListKeyName(Input:String; var value: String):String;   overload;
      function GetAddListKeyName(index: integer; var value: String):String; overload;
      function GetKeyIndex(const key: String): integer;
			procedure AddKeyToAddList(key: String; value: String);
      procedure DeleteFromAddlist(index: Integer);
//			function ReadFromFile(const FileName: string): Boolean;     { Load data }
			function ReadFromStream(const FStr: TStream): Boolean;     { Load data }
			function SaveTag: Boolean;      { Save tag data }
			function ClearTag: Boolean;    { Clear tag data }
			property FileSize: Integer read FFileSize;          { File size (bytes) }
			property ChannelModeID: Byte read FChannelModeID;   { Channel mode code }
			property ChannelMode: string read FGetChannelMode;  { Channel mode name }
			property SampleRate: Word read FSampleRate;          { Sample rate (hz) }
			property BitRateNominal: Word read FBitRateNominal;  { Nominal bit rate }
			property Title: string read FTitle write FTitle;           { Song title }
			property Artist: string read FArtist write FArtist;       { Artist name }
			property Album: string read FAlbum write FAlbum;           { Album name }
			property Track: String read FTrack write FTrack;           { Track number }
			property Date: string read FDate write FDate;                    { Year }
			property Genre: string read FGenre write FGenre;           { Genre name }
			property Comment: string read FComment write FComment;        { Comment }
//			property Performer: String read FPerformer write FPerformer;
//			property Description: String read FDescription write FDescription;
			property Copyright: String read FCopyright write FCopyright;
			property Lyrics: String read FLyrics write FLyrics;
			property Version: String read Fversion write Fversion;
			property AdditionalTags: TStringList read FAdditionalTags;
			property Vendor: string read FVendor;                   { Vendor string }
			property Duration: Double read FGetDuration;       { Duration (seconds) }
			property BitRate: Word read FGetBitRate;             { Average bit rate }
			property ID3v2: Boolean read FHasID3v2;      { True if ID3v2 tag exists }
			property Valid: Boolean read FIsValid;             { True if file valid }
	end;

implementation

const
  { Ogg page header ID }
  OGG_PAGE_ID = 'OggS';

  { Vorbis parameter frame ID }
  VORBIS_PARAMETERS_ID = #1 + 'vorbis';

  { Vorbis tag frame ID }
  VORBIS_TAG_ID = #3 + 'vorbis';

  { CRC table for checksum calculating }
  CRC_TABLE: array [0..$FF] of Cardinal = (
    $00000000, $04C11DB7, $09823B6E, $0D4326D9, $130476DC, $17C56B6B,
    $1A864DB2, $1E475005, $2608EDB8, $22C9F00F, $2F8AD6D6, $2B4BCB61,
    $350C9B64, $31CD86D3, $3C8EA00A, $384FBDBD, $4C11DB70, $48D0C6C7,
		$4593E01E, $4152FDA9, $5F15ADAC, $5BD4B01B, $569796C2, $52568B75,
    $6A1936C8, $6ED82B7F, $639B0DA6, $675A1011, $791D4014, $7DDC5DA3,
    $709F7B7A, $745E66CD, $9823B6E0, $9CE2AB57, $91A18D8E, $95609039,
    $8B27C03C, $8FE6DD8B, $82A5FB52, $8664E6E5, $BE2B5B58, $BAEA46EF,
    $B7A96036, $B3687D81, $AD2F2D84, $A9EE3033, $A4AD16EA, $A06C0B5D,
    $D4326D90, $D0F37027, $DDB056FE, $D9714B49, $C7361B4C, $C3F706FB,
    $CEB42022, $CA753D95, $F23A8028, $F6FB9D9F, $FBB8BB46, $FF79A6F1,
    $E13EF6F4, $E5FFEB43, $E8BCCD9A, $EC7DD02D, $34867077, $30476DC0,
    $3D044B19, $39C556AE, $278206AB, $23431B1C, $2E003DC5, $2AC12072,
    $128E9DCF, $164F8078, $1B0CA6A1, $1FCDBB16, $018AEB13, $054BF6A4,
    $0808D07D, $0CC9CDCA, $7897AB07, $7C56B6B0, $71159069, $75D48DDE,
    $6B93DDDB, $6F52C06C, $6211E6B5, $66D0FB02, $5E9F46BF, $5A5E5B08,
    $571D7DD1, $53DC6066, $4D9B3063, $495A2DD4, $44190B0D, $40D816BA,
    $ACA5C697, $A864DB20, $A527FDF9, $A1E6E04E, $BFA1B04B, $BB60ADFC,
    $B6238B25, $B2E29692, $8AAD2B2F, $8E6C3698, $832F1041, $87EE0DF6,
    $99A95DF3, $9D684044, $902B669D, $94EA7B2A, $E0B41DE7, $E4750050,
		$E9362689, $EDF73B3E, $F3B06B3B, $F771768C, $FA325055, $FEF34DE2,
    $C6BCF05F, $C27DEDE8, $CF3ECB31, $CBFFD686, $D5B88683, $D1799B34,
    $DC3ABDED, $D8FBA05A, $690CE0EE, $6DCDFD59, $608EDB80, $644FC637,
    $7A089632, $7EC98B85, $738AAD5C, $774BB0EB, $4F040D56, $4BC510E1,
    $46863638, $42472B8F, $5C007B8A, $58C1663D, $558240E4, $51435D53,
    $251D3B9E, $21DC2629, $2C9F00F0, $285E1D47, $36194D42, $32D850F5,
    $3F9B762C, $3B5A6B9B, $0315D626, $07D4CB91, $0A97ED48, $0E56F0FF,
    $1011A0FA, $14D0BD4D, $19939B94, $1D528623, $F12F560E, $F5EE4BB9,
    $F8AD6D60, $FC6C70D7, $E22B20D2, $E6EA3D65, $EBA91BBC, $EF68060B,
    $D727BBB6, $D3E6A601, $DEA580D8, $DA649D6F, $C423CD6A, $C0E2D0DD,
    $CDA1F604, $C960EBB3, $BD3E8D7E, $B9FF90C9, $B4BCB610, $B07DABA7,
    $AE3AFBA2, $AAFBE615, $A7B8C0CC, $A379DD7B, $9B3660C6, $9FF77D71,
    $92B45BA8, $9675461F, $8832161A, $8CF30BAD, $81B02D74, $857130C3,
    $5D8A9099, $594B8D2E, $5408ABF7, $50C9B640, $4E8EE645, $4A4FFBF2,
		$470CDD2B, $43CDC09C, $7B827D21, $7F436096, $7200464F, $76C15BF8,
    $68860BFD, $6C47164A, $61043093, $65C52D24, $119B4BE9, $155A565E,
    $18197087, $1CD86D30, $029F3D35, $065E2082, $0B1D065B, $0FDC1BEC,
    $3793A651, $3352BBE6, $3E119D3F, $3AD08088, $2497D08D, $2056CD3A,
    $2D15EBE3, $29D4F654, $C5A92679, $C1683BCE, $CC2B1D17, $C8EA00A0,
    $D6AD50A5, $D26C4D12, $DF2F6BCB, $DBEE767C, $E3A1CBC1, $E760D676,
    $EA23F0AF, $EEE2ED18, $F0A5BD1D, $F464A0AA, $F9278673, $FDE69BC4,
    $89B8FD09, $8D79E0BE, $803AC667, $84FBDBD0, $9ABC8BD5, $9E7D9662,
    $933EB0BB, $97FFAD0C, $AFB010B1, $AB710D06, $A6322BDF, $A2F33668,
    $BCB4666D, $B8757BDA, $B5365D03, $B1F740B4);


{ ********************* Auxiliary functions & procedures ******************** }

function DecodeUTF8(const Source: string): WideString;
var
  Index, SourceLength, FChar, NChar: Cardinal;
begin
  { Convert UTF-8 to unicode }
  Result := '';
  Index := 0;
  SourceLength := Length(Source);
  while Index < SourceLength do
  begin
    Inc(Index);
    FChar := Ord(Source[Index]);
		if FChar >= $80 then
    begin
      Inc(Index);
      if Index > SourceLength then exit;
      FChar := FChar and $3F;
      if (FChar and $20) <> 0 then
      begin
        FChar := FChar and $1F;
        NChar := Ord(Source[Index]);
        if (NChar and $C0) <> $80 then  exit;
        FChar := (FChar shl 6) or (NChar and $3F);
        Inc(Index);
        if Index > SourceLength then exit;
      end;
			NChar := Ord(Source[Index]);
      if (NChar and $C0) <> $80 then exit;
      Result := Result + WideChar((FChar shl 6) or (NChar and $3F));
    end
    else
      Result := Result + WideChar(FChar);
  end;
end;

{ --------------------------------------------------------------------------- }

function EncodeUTF8(const Source: WideString): string;
var
  Index, SourceLength, CChar: Cardinal;
begin
  { Convert unicode to UTF-8 }
  Result := '';
  Index := 0;
  SourceLength := Length(Source);
  while Index < SourceLength do
  begin
    Inc(Index);
    CChar := Cardinal(Source[Index]);
    if CChar <= $7F then
      Result := Result + Source[Index]
    else if CChar > $7FF then
    begin
      Result := Result + Char($E0 or (CChar shr 12));
      Result := Result + Char($80 or ((CChar shr 6) and $3F));
			Result := Result + Char($80 or (CChar and $3F));
    end
    else
    begin
      Result := Result + Char($C0 or (CChar shr 6));
      Result := Result + Char($80 or (CChar and $3F));
    end;
  end;
end;

{ --------------------------------------------------------------------------- }

function GetID3v2Size(const Source: TStream): Integer;
type
	ID3v2Header = record
    ID: array [1..3] of Char;
    Version: Byte;
    Revision: Byte;
    Flags: Byte;
    Size: array [1..4] of Byte;
  end;
var
  Header: ID3v2Header;
begin
  { Get ID3v2 tag size (if exists) }
  Result := 0;
	Source.Seek(0, soFromBeginning);
  Source.Read(Header, SizeOf(Header));
  if Header.ID = 'ID3' then
  begin
    Result :=
      Header.Size[1] * $200000 +
      Header.Size[2] * $4000 +
      Header.Size[3] * $80 +
      Header.Size[4] + 10;
    if Header.Flags and $10 = $10 then Inc(Result, 10);
    if Result > Source.Size then Result := 0;
  end;
end;

{ --------------------------------------------------------------------------- }

procedure SetTagItem(const Data: string; ReadAdditionalTags: boolean; var Info: FileInfo);
var
  Separator, Index: Integer;
	FieldID, FieldData: string;
	FieldSet: Boolean;
begin
  { Set Vorbis tag item if supported comment field found }
  Separator := Pos('=', Data);
  if Separator > 0 then
  begin
		FieldID := UpperCase(Copy(Data, 1, Separator - 1));
		FieldData := Copy(Data, Separator + 1, Length(Data) - Length(FieldID));
		FieldSet := false;
		for Index := 1 to VORBIS_FIELD_COUNT do
			if VORBIS_FIELD[Index] = FieldID then
			begin
				Info.Tag.FieldData[Index] := DecodeUTF8(Trim(FieldData));
				FieldSet := true
			end;
		if not FieldSet and ReadAdditionalTags then
			Info.Tag.AdditionalTags.Add(DecodeUTF8(Data))
  end
  else
    if Info.Tag.FieldData[0] = '' then Info.Tag.FieldData[0] := Data;
end;

{ --------------------------------------------------------------------------- }

procedure TOggVorbis.ReadTag(ReadAdditionalTags: Boolean);
function JumpOverOggS(var tagEnd: Integer): Integer;	//returnerer næste OggS position
var
	OggH: OggHeader;
  i: Integer;
  tagEndReached: boolean;
begin
	tagEndReached := false;
	result := FSource.Position;
  FSource.Read(OggH, SizeOf(OggH));
  inc(result, OggH.Segments + 27);
  tagEnd := result;
  FSource.Seek(result, soFromBeginning);
  for i:=1 to OggH.Segments do
  begin
  	if not tagEndReached then
    	inc(tagEnd,OggH.LacingValues[i]);
    tagEndReached := tagEndReached or ((OggH.LacingValues[i] < $FF) and (i < OggH.Segments));
  	inc(result, OggH.LacingValues[i])
  end;
  inc(FInfo.VorbisTagPageCount)
end;
function ReadSize(var nextOggS, tagEnd: Integer): Integer;
var
	b, i: byte;
begin
  result := 0;
  for i:=0 to 3 do	//read 4 byte = integer
  begin
		if FSource.Position + 1 > nextOggS then
    	nextOggS := JumpOverOggS(tagEnd);
    FSource.Read(b, 1);
    result := result or b shl (i*8)
  end
end;
var
  Index, SizeLeft, SizeToRead, nextOggS, i, tagEnd: Integer;
  Data: array[1..250] of Char;
  DataStr: String;
  tagEndReached: boolean;
begin
  { Read Vorbis tag }
  FInfo.VorbisTagPageCount := 1;
  nextOggS := FInfo.SPagePos + 27 + FInfo.SPage.Segments;
  tagEnd := nextOggS;
  tagEndReached := false;
  for i:=1 to FInfo.SPage.Segments do
  begin
  	if not tagEndReached then
    	inc(tagEnd, FInfo.SPage.LacingValues[i]);
    tagEndReached := tagEndReached or ((FInfo.SPage.LacingValues[i] < $FF) and (i < FInfo.SPage.Segments));
  	inc(nextOggS, FInfo.SPage.LacingValues[i])
  end;

  Index := 0;
  repeat
    DataStr := '';
    FillChar(Data, SizeOf(Data), 0);
    //
		//Source.Read(Size, SizeOf(Size));
    SizeLeft := ReadSize(nextOggS, tagEnd);

    while SizeLeft > 0 do
    begin
    	if SizeLeft > SizeOf(Data) then
      	SizeToRead := SizeOf(Data)
      else
      	SizeToRead := SizeLeft;

      //Checker at vi ikke løber ind i en OggS page
	    if FSource.Position + SizeToRead > nextOggS then
      	SizeToRead := nextOggS - FSource.Position;

      FSource.Read(Data, SizeToRead);
      DataStr := DataStr + copy(Data, 1, SizeToRead);
      Dec(SizeLeft, SizeToRead);

      //Er vi løbet ind i en OggS?
      if FSource.Position = nextOggS then
      	nextOggS := JumpOverOggs(tagEnd)
    end;
    { Set Vorbis tag item }
		SetTagItem(DataStr, ReadAdditionalTags, FInfo);
		if Index = 0 then
    	FSource.Read(FInfo.Tag.Fields, SizeOf(FInfo.Tag.Fields));
    Inc(Index);
  until Index > FInfo.Tag.Fields;
  FInfo.TagEndPos := tagEnd;
  //nextOggS - tagEnd; //FSource.Position;
  FInfo.AdditionalVorbisHeaderLength := nextOggS - FInfo.TagEndPos;
end;

{ --------------------------------------------------------------------------- }

function GetSamples(const Source: TStream): Integer;
var
  Index, DataIndex, Iterator: Integer;
  Data: array [0..250] of Char;
  Header: OggHeader;
begin
	{ Get total number of samples }
  Result := 0;
  for Index := 1 to 50 do
  begin
    DataIndex := Source.Size - (SizeOf(Data) - 10) * Index - 10;
    Source.Seek(DataIndex, soFromBeginning);
    Source.Read(Data, SizeOf(Data));
    { Get number of PCM samples from last Ogg packet header }
    for Iterator := SizeOf(Data) - 10 downto 0 do
      if Data[Iterator] +
        Data[Iterator + 1] +
        Data[Iterator + 2] +
        Data[Iterator + 3] = OGG_PAGE_ID then
      begin
        Source.Seek(DataIndex + Iterator, soFromBeginning);
        Source.Read(Header, SizeOf(Header));
        Result := Header.AbsolutePosition;
        exit;
      end;
  end;
end;

{ --------------------------------------------------------------------------- }

function TOggVorbis.GetInfo(ReadAdditionalTags: Boolean): Boolean;
var
	StreamStart, SearchMax: Integer;	//bruges til at søge op til 512 bytes ind i filen efter OggS-strengen
begin
  { Get info from file }
  SearchMax := 512;
	Result := false;
  try
  	FInfo.ID3v2Size := GetID3v2Size(FSource);
    if FSource.Size < SearchMax then
    	SearchMax := FSource.Size
  except
  end;

	for StreamStart:=0 to SearchMax do
	try
		FInfo.FileSize := FSource.Size-StreamStart;
		FSource.Seek(StreamStart + FInfo.ID3v2Size, soFromBeginning);
    FSource.Read(FInfo.FPage, SizeOf(FInfo.FPage));

		if FInfo.FPage.ID = OGG_PAGE_ID then
    begin
      FSource.Seek(StreamStart + FInfo.ID3v2Size + FInfo.FPage.Segments + 27, soFromBeginning);
      { Read Vorbis parameter header }
      FSource.Read(FInfo.Parameters, SizeOf(FInfo.Parameters));
      if FInfo.Parameters.ID = VORBIS_PARAMETERS_ID then
      begin
        FInfo.SPagePos := FSource.Position;
        FSource.Read(FInfo.SPage, SizeOf(FInfo.SPage));
        FSource.Seek(FInfo.SPagePos + FInfo.SPage.Segments + 27, soFromBeginning);
        FSource.Read(FInfo.Tag.ID, SizeOf(FInfo.Tag.ID));
        { Read Vorbis tag }
        if FInfo.Tag.ID = VORBIS_TAG_ID then
        	ReadTag(ReadAdditionalTags);
        { Get total number of samples }
        FInfo.Samples := GetSamples(FSource);
        Result := true;
        break
      end
    end
	finally
  end;
end;

{ --------------------------------------------------------------------------- }

{function GetTrack(const TrackString: string): Byte;
var
	Index, Value, Code: Integer;
begin
	// Extract track from string
	Index := Pos('/', TrackString);
	if Index = 0 then Val(TrackString, Value, Code)
	else Val(Copy(TrackString, 1, Index), Value, Code);
	if Code = 0 then Result := Value
	else Result := 0;
end;                           }

{ --------------------------------------------------------------------------- }

function GetAddListKeyName(Input:String; var value: String):String;
begin
	Result := Copy(Input, 1, Pos('=', Input) - 1);
	value := Copy(Input, length(Result)+2, length(Input))
end;

{ -------------------------------------------------------------------------- }

function BuildTag(const Info: FileInfo): TStringStream;
var
	Index, Fields, Size: Integer;
	FieldData, FieldName: string;
  b: byte;
begin
	{ Build Vorbis tag }
	Result := TStringStream.Create('');
	Fields := Info.Tag.AdditionalTags.Count;
	for Index := 1 to VORBIS_FIELD_COUNT do 	
		if Info.Tag.FieldData[Index] <> '' then Inc(Fields);
	{ Write frame ID, vendor info and number of fields }
	Result.Write(Info.Tag.ID, SizeOf(Info.Tag.ID));  //#3vorbis
	Size := Length(Info.Tag.FieldData[0]);
	Result.Write(Size, SizeOf(Size));
	Result.WriteString(Info.Tag.FieldData[0]);
	Result.Write(Fields, SizeOf(Fields));
	{ Write tag fields }
	for Index := 1 to VORBIS_FIELD_COUNT do
		if Info.Tag.FieldData[Index] <> '' then
		begin
			FieldData := VORBIS_FIELD[Index] +
				'=' + EncodeUTF8(Info.Tag.FieldData[Index]);
			Size := Length(FieldData);
			Result.Write(Size, SizeOf(Size));
			Result.WriteString(FieldData);
		end;

	//skriver Add.tags
	for Index := 0 to Info.Tag.AdditionalTags.Count-1 do
	begin
		FieldName := GetAddListKeyName(Info.Tag.AdditionalTags.Strings[Index], FieldData);
		FieldData := FieldName +
			'=' + EncodeUTF8(FieldData);
		Size := Length(FieldData);
		Result.Write(Size, SizeOf(Size));
		Result.WriteString(FieldData)
	end;
  b := 1;
  result.Write(b, 1)
end;

{ --------------------------------------------------------------------------- }

{procedure SetLacingValues(var Info: FileInfo; const NewTagSize: Integer);
var
  Index, Position, Value: Integer;
  Buffer: array [1..$FF] of Byte;
begin
  // Set new lacing values for the second Ogg page
  Position := 1;
  Value := 0;
  for Index := Info.SPage.Segments downto 1 do
  begin
    if Info.SPage.LacingValues[Index] < $FF then
    begin
      Position := Index;
      Value := 0;
    end;
    Inc(Value, Info.SPage.LacingValues[Index]);
  end;

  Value := Value + NewTagSize -
    (Info.TagEndPos - Info.SPagePos - Info.SPage.Segments - 27);

  // Change lacing values at the beginning
  for Index := 1 to Value div $FF do
  	Buffer[Index] := $FF;
  Buffer[(Value div $FF) + 1] := Value mod $FF;

  if Position < Info.SPage.Segments then
    for Index := Position + 1 to Info.SPage.Segments do
      Buffer[Index - Position + (Value div $FF) + 1] :=
        Info.SPage.LacingValues[Index];

  Info.SPage.Segments := Info.SPage.Segments - Position + (Value div $FF) + 1;
  for Index := 1 to Info.SPage.Segments do
    Info.SPage.LacingValues[Index] := Buffer[Index];
end;
}
{ --------------------------------------------------------------------------- }

{procedure CalculateCRC(var CRC: Cardinal; const Data; Size: Cardinal);
var
  Index: Cardinal;
  Buffer: array [0..SizeOf(Data)] of Byte absolute Data;
begin
  // Calculate CRC through data
  if Size > 0 then	//Ellers giver den cardinal-overflow
	  for Index := 0 to Size - 1 do
	    CRC := (CRC shl 8) xor CRC_TABLE[((CRC shr 24) and $FF) xor Buffer[Index]];
end;
          }
{ --------------------------------------------------------------------------- }


{procedure SetCRC(const Destination: TStream; Info: FileInfo);
var
  Index: Integer;
  Value: Cardinal;
  Data: array [1..$FF] of Byte;
begin
  // Calculate and set checksum for Vorbis tag
  Value := 0;
  CalculateCRC(Value, Info.SPage, Info.SPage.Segments + 27);
  Destination.Seek(Info.SPagePos + Info.SPage.Segments + 27, soFromBeginning);
  for Index := 1 to Info.SPage.Segments do
    if Info.SPage.LacingValues[Index] > 0 then
    begin
      Destination.Read(Data, Info.SPage.LacingValues[Index]);
      CalculateCRC(Value, Data, Info.SPage.LacingValues[Index]);
    end;
  Destination.Seek(Info.SPagePos + 22, soFromBeginning);
  Destination.Write(Value, SizeOf(Value));
end;   }

{ --------------------------------------------------------------------------- }

function BuildOggTagPages(Tag, outStr: TStream; Info: FileInfo): boolean;	//error code
var
	i, zero, pageNo, bytesPrPage, bytesToWrite, CRCfrom, CRCto, tagSizeLeft: Integer;
  crc: Cardinal;
  b, pageSegments: Byte;
  segmentTable: array[0..255] of byte;
begin
	zero := 0;
  tag.Position := 0;
	bytesPrPage := (tag.Size div Info.VorbisTagPageCount)+1;

  if bytesPrPage > 65024 then
  begin
  	result := false;
    exit
  end;

  for pageNo:=1 to Info.VorbisTagPageCount do
  begin
    CRCfrom := outStr.Position;
		outStr.Write(Info.SPage, 5);
    if pageNo = 1 then
    	b := 0
    else
    	b := 1;
    outStr.Write(b, sizeOf(b));
    outStr.Write(Info.SPage.AbsolutePosition, SizeOf(Info.SPage.AbsolutePosition));
    outStr.Write(Info.SPage.Serial, SizeOf(Info.SPage.Serial));
    outStr.Write(pageNo, 4);
    outStr.Write(zero, 4); // CRC32

    if (tag.Size - tag.Position < bytesPrPage) or (Info.VorbisTagPageCount = pageNo) then
    	bytesToWrite := tag.Size - tag.Position
    else
    	bytesToWrite := bytesPrPage;

		tagSizeLeft := tag.Size - Info.AdditionalVorbisHeaderLength - tag.Position;

    pageSegments := 0;
    if (tagSizeLeft > 0) and (tagSizeLeft < bytesToWrite) then     //tag slutter i denne Ogg-page
    begin
    	i := tagSizeLeft;
    	while i > 0 do
      begin
        inc(pageSegments);
        if i = 255 then
          segmentTable[pageSegments-1] := 254
        else
        if i > 255 then
          segmentTable[pageSegments-1] := 255
        else
          segmentTable[pageSegments-1] := i;
        dec(i, segmentTable[pageSegments-1])
      end;
      i := bytesToWrite - tagSizeLeft
  	end
    else
    	i := bytesToWrite;

    while i > 0 do
    begin
      inc(pageSegments);
      if Info.VorbisTagPageCount = pageNo then
      begin
        if i > 255 then
          segmentTable[pageSegments-1] := 255
        else
          segmentTable[pageSegments-1] := i
      end
      else
      begin
        if i >= 255 then
          segmentTable[pageSegments-1] := 255
        else
        begin	//de resterende bytes der skal skrives overføres til næste ogg page
          dec(pageSegments);
          dec(bytesToWrite, i);
          break
        end
      end;
      dec(i, segmentTable[pageSegments-1])
    end;

    outStr.Write(pageSegments, 1);
    outStr.Write(segmentTable, pageSegments);

    if bytesToWrite > 0 then
	    outStr.CopyFrom(tag, bytesToWrite);

    CRCto := outStr.Position;

    //beregner CRC
    crc := 0;
    outStr.Position := CRCfrom;
    while outStr.Position < CRCto do
    begin
      outStr.Read(b, 1);
    	CRC := (CRC shl 8) xor CRC_TABLE[((CRC shr 24) and $FF) xor b]
    end;
    outStr.Position := CRCfrom + 22;
    outStr.Write(crc, 4);
    outStr.Position := CRCto
  end;
  result := true
end;

function RebuildFile(Source: TStream; Tag: TStream; Info: FileInfo): Boolean;
function min(i1, i2: Integer): Integer;
begin
	if i1 < i2 then
  	result := i1
  else
  	result := i2
end;
var
	EncodedTag: TStream;
  NewStreamSize, transferred, delta, transfer, floor, position: Integer;
  buffer: array[1..262144] of Byte;	// 1/4 mb = 262144 bytes
begin
	{ Rebuild the file with the new Vorbis tag }
  Result := false;
  try
		{ Copy data blocks }
    Source.Seek(Info.TagEndPos, soFromBeginning);
    if info.AdditionalVorbisHeaderLength > 0 then
    begin
    	tag.Position := tag.Size;
      tag.CopyFrom(source, info.AdditionalVorbisHeaderLength)
    end;

    EncodedTag := TMemoryStream.Create;
    Source.Position := 0;
    EncodedTag.CopyFrom(Source, Info.SPagePos);		//Alt indtil second OggS er nu kopieret til Destination
    if not BuildOggTagPages(tag, EncodedTag, Info) then
    begin
    	EncodedTag.Free;
      result := false;
      exit
    end;

    Source.Seek(Info.TagEndPos + Info.AdditionalVorbisHeaderLength, soFromBeginning);
    NewStreamSize := Source.Size - Source.Position + EncodedTag.Size;

    // Move the data stream
    delta := NewStreamSize - Source.Size;
		if delta > 0 then
    begin	//make file bigger
    	Source.Size := NewStreamSize;
      Source.Position := Source.Size - delta;
      Floor := Source.Size;
      while source.Position > 0 do
      begin
      	transfer := min(Source.Position, SizeOf(buffer));
        Source.Seek(-transfer, soFromCurrent);
        position := Source.Position;
        transferred := Source.Read(buffer, transfer);
        Source.Position := Floor - transferred;
        Floor := Source.Position;
        Source.Write(buffer, transferred);
        Source.Position := position
      end
    end
    else
    if delta < 0 then
    begin	//make file smaller
    	Source.Position := -delta;
    	Floor := 0;
    	while Source.Position < Source.Size do
      begin
      	transfer := min(Source.Size - Source.Position, SizeOf(buffer));
        transferred := Source.Read(buffer, transfer);
        position := Source.Position;
        Source.Position := Floor;
        Source.Write(buffer, transferred);
        Floor := Source.Position;
        Source.Position := position
      end;
      Source.Size := NewStreamSize
    end;

    Source.Position := 0;
    Source.CopyFrom(EncodedTag, 0);
    EncodedTag.Free;
    result := true
  except
  	result := false
	end
end;

{ ********************** Private functions & procedures ********************* }

procedure TOggVorbis.FResetData;
begin
  { Reset variables }
  FFileSize := 0;
  FChannelModeID := 0;
  FSampleRate := 0;
  FBitRateNominal := 0;
  FSamples := 0;
  FID3v2Size := 0;
	FTitle := '';
	FArtist := '';
	FAlbum := '';
	FTrack := '';
	FDate := '';
	FGenre := '';
	FComment := '';
	FVendor := '';
//	FPerformer := '';
//	FDescription := '';
	FCopyright := '';
	FLyrics := '';
	Fversion := '';
  FillChar(FInfo, SizeOf(FInfo), 0);
end;

{ --------------------------------------------------------------------------- }

function TOggVorbis.FGetChannelMode: string;
begin
  { Get channel mode name }
  Result := VORBIS_MODE[FChannelModeID];
end;

{ --------------------------------------------------------------------------- }

function TOggVorbis.FGetDuration: Double;
begin
  { Calculate duration time }
  if FSamples > 0 then
    if FSampleRate > 0 then
      Result := FSamples / FSampleRate
    else
      Result := 0
  else
		if (FBitRateNominal > 0) and (FChannelModeID > 0) then
      Result := (FFileSize - FID3v2Size) /
        FBitRateNominal / FChannelModeID / 125 * 2
    else
      Result := 0;
end;

{ --------------------------------------------------------------------------- }

function TOggVorbis.FGetBitRate: Word;
begin
  { Calculate average bit rate }
  Result := 0;
  if FGetDuration > 0 then
    Result := Round((FFileSize - FID3v2Size) / FGetDuration / 125);
end;

{ --------------------------------------------------------------------------- }

function TOggVorbis.FHasID3v2: Boolean;
begin
  { Check for ID3v2 tag }
  Result := FID3v2Size > 0;
end;

{ --------------------------------------------------------------------------- }

function TOggVorbis.FIsValid: Boolean;
begin
  { Check for file correctness }
	Result := (FChannelModeID in [VORBIS_CM_MONO, VORBIS_CM_STEREO]) and
    (FSampleRate > 0) and (FGetDuration > 0.1) and (FGetBitRate > 0);
end;

{ ********************** Public functions & procedures ********************** }

constructor TOggVorbis.Create;
begin
	{ Object constructor }
	FAdditionalTags := TStringlist.Create;
	FResetData;
  inherited;
end;

{ --------------------------------------------------------------------------- }

destructor TOggVorbis.Destroy;
begin
	{ Object destructor }
	FAdditionalTags.free;
	inherited;
end;

{ --------------------------------------------------------------------------- }

procedure TOggVorbis.AddKeyToAddList(key: String; value: String);
begin
	FAdditionalTags.Add(AnsiUppercase(key) + '=' + value)
end;

procedure TOggVorbis.DeleteFromAddlist(index: Integer);
begin
	FAdditionalTags.Delete(index);
end;

{ --------------------------------------------------------------------------- }

function TOggVorbis.GetKeyIndex(const key: String): integer;
var
	i: Integer;
begin
	result := -1;

	for i:=0 to FAdditionalTags.Count-1 do
  	if Q_SameText(key, Copy(FAdditionalTags.Strings[i], 1, Pos('=', FAdditionalTags.Strings[i]) - 1)) then
    begin
    	result := i;
      break;
    end;
end;

function TOggVorbis.GetAddListKeyName(Input:String; var value: String):String;
begin
	Result := Copy(Input, 1, Pos('=', Input) - 1);
	value := Copy(Input, length(Result)+2, length(Input))
end;

function TOggVorbis.GetAddListKeyName(index: integer; var value: String):String;
begin
	result := GetAddListKeyName(FAdditionalTags.Strings[index], value);
end;

{ --------------------------------------------------------------------------- }

{function TOggVorbis.ReadFromFile(const FileName: string): Boolean;
begin
	{ Read data from file }
 {	Result := false;
	Fsource := nil;
	try
		FSource := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
		FResetData;
		FillChar(Info, SizeOf(Info), 0);
		FAdditionalTags.Clear;
		Info.Tag.AdditionalTags := FAdditionalTags;
		if GetInfo(true) then
		begin
			{ Fill variables }
	{		FFileSize := Info.FileSize;
			FChannelModeID := Info.Parameters.ChannelMode;
			FSampleRate := Info.Parameters.SampleRate;
			FBitRateNominal := Round(Info.Parameters.BitRateNominal / 1000);
			FSamples := Info.Samples;
			FID3v2Size := Info.ID3v2Size;
			FTitle := Info.Tag.FieldData[1];
			if Info.Tag.FieldData[2] <> '' then FArtist := Info.Tag.FieldData[2]
			else FArtist := Info.Tag.FieldData[8];
			FAlbum := Info.Tag.FieldData[3];
			FTrack := GetTrack(Info.Tag.FieldData[4]);
			FDate := Info.Tag.FieldData[5];
			FGenre := Info.Tag.FieldData[6];
			if Info.Tag.FieldData[7] <> '' then FComment := Info.Tag.FieldData[7]
			else FComment := Info.Tag.FieldData[9];
			FVendor := Info.Tag.FieldData[0];

			//nye by AT:
			FCopyright := Info.Tag.FieldData[10];
			FLyrics := Info.Tag.FieldData[11];
			FVersion := Info.Tag.FieldData[12];

			Result := true;
		end
		finally
			if assigned(Source) then
				Source.free
		end;
end;    }

{ --------------------------------------------------------------------------- }

function TOggVorbis.ReadFromStream(const FStr: TStream): Boolean;
begin
	{ Read data from file }
	Result := false;
	FResetData;
	FAdditionalTags.Clear;
	FInfo.Tag.AdditionalTags := FAdditionalTags;
  FSource := FStr;
	if GetInfo(true) then
	begin
		{ Fill variables }
		FFileSize := FInfo.FileSize;
		FChannelModeID := FInfo.Parameters.ChannelMode;
		FSampleRate := FInfo.Parameters.SampleRate;
		FBitRateNominal := Round(FInfo.Parameters.BitRateNominal / 1000);
		FSamples := FInfo.Samples;
		FID3v2Size := FInfo.ID3v2Size;
    FTitle := FInfo.Tag.FieldData[1];
		if FInfo.Tag.FieldData[2] <> '' then FArtist := FInfo.Tag.FieldData[2]
    else FArtist := FInfo.Tag.FieldData[8];
		FAlbum := FInfo.Tag.FieldData[3];
		FTrack := FInfo.Tag.FieldData[4];
		FDate := FInfo.Tag.FieldData[5];
		FGenre := FInfo.Tag.FieldData[6];
		if FInfo.Tag.FieldData[7] <> '' then FComment := FInfo.Tag.FieldData[7]
		else FComment := FInfo.Tag.FieldData[9];
		FVendor := FInfo.Tag.FieldData[0];

		FCopyright := FInfo.Tag.FieldData[10];
		FLyrics := FInfo.Tag.FieldData[11];
		FVersion := FInfo.Tag.FieldData[12];

    Result := true;
	end;
end;

{ --------------------------------------------------------------------------- }

function TOggVorbis.SaveTag: Boolean;
var
	Tag, Str:TStream;
begin
  { Save Vorbis tag }
	Result := false;
	FInfo.Tag.AdditionalTags := FAdditionalTags;

  { Prepare tag data and save to file }
  FInfo.Tag.FieldData[1] := Trim(FTitle);
  FInfo.Tag.FieldData[2] := Trim(FArtist);
  FInfo.Tag.FieldData[3] := Trim(FAlbum);
  FInfo.Tag.FieldData[4] := Trim(FTrack);

  FInfo.Tag.FieldData[5] := Trim(FDate);
  FInfo.Tag.FieldData[6] := Trim(FGenre);
  FInfo.Tag.FieldData[7] := Trim(FComment);
  FInfo.Tag.FieldData[8] := '';
  FInfo.Tag.FieldData[9] := '';

  //nye by AT:
  FInfo.Tag.FieldData[10] := FCopyright;
  FInfo.Tag.FieldData[11] := FLyrics;
  FInfo.Tag.FieldData[12] := FVersion;

  Tag := BuildTag(FInfo);
  Result := RebuildFile(FSource, Tag, FInfo);
  Tag.Free;

  Str := FSource;
  ReadFromStream(Str)
end;

{ --------------------------------------------------------------------------- }

function TOggVorbis.ClearTag: Boolean;
begin
  { Clear Vorbis tag }
  FTitle := '';
  FArtist := '';
	FAlbum := '';
  FTrack := '';
	FDate := '';
	FGenre := '';
	FComment := '';
	FCopyright := '';
	FLyrics := '';
	FVersion := '';

	FAdditionalTags.Clear;
	Result := SaveTag;
end;

end.

