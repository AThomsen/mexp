{ *************************************************************************** }
{                                                                             }
{ Audio Tools Library (Freeware)                                              }
{ Class TMPEGaudio - for manipulating with MPEG audio file information        }
{                                                                             }
{ Uses:                                                                       }
{   - Class TID3v1                                                            }
{   - Class TID3v2                                                            }
{                                                                             }
{ Copyright (c) 2001 by Jurgen Faul                                           }
{ E-mail: jfaul@gmx.de                                                        }
{ http://jfaul.de/atl                                                         }
{                                                                             }
{ Version 1.1 (11 September 2001)                                             }
{   - Improved encoder guessing for CBR files                                 }
{                                                                             }
{ Version 1.0 (31 August 2001)                                                }
{   - Support for MPEG audio (versions 1, 2, 2.5, layers I, II, III)          }
{   - Support for Xing & FhG VBR                                              }
{   - Ability to guess audio encoder (Xing, FhG, LAME, Blade, GoGo, Shine)    }
{   - Class TID3v1: reading & writing support for ID3v1.x tags                }
{   - Class TID3v2: reading support for ID3v2.3.x tags                        }
{                                                                             }
{ *************************************************************************** }

unit MPEGaudio;

interface

uses
  Classes, SysUtils, math, QStrings, MyMemorystream;

const
  { Table for bit rates }
  MPEG_BIT_RATE: array [0..3, 0..3, 0..15] of Word =
    (
    { For MPEG 2.5 }
    ((0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, 0),
    (0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, 0),
    (0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256, 0)),
    { Reserved }
    ((0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)),
    { For MPEG 2 }
    ((0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, 0),
    (0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, 0),
    (0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256, 0)),
    { For MPEG 1 }
    ((0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 0),
    (0, 32, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 384, 0),
    (0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 0))
    );

  { Sample rate codes }
  MPEG_SAMPLE_RATE_LEVEL_3 = 0;                                     { Level 3 }
  MPEG_SAMPLE_RATE_LEVEL_2 = 1;                                     { Level 2 }
  MPEG_SAMPLE_RATE_LEVEL_1 = 2;                                     { Level 1 }
  MPEG_SAMPLE_RATE_UNKNOWN = 3;                               { Unknown value }

  { Table for sample rates }
  MPEG_SAMPLE_RATE: array [0..3, 0..3] of Word =
    (
    (11025, 12000, 8000, 0),                                   { For MPEG 2.5 }
    (0, 0, 0, 0),                                                  { Reserved }
    (22050, 24000, 16000, 0),                                    { For MPEG 2 }
    (44100, 48000, 32000, 0)                                     { For MPEG 1 }
    );

  { VBR header ID for Xing/FhG }
  VBR_ID_XING = 'Xing';                                         { Xing VBR ID }
  VBR_ID_FHG = 'VBRI';                                           { FhG VBR ID }

  { MPEG version codes }
  MPEG_VERSION_2_5 = 0;                                            { MPEG 2.5 }
  MPEG_VERSION_UNKNOWN = 1;                                 { Unknown version }
  MPEG_VERSION_2 = 2;                                                { MPEG 2 }
  MPEG_VERSION_1 = 3;                                                { MPEG 1 }

  { MPEG version names }
  MPEG_VERSION: array [0..3] of string =
    ('MPEG 2.5', 'MPEG ?', 'MPEG 2', 'MPEG 1');

  { MPEG layer codes }
  MPEG_LAYER_UNKNOWN = 0;                                     { Unknown layer }
  MPEG_LAYER_III = 1;                                             { Layer III }
  MPEG_LAYER_II = 2;                                               { Layer II }
  MPEG_LAYER_I = 3;                                                 { Layer I }

  { MPEG layer names }
  MPEG_LAYER: array [0..3] of string =
    ('Layer ?', 'Layer III', 'Layer II', 'Layer I');

  { Channel mode codes }
  MPEG_CM_STEREO = 0;                                                { Stereo }
  MPEG_CM_JOINT_STEREO = 1;                                    { Joint Stereo }
  MPEG_CM_DUAL_CHANNEL = 2;                                    { Dual Channel }
  MPEG_CM_MONO = 3;                                                    { Mono }
  MPEG_CM_UNKNOWN = 4;                                         { Unknown mode }

  { Channel mode names }
  MPEG_CM_MODE: array [0..4] of string =
    ('Stereo', 'Joint Stereo', 'Dual Channel', 'Mono', 'Unknown');

  { Extension mode codes (for Joint Stereo) }
  MPEG_CM_EXTENSION_OFF = 0;                        { IS and MS modes set off }
  MPEG_CM_EXTENSION_IS = 1;                             { Only IS mode set on }
  MPEG_CM_EXTENSION_MS = 2;                             { Only MS mode set on }
  MPEG_CM_EXTENSION_ON = 3;                          { IS and MS modes set on }
  MPEG_CM_EXTENSION_UNKNOWN = 4;                     { Unknown extension mode }

  { Emphasis mode codes }
  MPEG_EMPHASIS_NONE = 0;                                              { None }
  MPEG_EMPHASIS_5015 = 1;                                          { 50/15 ms }
  MPEG_EMPHASIS_UNKNOWN = 2;                               { Unknown emphasis }
  MPEG_EMPHASIS_CCIT = 3;                                         { CCIT J.17 }

  { Emphasis names }
  MPEG_EMPHASIS: array [0..3] of string =
    ('None', '50/15 ms', 'Unknown', 'CCIT J.17');

  { Encoder codes }
  MPEG_ENCODER_UNKNOWN = 0;                                 { Unknown encoder }
  MPEG_ENCODER_XING = 1;                                               { Xing }
  MPEG_ENCODER_FHG = 2;                                                 { FhG }
  MPEG_ENCODER_LAME = 3;                                               { LAME }
  MPEG_ENCODER_BLADE = 4;                                             { Blade }
  MPEG_ENCODER_GOGO = 5;                                               { GoGo }
  MPEG_ENCODER_SHINE = 6;                                             { Shine }

  { Encoder names }
  MPEG_ENCODER: array [0..6] of string =
    ('Unknown', 'Xing', 'FhG', 'LAME', 'Blade', 'GoGo', 'Shine');

type
  { Xing/FhG VBR header data }
  VBRData = record
    Found: Boolean;                                { True if VBR header found }
    ID: array [1..4] of Char;                   { Header ID: "Xing" or "VBRI" }
    Frames: Integer;                                 { Total number of frames }
    Bytes: Integer;                                   { Total number of bytes }
    Scale: Byte;                                         { VBR scale (1..100) }
    VendorID: string;                                { Vendor ID (if present) }
    InvalidHeader: Boolean;                         { Need to scan all frames }
    CanWriteNewVBR:boolean;
    Flags : byte;
  end;

  { MPEG frame header data}
  FrameData = record
    Found: Boolean;                                     { True if frame found }
    Position: Integer;                           { Frame position in the file }
    Size: Word;                                          { Frame size (bytes) }
    Xing: Boolean;                                     { True if Xing encoder }
    Data: array [1..4] of Byte;                 { The whole frame header data }
    VersionID: Byte;                                        { MPEG version ID }
    LayerID: Byte;                                            { MPEG layer ID }
    ProtectionBit: Boolean;                        { True if protected by CRC }
    BitRateID: Word;                                            { Bit rate ID }
    SampleRateID: Word;                                      { Sample rate ID }
    PaddingBit: Boolean;                               { True if frame padded }
    PrivateBit: Boolean;                                  { Extra information }
    ModeID: Byte;                                           { Channel mode ID }
    ModeExtensionID: Byte;             { Mode extension ID (for Joint Stereo) }
    CopyrightBit: Boolean;                        { True if audio copyrighted }
    OriginalBit: Boolean;                            { True if original media }
    EmphasisID: Byte;                                           { Emphasis ID }
  end;

  { Class TMPEGaudio }
  TMPEGaudio = class(TObject)
    private
      { Private declarations }
      FFileLength: Integer;
      FStartPos : integer;
      Fid3v1Size : integer;
      FVendorID: string;
      FVBR: VBRData;
      FFrame: FrameData;
//      FID3v1: TID3v1;
//      FID3v2: TID3v2;
      FCalculatedBitrate : Word;
      FCalculatedDuration : Cardinal;
      FFirstFramePos : integer;
      //VBR ting
      procedure FResetData;
      function FGetVersion: string;
      function FGetLayer: string;
      function FGetBitRate: Word;
      function FGetSampleRate: Word;
      function FGetChannelMode: string;
      function FGetEmphasis: string;
      function FGetFrames: Integer;
      function FGetDuration: Cardinal;
      function FGetVBREncoderID: Byte;
      function FGetCBREncoderID: Byte;
      function FGetEncoderID: Byte;
      function FGetEncoder: string;
      function FGetValid: Boolean;
      function IsVBRnoHeader(Fstr: TStream; var ReturnBitrate:Integer) :Boolean;
    public
      { Public declarations }
      constructor Create;                                     { Create object }
      destructor Destroy; override;                          { Destroy object }
      function AddNewVBRtoStream(Fstr:TStream):boolean;
      function ReadFromFile(const FileName: string; startPos:integer; HasV1:boolean): Boolean;     { Load data }
      function ReadFromStream(const Fstr: TStream; StartPos:integer; HasV1:boolean; copyToMemWhenScanningEntire:boolean=false): Boolean;       {Load data }
      property FileLength: Integer read FFileLength;    { File length (bytes) }
      property VBR: VBRData read FVBR;                      { VBR header data }
      property Frame: FrameData read FFrame;              { Frame header data }
//      property ID3v1: TID3v1 read FID3v1;                    { ID3v1 tag data }
//      property ID3v2: TID3v2 read FID3v2;                    { ID3v2 tag data }
      property Version: string read FGetVersion;          { MPEG version name }
      property Layer: string read FGetLayer;                { MPEG layer name }
      property BitRate: Word read FGetBitRate;            { Bit rate (kbit/s) }
      property SampleRate: Word read FGetSampleRate;       { Sample rate (hz) }
      property ChannelMode: string read FGetChannelMode;  { Channel mode name }
      property Emphasis: string read FGetEmphasis;            { Emphasis name }
      property Frames: Integer read FGetFrames;      { Total number of frames }
      property Duration: Cardinal read FGetDuration;      { Song duration (msec) }
      property EncoderID: Byte read FGetEncoderID;       { Guessed encoder ID }
      property Encoder: string read FGetEncoder;       { Guessed encoder name }
      property Valid: Boolean read FGetValid;       { True if MPEG file valid }
      property FirstFramePos : integer read FFirstFramePos;
  end;

implementation

const
  { Limitation constants }
  MAX_MPEG_FRAME_LENGTH = 1729;                      { Max. MPEG frame length }
  MIN_MPEG_BIT_RATE = 8;                                { Min. bit rate value }
  MAX_MPEG_BIT_RATE = 448;                              { Max. bit rate value }
  MIN_ALLOWED_DURATION = 100;                      { Min. song duration value }

  { VBR Vendor ID strings }
  VENDOR_ID_LAME = 'LAME';                                         { For LAME }
  VENDOR_ID_GOGO_NEW = 'GOGO';                               { For GoGo (New) }
  VENDOR_ID_GOGO_OLD = 'MPGE';                               { For GoGo (Old) }

{ ********************* Auxiliary functions & procedures ******************** }

function IsFrameHeader(const HeaderData: array of Byte): Boolean;
begin
  { Check for valid frame header }
{  result :=
  (HeaderData[0]=255) and
  ((HeaderData[1] shr 5)=7)}

  if ((HeaderData[0] and $FF) <> $FF) or
    ((HeaderData[1] and $E0) <> $E0) or
    (((HeaderData[1] shr 3) and 3) = 1) or
    (((HeaderData[1] shr 1) and 3) = 0) or
    ((HeaderData[2] and $F0) = $F0) or
    ((HeaderData[2] and $F0) = 0) or
    (((HeaderData[2] shr 2) and 3) = 3) or
    ((HeaderData[3] and 3) = 2) then
    Result := false
  else
    Result := true;
end;

{ --------------------------------------------------------------------------- }

procedure DecodeHeader(const HeaderData: array of Byte; var Frame: FrameData);
begin
  { Decode frame header data }
  Move(HeaderData, Frame.Data, SizeOf(Frame.Data));
  Frame.VersionID := (HeaderData[1] shr 3) and 3;
  Frame.LayerID := (HeaderData[1] shr 1) and 3;
  Frame.ProtectionBit := (HeaderData[1] and 1) <> 1;
  Frame.BitRateID := HeaderData[2] shr 4;
  Frame.SampleRateID := (HeaderData[2] shr 2) and 3;
  Frame.PaddingBit := ((HeaderData[2] shr 1) and 1) = 1;
  Frame.PrivateBit := (HeaderData[2] and 1) = 1;
  Frame.ModeID := (HeaderData[3] shr 6) and 3;
  Frame.ModeExtensionID := (HeaderData[3] shr 4) and 3;
  Frame.CopyrightBit := ((HeaderData[3] shr 3) and 1) = 1;
  Frame.OriginalBit := ((HeaderData[3] shr 2) and 1) = 1;
  Frame.EmphasisID := HeaderData[3] and 3;
end;

{ --------------------------------------------------------------------------- }

function ValidFrameAt(const Index: Word; Data: array of Byte): Boolean;
var
  HeaderData: array [1..4] of Byte;
begin
  { Check for frame at given position }
  if index +3 < length(Data) then
  begin
	  HeaderData[1] := Data[Index];
	  HeaderData[2] := Data[Index + 1];
	  HeaderData[3] := Data[Index + 2];
	  HeaderData[4] := Data[Index + 3];
	  if IsFrameHeader(HeaderData) then Result := true
	  else Result := false
  end
  	else Result := false
end;

{ --------------------------------------------------------------------------- }
                                                   
function GetCoefficient(const Frame: FrameData): Byte;
begin
  { Get frame coefficient }
  if Frame.VersionID = MPEG_VERSION_1 then
    if Frame.LayerID = MPEG_LAYER_I then Result := 48
    else Result := 144
  else
    if Frame.LayerID = 3 then Result := 24
    else Result := 72;
end;

{ --------------------------------------------------------------------------- }

function GetBitRate(const Frame: FrameData): Word;
begin
  { Get bit rate }
  Result := MPEG_BIT_RATE[Frame.VersionID, Frame.LayerID, Frame.BitRateID];
end;

{ --------------------------------------------------------------------------- }

function GetSampleRate(const Frame: FrameData): Word;
begin
  { Get sample rate }
  Result := MPEG_SAMPLE_RATE[Frame.VersionID, Frame.SampleRateID];
end;

{ --------------------------------------------------------------------------- }

function GetPadding(const Frame: FrameData): Byte;
begin
  { Get frame padding }
  if Frame.PaddingBit then
    if Frame.LayerID = MPEG_LAYER_I then Result := 4
    else Result := 1
  else Result := 0;
end;

{ --------------------------------------------------------------------------- }

function GetFrameLength(const Frame: FrameData): Word;
var
  Coefficient, BitRate, SampleRate, Padding: Word;
begin
  { Calculate MPEG frame length }
  Coefficient := GetCoefficient(Frame);
  BitRate := GetBitRate(Frame);
  SampleRate := GetSampleRate(Frame);
  Padding := GetPadding(Frame);
  Result := Trunc(Coefficient * BitRate * 1000 / SampleRate) + Padding;
end;

{ --------------------------------------------------------------------------- }

function IsXing(const Index: Word; Data: array of Byte): Boolean;
begin
  { Get true if Xing encoder }
  Result :=
    (Data[Index] = 0) and
    (Data[Index + 1] = 0) and
    (Data[Index + 2] = 0) and
    (Data[Index + 3] = 0) and
    (Data[Index + 4] = 0) and
    (Data[Index + 5] = 0);
end;

{ --------------------------------------------------------------------------- }

function GetXingInfo(const Index: Word; Data: array of Byte): VBRData;
begin
  { Extract Xing VBR info at given position }
  FillChar(Result, SizeOf(Result), 0);
  Result.Found := true;
  Result.ID := VBR_ID_XING;
  Result.Flags :=
               Data[Index + 4] or
               Data[Index + 5] or
               Data[Index + 6] or
               Data[Index + 7];
  Result.Frames :=
    Data[Index + 8] * $1000000 +
    Data[Index + 9] * $10000 +
    Data[Index + 10] * $100 +
    Data[Index + 11];
  Result.Bytes :=
    Data[Index + 12] * $1000000 +
    Data[Index + 13] * $10000 +
    Data[Index + 14] * $100 +
    Data[Index + 15];
  Result.Scale := Data[Index + 119];
  { Vendor ID can be not present }
  Result.VendorID :=
    Chr(Data[Index + 120]) +
    Chr(Data[Index + 121]) +
    Chr(Data[Index + 122]) +
    Chr(Data[Index + 123]) +
    Chr(Data[Index + 124]) +
    Chr(Data[Index + 125]) +
    Chr(Data[Index + 126]) +
    Chr(Data[Index + 127]);
  Result.InvalidHeader := (Result.Frames=0) or ((Result.Bytes=0) and ((Result.flags and $02)=2))
end;

{ --------------------------------------------------------------------------- }

function GetFhGInfo(const Index: Word; Data: array of Byte): VBRData;
begin
  { Extract FhG VBR info at given position }
  FillChar(Result, SizeOf(Result), 0);
  Result.Found := true;
  Result.ID := VBR_ID_FHG;
  Result.Scale := Data[Index + 9];
  Result.Bytes :=
    Data[Index + 10] * $1000000 +
    Data[Index + 11] * $10000 +
    Data[Index + 12] * $100 +
    Data[Index + 13];
  Result.Frames :=
    Data[Index + 14] * $1000000 +
    Data[Index + 15] * $10000 +
    Data[Index + 16] * $100 +
    Data[Index + 17];
  Result.InvalidHeader := false;
end;

{ --------------------------------------------------------------------------- }

function FindVBR(const Index: Word; Data: array of Byte): VBRData;
begin
  { Check for VBR header at given position }
  FillChar(Result, SizeOf(Result), 0);
  if Chr(Data[Index]) +
    Chr(Data[Index + 1]) +
    Chr(Data[Index + 2]) +
    Chr(Data[Index + 3]) = VBR_ID_XING then Result := GetXingInfo(Index, Data);
  if Chr(Data[Index]) +
    Chr(Data[Index + 1]) +
    Chr(Data[Index + 2]) +
    Chr(Data[Index + 3]) = VBR_ID_FHG then Result := GetFhGInfo(Index, Data);
end;

{ --------------------------------------------------------------------------- }

function GetVBRDeviation(const Frame: FrameData): Byte;
begin
  { Calculate VBR deviation }
  if Frame.VersionID = MPEG_VERSION_1 then
    if Frame.ModeID <> MPEG_CM_MONO then Result := 36
    else Result := 21
  else
    if Frame.ModeID <> MPEG_CM_MONO then Result := 21
    else Result := 13;
end;

{ --------------------------------------------------------------------------- }

function HasRipperGroupTag(const data: array of Byte):boolean;
var i:integer;
    s:String;
begin
     setLength(s, length(data));
     for i:=0 to length(data)-1 do
         s[i+1] := char(data[i]);
     result := (Q_PosText('Tagged', s)>0) or (Q_PosText('Release Date', s)>0) or (Q_PosText('Automatic Tag Engine', s)>0);
//     showmessage(s)
end;

function FindFrame(const Data: array of Byte; var VBR: VBRData): FrameData;
var
  HeaderData: array [1..4] of Byte;
  Iterator, FL: Integer;
begin
  { Search for valid frame }
  FillChar(Result, SizeOf(Result), 0);
  Move(Data, HeaderData, SizeOf(HeaderData));
  for Iterator := 0 to SizeOf(Data) - 5 do//MAX_MPEG_FRAME_LENGTH do
  begin
    { Decode data if frame header found }
    if IsFrameHeader(HeaderData) then
    begin
      DecodeHeader(HeaderData, Result);
      { Check for next frame and try to find VBR header }
      FL := GetFrameLength(Result);
      if ((Iterator+FL) < (sizeOf(data)+3)) and ValidFrameAt(Iterator + FL, Data) then
      begin
        Result.Found := true;
        Result.Position := Iterator;
        Result.Size := FL;
        Result.Xing := IsXing(Iterator + SizeOf(HeaderData), Data);
        VBR := FindVBR(Iterator + GetVBRDeviation(Result), Data);
        break
      end; //of validframe
    end; //of isFrameHeader
    HeaderData[1] := HeaderData[2];
    HeaderData[2] := HeaderData[3];
    HeaderData[3] := HeaderData[4];
    HeaderData[4] := Data[Iterator + SizeOf(HeaderData)];
  end; //of if
end;

function FindFrame2(const Data: array of Byte): FrameData;
var
  HeaderData: array [1..4] of Byte;
  Iterator, FL: Integer;
begin
  { Search for valid frame }
  FillChar(Result, SizeOf(Result), 0);
  Move(Data, HeaderData, SizeOf(HeaderData));
  for Iterator := 0 to SizeOf(Data) - 5 do//MAX_MPEG_FRAME_LENGTH do
  begin
    { Decode data if frame header found }
    if IsFrameHeader(HeaderData) then
    begin
      DecodeHeader(HeaderData, Result);
      { Check for next frame and try to find VBR header }
      FL := GetFrameLength(Result);
      if ((Iterator+FL) < (sizeOf(data)+3)) and ValidFrameAt(Iterator + FL, Data) then
      begin
        Result.Found := true;
        Result.Position := Iterator;
        Result.Size := FL;
        break
      end; //of validframe
    end; //of isFrameHeader
    HeaderData[1] := HeaderData[2];
    HeaderData[2] := HeaderData[3];
    HeaderData[3] := HeaderData[4];
    HeaderData[4] := Data[Iterator + SizeOf(HeaderData)];
  end; //of if
end;

{ --------------------------------------------------------------------------- }

function FindVendorID(const Data: array of Byte; FrameSize: Word): string;
var
  Iterator: Integer;
  VendorID: string;
begin
  { Search for vendor ID }
  Result := '';
  for Iterator := 0 to FrameSize * 2 do
  begin
    VendorID :=
      Chr(Data[SizeOf(Data) - Iterator - 8]) +
      Chr(Data[SizeOf(Data) - Iterator - 7]) +
      Chr(Data[SizeOf(Data) - Iterator - 6]) +
      Chr(Data[SizeOf(Data) - Iterator - 5]);
    if VendorID = VENDOR_ID_LAME then
    begin
      Result := VendorID +
        Chr(Data[SizeOf(Data) - Iterator - 4]) +
        Chr(Data[SizeOf(Data) - Iterator - 3]) +
        Chr(Data[SizeOf(Data) - Iterator - 2]) +
        Chr(Data[SizeOf(Data) - Iterator - 1]);
      break;
    end;
    if VendorID = VENDOR_ID_GOGO_NEW then
    begin
      Result := VendorID;
      break;
    end;
  end;
end;

{ ********************** Private functions & procedures ********************* }

procedure TMPEGaudio.FResetData;
begin
  { Reset all variables }
  FFileLength := 0;
  FStartPos := 0;
  FVendorID := '';
  FillChar(FVBR, SizeOf(FVBR), 0);
  FillChar(FFrame, SizeOf(FFrame), 0);
  FFrame.VersionID := MPEG_VERSION_UNKNOWN;
  FFrame.SampleRateID := MPEG_SAMPLE_RATE_UNKNOWN;
  FFrame.ModeID := MPEG_CM_UNKNOWN;
  FFrame.ModeExtensionID := MPEG_CM_EXTENSION_UNKNOWN;
  FFrame.EmphasisID := MPEG_EMPHASIS_UNKNOWN;
//  FID3v1.ResetData;
//  FID3v2.ResetData;
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetVersion: string;
begin
  { Get MPEG version name }
  Result := MPEG_VERSION[FFrame.VersionID];
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetLayer: string;
begin
  { Get MPEG layer name }
  Result := MPEG_LAYER[FFrame.LayerID];
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetBitRate: Word;
begin
  { Get bit rate, calculate average bit rate if VBR header found }
  if (FVBR.Found) and (FVBR.Frames > 0) and (not FVBR.InvalidHeader) then
    Result := Round((FVBR.Bytes / FVBR.Frames - GetPadding(FFrame)) *
      GetSampleRate(FFrame) / GetCoefficient(FFrame) / 1000)
  else
  if (FVBR.Found) and (FVBR.InvalidHeader) then
        result := FCalculatedBitrate
  else
    Result := GetBitRate(FFrame);
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetSampleRate: Word;
begin
  { Get sample rate }
  Result := GetSampleRate(FFrame);
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetChannelMode: string;
begin
  { Get channel mode name }
  Result := MPEG_CM_MODE[FFrame.ModeID];
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetEmphasis: string;
begin
  { Get emphasis name }
  Result := MPEG_EMPHASIS[FFrame.EmphasisID];
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetFrames: Integer;
begin
  { Get total number of frames, calculate if VBR header not found }
  if FVBR.Found then
    Result := FVBR.Frames
  else
    Result := (FFileLength - FStartPos - FFrame.Position - FId3v1Size) div
      GetFrameLength(FFrame);
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetDuration: Cardinal;
begin
  { Calculate song duration }
  if FFrame.Found then
    if (FVBR.Found) and (FVBR.Frames > 0) and (not FVBR.InvalidHeader) then
      Result := round(FVBR.Frames * GetCoefficient(FFrame) * (8 / GetSampleRate(FFrame))) * 1000
    else
    if (FVBR.Found) and (FVBR.InvalidHeader) then
        result := FCalculatedDuration
    else
      Result := round((FFileLength - FStartPos - FFrame.Position - FId3v1Size) * 8 /
        GetBitRate(FFrame))// / 1000
  else
    Result := 0;
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetVBREncoderID: Byte;
begin
  { Guess VBR encoder and get ID }
  Result := 0;
  if Copy(FVBR.VendorID, 1, 4) = VENDOR_ID_LAME then
    Result := MPEG_ENCODER_LAME;
  if Copy(FVBR.VendorID, 1, 4) = VENDOR_ID_GOGO_NEW then
    Result := MPEG_ENCODER_GOGO;
  if Copy(FVBR.VendorID, 1, 4) = VENDOR_ID_GOGO_OLD then
    Result := MPEG_ENCODER_GOGO;
  if (FVBR.ID = VBR_ID_XING) and
    (Copy(FVBR.VendorID, 1, 4) <> VENDOR_ID_LAME) and
    (Copy(FVBR.VendorID, 1, 4) <> VENDOR_ID_GOGO_NEW) and
    (Copy(FVBR.VendorID, 1, 4) <> VENDOR_ID_GOGO_OLD) then
    Result := MPEG_ENCODER_XING;
  if FVBR.ID = VBR_ID_FHG then
    Result := MPEG_ENCODER_FHG;
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetCBREncoderID: Byte;
begin
  { Guess CBR encoder and get ID }
  Result := MPEG_ENCODER_FHG;
  if (FFrame.OriginalBit) and
    (FFrame.ProtectionBit) then
    Result := MPEG_ENCODER_LAME;
  if (GetBitRate(FFrame) <= 160) and
    (FFrame.ModeID = MPEG_CM_STEREO) then
    Result := MPEG_ENCODER_BLADE;
  if (FFrame.CopyrightBit) and
    (FFrame.OriginalBit) and
    (not FFrame.ProtectionBit) then
    Result := MPEG_ENCODER_XING;
  if (FFrame.Xing) and
    (FFrame.OriginalBit) then
    Result := MPEG_ENCODER_XING;
  if (FFrame.ModeID = MPEG_CM_DUAL_CHANNEL) and
    (FFrame.ProtectionBit) then
    Result := MPEG_ENCODER_SHINE;
  if Copy(FVendorID, 1, 4) = VENDOR_ID_LAME then
    Result := MPEG_ENCODER_LAME;
  if Copy(FVendorID, 1, 4) = VENDOR_ID_GOGO_NEW then
    Result := MPEG_ENCODER_GOGO;
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetEncoderID: Byte;
begin
  { Get guessed encoder ID }
  if FFrame.Found then
    if FVBR.Found then Result := FGetVBREncoderID
    else Result := FGetCBREncoderID
  else
    Result := 0;
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetEncoder: string;
var
  VendorID: string;
begin
  { Get guessed encoder name and encoder version for LAME }
  Result := MPEG_ENCODER[FGetEncoderID];
  if FVBR.VendorID <> '' then VendorID := FVBR.VendorID;
  if FVendorID <> '' then VendorID := FVendorID;
  if (FGetEncoderID = MPEG_ENCODER_LAME) and
    (Length(VendorID) >= 8) and
    (VendorID[5] in ['0'..'9']) and
    (VendorID[6] = '.') and
    (VendorID[7] in ['0'..'9']) and
    (VendorID[8] in ['0'..'9']) then
    Result :=
      Result + #32 +
      VendorID[5] +
      VendorID[6] +
      VendorID[7] +
      VendorID[8];
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.FGetValid: Boolean;
begin
  { Check for right MPEG file data }
  Result :=
    (FFrame.Found) and
    (FGetBitRate >= MIN_MPEG_BIT_RATE) and
    (FGetBitRate <= MAX_MPEG_BIT_RATE) and
    (FGetDuration >= MIN_ALLOWED_DURATION);
end;

{ ********************** Public functions & procedures ********************** }

constructor TMPEGaudio.Create;
begin
  { Object constructor }
  inherited;
//  FID3v1 := TID3v1.Create;
//  FID3v2 := TID3v2.Create;
  FResetData;
end;

{ --------------------------------------------------------------------------- }

destructor TMPEGaudio.Destroy;
begin
  { Object destructor }
//  FID3v1.Free;
//  FID3v2.Free;
  inherited;
end;

{ --------------------------------------------------------------------------- }

function TMPEGaudio.IsVBRnoHeader(Fstr: TStream; var ReturnBitrate:Integer) :Boolean;
//by anders thomsen
const   split = 2;
var
        Data: array [1..MAX_MPEG_FRAME_LENGTH * 2] of Byte;
        PosBackup: cardinal;
        Transferred, i,x, CurrentBitrate: Integer;
        Frm : FrameData;
begin
        PosBackup := Fstr.Position;
        CurrentBitrate := -1;
        result := false;
        for i:=1 to split do
        begin
                Fstr.Position := trunc(Fstr.size * i/(split+1));
                for x:=0 to 3 do
                begin
                Transferred := Fstr.Read(Data, Sizeof(Data));
                Frm := FindFrame2(Data);
                if CurrentBitrate = -1 then
                   CurrentBitrate := getBitrate(Frm)
                else
                   if CurrentBitrate <> getBitrate(Frm) then
                   begin
                     result := true;
                     break
                   end;
                if Frm.Found then Fstr.Position := Fstr.Position - Transferred + Frm.Position + Frm.Size
                end;
                if result then break
        end;

        if result then ReturnBitrate := -1 else ReturnBitrate := CurrentBitrate;
        Fstr.Position := PosBackup
end;

function MyCopyFrom(Source, Dest: TStream; Count: Longint): Longint;
const
  MaxBufSize = $200000;//1 mb, gammel værdi: $F000;
var
  BufSize, N: Integer;
  Buffer: PChar;
begin
  if Count = 0 then
  begin
    Source.Position := 0;
    Count := Source.Size;
  end;
  Result := Count;
  if Count > MaxBufSize then BufSize := MaxBufSize else BufSize := Count;
  GetMem(Buffer, BufSize);
  try
    while Count <> 0 do
    begin
      if Count > BufSize then N := BufSize else N := Count;
      Source.ReadBuffer(Buffer^, N);
      Dest.WriteBuffer(Buffer^, N);
      Dec(Count, N);
    end;
  finally
    FreeMem(Buffer, BufSize);
  end;
end;

function TMPEGaudio.ReadFromStream(const Fstr: TStream; StartPos:integer; HasV1:boolean; copyToMemWhenScanningEntire:boolean=false): Boolean;
var
  Data: array [1..MAX_MPEG_FRAME_LENGTH * 2] of Byte;
  Transferred, CorrectBR, FirstFramePos: Integer;
  FrameCount, BR : Cardinal;
  frameFound, FrameFoundInEnd : boolean;
  Mstr:TStream;
  Str:TStream;
begin
  Result := false;
  frameFound := false;
  FResetData;
  Fstr.position := 0;
  FFirstFramePos := 0;
  FStartPos := startPos;
  FId3v1Size := 128 * integer(Hasv1);
  { At first search for tags, then search for a MPEG frame and VBR data }
 { if (FID3v1.ReadFromStream(Fstr)) and (FID3v2.ReadFromStream(Fstr)) then }
    try
      { Open file, read first block of data and search for a frame }
      FFileLength := Fstr.size;
      Fstr.position := FStartPos;
      Transferred := Fstr.Read(Data, Sizeof(Data));
      FFrame := FindFrame(Data, FVBR);
      frameFound := FFrame.Found;
      if frameFound then
         FirstFramePos := Fstr.Position - transFerred + FFrame.Position
      else
      begin//Er der den taggergrouppe DIZ?
           if HasRipperGroupTag(data) then
           begin
                while not frameFound and (Fstr.position < Fstr.size) do
                begin
                     Fstr.position := Fstr.Position-3;
                     Transferred := Fstr.Read(Data, Sizeof(Data));
                     FFrame := FindFrame(Data, FVBR);
                     frameFound := FFrame.Found
                end;
                if frameFound then
                   FirstFramePos := Fstr.Position - transFerred + FFrame.Position
                else FirstFramePos := -1
           end
      end;
      { Try to search in the middle if no frame at the beginning found }
      if (not FFrame.Found) and (Transferred = SizeOf(Data)) then
      begin
        FStr.position := trunc((FFileLength - FStartPos) * 0.75);
        Transferred := Fstr.Read(Data, SizeOf(Data));
        FFrame := FindFrame(Data, FVBR);
        frameFound := FFrame.Found;
        FrameFoundInEnd := frameFound;
        if FrameFound then FirstFramePos := -1
      end else FrameFoundInEnd := false;
      if FFRame.found then FFirstFramePos := Fstr.Position - Transferred + FFrame.Position;
      { Check if the file is with VBR and invalid header }
      if (FFrame.Found) and ((FVBR.Found and FVBR.InvalidHeader) or not FVBR.Found) and ((FirstFramePos=-1) or IsVBRnoHeader(Fstr, CorrectBR)) then
      begin
         { invalid VBR header. Calculating duration and average bitrate - reading entire file}
         //by Thomsen

                FirstFramePos := -1;
                FVBR.CanWriteNewVBR := (not FrameFoundInEnd) or (FVBR.InvalidHeader and FVBR.Found);
                FVBR.Found := true;
                FVBR.InvalidHeader := true;

                //copy to mem?
                if copyToMemWhenScanningEntire then
                begin
                     try
                          Mstr := TMemoryStream.Create;
                          MyCopyFrom(Fstr, Mstr, 0);
                          Str := Mstr
                     except
                          Str := Fstr;
                          copyToMemWhenScanningEntire := false;
                          Mstr.free
                     end
                end
                else Str := Fstr;

                frameCount := 0;
                BR := 0;
                FCalculatedBitrate := 0;
                FCalculatedDuration := 0;
                Str.position := FstartPos;
                Transferred := Str.Read(Data, Sizeof(Data));
                FFrame := FindFrame2(Data);
                while (Str.position < Str.size) do
                begin
                        if Fframe.Found then
                        begin
                                if FirstFramePos = -1 then
                                   FirstFramePos := Str.Position - Transferred + Fframe.position;
                                inc(frameCount);
                                inc(BR, GetBitrate(FFrame));
                                inc(FCalculatedDuration, Fframe.Size);
                                Str.position := Str.position - Transferred + Fframe.position + fFrame.size;
                        end else Str.position := Str.Position-3;
                        Transferred := Str.Read(Data, Sizeof(Data));
                        FFrame := FindFrame2(Data);
                end;
                //Fframe skal være den først fundne frame ved afslutningen:
                if copyToMemWhenScanningEntire then
                   Mstr.free;

                if FirstFramePos >= 0 then
                   fFirstFramePos := FirstFramePos
                else fFirstFramePos := 0;
                Fstr.position := fFirstFramePos;
                Transferred := Fstr.Read(Data, Sizeof(Data));
                FFrame := FindFrame2(Data);

                FVBR.Frames := frameCount;
                FCalculatedBitrate := BR div max(1, frameCount);
                FCalculatedDuration := (FCalculatedDuration*8) div FCalculatedBitrate
      end
      else if (FFrame.Found) and (not FVBR.Found) and (getBitrate(FFrame) <> CorrectBR) and (CorrectBR > 0) then
      begin
        repeat  //øffe hvad gør denne?
                if FFrame.found then
                   Fstr.position := Fstr.position - transferred + Fframe.position + fFrame.size;
                Transferred := Fstr.Read(Data, Sizeof(Data));
                FFrame := FindFrame(Data, FVBR)
        until (Fstr.Position >= Fstr.Size) or ((FFrame.found) and (getBitrate(FFrame) = CorrectBR));

      { Search for vendor ID at the end if CBR encoded }

      if (FFrame.Found) and (not FVBR.Found) then
      begin
        FStr.Position := FfileLength - Sizeof(Data) - FId3v1Size;
        Transferred := FStr.Read(Data, sizeof(data));
        FVendorID := FindVendorID(Data, FFrame.Size);
      end
      end;
      Result := true;
    except
    end;
  if not FrameFound then FResetData;
end;

function TMPEGaudio.ReadFromFile(const FileName: string; startPos:integer; HasV1:boolean): Boolean;
var
  FStr:TStream;
begin
	try
  	Fstr := TFileStream.create(Filename, fmOpenRead or fmShareDenyNone);
    try
  		result := ReadFromStream(Fstr, startPos, HasV1)
    finally
    	Fstr.free;
    end
  except
  	Result := false
  end
end;

function TMPEGaudio.AddNewVBRtoStream(Fstr:TStream):boolean;
procedure setBit(var b:byte; const index:byte; value:boolean);
begin
     if value then
        b := b or (1 shl (7-index))
     else
         b := b and not (1 shl (7-index))
end;
procedure MakeI(var a:array of byte; i:integer);
begin
     {$R-}
     fillChar(a, 4, #0);
     a[0] := i shr 24;
     a[1] := i shr 16;
     a[2] := i shr 8;
     a[3] := i shr 0
end;
var      Mstr : TStream;
				 FStr2 : TMyMemorystream;
         b, BRvalue:byte;
         i:integer;
         tempFrame : FrameData;
         tempVBR : VBRData;
         Data: array [1..MAX_MPEG_FRAME_LENGTH * 2] of Byte;
         mpegHeader, bArr:array [1..4] of byte;
         toc : array[0..99] of byte;
         HBR, coef, VBRdev, TOCindex:integer; //header-bit-rate
         duration, nextTocDuration, mpegPos, mpegLength, durationPos, transferred, XingFrameLength : cardinal;
begin
     if FVBR.Found and FVBR.InvalidHeader and Fframe.Found then
     begin
          Mstr := TMemoryStream.create;
          FillChar(toc, sizeOf(toc), #0);
          coef := GetCoefficient(fFrame);
          VBRdev := GetVBRDeviation(fFrame);

          Fstr.Position := fFirstFramePos;
          transferred := Fstr.Read(data, sizeOf(data));
          tempFrame := FindFrame(data, tempVBR);
          if tempVBR.Found and tempVBR.InvalidHeader then //der er fundet en invalid header, den skal fjernes!
          begin
               Fstr.Position := Fstr.position - Transferred + tempFrame.position + tempFrame.size;
               Transferred := Fstr.Read(data, sizeOf(data));
               tempFrame := findFrame(data, tempVBR);
               fFirstFramePos := Fstr.position - TransFerred + tempFrame.Position;
               dec(FVBR.Frames)
          end;

          //finder bitrate, 48 eller 64
          if fFrame.VersionID = MPEG_VERSION_1 then
          begin
               if fFrame.LayerID in [MPEG_LAYER_I, MPEG_LAYER_II] then BRvalue := 2 else BRvalue := 3;
               if fFrame.LayerID in [MPEG_LAYER_II, MPEG_LAYER_III] then HBR := 48 else HBR := 64
          end else
          begin
               HBR := 48;
               if fFrame.LayerID = MPEG_LAYER_I then BRvalue := 2 else BRvalue := 6
          end;

          xingFrameLength := Trunc(coef * HBR * 1000 / GetSampleRate(fFrame));

          move(fFrame.data, mpegHeader, sizeOf(fFrame.data));

          //sætter bitrate
          setBit(mpegHeader[3], 0, false);
          setBit(mpegHeader[3], 1, BRvalue=6);
          setBit(mpegHeader[3], 2, true);
          setBit(mpegHeader[3], 3, BRvalue=3);

          //sætter padding off
          setBit(mpegHeader[3], 6, false);

          //skriver Mpeg-headeren
          Mstr.Size := 0;
          for i:=1 to 4 do
              Mstr.Write(mpegHeader[i], 1);

          //fylder til den når VBRdeviation
          b := 0;
          for i:=1 to VBRdev-4 do
              Mstr.Write(b, 1);

          //Skriver Xing
          Mstr.Write(VBR_ID_XING[1], 4);

          //Skriver Flags
          b := 0;
          for i:=1 to 3 do
              Mstr.Write(b, 1);
          b := 7;
          Mstr.Write(b, 1);
          //eo Flags

          //Frame Count
          MakeI(bArr, FVBR.Frames+1);
          Mstr.Write(bArr, 4);

          //File Size
          MakeI(bArr, FFileLength - fFirstFramePos - FFrame.Position - FId3v1Size + xingFrameLength);
          Mstr.Write(bArr, 4);

          //Fylder TOC
          duration := FGetDuration;
          mpegLength := FfileLength - fFirstFramePos - Fframe.Position - Fid3v1Size + xingFrameLength;
          TOCindex := 0;
          mpegPos := xingFrameLength;
          durationPos := 0;
          nextTocDuration := trunc(duration/100*TOCindex);

          Fstr.position := fFirstFramePos;
          Transferred := Fstr.Read(Data, Sizeof(Data));
          FFrame := FindFrame2(Data);
          while (Fstr.position < Fstr.size-fId3v1Size) do
          begin
                if Fframe.Found then
               begin
                    TOC[TOCindex] := round(255*(mpegPos/mpegLength));
                    inc(durationPos, round(Fframe.Size*8/GetBitRate(Fframe)));
                    if durationPos>nextTocDuration then
                    begin
                         inc(TOCindex);
                         nextTocDuration := round(duration/100*TOCindex)
                    end;
                    inc(mpegPos, Fframe.position + fFrame.size);
                    Fstr.position := Fstr.position - Transferred + Fframe.position + fFrame.size; //sæter position til der hvor framen er slut
               end else
               begin
                    Fstr.position := Fstr.Position-3;
                    inc(mpegPos, transferred)
               end;
              // inc(mpegPos, Fframe.position + fFrame.size);
               Transferred := Fstr.Read(Data, Sizeof(Data));
               FFrame := FindFrame2(Data);
          end;
          //Fframe skal være den først fundne frame ved afslutningen:
          Fstr.position := fFirstFramePos;
          Transferred := Fstr.Read(Data, Sizeof(Data));
          FFrame := FindFrame2(Data);

          for i:=0 to 99 do
              Mstr.Write(TOC[i], 1);
          b := 0;
          //skriver de sidste til den når Coef
          while Mstr.size < xingFrameLength do
                Mstr.Write(b, 1);

          Fstr2 := TMyMemorystream.create;
          Fstr.position := 0;
          Mstr.position := 0;
          if fStartPos>0 then Fstr2.CopyFrom(Fstr, fStartPos);
          Fstr.position := fFirstFramePos;//(FFrame.position, soFromCurrent); //flytter positionen til den første MPEG frame
          Fstr2.CopyFrom(Mstr, Mstr.size);
          Fstr2.CopyFrom(Fstr, Fstr.size-Fstr.position, 1048576);
          Fstr2.position := 0;
          Fstr.Size := 0;
          Fstr.CopyFrom(Fstr2, Fstr2.size);
          Fstr2.Size := 0;
          Mstr.size := 0;
          Mstr.free;
          result := true
     end else result := false;
end;

end.
