unit VirtualTreesEx;

interface
  uses Graphics, Classes, Windows, VirtualTrees;

type
  TVirtualStringTreeEx = class(TVirtualStringTree)
  private
    FOnGetNodeWidth: TVTGetNodeWidthEvent;
  protected
    function DoGetNodeWidth(Node: PVirtualNode; Column: TColumnIndex; Canvas: TCanvas = nil): Integer; override;
  public
    function InvalidateCell(Node: PVirtualNode; Column: TColumnIndex): TRect;
  published
    property OnGetNodeWidth: TVTGetNodeWidthEvent read FOnGetNodeWidth write FOnGetNodeWidth;
end;
procedure Register;

implementation

  function TVirtualStringTreeEx.DoGetNodeWidth(Node: PVirtualNode; Column: TColumnIndex; Canvas: TCanvas = nil): Integer;
  begin
    Result := Inherited DoGetNodeWidth(Node, Column, Canvas);

    if Assigned(FOnGetNodeWidth) then
    begin
    	if Canvas = nil then
      	Canvas := Self.Canvas;
      FOnGetNodeWidth(Self, Canvas, Node, Column, Result);
    end
  end;

  function TVirtualStringTreeEx.InvalidateCell(Node: PVirtualNode; Column: TColumnIndex): TRect;
  begin
  	if (UpdateCount = 0) and HandleAllocated then
    begin
      Result := GetDisplayRect(Node, Column, false);
      InvalidateRect(Handle, @Result, False);
    end;
  end;


procedure Register;
begin
	RegisterComponents('MEXP', [TVirtualStringTreeEx]);
end;


end.
