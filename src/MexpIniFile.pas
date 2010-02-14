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


unit MexpIniFile;

interface

uses Windows, Classes, SysUtils, QStringlist, MyMemoryStream;

type
	TData = class(TObject)
	public
		size: Word;
		p: Pointer;
	end;

type
	TMexpIniFile = class(TObject)
	private
    FChanged: Boolean;

		Ffilename: String;
		Flist: TQ_StringList;
    FClearing: Boolean;
		procedure LoadFromFile;
		procedure FreeMemory(const index: Integer; const removeFromList: Boolean = false);
		Function PrepareWrite(const Name: String): TData;
	public
		constructor Create(const filename: String); overload;
		destructor Destroy; override;

		function ValueExists(const name: String):boolean;
		procedure ClearAllValues;

    procedure WriteToFile;

		function ReadBinaryData(const Name: string; var Buffer; BufSize: Integer): Integer;
		function ReadBool(const Name: string): Boolean;
		function ReadInteger(const Name: string): Integer;
		function ReadString(const Name: string): string;
		function ReadDate(const Name: string): TDateTime;

		procedure WriteBinaryData(const Name: string; var Buffer; BufSize: Integer);
		procedure WriteBool(const Name: string; Value: Boolean);
		procedure WriteInteger(const Name: string; Value: Integer);
		procedure WriteString(const Name, Value: string);
		procedure WriteDate(const Name: string; Value: TDateTime);
	end;

implementation

procedure WriteNullTermString(FStr: TStream; const s: String);
var
	c: byte;
begin
	c := 0;
	if length(s) > 0 then
		FStr.Write(s[1], length(s));
	FStr.Write(c, 1)
end;

function ReadStringUntilNull(FStr: TStream): String;
var
	c: byte;
  i: integer;
begin
	SetLength(result, 255);
  i := 1;
	while (FStr.Position < FStr.Size) and (i < 255) do
	begin
		FStr.Read(c, 1);
		if c = 0 then
			break
		else
			result[i] := chr(c);
    inc(i)
	end;
  SetLength(result, i-1);
end;

constructor TMexpIniFile.Create(const filename: String);
begin
	Ffilename := filename;
	FList := TQ_StringList.Create;
	FList.CaseSensitive := false;
	FList.Sorted := true;
  FChanged := false;
  FClearing := false;
	LoadFromFile;
end;

destructor TMexpIniFile.Destroy;
begin
	WriteToFile;
	ClearAllValues;
	FList.Free
end;

procedure TMexpIniFile.FreeMemory(const index: Integer; const removeFromList: Boolean = false);
var
	data: TData;
begin
	if (index < FList.Count) and assigned(FList.Objects[index]) then
  begin
		data := TData(FList.Objects[index]);
    try
			FreeMem(data.p, data.Size);
      data.Free;
    except
  	end;
		if removeFromList then
			FList.Delete(index)
		else
			FList.Objects[index] := nil
  end
end;

function TMexpIniFile.ValueExists(const name: String):Boolean;
var
	i: Integer;
begin
	result := FList.Find(name, i)
end;

procedure TMexpIniFile.ClearAllValues;
var
	i: Integer;
begin
	if FClearing then exit;

	FClearing := true;
	for i:=0 to Flist.Count-1 do
		FreeMemory(i, false);
	FList.clear;
  FClearing := false;
  FChanged := true
end;

procedure TMexpIniFile.WriteToFile;
const
	CRLF: Array[1..2] of Char = #13#10;
var
	Str: TMyMemoryStream;
	i: Integer;
	data: TData;
begin
  if not FChanged then
  	exit;

  Str := TMyMemoryStream.Create;
	for i:=0 to FList.Count-1 do
	begin
		data := TData(FList.Objects[i]);
		WriteNullTermString(Str, FList.Strings[i]);
		Str.Write(data.Size, SizeOf(data.Size));
		Str.Write(data.p^, data.Size);
		Str.Write(CRLF, 2)
	end;
  Str.SaveToFile(fFilename);
	Str.Free;

  FChanged := false
end;

procedure TMexpIniFile.LoadFromFile;
var
	data: TData;
	Str: TMemoryStream;
	s: String;
begin
	if FileExists(Ffilename) then
	begin
    Str := TMemoryStream.Create;
    Str.LoadFromFile(fFilename);

		while str.Position < str.Size do
		begin
			s := ReadStringUntilNull(str);
			data := TData.Create;
			Str.Read(data.Size, SizeOf(data.Size));
			GetMem(data.p, data.size);
			Str.Read(data.p^, data.size);
			Str.Seek(2, soFromCurrent);
			FList.AddObject(s, data);
		end;
		Str.free;
    FChanged := false
	end
end;

function TMexpIniFile.ReadBinaryData(const Name: string; var Buffer; BufSize: Integer): Integer;
var
	index: Integer;
	data: TData;
begin
	if FList.Find(Name, index) then
	begin
		data := TData(FList.Objects[index]);
		//min:
		result := data.size;
		if BufSize < result then
			result := BufSize;
		//eo min
		move(data.p^, Buffer, result)
	end;
end;

function TMexpIniFile.ReadBool(const Name: string): Boolean;
var
	index: Integer;
	data: TData;
begin
	result := false;
	if FList.Find(Name, index) then
	begin
		data := TData(FList.Objects[index]);
		result := boolean(data.p^)
	end
end;

function TMexpIniFile.ReadInteger(const Name: string): Integer;
var
	index: Integer;
	data: TData;
begin
	result := 0;
	if FList.Find(Name, index) then
	begin
		data := TData(FList.Objects[index]);
		result := Integer(data.p^)
	end
end;

function TMexpIniFile.ReadString(const Name: string): string;
var
	index: Integer;
	data: TData;
begin
	result := '';
	if FList.Find(Name, index) then
	begin
		data := TData(FList.Objects[index]);
		result := pchar(data.p)
	end
end;

function TMexpIniFile.ReadDate(const Name: string): TDateTime;
var
	index: Integer;
begin
	if FList.Find(Name, index) then
		ReadBinaryData(Name, result, SizeOf(Result))
end;

//------------------------- WRITE METHODS ----------------------------------------------

Function TMexpIniFile.PrepareWrite(const Name: String): TData;
var
	Index: Integer;
begin
	if FList.Find(Name, index) then
	begin
		result := TData(FList.Objects[index]);
		FreeMem(result.p, result.Size)
	end
	else
	begin
		result := TData.Create;
		Index := FList.AddObject(Name, result)
	end
end;

procedure TMexpIniFile.WriteBinaryData(const Name: string; var Buffer; BufSize: Integer);
var
	data: TData;
begin
	data := PrepareWrite(Name);
	data.Size := BufSize;
	GetMem(data.p, data.Size);
	move(Buffer, data.p^, BufSize);
  FChanged := true
end;

procedure TMexpIniFile.WriteBool(const Name: string; Value: Boolean);
var
	data: TData;
begin
	data := PrepareWrite(Name);
	data.size := SizeOf(Boolean);
	GetMem(data.p, data.size);
	move(Value, data.p^, data.Size);
  FChanged := true
end;

procedure TMexpIniFile.WriteInteger(const Name: string; Value: Integer);
var
	data: TData;
begin
	data := PrepareWrite(Name);
	data.size := SizeOf(Integer);
	GetMem(data.p, data.size);
	move(Value, data.p^, data.Size);
  FChanged := true
end;

procedure TMexpIniFile.WriteString(const Name, Value: string);
var
	data: TData;
begin
	data := PrepareWrite(Name);
	data.size := length(Trim(Value))+1;
	GetMem(data.p, data.size);
	StrCopy(data.p, Pchar(Value));
  FChanged := true
	//pchar(data.p) := pchar(Value)
end;

procedure TMexpIniFile.WriteDate(const Name: string; Value: TDateTime);
begin
	WriteBinaryData(Name, Value, SizeOf(Value));
  FChanged := true
end;

end.
 