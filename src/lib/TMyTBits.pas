unit MyTBits;

interface
uses SysUtils, Consts;

Type
  TMyTBits = class
  private
    FSize: Integer;
    FBits: Pointer;
    FBlockSize: Integer;
    procedure Error;
    procedure SetSize(Value: Integer);
    procedure SetBit(Index: Integer; Value: Boolean);
    function GetBit(Index: Integer): Boolean;
    function GetBitInBlock(Index, blockIndex: Integer): Boolean;
    procedure SetBitInBlock(Index, blockIndex: Integer; value: boolean);
  public
    destructor Destroy; override;
    function OpenBit: Integer;
    procedure SetAllToFalse;
    property Bits[Index: Integer]: Boolean read GetBit write SetBit; default;
    property BitsInBlock[Index, blockIndex: Integer]: Boolean read GetBitInBlock write SetBitInBlock;
    property Size: Integer read FSize write SetSize;
    property BlockSize: Integer read FBlockSize write FBlockSize;
  end;

  EBitsError = class(Exception);

implementation

const
  BitsPerInt = SizeOf(Integer) * 8;

type
  TBitEnum = 0..BitsPerInt - 1;
  TBitSet = set of TBitEnum;
  PBitArray = ^TBitArray;
  TBitArray = array[0..4096] of TBitSet;

destructor TMyTBits.Destroy;
begin
  SetSize(0);
  inherited Destroy;
end;

procedure TMyTBits.Error;
begin
 raise EBitsError.CreateRes(@SBitsIndexError);
end;

procedure TMyTBits.SetAllToFalse;
var
	len: integer;
begin
	len := ((Size + BitsPerInt - 1) div BitsPerInt) * SizeOf(Integer);
	if len > 0 then
		FillChar(FBits^, len, 0)
end;

procedure TMyTBits.SetSize(Value: Integer);
var
  NewMem: Pointer;
  NewMemSize: Integer;
  OldMemSize: Integer;

  function Min(X, Y: Integer): Integer;
  begin
    Result := X;
    if X > Y then Result := Y;
  end;

begin
  if Value <> Size then
  begin
    if Value < 0 then Error;
    NewMemSize := ((Value + BitsPerInt - 1) div BitsPerInt) * SizeOf(Integer);
    OldMemSize := ((Size + BitsPerInt - 1) div BitsPerInt) * SizeOf(Integer);
    if NewMemSize <> OldMemSize then
    begin
      NewMem := nil;
      if NewMemSize <> 0 then
      begin
        GetMem(NewMem, NewMemSize);
        FillChar(NewMem^, NewMemSize, 0);
      end;
      if OldMemSize <> 0 then
      begin
        if NewMem <> nil then
          Move(FBits^, NewMem^, Min(OldMemSize, NewMemSize));
        FreeMem(FBits, OldMemSize);
      end;
      FBits := NewMem;
    end;
    FSize := Value;
  end;
end;

procedure TMyTBits.SetBit(Index: Integer; Value: Boolean); assembler;
asm
        CMP     Index,[EAX].FSize
        JAE     @@Size

@@1:    MOV     EAX,[EAX].FBits
        OR      Value,Value
        JZ      @@2
        BTS     [EAX],Index
        RET

@@2:    BTR     [EAX],Index
        RET

@@Size: CMP     Index,0
        JL      TMyTBits.Error
        PUSH    Self
        PUSH    Index
        PUSH    ECX {Value}
        INC     Index
        CALL    TMyTBits.SetSize
        POP     ECX {Value}
        POP     Index
        POP     Self
        JMP     @@1
end;

function TMyTBits.GetBit(Index: Integer): Boolean; assembler;
asm
        CMP     Index,[EAX].FSize
        JAE     TMyTBits.Error
        MOV     EAX,[EAX].FBits
        BT      [EAX],Index
        SBB     EAX,EAX
        AND     EAX,1
end;

function TMyTBits.GetBitInBlock(Index, blockIndex: Integer): Boolean;
begin
	result := GetBit(FBlockSize * blockIndex + Index)
end;

procedure TMyTBits.SetBitInBlock(Index, blockIndex: Integer; value: boolean);
begin
	SetBit(FBlockSize * blockIndex + Index, value)
end;

function TMyTBits.OpenBit: Integer;
var
  I: Integer;
  B: TBitSet;
  J: TBitEnum;
  E: Integer;
begin
  E := (Size + BitsPerInt - 1) div BitsPerInt - 1;
  for I := 0 to E do
    if PBitArray(FBits)^[I] <> [0..BitsPerInt - 1] then
    begin
      B := PBitArray(FBits)^[I];
      for J := Low(J) to High(J) do
      begin
        if not (J in B) then
        begin
          Result := I * BitsPerInt + J;
          if Result >= Size then Result := Size;
          Exit;
        end;
      end;
    end;
  Result := Size;
end;

end.
