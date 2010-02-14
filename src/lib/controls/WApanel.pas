unit WApanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ExtCtrls, ColorConv, SpecialPanel;

type
	TWApanel = class(TSpecialPanel)
	private
        Fext3d : Boolean;
        FExt3dWidth : Integer;
        FPaintTop, FPaintLeft, FPaintRight, FPaintBottom:Boolean;
		{ Private declarations }
  protected
        procedure paint; override;
    { Protected declarations }
  public
    { Public declarations }
  published
        Property Ext3d : Boolean         read   Fext3d  write Fext3d;
        Property Ext3dWidth : Integer    read   FExt3dWidth write FExt3dWidth;
        Property PaintLeft : Boolean    read FPaintLeft         write FPaintLeft;
        Property PaintTop : Boolean    read FPaintTop         write FPaintTop;
        Property PaintRight : Boolean    read FPaintRight         write FPaintRight;
        Property PaintBottom : Boolean    read FPaintBottom         write FPaintBottom;
    { Published declarations }
  end;

  Procedure PaintWA(Can: TCanvas; R : Trect; Color:Tcolor; Raized:Boolean; PaintLeft:Boolean; PaintTop:Boolean; PaintRight:Boolean; PaintBottom:Boolean); overload;
  Procedure PaintWA(Can: TCanvas; R : Trect; Color:Tcolor; Ctop, Cright, Cbottom, Cleft : Integer; Raized:Boolean; PaintLeft:Boolean; PaintTop:Boolean; PaintRight:Boolean; PaintBottom:Boolean); overload;
	Procedure PaintWAmixColor(Can: TCanvas; R : Trect; Color:Tcolor; Raized:Boolean; PaintLeft:Boolean; PaintTop:Boolean; PaintRight:Boolean; PaintBottom:Boolean);
	Procedure TileDraw(canvas: TCanvas; bitmap: TBitmap; bounds: TRect);

procedure Register;

implementation

Procedure TileDraw(canvas: TCanvas; bitmap: TBitmap; bounds: TRect);
var
	x, y: Integer;
	yExeedsBounds: Boolean;
begin
  y := bounds.Top;
	while y < bounds.Bottom do
	begin
		yExeedsBounds := y + bitmap.Height > bounds.Bottom;
		x := bounds.Left;
		while x < bounds.Right do
		begin
			if yExeedsBounds or (x + bitmap.Width > bounds.Right) then
				//canvas.CopyRect(rect(x, y, bounds.Right, bounds.Bottom), bitmap.Canvas, bitmap.Canvas.ClipRect)
        BitBlt(canvas.handle, x, y, bounds.right, bounds.bottom, bitmap.canvas.handle, 0, 0, SRCCOPY)
			else
//				canvas.Draw(x, y, bitmap);
      	BitBlt(canvas.handle, x, y, bitmap.width, bitmap.Height, bitmap.canvas.Handle, 0, 0, SRCCOPY);
			inc(x, bitmap.Width)
		end;
		inc(y, bitmap.Height)
	end
end;

Procedure PaintWA(Can: TCanvas; R : Trect; Color:Tcolor; Raized:Boolean; PaintLeft:Boolean; PaintTop:Boolean; PaintRight:Boolean; PaintBottom:Boolean); overload;
Const
        Ctop = 75;
        Cright = -30;
        Cbottom = -20;
        Cleft = 90;
begin
	PaintWA(Can, R, Color, Ctop, Cright, Cbottom, Cleft, Raized, PaintLeft, PaintTop, PaintRight, PaintBottom)
end;

Procedure PaintWA(Can: TCanvas; R : Trect; Color:Tcolor; Ctop, Cright, Cbottom, Cleft : Integer; Raized:Boolean; PaintLeft:Boolean; PaintTop:Boolean; PaintRight:Boolean; PaintBottom:Boolean); overload;
begin
        with can do begin
        pen.Mode := pmCopy;
        pen.Style := psSolid;
        pen.Width := 1;

        if raized then pen.color := ChangeBrightness(Color, Ctop) else pen.color := ChangeBrightness(Color, Cbottom);
        moveto(r.left, r.top);
        if PaintTop then lineto(r.right, r.top) else moveto(r.right, r.top);

        if raized then pen.color := ChangeBrightness(Color, Cright) else pen.color := ChangeBrightness(Color, Cleft);
        if PaintRight then lineto(r.right, r.Bottom) else moveto(r.right, r.Bottom);

        if raized then pen.color := ChangeBrightness(Color, Cbottom) else pen.color := ChangeBrightness(Color, Ctop);
        if PaintBottom then lineto(r.Left, r.Bottom) else moveto(r.Left, r.Bottom);

        if raized then pen.color := ChangeBrightness(color, Cleft) else pen.color := ChangeBrightness(Color, Cright);
        if PaintLeft then lineto(r.Left, r.Top) else moveto(r.Left, r.Top)
        end
end;

Procedure PaintWAmixColor(Can: TCanvas; R : Trect; Color:Tcolor; Raized:Boolean; PaintLeft:Boolean; PaintTop:Boolean; PaintRight:Boolean; PaintBottom:Boolean);
begin
        with can do begin
        pen.Mode := pmCopy;
        pen.Style := psSolid;
        pen.Width := 1;

        if raized then pen.color := mixColors(color, clWhite) else pen.color := mixColors(color, clBlack);
        moveto(r.left, r.top);
        if PaintTop then lineto(r.right, r.top) else moveto(r.right, r.top);

        if raized then pen.color := mixColors(color, clWhite) else pen.color := mixColors(color, clBlack);
        if PaintRight then lineto(r.right, r.Bottom) else moveto(r.right, r.Bottom);

        if raized then pen.color := mixColors(color, clBlack) else pen.color := mixColors(color, clWhite);
        if PaintBottom then lineto(r.Left, r.Bottom) else moveto(r.Left, r.Bottom);

        if raized then pen.color := mixColors(color, clBlack) else pen.color := mixColors(color, clWhite);
        if PaintLeft then lineto(r.Left, r.Top) else moveto(r.Left, r.Top)
        end
end;

procedure TWApanel.Paint;
Const
        Ctop = 50;
        Cright = -30;
        Cbottom = -20;
        Cleft = 20;

        Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var     BW:integer;
        re:Trect;
        FontHeight: Integer;
        Flags: Longint;
begin
//        inherited Paint;
  re := GetClientRect;
  with Canvas do
  begin
    Brush.Color := Color;
    FillRect(Re);
    Re.Left := Re.Left + 5;
    Re.Right := Re.Right -5;
    Brush.Style := bsClear;
    Font := Self.Font;
    FontHeight := TextHeight('W');
    with Re do
    begin
      Top := ((Bottom + Top) - FontHeight) div 2;
      Bottom := Top + FontHeight;
    end;
    Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[Alignment];
    Flags := DrawTextBiDiModeFlags(Flags);
    DrawText(Handle, PChar(Caption), -1, Re, Flags);
  end;

if FExt3d then
begin
        with canvas do
                if FExt3dWidth > 1 then
                begin
                        pen.Mode := pmCopy;
                        pen.Style := psDot;
                        pen.Width := 1;
                        brush.style := bsSolid;
                        BW := FExt3dWidth;

                        //top
                        pen.Color := ChangeBrightness(self.Color, Ctop);
                        brush.color := pen.color;
                        polygon([point(0,0), point(clientwidth, 0), point(clientwidth - BW, BW), point(bw, bw)]);

                        //højre
                        pen.Color := ChangeBrightness(self.Color, Cright);
                        brush.color := pen.color;
                        polygon([point(clientwidth,0), point(clientwidth, clientheight), point(clientwidth - BW, clientheight - BW), point(clientwidth - bw, bw)]);

                        //bund:
                        pen.Color := ChangeBrightness(self.Color, Cbottom);
                        brush.color := pen.color;
                        polygon([point(clientwidth,clientheight), point(0, clientheight), point(BW, clientheight - BW), point(clientwidth - bw, clientheight - bw)]);

                         //venstre
                        pen.Color := ChangeBrightness(self.Color, Cleft);
                        brush.color := pen.color;
                        polygon([point(0, 0), point(BW, BW), point(BW, clientheight - BW), point(0, clientheight)])
                end else
                begin
                        PaintWA(canvas, rect(0,0,clientwidth, clientheight-1), self.color, true, FPaintLeft, FPaintTop, FPaintRight, FPaintBottom)

                end;
  end;
  if assigned(onPaint) then
  	onPaint(self, Canvas);
end;

procedure Register;
begin
  RegisterComponents('Thomsen', [TWApanel]);
end;

end.
