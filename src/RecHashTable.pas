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


unit RecHashTable;

interface
uses
    Classes, QStrings, MexpTypes;

type
  TRecHashTable = class(TList)
  private
    { Private declarations }
   // fList: TList;
  protected
    { Protected declarations }
  public
  	function FindFilename(const filename: string; var Index: Integer): Boolean; overload;
    function FindFilename(const filename: string; hash:LongWord; var Index: Integer): Boolean; overload;
    function FindRec(rec: PRec; var index: Integer): Boolean;
    { Public declarations }
//    constructor Create;
//    destructor Destroy; override;
    procedure AddRec(rec: PRec; insertSorted: boolean);
//    procedure SetCapacity(newCapacity: integer);
    procedure Sort; overload;
  end;

implementation
uses
	defs;

function SortComparer(Item1, Item2: Pointer): Integer;
var
	rec1, rec2: PRec;
begin
	if Item1 = Item2 then
  	result := 0
  else
  begin
 		rec1 := item1;
	  rec2 := item2;
	  if rec1.FilenameHash > rec2.FilenameHash then
	  	result := 1
	  else
	  if rec1.FilenameHash < rec2.FilenameHash then
	  	result := -1
	  else
    if rec1.Fpath > rec2.Fpath then
    	result := 1
    else
    if rec1.Fpath < rec2.Fpath then
    	result := -1
    else
	  	result := Q_PCompText(rec1.fName, rec2.fName)
  end
end;

procedure TRecHashTable.Sort;
begin
	Sort(SortComparer)
end;

Procedure TRecHashTable.AddRec(rec: PRec; insertSorted: boolean);
var
	i: integer;
begin
	if rec.FilenameHash = 0 then
  	rec.FilenameHash := Q_TextHashKey(FpathList.Strings[rec.fpath] + rec.fName);

	if insertSorted then
  begin
    FindRec(rec, i);
    Insert(i, rec)
  end
  else
  	Add(rec)
end;

function TRecHashTable.FindFilename(const filename: string; var Index: Integer): Boolean;
begin
	result := FindFilename(filename, Q_TextHashKey(filename), index);
end;

function TRecHashTable.FindFilename(const filename: string; hash:LongWord; var Index: Integer): Boolean;
Function Compare(rec: PRec): integer;
begin
	if rec.FilenameHash > hash then
  	result := 1
  else
  if rec.FilenameHash < hash then
  	result := -1
  else
  	result := Q_CompText(FpathList.strings[rec.fPath] + rec.fName, filename)
end;
var
  H, I, C: Integer;
begin
  Result := False;
  index := 0;
  H := Count - 1;
  while index <= H do
  begin
    I := (index + H) shr 1;
    //C := Q_CompStr(Strings[I], S);
    C := Compare(List^[i]);
    if C < 0 then Index := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        index := I;
      end;
    end;
  end;
end;

function TRecHashTable.FindRec(rec: PRec; var index: Integer): Boolean;
var
  H, I, C: Integer;
begin
  Result := False;
  index := 0;
  H := Count - 1;
  while index <= H do
  begin
    I := (index + H) shr 1;
    //C := Q_CompStr(Strings[I], S);
    C := SortComparer(List^[i], rec);
    if C < 0 then Index := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        index := I;
      end;
    end;
  end;
end;

{function TQCS_StringList.Find(const S: string; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Q_CompStr(Strings[I], S);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then L := I;
      end;
    end;
  end;
  Index := L;
end;                }

end.
