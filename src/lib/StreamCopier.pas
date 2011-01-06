unit StreamCopier;
interface
uses
	Classes, SysUtils, math;

	procedure MoveStreamContents(Fstr: TStream; delta: Integer);
	
implementation

procedure MoveStreamContents(Fstr: TStream; delta: Integer);  //delta angiver hvor meget større streamen skal blive
var
	ByteArr: array[1..51200] of byte; //flytter 50 kilobyte
	Transferred, BlockSize : integer;
	BytesMoved: Cardinal;
begin
  BytesMoved := 0;
	if delta > 0 then   //filen skal gøres større
	begin
		Fstr.Size := Fstr.Size + delta; //udvider filen
		BlockSize := min(Fstr.Size - delta, SizeOf(ByteArr));
		while BytesMoved < Fstr.Size - delta do
		begin
			Fstr.Position := Fstr.Size - delta - BytesMoved - BlockSize;
			Transferred := Fstr.Read(ByteArr, BlockSize);
			inc(BytesMoved, Transferred);
			FStr.Position := FStr.Size - BytesMoved;
			Fstr.Write(ByteArr, Transferred);
			BlockSize := min(Fstr.Size - delta - BytesMoved, SizeOf(ByteArr))
		end
	end else
	if delta < 0 then    //filen skal gøres mindre
	begin
			BlockSize := min(Fstr.Size, SizeOf(ByteArr));
			while BytesMoved < Fstr.Size + delta do  //+ delta, da delta er negativ
			begin
				Fstr.Position := BytesMoved - delta;
				Transferred := FStr.Read(ByteArr, BlockSize);
				Fstr.Position := BytesMoved;
				Fstr.Write(ByteArr, Transferred);
				inc(BytesMoved, Transferred)
			end;
			Fstr.Size := FStr.Size + delta
	end
end;

end.
