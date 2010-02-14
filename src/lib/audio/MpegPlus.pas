{ *************************************************************************** }
{                                                                             }
{ Audio Tools Library (Freeware)                                              }
{ Class TMPEGplus - for manipulating with MPEGplus file information           }
{                                                                             }
{ Uses:                                                                       }
{   - Class TID3v1                                                            }
{                                                                             }
{ Copyright (c) 2001,2002 by Jurgen Faul                                      }
{ E-mail: jfaul@gmx.de                                                        }
{ http://jfaul.de/atl                                                         }
{                                                                             }
{ Version 1.3 (8 February 2002)                                               }
{   - Fixed bug with property Corrupted                                       }
{                                                                             }
{ Version 1.2 (2 August 2001)                                                 }
{   - Class TID3v1: reading & writing support for ID3v1.x tags                }
{   - Some class properties added/changed                                     }
{                                                                             }
{ Version 1.1 (26 July 2001)                                                  }
{   - Fixed reading problem by "read only" files                              }
{                                                                             }
{ Version 1.0 (23 May 2001)                                                   }
{   - Support for MPEGplus files (stream versions 4-7)                        }
{   - ID3v1.1 tag supported (read only)                                       }
{                                                                             }
{ *************************************************************************** }

unit MPEGplus;

interface

uses
  Classes, SysUtils;

const
  { Used with ChannelModeID property }
  MPP_CM_STEREO = 1;                                  { Index for stereo mode }
  MPP_CM_JOINT_STEREO = 2;                      { Index for joint-stereo mode }

  { Channel mode names }
  MPP_MODE: array [0..2] of string = ('Unknown', 'Stereo', 'Joint Stereo');

  { Used with ProfileID property }
  MPP_PROFILE_TELEPHONE = 0;
  MPP_PROFILE_THUMB = 1;                             { 'Thumb' (poor) quality }
  MPP_PROFILE_RADIO = 2;                           { 'Radio' (normal) quality }
  MPP_PROFILE_STANDARD = 3;                       { 'Standard' (good) quality }
  MPP_PROFILE_XTREME = 4;                      { 'Xtreme' (very good) quality }
  MPP_PROFILE_INSANE = 5;                      { 'Insane' (excellent) quality }
  MPP_PROFILE_BRAINDEAD = 6;

  { Profile names }
  MPP_PROFILE: array [-1..6] of string =
    ('Unknown', 'Telephone', 'Thumb', 'Radio', 'Standard', 'Xtreme', 'Insane', 'Braindead');

type
  { Class TMPEGplus }
  TMPEGplus = class(TObject)
    private
      { Private declarations }
      FValid: Boolean;
      FChannelModeID: Byte;
      FFileSize: Cardinal;
      FFrameCount: Cardinal;
      FHasId3v1: Boolean;
      FBitRate: Word;
      FStreamVersion: Byte;
      FProfileID: Byte;
//      FTag: TID3v1;
      procedure FResetData;
      function FGetChannelMode: string;
      function FGetBitRate: Word;
      function FGetProfile: string;
      function FGetDuration: Double;
      function FIsCorrupted: Boolean;
    public
      { Public declarations }
      constructor Create;                                     { Create object }
      destructor Destroy; override;                          { Destroy object }
			function ReadFromFile(const FileName: string; HasId3v1: boolean; StartPos: Integer): Boolean;   { Load header }
			function ReadFromStream(const Fstr: TStream;  HasId3v1: boolean; StartPos:Integer): Boolean;
      property Valid: Boolean read FValid;             { True if header valid }
      property ChannelModeID: Byte read FChannelModeID;   { Channel mode code }
      property ChannelMode: string read FGetChannelMode;  { Channel mode name }
      property FileSize: Cardinal read FFileSize;         { File size (bytes) }
      property FrameCount: Cardinal read FFrameCount;      { Number of frames }
      property BitRate: Word read FGetBitRate;                     { Bit rate }
      property StreamVersion: Byte read FStreamVersion;      { Stream version }
      property ProfileID: Byte read FProfileID;                { Profile code }
      property Profile: string read FGetProfile;               { Profile name }
//      property Tag: TID3v1 read FTag;                              { File tag }
      property Duration: Double read FGetDuration;       { Duration (seconds) }
      property Corrupted: Boolean read FIsCorrupted; { True if file corrupted }
  end;

implementation

type
  { File header data - for internal use }
  HeaderRecord = record
    ByteArray: array [1..12] of Byte;                    { Data as byte array }
    IntegerArray: array [1..3] of Integer;            { Data as integer array }
    FileSize: Integer;                                            { File size }
  end;

{ ********************* Auxiliary functions & procedures ******************** }

function ReadHeaderFromStream(const Fstr: Tstream; var Header: HeaderRecord): Boolean;
var
   Transferred: Integer;
   Fsize:integer;
begin
  try
    Result := true;
    Fsize := Fstr.Size - Fstr.Position;
    Transferred := Fstr.Read(Header, 12);
    { Read header and get file size }
    Header.FileSize := Fsize;
    { if transfer is not complete }
    if Transferred < 12 then Result := false
    else Move(Header.ByteArray, Header.IntegerArray, SizeOf(Header.ByteArray));
  except
    { Error }
    Result := false;
  end;
end;

{function ReadHeader(const FileName: string; var Header: HeaderRecord): Boolean;
var
  SourceFile: file;
  Transferred: Integer;
begin
  try
    Result := true;
    { Set read-access and open file }
{    AssignFile(SourceFile, FileName);
    FileMode := 0;
    Reset(SourceFile, 1);
    { Read header and get file size }
{    BlockRead(SourceFile, Header, 12, Transferred);
    Header.FileSize := FileSize(SourceFile);
    CloseFile(SourceFile);
    { if transfer is not complete }
{    if Transferred < 12 then Result := false
    else Move(Header.ByteArray, Header.IntegerArray, SizeOf(Header.ByteArray));
  except
    { Error }
 {   Result := false;
  end;
end;   }

{ --------------------------------------------------------------------------- }

function GetStreamVersion(const Header: HeaderRecord): Byte;
begin
  { Get MPEGplus stream version }
  if (Header.IntegerArray[1] = 120279117) or (Header.IntegerArray[1] = 388714573) then         { 120279117 = 'MP+' + #7 | 388714573 = 'MP+' #71 (= 7.1)}
    Result := 7
  else
    case (Header.ByteArray[2] mod 32) div 2 of
      3: Result := 4;
      7: Result := 5;
      11: Result := 6
      else Result := 0;
    end;
end;

{ --------------------------------------------------------------------------- }

function GetChannelModeID(const Header: HeaderRecord): Byte;
begin
  if GetStreamVersion(Header) = 7 then
    { Get channel mode for stream version 7 }
    if (Header.ByteArray[12] mod 128) < 64 then Result := MPP_CM_STEREO
    else Result := MPP_CM_JOINT_STEREO
  else
    { Get channel mode for stream version 4-6 }
    if (Header.ByteArray[3] mod 128) = 0 then Result := MPP_CM_STEREO
    else Result := MPP_CM_JOINT_STEREO;
end;

{ --------------------------------------------------------------------------- }

function GetFrameCount(const Header: HeaderRecord): Cardinal;
begin
  { Get frame count }
  case GetStreamVersion(Header) of
    4: Result := Header.IntegerArray[2] shr 16;
    5..7: Result := Header.IntegerArray[2];
    else Result := 0;
  end;
end;

{ --------------------------------------------------------------------------- }

function GetBitRate(const Header: HeaderRecord): Word;
begin
  { Try to get bit rate }
  case GetStreamVersion(Header) of
    4, 5: Result := Header.IntegerArray[1] shr 23;
    else Result := 0;
  end;
end;

{ --------------------------------------------------------------------------- }

function GetProfileID(const Header: HeaderRecord): Byte;
begin
  Result := 0;
  { Get MPEGplus profile (exists for stream version 7 only) }
  if GetStreamVersion(Header) = 7 then
    case Header.ByteArray[11] of
      112: Result := MPP_PROFILE_TELEPHONE;
      128: Result := MPP_PROFILE_THUMB;
      144: Result := MPP_PROFILE_RADIO;
      160: Result := MPP_PROFILE_STANDARD;
      176: Result := MPP_PROFILE_XTREME;
      192: Result := MPP_PROFILE_INSANE;
      208: Result := MPP_PROFILE_BRAINDEAD
    end
    else
    	Result := 0
end;

{ ********************** Private functions & procedures ********************* }

procedure TMPEGplus.FResetData;
begin
  FValid := false;
  FChannelModeID := 0;
  FFileSize := 0;
  FFrameCount := 0;
  FBitRate := 0;
  FStreamVersion := 0;
  FProfileID := 0;
//  FTag.ResetData;
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FGetChannelMode: string;
begin
  Result := MPP_MODE[FChannelModeID];
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FGetBitRate: Word;
begin
  Result := FBitRate;
  { Calculate bit rate if not given }
  if (Result = 0) and (FFrameCount > 0) then
    if FhasId3v1 then
      Result := Round((FFileSize - 128) * 8 * 44.1 / FFRameCount / 1152)
    else
      Result := Round(FFileSize * 8 * 44.1 / FFRameCount / 1152);
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FGetProfile: string;
begin
	if (FProfileID >= -1) and (FProfileID < 6) then
  	Result := MPP_PROFILE[FProfileID]
  else
  	result := MPP_Profile[-1]
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FGetDuration: Double;
begin
  { Calculate duration time }
  Result := FFRameCount * 1152 / 44100;
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.FIsCorrupted: Boolean;
begin
  { Check for file corruption }
  Result := (FValid) and ((FGetBitRate < 16) or (FGetBitRate > 480));
end;

{ ********************** Public functions & procedures ********************** }

constructor TMPEGplus.Create;
begin
  inherited;
  FResetData;
end;

{ --------------------------------------------------------------------------- }

destructor TMPEGplus.Destroy;
begin
//  FTag.Free;
  inherited;
end;

{ --------------------------------------------------------------------------- }

function TMPEGplus.ReadFromFile(const FileName: string; HasId3v1:boolean; StartPos: Integer): Boolean;
var
	FStr : TStream;
begin
	try
		Fstr := TFileStream.Create(FileName, fmOpenRead	or fmShareDenyWrite);
		result := ReadFromStream(Fstr, HasId3v1, StartPos);
		Fstr.free
	except
		result := false
	end
end;

function TMPEGplus.ReadFromStream(const Fstr: TStream; HasId3v1:boolean; StartPos:Integer): Boolean;
//husk, at Fstr.position er der hvor mpgframes starter!
var
  Header: HeaderRecord;
begin
	{ Reset data and load header from file to variable }
	FStr.Position := StartPos;
  FResetData;
  Result := ReadHeaderFromStream(Fstr, Header);
  { Process data if loaded and file valid }
  if (Result) and (Header.FileSize > 0) and (GetStreamVersion(Header) > 0) then
  begin
    FhasId3v1 := HasId3v1;
    FValid := true;
    { Fill properties with header data }
    FChannelModeID := GetChannelModeID(Header);
    FFileSize := Header.FileSize;
    FFrameCount := GetFrameCount(Header);
    FBitRate := GetBitRate(Header);
    FStreamVersion := GetStreamVersion(Header);
    FProfileID := GetProfileID(Header);
//    FTag.ReadFromFile(FileName);
  end;
end;

end.
