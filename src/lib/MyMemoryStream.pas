unit MyMemoryStream;

interface
uses Windows, Classes, Consts;

type
	TMyMemorystream = class(TMemorystream)
  	public
    	public reallocCount: integer;
    	function CopyFrom(Source: TStream; Count: Longint; MaxBufSize: longint): Longint; overload;
      Procedure SetCapacity(newCapacity: LongInt);
    protected
    	function Realloc(var NewCapacity: Longint): Pointer; override;
end;

implementation

const
  MemoryDelta = $100000; { Must be a power of 2 }

function TMyMemorystream.CopyFrom(Source: TStream; Count: Longint; MaxBufSize: longint): Longint;
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
      WriteBuffer(Buffer^, N);
      Dec(Count, N);
    end;
  finally
    FreeMem(Buffer, BufSize);
  end;
end;

Procedure TMyMemoryStream.SetCapacity(newCapacity: LongInt);
begin
	Capacity := newCapacity;
end;

function TMyMemoryStream.Realloc(var NewCapacity: Longint): Pointer;
begin
	if Capacity = 0 then
  	reallocCount := 1
  else
  	inc(reallocCount);
  if NewCapacity > 0 then
    NewCapacity := (NewCapacity + (MemoryDelta - 1)) and not (MemoryDelta - 1);
  Result := Memory;
  if NewCapacity <> Capacity then
  begin
    if NewCapacity = 0 then
    begin
      GlobalFreePtr(Memory);
      Result := nil;
    end else
    begin
      if Capacity = 0 then
        Result := GlobalAllocPtr(HeapAllocFlags, NewCapacity)
      else
        Result := GlobalReallocPtr(Memory, NewCapacity, HeapAllocFlags);
      if Result = nil then raise EStreamError.CreateRes(@SMemoryStreamError);
    end;
  end;
end;

end.
 