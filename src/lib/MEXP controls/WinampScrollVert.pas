unit WinampScrollVert;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ExtCtrls, math, WApanel, ColorConv;

type
	TOnScroll = procedure(Sender: TObject; SBcode:Integer; Param:Integer) of object;
	TOnGetImage = procedure(Sender: TObject; Horizontal: boolean; index: Integer; out bitmap: TBitmap) of object;

	TWinampScrollVert = class(TPanel)
  private
				Ftimer : TTimer;
				Fmin: Integer;
        Fmax: Integer;
        Fpos: Integer;
        FpageSize: Integer;
        Fshowslider:boolean;
				FOnScroll : TOnScroll;
				FOnGetImage: TOnGetImage;
				Fcolor : Tcolor;
				FPaintTop, FPaintLeft, FPaintRight, FPaintBottom:Boolean;
				FHoriz : Boolean;

				FBitmapped: Boolean;
				FupArrowHeight, FtrackbarYpos, FtrackbarStopFromButton: Integer;

        FMouseDragging : Boolean;

        SlBoundsMin : Integer;
        SlBoundsMax : Integer;
				TrackHeight : Integer;
        deltaThumbHeight : integer;
        Capturing : Boolean;
        MouseDownSpot : Tpoint;
        MouseDeltaY : Integer;
        ThumbScrolling : Boolean;
				ArrowHeight : integer;

        Procedure FChangePos(value:integer);
				Procedure FChangeMin(value:integer);
        Procedure FChangeMax(value:integer);
        Procedure FShowSliderChange(value : Boolean);
        Procedure FChangeColor(value : Tcolor);
				Procedure FHorizChange(value : Boolean);

        Procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        Procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        //procedure MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
        procedure MouseMove(var msg: TWMMouseMove); message WM_MOUSEMOVE;
        procedure OnTimer(Sender: TObject);
    { Private declarations }
  protected
				procedure paint; override;
    { Protected declarations }
  public
        constructor create(AOwner: TComponent);override;
        destructor Destroy; override;
    { Public declarations }
  published
				Property				Bitmapped: Boolean			read FBitmapped write FBitmapped;
				Property        BM_UpArrowHeight :Integer read FupArrowHeight       write FupArrowHeight;
				Property        TrackbarYpos :Integer read FtrackbarYpos       write FtrackbarYpos;
				Property        BM_TtrackbarStopFromBottom :Integer read FtrackbarStopFromButton       write FtrackbarStopFromButton;

				Property        SMin :Integer           read Fmin       write Fmin;
        Property        SMax :Integer           read Fmax       write Fmax;
				Property        PageSize :Integer       read FpageSize  write Fpagesize;
        Property        Position:Integer        read Fpos       write FChangepos;
        Property        ShowSlider:Boolean      read Fshowslider write FShowSliderChange;
				property        OnScroll : TOnScroll    read FOnScroll  write FOnScroll;
				property				OnGetImage: TOnGetImage read FOnGetImage write FOnGetImage;
				property        Color : Tcolor          read Fcolor     write FChangeColor;
//				property        TopHeight : Integer     read FTopHeight write FTopHeight;
        property        Horizontal : Boolean    read Fhoriz     write FHorizChange;

        property        MouseDragging : Boolean    read FMouseDragging;

        Property PaintLeft : Boolean    read FPaintLeft         write FPaintLeft;
        Property PaintTop : Boolean    read FPaintTop         write FPaintTop;
        Property PaintRight : Boolean    read FPaintRight         write FPaintRight;
        Property PaintBottom : Boolean    read FPaintBottom         write FPaintBottom;

    { Published declarations }
  end;

procedure Register;

Const
        Delay1 = 400;
        Delay2 = 100;

//				StopHeight = 6;
//				SbundHeight = 6;
//        BundHeight = 1;
        MinSliderHeight = 20;

implementation

Procedure TWinampScrollVert.FChangeColor(value : Tcolor);
begin
        Fcolor := Value;
				invalidate
end;

Procedure TWinampScrollVert.FHorizChange(value : Boolean);
begin
	FHoriz := Value;
	if FHoriz then
		height := 13
	else
		width := 13;

	invalidate
end;

procedure TWinampScrollVert.OnTimer(Sender: TObject);
begin
	if Ftimer.Interval = delay1 then
		Ftimer.interval := delay2;
	MouseDown(Ftimer,mbleft , [], self.screentoclient(mouse.cursorpos).x, self.screentoclient(mouse.cursorpos).y)
end;

procedure TWinampScrollVert.MouseMove(var msg: TWMMouseMove);
var     pos, i:Integer;
begin
	if Capturing and ThumbScrolling then
	begin
		if FHoriz then
			i:= msg.XPos
		else i:=msg.YPos;

		Ftimer.enabled := false;
		pos := round(((i - mouseDeltaY - FtrackbarYpos) / (TrackHeight-deltaThumbHeight)) * Fmax);
		OnScroll(self, SB_THUMBPOSITION, pos)
	end;

  if assigned(OnMouseMove) then
  	OnmouseMove(self, KeysToShiftState(msg.keys), msg.Pos.x, msg.pos.y)
end;

{
procedure TWinampScrollVert.MouseMove(Sender: TObject;
	Shift: TShiftState; X, Y: Integer);
var     pos, i:Integer;
begin
	if Capturing and ThumbScrolling then
	begin
		if FHoriz then
			i:=x
		else i:=y;

		Ftimer.enabled := false;
		pos := round(((i - mouseDeltaY - FtrackbarYpos) / (TrackHeight-deltaThumbHeight)) * Fmax);
		OnScroll(self, SB_THUMBPOSITION, pos)
	end
end; }

Procedure TWinampScrollVert.MouseDown(Sender: TObject;
	Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	if not Capturing then SetCapture(self.canvas.Handle);
	FMouseDragging := true;
	Capturing := true;

	if FHoriz then
	begin
		if (x >= SlBoundsMin) and (x <= SlBoundsMax) then   //trykkes der på sliderknappen
		begin
			MouseDownSpot := point(x, y);
			MouseDeltaY := x - SlBoundsMin;
			ThumbScrolling := true
		end else
		begin
			if sender <> Ftimer then Ftimer.Interval := delay1;
			Ftimer.enabled := true;
			ThumbScrolling := false;

			if (FBitmapped and (x <= FupArrowHeight)) or (not FBitmapped and (x <= ArrowHeight +2)) then OnScroll(self, SB_LINEUP, 0) else
			if (FBitmapped and (x < FtrackbarYpos)) or (not FBitmapped and (x in [ArrowHeight +2..(2*ArrowHeight) +4])) then OnScroll(self, SB_LINEDOWN, 0) else
			if x < SlBoundsMin then OnScroll(self, SB_PAGEUP, 0) else
			if x > SlBoundsMax then OnScroll(self, SB_PAGEDOWN, 0)
		end
	end
	else
	begin
		if (y >= SlBoundsMin) and (y <= SlBoundsMax) then  	//trykkes der på sliderknappen
		begin
			MouseDownSpot := point(x, y);
			MouseDeltaY := y - SlBoundsMin;
			ThumbScrolling := true
		end
		else
		begin
			if sender <> Ftimer then Ftimer.Interval := delay1;
			Ftimer.enabled := true;
			ThumbScrolling := false;

			if (FBitmapped and (y <= FupArrowHeight)) or (not FBitmapped and (y <= ArrowHeight +2)) then OnScroll(self, SB_LINEUP, 0) else
			if (FBitmapped and (y < FtrackbarYpos)) or (not FBitmapped and (y in [ArrowHeight +2..(2*ArrowHeight) +4])) then OnScroll(self, SB_LINEDOWN, 0) else
			if y < SlBoundsMin then OnScroll(self, SB_PAGEUP, 0) else
			if y > SlBoundsMax then OnScroll(self, SB_PAGEDOWN, 0)
		end
	end
end;

Procedure TWinampScrollVert.MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	Ftimer.enabled := false;
	ThumbScrolling := false;
	if Capturing then
	begin
		ReleaseCapture;
		Capturing := false
	end;
	FMouseDragging := false
end;

procedure TWinampScrollVert.Paint;
var
	bm, temp : Tbitmap;
	Ypos, SliderTotalHeight, i, BottomHeight, SliderTopHeight, SliderBottomHeight :integer;
	OnlyArrows : Boolean;
begin
	if (not visible) or (Width < 0) or (Height < 0) then
		exit;

	bm := Tbitmap.create;
	bm.width := Width;
	bm.height := Height;
	temp := nil;

	if FBitmapped then
		BottomHeight := FtrackbarStopFromButton
	else
		BottomHeight := 2;

	//finder TrackHeight
	if FHoriz then
		TrackHeight := math.max(Width - FtrackbarYpos - BottomHeight, 1)
	else
		TrackHeight := math.max(Height - FtrackbarYpos - BottomHeight, 1);

	if FBitmapped then
	begin
		yPos := 0;
		if assigned(FOnGetImage) then
		begin
			FOnGetImage(self, FHoriz, 4, temp);   //tegner top/left
			if assigned(temp) then
			begin
				bm.Canvas.Draw(0, 0, temp);
				if FHoriz then
					inc(yPos, temp.Width)
				else
					inc(yPos, temp.Height)
			end;

			FOnGetImage(self, FHoriz, 5, temp);   //tegner middle
			if assigned(temp) then
			begin
				if FHoriz then
					TileDraw(bm.Canvas, temp, rect(yPos, 0, Width, Height))
				else
					TileDraw(bm.Canvas, temp, rect(0, yPos, Width, Height))
			end;

			FOnGetImage(self, FHoriz, 6, temp);   //tegner Bottom/Right
			if assigned(temp) then
			begin
				if FHoriz then
					bm.Canvas.Draw(Width-temp.Width, 0, temp)
				else
					bm.Canvas.Draw(0, Height-temp.Height, temp)
			end
		end
	end
	else
	//ikke bitmapped:
	begin
		onlyarrows := false;
		
		if FHoriz then
			onlyarrows := not FBitmapped and (FtrackbarYpos > 0) and (Width < FtrackbarYpos + BottomHeight + MinSliderHeight + 2)
		else
			onlyarrows := not FBitmapped and (FtrackbarYpos > 0) and (Height < FtrackbarYpos + BottomHeight + MinSliderHeight + 2);

		bm.Canvas.brush.Color := Fcolor;
		bm.Canvas.brush.Style := bsSolid;
		bm.Canvas.FillRect(rect(0,0,Width, Height));
		PaintWA(bm.canvas, rect(0,0,Width-1, Height-1), Fcolor, true, FPaintLeft, FPaintTop, FPaintRight, FPaintBottom);

		bm.Canvas.brush.Color := ChangeBrightness(Fcolor, -10);
		if not OnlyArrows then
			if FHoriz then
			begin
				bm.Canvas.FillRect(rect(FtrackbarYpos, 3, Width-4, Height-1-BottomHeight));
				PaintWA(bm.canvas, rect(FtrackbarYpos, 3, Width-4, Height-1-BottomHeight), Fcolor, false, true, true, true, true);
			end else
			begin
				bm.Canvas.FillRect(rect(3, FtrackbarYpos, Width-4, Height-1-BottomHeight));
				PaintWA(bm.canvas, rect(3, FtrackbarYpos, Width-4, Height-1-BottomHeight), Fcolor, false, true, true, true, true);
			end;
		if FtrackbarYpos > 0 then
		begin   //tegner pile
			bm.Canvas.brush.color := ChangeBrightness(self.color, 100, true);
			bm.canvas.pen.color := ChangeBrightness(self.color, 100, true);
			if OnlyArrows then
				ArrowHeight :=  (Height div 2) -4
			else
				ArrowHeight :=  (FtrackbarYpos div 2) -4; {de 2 er til top/bund}
			Ypos := 2;
			if FHoriz then
			begin
				bm.Canvas.Polygon([point(Ypos, 6), point(Ypos + ArrowHeight, 9), point(Ypos + ArrowHeight, 3)]);

				Ypos := Ypos + ArrowHeight + 3;

				bm.Canvas.Polygon([point(ypos, 3), point(Ypos, 9), point(Ypos + ArrowHeight, 6)])
			end
			else
			begin
				bm.Canvas.Polygon([point(6, Ypos), point(9, Ypos + ArrowHeight), point(3, Ypos + ArrowHeight)]);

				Ypos := Ypos + ArrowHeight + 3;

				bm.Canvas.Polygon([point(3, Ypos), point(9, Ypos), point(6, Ypos + ArrowHeight)])
			end
		end
	end;

	if FBitmapped or (FshowSlider and not onlyarrows) then
	begin
		//Fpos Pixels over clientrect
		// Fmax er treerect.bottom
		SliderTotalHeight := round(TrackHeight * (FpageSize / math.max(1, Fmax)));
		deltaThumbHeight := 0;
		if SliderTotalHeight < MinSliderHeight then
		begin
			//sliderknappen bliver for lille, den sættes til 20 i stedet
			i := MinSliderHeight - round(TrackHeight * (FpageSize / math.max(1, Fmax)));
			i := round (i * (Fpos / math.max(1, Fmax)));

			deltaThumbHeight := MinSliderHeight -slidertotalheight;
			slidertotalheight := MinSliderHeight;
			Ypos := FtrackbarYpos + round(TrackHeight * (Fpos / math.max(1, Fmax))) - i
		end
		else
			Ypos := FtrackbarYpos + round(TrackHeight * (Fpos / math.max(1, Fmax)));

		if SliderTotalHeight <> TrackHeight then
		begin
			SlBoundsMin := Ypos;
			//Tegner den øvste del af slideren
			if assigned(FOnGetImage) then
				FOnGetImage(self, FHoriz, 1, temp);
			if assigned(temp) then
				if FHoriz then
				begin
					bm.Canvas.Draw(Ypos, 3, temp);
					SliderTopHeight := temp.Width;
					inc(Ypos, temp.width)
				end
				else
				begin
					bm.Canvas.Draw(3, Ypos, temp);
					SliderTopHeight := temp.Height;
					inc(Ypos, temp.height)
				end;

			//finder SliderBottomHeight
			if assigned(FOnGetImage) then
				FOnGetImage(self, FHoriz, 3, temp);
			if assigned(temp) then
				if FHoriz then
					SliderBottomHeight := temp.Width
				else
					SliderBottomHeight := temp.Height;

			//Tegner midten af slideren
			if assigned(FOnGetImage) then
				FOnGetImage(self, FHoriz, 2, temp);
			if assigned(temp) and (temp.Width >0) and (temp.Height >0) and (slidertotalheight > SliderTopHeight+SliderBottomHeight) then
			begin
				if FHoriz then
					TileDraw(bm.Canvas, temp, rect(yPos, 3, yPos + SliderTotalHeight - (SliderTopHeight-SliderBottomHeight)-12, 3+temp.Height))
				else
					TileDraw(bm.Canvas, temp, rect(3, yPos, 3+temp.Width, yPos + SliderTotalHeight - (SliderTopHeight-SliderBottomHeight)-12));

				yPos := yPos + SliderTotalHeight - (SliderTopHeight-SliderBottomHeight)-12
			end;

				//Tegner slutningen af slideren
				if assigned(FOnGetImage) then
					FOnGetImage(self, FHoriz, 3, temp);
				if assigned(temp) then
					if FHoriz then
						bm.Canvas.Draw(Ypos, 3, temp)
					else
						bm.Canvas.Draw(3, Ypos, temp);

				SlBoundsmax := SlBoundsmin + SliderTotalHeight
			end
			else
			begin
				SlBoundsmin := -5;
				SlBoundsmax := -4
			end
		end
		else
		begin
			SlBoundsmin := -5;
			SlBoundsmax := -4
		end;
		canvas.Draw(0,0, bm);
		bm.free
end;

constructor TWinampScrollVert.Create(AOwner : TComponent);
Begin
	inherited Create(AOwner);
	controlstyle := controlstyle + [csOpaque];
	DoubleBuffered := true;
	width := 13;
	onMouseDown := MouseDown;
//	OnMouseMove := MouseMove;
	OnMouseUp := MouseUp;
	Capturing := false;
	FTimer := TTimer.Create(nil);
	FTimer.OnTimer := OnTimer;
	FTimer.enabled := false;
	FTimer.Interval := delay1;
	FMouseDragging := false;
end;

destructor TWinampScrollVert.Destroy;
begin
	try
		FTimer.Free;
		inherited
  except
  end
end;


Procedure TWinampScrollVert.FShowSliderChange(value : Boolean);
begin
	FShowSlider := value;
	invalidate
end;

Procedure TWinampScrollVert.FChangePos(value:integer);
begin
	Fpos := value;
	invalidate;
	update
end;

Procedure TWinampScrollVert.FChangeMin(value:integer);
begin
	Fmin := value;
	invalidate
end;

Procedure TWinampScrollVert.FChangeMax(value:integer);
begin
	Fmin := value;
	invalidate;
	update
end;

procedure Register;
begin
	RegisterComponents('MEXP', [TWinampScrollVert]);
end;

end.

