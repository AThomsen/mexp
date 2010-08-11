unit QCSStringList;
//Case sensitive

interface
uses
    Classes, QStrings, math;

type
  TQCS_StringList = class(TStringList)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
        procedure Sort; override;
        function Find(const S: string; var Index: Integer): Boolean; override;
    { Public declarations }
  published
    { Published declarations }
  end;

implementation

function QStringsCompare(List: TStringList; Index1, Index2: Integer): Integer;
begin
     Result := //AnsiCompare(List.Strings[Index2], List.Strings[Index1], -1, -1, 0)
     Q_CompStr(List.Strings[Index1], List.Strings[Index2]);
end;

Procedure TQCS_StringList.Sort;
begin
     CustomSort(QStringsCompare)
end;

function TQCS_StringList.Find(const S: string; var Index: Integer): Boolean;
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
end;
end.
