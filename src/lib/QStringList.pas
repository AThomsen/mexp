unit QStringList;

interface
uses
    Classes, QStrings,
     {$IFDEF VER150} //This is for Delphi 7
    RTLConsts 
    {$ELSE}
    Consts
    {$ENDIF}
    ;

type
  TQ_StringList = class;

  PStringItem = ^TStringItem;
  TStringItem = record
    FObject: TObject;
    FString: string;
  end;

  PStringItemList = ^TStringItemList;
  TStringItemList = array[0..MaxListSize] of TStringItem;
  TQ_StringListSortCompare = function(List: TQ_StringList; Index1, Index2: Integer): Integer;

  TQ_StringList = class(TStrings)
  private
  	FCaseSensitive: Boolean;
    FList: PStringItemList;
    FCount: Integer;
    FCapacity: Integer;
    FSorted: Boolean;
    FDuplicates: TDuplicates;
    FOnChange: TNotifyEvent;
    FOnChanging: TNotifyEvent;
    procedure ExchangeItems(Index1, Index2: Integer);
    procedure Grow;
    procedure QuickSort(L, R: Integer; SCompare: TQ_StringListSortCompare);
    procedure InsertItem(Index: Integer; const S: string);
    procedure SetSorted(Value: Boolean);
    function FindCaseSensitive(const S: string; var Index: Integer): Boolean;
		function FindCaseInsensitive(const S: string; var Index: Integer): Boolean;
    procedure FSetCaseSensitive(value: Boolean);
  protected
    function Get(Index: Integer): string; override;
    function GetCapacity: Integer; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetCapacity(NewCapacity: Integer); override;
  public
    destructor Destroy; override;
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    function Find(const S: string; var Index: Integer): Boolean; virtual;
    function IndexOf(const S: string): Integer; override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Sort; virtual;
    procedure CustomSort(Compare: TQ_StringListSortCompare); virtual;
    property Duplicates: TDuplicates read FDuplicates write FDuplicates;
    property CaseSensitive: Boolean read FCaseSensitive write FSetCaseSensitive;
    property Sorted: Boolean read FSorted write SetSorted;
  end;

implementation

	{ TQ_StringList }

destructor TQ_StringList.Destroy;
begin
  FOnChange := nil;
  FOnChanging := nil;
  inherited Destroy;
  if FCount <> 0 then Finalize(FList^[0], FCount);
  FCount := 0;
  SetCapacity(0);
end;

function TQ_StringList.Add(const S: string): Integer;
begin
  if not Sorted then
    Result := FCount
  else
    if Find(S, Result) then
      case Duplicates of
        dupIgnore: Exit;
        dupError: Error(@SDuplicateString, 0);
      end;
  InsertItem(Result, S);
end;

procedure TQ_StringList.FSetCaseSensitive(value: Boolean);
begin
	FCaseSensitive := value;
	if Sorted then
		sort
end;

procedure TQ_StringList.Clear;
begin
  if FCount <> 0 then
  begin
    Finalize(FList^[0], FCount);
    FCount := 0;
    SetCapacity(0);
  end;
end;

procedure TQ_StringList.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then Error(@SListIndexError, Index);
//  Changing;
  Finalize(FList^[Index]);
  Dec(FCount);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index],
      (FCount - Index) * SizeOf(TStringItem));
//  Changed;
end;

procedure TQ_StringList.Exchange(Index1, Index2: Integer);
begin
  if (Index1 < 0) or (Index1 >= FCount) then Error(@SListIndexError, Index1);
  if (Index2 < 0) or (Index2 >= FCount) then Error(@SListIndexError, Index2);
//  Changing;
  ExchangeItems(Index1, Index2);
//  Changed;
end;

procedure TQ_StringList.ExchangeItems(Index1, Index2: Integer);
var
  Temp: Integer;
  Item1, Item2: PStringItem;
begin
  Item1 := @FList^[Index1];
  Item2 := @FList^[Index2];
  Temp := Integer(Item1^.FString);
  Integer(Item1^.FString) := Integer(Item2^.FString);
  Integer(Item2^.FString) := Temp;
  Temp := Integer(Item1^.FObject);
  Integer(Item1^.FObject) := Integer(Item2^.FObject);
  Integer(Item2^.FObject) := Temp;
end;

Function TQ_StringList.Find(const S: string; var Index: Integer): Boolean;
begin
	if FCaseSensitive then
		result := FindCaseSensitive(s, index)
	else
		result := FindCaseInsensitive(s, index)
end;

function TQ_StringList.FindCaseSensitive(const S: string; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
		C := Q_CompStr(FList^[I].FString, S);
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

function TQ_StringList.FindCaseInsensitive(const S: string; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Q_CompText(FList^[I].FString, S);
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

function TQ_StringList.Get(Index: Integer): string;
begin
  Result := FList^[Index].FString;
end;

function TQ_StringList.GetCapacity: Integer;
begin
  Result := FCapacity;
end;

function TQ_StringList.GetCount: Integer;
begin
  Result := FCount;
end;

function TQ_StringList.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then Error(@SListIndexError, Index);
  Result := FList^[Index].FObject;
end;

procedure TQ_StringList.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then Delta := FCapacity div 4 else
    if FCapacity > 8 then Delta := 16 else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

function TQ_StringList.IndexOf(const S: string): Integer;
begin
  if not Sorted then Result := inherited IndexOf(S) else
    if not Find(S, Result) then Result := -1;
end;

procedure TQ_StringList.Insert(Index: Integer; const S: string);
begin
  if Sorted then Error(@SSortedListError, 0);
  if (Index < 0) or (Index > FCount) then Error(@SListIndexError, Index);
  InsertItem(Index, S);
end;

procedure TQ_StringList.InsertItem(Index: Integer; const S: string);
begin
  if FCount = FCapacity then Grow;
  if Index < FCount then
    System.Move(FList^[Index], FList^[Index + 1],
      (FCount - Index) * SizeOf(TStringItem));
  with FList^[Index] do
  begin
    Pointer(FString) := nil;
    FObject := nil;
    FString := S;
  end;
  Inc(FCount);
end;

procedure TQ_StringList.Put(Index: Integer; const S: string);
begin
  if Sorted then Error(@SSortedListError, 0);
  if (Index < 0) or (Index >= FCount) then Error(@SListIndexError, Index);
  FList^[Index].FString := S;
end;

procedure TQ_StringList.PutObject(Index: Integer; AObject: TObject);
begin
  if (Index < 0) or (Index >= FCount) then Error(@SListIndexError, Index);
  FList^[Index].FObject := AObject;
end;

procedure TQ_StringList.QuickSort(L, R: Integer; SCompare: TQ_StringListSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;

procedure TQ_StringList.SetCapacity(NewCapacity: Integer);
begin
  ReallocMem(FList, NewCapacity * SizeOf(TStringItem));
  FCapacity := NewCapacity;
end;

procedure TQ_StringList.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    if Value then Sort;
    FSorted := Value;
  end;
end;

function QStringsCompareCaseSensitive(List: TQ_StringList; Index1, Index2: Integer): Integer;
begin
		 Result := Q_CompStr(List.FList^[Index1].FString, List.FList^[Index2].FString);
end;

function QStringsCompareCaseInsensitive(List: TQ_StringList; Index1, Index2: Integer): Integer;
begin
		 Result := Q_CompText(List.FList^[Index1].FString, List.FList^[Index2].FString);
end;

Procedure TQ_StringList.Sort;
begin
	if FCaseSensitive then
		CustomSort(QStringsCompareCaseSensitive)
	else
		CustomSort(QStringsCompareCaseInsensitive)
end;

procedure TQ_StringList.CustomSort(Compare: TQ_StringListSortCompare);
begin
  if not Sorted and (FCount > 1) then
  begin
    QuickSort(0, FCount - 1, Compare);
  end;
end;

{type
  TQ_StringList = class(TStringList)
	private
		FCaseSensitive: Boolean;
		procedure FSetCaseSensitive(value: Boolean);
		function FindCaseSensitive(const S: string; var Index: Integer): Boolean;
		function FindCaseInsensitive(const S: string; var Index: Integer): Boolean;

	public
		constructor Create; overload;
		procedure Sort; override;
		function Find(const S: string; var Index: Integer): Boolean; override;
		property CaseSensitive: Boolean read FCaseSensitive write FSetCaseSensitive;
	end;

implementation

function QStringsCompareCaseSensitive(List: TQ_StringList; Index1, Index2: Integer): Integer;
begin
		 Result := Q_CompStr(List.Strings[Index1], List.Strings[Index2]);
end;

function QStringsCompareCaseInsensitive(List: TQ_StringList; Index1, Index2: Integer): Integer;
begin
		 Result := Q_CompText(List.Strings[Index1], List.Strings[Index2]);
end;

procedure TQ_StringList.FSetCaseSensitive(value: Boolean);
begin
	FCaseSensitive := value;
	if Sorted then
		sort
end;

constructor TQ_StringList.create;
begin
	inherited create;
	FCaseSensitive := false;
end;

Procedure TQ_StringList.Sort;
begin
	if FCaseSensitive then
		CustomSort(QStringsCompareCaseSensitive)
	else
		CustomSort(QStringsCompareCaseInsensitive)
end;

Function TQ_StringList.Find(const S: string; var Index: Integer): Boolean;
begin
	if FCaseSensitive then
		result := FindCaseSensitive(s, index)
	else
		result := FindCaseInsensitive(s, index)
end;

function TQ_StringList.FindCaseSensitive(const S: string; var Index: Integer): Boolean;
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

function TQ_StringList.FindCaseInsensitive(const S: string; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Q_CompText(Strings[I], S);
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
            }
end.
