{ *************************************************************************** }
{                                                                             }
{ Audio Tools Library (Freeware)                                              }
{ Class TMonkey - for manipulating with Monkey's Audio file information       }
{                                                                             }
{ Uses:                                                                       }
{   - Class TID3v1                                                            }
{   - Class TID3v2                                                            }
{   - Class TAPEtag                                                           }
{                                                                             }
{ Copyright (c) 2001,2002 by Jurgen Faul                                      }
{ E-mail: jfaul@gmx.de                                                        }
{ http://jfaul.de/atl                                                         }
{                                                                             }
{ Version 1.3 (23 May 2002)                                                   }
{   - Class TID3v2: support for padding                                       }
{                                                                             }
{ Version 1.2 (21 April 2002)                                                 }
{   - Class TID3v2: support for ID3v2 tags                                    }
{   - Class TAPEtag: support for APE tags                                     }
{                                                                             }
{ Version 1.1 (11 September 2001)                                             }
{   - Added property Samples                                                  }
{   - Removed WAV header information                                          }
{                                                                             }
{ Version 1.0 (7 September 2001)                                              }
{   - Support for Monkey's Audio files                                        }
{   - Class TID3v1: reading & writing support for ID3v1.x tags                }
{                                                                             }
{ *************************************************************************** }

unit Monkey;

interface

uses
	Classes, SysUtils;//, APEtag;

const
  { Compression level codes }
  MONKEY_COMPRESSION_FAST = 1000;                               { Fast (poor) }
  MONKEY_COMPRESSION_NORMAL = 2000;                           { Normal (good) }
  MONKEY_COMPRESSION_HIGH = 3000;                          { High (very good) }
  MONKEY_COMPRESSION_EXTRA_HIGH = 4000;                   { Extra high (very good) }
  MONKEY_COMPRESSION_LEVEL_INSANE = 5000;								{Insane (best) }

  { Compression level names }
  MONKEY_COMPRESSION: array [0..5] of string =
    ('Unknown', 'Fast', 'Normal', 'High', 'Extra High', 'Insane');

  { Format flags }
  MONKEY_FLAG_8_BIT = 1;                                        { Audio 8-bit }
  MONKEY_FLAG_CRC = 2;                            { New CRC32 error detection }
  MONKEY_FLAG_PEAK_LEVEL = 4;                             { Peak level stored }
  MONKEY_FLAG_24_BIT = 8;                                      { Audio 24-bit }
  MONKEY_FLAG_SEEK_ELEMENTS = 16;            { Number of seek elements stored }
  MONKEY_FLAG_WAV_NOT_STORED = 32;                    { WAV header not stored }

  { Channel mode names }
  MONKEY_MODE: array [0..2] of string =
    ('Unknown', 'Mono', 'Stereo');

type
  { Real structure of Monkey's Audio header }
  CommonApeHeader = packed record
    ID: array [1..4] of Char;                                 { Always "MAC " }
    VersionID: Word;                    { Version number * 1000 (3.91 = 3910) }
  end;

  OldApeHeader = packed record
    CompressionID: Word;                             { Compression level code }
    Flags: Word;                                           { Any format flags }
    Channels: Word;                                      { Number of channels }
    SampleRate: Integer;                                   { Sample rate (hz) }
    HeaderBytes: Integer;                 { Header length (without header ID) }
    TerminatingBytes: Integer;                                { Extended data }
    TotalFrames: Integer;                           { Number of frames in the file }
    FinalFrameBlocks: Integer;             { Number of samples in the final frame }
    PeakLevel: Integer;                              { Peak level (if stored) }
    SeekElements: Integer;              { Number of seek elements (if stored) }
  end;

  ApeHeader = packed record
  	CompressionLevel: word;                 // the compression level (see defines I.E. COMPRESSION_LEVEL_FAST)
    FormatFlags: word;                      // any format flags (for future use)

    BlocksPerFrame: longWord;                   // the number of audio blocks in one frame
    FinalFrameBlocks: longWord;                 // the number of audio blocks in the final frame
    TotalFrames: longWord;                      // the total number of frames

    BitsPerSample: word;                    // the bits per sample (typically 16)
    Channels: word;                         // the number of channels (1 or 2)
    SampleRate: longWord;                       // the sample rate (typically 44100)
	end;

  { Class TMonkey }
  TMonkey = class(TObject)
    private
      { Private declarations }
      FFileLength: Integer;
      FCommonHeader: CommonApeHeader;
      FOldHeader: OldApeHeader;
      FApeHeader: ApeHeader;

      procedure FResetData;
      function FGetValid: Boolean;
      function FGetVersion: string;
      function FGetCompression: string;
//      function FGetBits: Byte;
      function FGetChannelMode: string;
//      function FGetPeak: Double;
//      function FGetSamplesPerFrame: Integer;
      function FGetTotalBlocks: Integer;
      function FGetBlocksPerFrame:longword;
      function FGetDuration: Double;
//      function FGetRatio: Double;
      function FUseOldHeader: boolean;
      function FGetChannels: integer;
      function FGetSampleRate: integer;
      function FGetCompressionID: integer;
      function FGetVersionID: integer;
    public
      { Public declarations }
      constructor Create;                                     { Create object }
      destructor Destroy; override;                          { Destroy object }
			function ReadFromFile(const FileName: string; StartPos: Integer): Boolean;   { Load header }
			function ReadFromStream(FStr: TStream; StartPos: Integer): Boolean;   { Load header }
      property FileLength: Integer read FFileLength;    { File length (bytes) }
//      property Header: MonkeyHeader read FHeader;     { Monkey's Audio header }
//			property ID3v1: TID3v1 read FID3v1;                    { ID3v1 tag data }
//      property ID3v2: TID3v2 read FID3v2;                    { ID3v2 tag data }
//      property APEtag: TAPEtag read FAPEtag;                   { APE tag data }
      property Valid: Boolean read FGetValid;          { True if header valid }
      property Version: string read FGetVersion;            { Encoder version }
      property Compression: string read FGetCompression;  { Compression level }
//      property Bits: Byte read FGetBits;                    { Bits per sample }
      property ChannelMode: string read FGetChannelMode;       { Channel mode }
//      property Peak: Double read FGetPeak;             { Peak level ratio (%) }
//      property Samples: Integer read FGetSamples;         { Number of samples }
      property Duration: Double read FGetDuration;       { Duration (seconds) }
//      property Ratio: Double read FGetRatio;          { Compression ratio (%) }
      property Channels: integer read FGetChannels;
      property SampleRate: integer read FGetSampleRate;
      property CompressionID: integer read FGetCompressionID;
      property VersionID: integer read FGetVersionID;
  end;

implementation

{ ********************** Private functions & procedures ********************* }

procedure TMonkey.FResetData;
begin
  { Reset data }
  FFileLength := 0;
  FillChar(FCommonHeader, SizeOf(FCommonHeader), 0);
  FillChar(FOldHeader, SizeOf(FOldHeader), 0);
  FillChar(FApeHEader, SizeOf(FApeHEader), 0);
//  FID3v1.ResetData;
//  FID3v2.ResetData;
//  FAPEtag.ResetData;
end;

{ --------------------------------------------------------------------------- }

function TMonkey.FGetValid: Boolean;
begin
  { Check for right Monkey's Audio file data }
  if FCommonHeader.ID = 'MAC ' then
      result := (FGetSampleRate > 0) and (FGetChannels in [1, 2])
  else
  	result := false
end;

{ --------------------------------------------------------------------------- }

function TMonkey.FGetVersion: string;
begin
  { Get encoder version }
  if FCommonHeader.VersionID = 0 then Result := ''
  else Str(FCommonHeader.VersionID / 1000 : 4 : 2, Result);
end;

{ --------------------------------------------------------------------------- }

function TMonkey.FGetCompression: string;
var
	i: integer;
begin
  { Get compression level }
  i := FGetCompressionID div 1000;
  if not (i in [0..5]) then
  	i := 0;
  Result := MONKEY_COMPRESSION[i];
end;

{ --------------------------------------------------------------------------- }

{function TMonkey.FGetBits: Byte;
begin
  { Get number of bits per sample
  if FGetValid then
  begin
    Result := 16;
//    if FHeader.Flags and MONKEY_FLAG_8_BIT > 0 then Result := 8;
//    if FHeader.Flags and MONKEY_FLAG_24_BIT > 0 then Result := 24;
  end
  else
    Result := 0;
end; }

{ --------------------------------------------------------------------------- }

function TMonkey.FGetChannelMode: string;
begin
	{ Get channel mode }
  if FGetChannels in [1, 2] then
	  Result := MONKEY_MODE[FGetChannels]
  else
  	result := MONKEY_MODE[0]
end;

{ --------------------------------------------------------------------------- }

{function TMonkey.FGetPeak: Double;
begin
  { Get peak level ratio
  if (FGetValid) and (FHeader.Flags and MONKEY_FLAG_PEAK_LEVEL > 0) then
    case FGetBits of
      16: Result := FHeader.PeakLevel / 32768 * 100;
      24: Result := FHeader.PeakLevel / 8388608 * 100;
			else Result := FHeader.PeakLevel / 128 * 100;
    end
  else
    Result := 0;  
end;              }

{ --------------------------------------------------------------------------- }

{function TMonkey.FGetSamplesPerFrame: Integer;
begin
	{ Get number of samples in a frame
	if FGetValid then
    if (FHeader.VersionID >= 3950) then
      Result := 9216 * 32
		else
		if (FHeader.VersionID >= 3900) or
      ((FHeader.VersionID >= 3800) and
      (FHeader.CompressionID = MONKEY_COMPRESSION_EXTRA_HIGH)) then
      Result := 9216 * 8
    else
      Result := 9216
  else
		Result := 0
end;                }

{ --------------------------------------------------------------------------- }

function TMonkey.FGetTotalBlocks: Integer;
begin
  { Get number of samples }
  if FGetValid then
  	if FUseOldHeader then
    	if FOldHeader.TotalFrames = 0 then
      	result := 0
      else
      	result := ((FOldHeader.TotalFrames - 1) * FGetBlocksPerFrame) + FOldHeader.FinalFrameBlocks
    else
    	if FApeHeader.TotalFrames = 0 then
      	result := 0
      else
      	result := ((FApeHeader.TotalFrames - 1) * FGetBlocksPerFrame) + FApeHeader.FinalFrameBlocks
	else
		Result := 0
end;

function TMonkey.FGetBlocksPerFrame:longword;
begin
	if FUseOldHEader then
  begin
  	if ((FCommonHeader.VersionID >= 3900) or ((FCommonHeader.VersionID >= 3800) and (FGetCompressionID = MONKEY_COMPRESSION_EXTRA_HIGH))) then
    	result := 73728
    else
    	result := 9216;
    if ((FCommonHeader.VersionID >= 3950)) then
    	result := 73728 * 4
  end
  else
  	result := FApeHeader.BlocksPerFrame
end;

{ --------------------------------------------------------------------------- }

function TMonkey.FGetDuration: Double;
begin
  { Get song duration }
  if FGetValid then
  	Result := FGetTotalBlocks / FGetSampleRate
  else
  	Result := 0;
end;

{ --------------------------------------------------------------------------- }

{function TMonkey.FGetRatio: Double;
begin
  { Get compression ratio 
  if FGetValid then
//    Result := FFileLength /
//      (FGetSamples * FHeader.Channels * FGetBits / 8 + 44) * 100
  else
    Result := 0;
end;         }

function TMonkey.FGetVersionID: Integer;
begin
	result := FCommonHeader.VersionID;
end;

function TMonkey.FGetCompressionID: Integer;
begin
	if FGetValid then
  	if FUseOldHeader then
    	result := FOldHeader.CompressionID
    else
    	result := FApeHeader.CompressionLevel
  else
  	result := 0
end;

function TMonkey.FGetSampleRate: Integer;
begin
	if FUseOldHeader then
  	result := FOldHeader.SampleRate
  else
  	result := FApeHeader.SampleRate
end;

function TMonkey.FGetChannels: integer;
begin
  if FUseOldHeader then
    result := FOldHeader.Channels
  else
    result := FApeHeader.Channels
end;

Function TMonkey.FUseOldHeader: boolean;
begin
	result := FCommonHeader.VersionID < 3980;
end;

{ ********************** Public functions & procedures ********************** }

constructor TMonkey.Create;
begin
  { Create object }
  inherited;
//  FID3v1 := TID3v1.Create;
//  FID3v2 := TID3v2.Create;
//  FAPEtag := TAPEtag.Create;
  FResetData;
end;

{ --------------------------------------------------------------------------- }

destructor TMonkey.Destroy;
begin
  { Destroy object }
//  FID3v1.Free;
//  FID3v2.Free;
//  FAPEtag.Free;
  inherited;
end;

{ --------------------------------------------------------------------------- }

function TMonkey.ReadFromFile(const FileName: string; StartPos: Integer): Boolean;
var
	FStr : TStream;
begin
	try
		Fstr := TFileStream.Create(FileName, fmOpenRead	or fmShareDenyWrite);
		result := ReadFromStream(Fstr, StartPos);
		Fstr.free
	except
		result := false
	end
end;

function TMonkey.ReadFromStream(FStr: TStream; StartPos: Integer): Boolean;   { Load header }
var
	descriptorBytes: longword;
begin
  try
    { Reset data and search for file tag }
    FResetData;
		{ Set read-access, open file and get file length }
		FFileLength := FStr.Size;
    { Read Monkey's Audio header data }
		FStr.Position := StartPos;
		FStr.Read(FCommonHeader, SizeOf(FCommonHeader));
    if FUseOldHeader then
    begin
    	FStr.Read(FOldHeader, SizeOf(FOldHeader));
      if FOldHeader.Flags and MONKEY_FLAG_PEAK_LEVEL = 0 then
				FOldHeader.PeakLevel := 0;
			if FOldHeader.Flags and MONKEY_FLAG_SEEK_ELEMENTS = 0 then
				FOldHeader.SeekElements := 0;
    end
    else
    begin
    	FStr.Position := 8 + StartPos;
			FStr.Read(descriptorBytes, SizeOf(descriptorBytes));
    	FStr.Seek(descriptorBytes - 12, soFromCurrent);   //-12
      FStr.Read(FApeHeader, SizeOf(FApeHeader))
    end;

		Result := true;
	except
    FResetData;
    Result := false;
  end;
end;

end.
