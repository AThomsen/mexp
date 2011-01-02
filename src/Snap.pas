unit Snap;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, Forms, extCtrls;	

const
  standardRadius : integer = 10;

  function IsWindowCovered(const wnd : HWND): Boolean;
  function ForceForegroundWindow(hwnd: THandle): boolean;
  function NextWindowToGetFocus(from: HWND): HWND;

type
  TSnap = class(TComponent)

  private
    { Private declarations }
    //list : TList; //liste som holder Precs

	protected
    { Protected declarations }
  public
    { Public declarations }
    list : TList; //liste som holder Precs
    Started: Boolean;
		constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

		function AddHook(hw: HWND; hwToMoveWith: HWND; Form: TForm; moveHookedWindows: boolean; canHookToOthers:boolean; SnapToScreen:boolean; SetDoubleBufferedOnResize: Boolean; aot: Boolean; winamp5styleWindow: boolean):TComponent;
    procedure Start;
		procedure CheckAllSnaps;
    function GetSnapWin(hwn : HWND):TComponent; //retunrerer TSnapWin
    procedure ChangeHwnd(oldHwnd, newHwnd: HWND);
  published
		{ Published declarations }
  end;

type
		TSnapWin = class(TComponent)
    public
					restoreBorderStyleTime : Ttimer;
					hw : HWND;
          hwToMoveWith: HWND;
					Fform : TForm;
					snappedTo : HWND;
					showHideWith : HWND;
          FOldWndProc : pointer;
          FNewWndProc : pointer;
          moveHookedWindows : boolean;
          canHookToOthers : boolean;
					snapToScreenBorder : boolean;
					FSetDoubleBufferedOnResize : boolean;
					AlwaysOnTop : boolean;
					notCovered : boolean;
					WindowClosed : boolean;
          Fwinamp5styleWindow: boolean;
//					ChangeToToolWin : boolean;	//fjernet 25/3-03 - da jeg ikke kan gennemskue hvad den skal bruges til!
					SnappedWindowIsMinimized : boolean;
					windowMinimized: boolean;
					lastPos : TRect;
					owner : TSnap;
          height : integer;
          width : integer;
          mouseX : integer;
          mouseY : integer;
          deltaX : integer;
					deltaY : integer;
          fInitialized: boolean;

					constructor Create(aOwner: TSnap; hwn : HWND; hwndToMoveWith: Hwnd; Form: TForm; MoveHooked : boolean; canHook : boolean; SnapToScreen:boolean; SetDoubleBufferedOnResize: boolean; aot: boolean; winamp5styleWindow: boolean);
					destructor Destroy; override;
          procedure Initialize;
		      procedure Uninitialize;
          procedure NewWndProc(Var Msg:TMessage);
					function CloseToMe(const hwn:HWND; const mouseCursor : TPoint; var myPos:TRect; var hwPos:TRect; firstRun:boolean; const radius : integer; DragBorder: Integer):boolean;
          function SnapToScreen(const mouseCursor : TPoint; var myPos:TRect):boolean;
					procedure CheckSnap(var r:TRect; const mouseCursor : TPoint; radius : integer; DragBorder: Integer);
					procedure restoreBorderStyleTimerOnTimer(Sender: TObject);
					procedure ShowForm;
//          procedure ChangeHandle(newHandle: hwnd);
		end;

implementation

function NextWindowToGetFocus(from: HWND): HWND;
begin
  result := from;
	repeat
		result := GetWindow(result, GW_HWNDNEXT)
  until (result = 0) or IsWindowVisible(result)
end;

function ForceForegroundWindow(hwnd: THandle): boolean;
const
  SPI_GETFOREGROUNDLOCKTIMEOUT = $2000;
  SPI_SETFOREGROUNDLOCKTIMEOUT = $2001;
var
  ForegroundThreadID: DWORD;
  ThisThreadID      : DWORD;
  timeout           : DWORD;
begin
  if IsIconic(hwnd) then
  	ShowWindow(hwnd, SW_RESTORE);

  if GetForegroundWindow = hwnd then
  	Result := true
  else
  begin
    // Windows 98/2000 doesn't want to foreground a window when some other
    // window has keyboard focus

    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4))
       or
      ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
      ((Win32MajorVersion > 4) or ((Win32MajorVersion = 4) and
      (Win32MinorVersion > 0)))) then
    begin
      // Code from Karl E. Peterson, www.mvps.org/vb/sample.htm
      // Converted to Delphi by Ray Lischner
      // Published in The Delphi Magazine 55, page 16

      Result := false;
      ForegroundThreadID := GetWindowThreadProcessID(GetForegroundWindow,nil);
      ThisThreadID := GetWindowThreadPRocessId(hwnd,nil);
      if AttachThreadInput(ThisThreadID, ForegroundThreadID, true) then
      begin
        BringWindowToTop(hwnd); // IE 5.5 related hack
        SetForegroundWindow(hwnd);
        AttachThreadInput(ThisThreadID, ForegroundThreadID, false);
        Result := (GetForegroundWindow = hwnd);
      end;
      if not Result then
      begin
        // Code by Daniel P. Stasinski
        SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, @timeout, 0);
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(0), SPIF_SENDCHANGE);
        BringWindowToTop(hwnd); // IE 5.5 related hack
        SetForegroundWindow(hWnd);
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(timeout), SPIF_SENDCHANGE);
      end;
    end
    else
    begin
      BringWindowToTop(hwnd); // IE 5.5 related hack
      SetForegroundWindow(hwnd);
    end;

    Result := (GetForegroundWindow = hwnd);
  end;
end; { ForceForegroundWindow }

function IsWindowCovered(const wnd : HWND): Boolean;
Var
   Rect: TRect;
   MyRgn, TempRgn: HRGN;
   RType: Integer;
   hw: HWND;
begin
     GetWindowRect(wnd, Rect);                  // screen coordinates
     MyRgn := CreateRectRgnIndirect(Rect);      // MyForm not overlapped region
     hw := GetTopWindow(0);                     // currently examined top window
     RType := SIMPLEREGION;                     // MyRgn type

     // From topmost window downto MyForm, build the not overlapped portion of MyForm
     While (hw<>0) and (hw <> wnd) and (RType <> NULLREGION) Do
     Begin
          // nothing to do if hidden window
          if IsWindowVisible(hw) then
          begin
               GetWindowRect(hw, Rect);
               TempRgn := CreateRectRgnIndirect(Rect);// currently examined window region
               RType := CombineRgn(MyRgn, MyRgn, TempRgn, RGN_DIFF);  // diff intersect
               DeleteObject( TempRgn );
					end; {if}
          If RType <> NULLREGION then              // there's a remaining portion
             hw := GetNextWindow( hw, GW_HWNDNEXT );
     End; {while}

     DeleteObject( MyRgn );
     Result := RType = NULLREGION
end;


/////////////////////////////////////////////////////////

constructor TSnap.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  list := TList.Create;
	Started := false;
end;

destructor TSnap.Destroy;
var
   i:integer;
begin
  for i:=0 to list.count-1 do
     TSnapWin(list.items[i]).free;

  list.free;
  list := nil;
  inherited Destroy
end;

/////////////////////////////////////////////////////////


procedure TSnap.CheckAllSnaps;
var
   i:integer;
   r:TRect;
   sn : TSnapWin;
begin
	if list <> nil then
	  for i:=0 to list.count-1 do
	  begin
	    sn := TSnapWin(list.items[i]);
	    sn.notCovered := isWindowVisible(sn.hwToMoveWith) and not IsWindowCovered(sn.hwToMoveWith);
	    if sn.canHookToOthers then
	    begin
	      GetWindowRect(sn.hwToMoveWith, r);
	      sn.mouseX := 0;
	      sn.mouseY := 0;
	      sn.CheckSnap(r, Point(r.Left, r.Top), 1, -1)
	    end
	  end
end;

function TSnap.GetSnapWin(hwn : HWND):TComponent; //retunrerer TSnapWin
var
   i:integer;
begin
  result := nil;
  for i:=0 to list.count-1 do
     if TSnapWin(list.items[i]).hw = hwn then
        result := TSnapWin(list.items[i])
end;

procedure TSnap.ChangeHwnd(oldHwnd, newHwnd: HWND);
var
   i:integer;
   sw: TSnapWin;
begin
  for i:=0 to list.count-1 do
  begin
  	sw := TSnapWin(list.items[i]);
		if sw.hw = oldHwnd then
    	sw.hw := newHwnd;

    if sw.hwToMoveWith = oldHwnd then
    	sw.hwToMoveWith := newHwnd;

    if sw.snappedTo = oldHwnd then
    	sw.snappedTo := newHwnd;

    if sw.showHideWith = oldHwnd then
    	sw.showHideWith := newHwnd;
  end;
end;

function TSnap.AddHook(hw: HWND; hwToMoveWith: HWND; Form: TForm; moveHookedWindows: boolean; canHookToOthers:boolean; SnapToScreen:boolean; SetDoubleBufferedOnResize: Boolean; aot: boolean; winamp5styleWindow: boolean):TComponent;
var
	 snapWin : TSnapWin;
begin
  snapWin := TSnapWin.Create(self, hw,hwToMoveWith, Form, moveHookedWindows, canHookToOthers, SnapToScreen, SetDoubleBufferedOnResize, aot, winamp5styleWindow);
  list.Add(snapWin);
  result := snapWin
end;

procedure TSnap.Start;
var
	i: Integer;
begin
	Started := true;
	for i:=0 to list.count-1 do
  	TSnapWin(list.Items[i]).Initialize
end;

procedure TSnapWin.Initialize;
begin
	if owner.Started then
  begin
		FNewWndProc := MakeObjectInstance(NewWndProc);
	  FOldWndProc := pointer(SetWindowLong(hw, GWL_WNDPROC, Longint(FNewWndProc)));
	  fInitialized := true
  end
end;

procedure TSnapWin.Uninitialize;
begin
	if fInitialized then
  begin
  	if IsWindow(hw) then
    begin
			SetWindowLong(hw, GWL_WNDPROC, LongInt(FOldWndProc))
    end;
    FreeObjectInstance(FNewWndProc);
    fInitialized := false
  end;
end;

{
procedure TSnapWin.ChangeHandle(newHandle: hwnd);
var
	ptr: pointer;
begin
	if fInitiated then
  begin
  	ptr := pointer(SetWindowLong(hw, GWL_WNDPROC, LongInt(FOldWndProc)));

  end;
end;  }

constructor TSnapWin.Create(aOwner: TSnap; hwn : HWND; hwndToMoveWith: HWND; Form: TForm; MoveHooked : boolean; canHook : boolean; SnapToScreen:boolean; SetDoubleBufferedOnResize: boolean; aot: boolean; winamp5styleWindow: boolean);
var
   r : TRect;
begin
  inherited Create(aOwner);
  fInitialized := false;
  owner := TSnap(aOwner);
  restoreBorderStyleTime := Ttimer.Create(self);
  restoreBorderStyleTime.Interval := 1;
  restoreBorderStyleTime.OnTimer := restoreBorderStyleTimerOnTimer;
  hw := hwn;
  hwToMoveWith := hwndToMoveWith;
  showHideWith := 0;
  moveHookedWindows := MoveHooked;
  canHookToOthers := canHook;
  snapToScreenBorder := SnapToScreen;
  AlwaysOnTop := aot;
  FForm := Form;
  WindowClosed := true;
  Fwinamp5styleWindow := winamp5styleWindow;
  //		 ChangeToToolWin := false;
  FSetDoubleBufferedOnResize := SetDoubleBufferedOnResize;
  //		 FOldWndProc := Pointer(GetWindowLong(hw, GWL_WNDPROC));
  GetWindowRect(hw, lastPos);
  GetWindowRect(hw, r);
  width := r.Right - r.Left;
  height := r.Bottom - r.Top
end;

destructor TSnapWin.Destroy;
begin
	restoreBorderStyleTime.Enabled := false;
	restoreBorderStyleTime.Free;
  Uninitialize;
	inherited Destroy
end;

procedure TSnapWin.ShowForm;
begin
	if IsIconic(Fform.handle) then
		ShowWindow(Fform.handle, SW_RESTORE);

//  if assigned(Fform) then
//	 	Fform.Show;
{	with Fform do
									 SetWindowPos(Handle,
									 HWND_TOPMOST,
									 Left,
									 Top,
									 Width,
									 Height,
									 SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);  }

	ForceForegroundWindow(hwToMoveWith);

	if not AlwaysOnTop then
	with Fform do
									 SetWindowPos(Handle,
									 HWND_NOTOPMOST,
									 Left,
									 Top,
									 Width,
									 Height,
									 SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE)
end;

procedure TSnapWin.restoreBorderStyleTimerOnTimer(Sender: TObject);
begin
	restoreBorderStyleTime.Enabled := false;
	if {ChangeToToolWin and }assigned(Fform) then
		ShowForm
end;

function TSnapWin.CloseToMe(const hwn:HWND; const mouseCursor : TPoint; var myPos:TRect; var hwPos:TRect; firstRun:boolean; const radius : integer; DragBorder: Integer):boolean;
{	function GetDivByTen(x: integer):integer;
	var
		d: double;
		i:integer;
	begin
		d := x / 25;
		i := trunc(d);
		d := d - i;
		result := (25 * i) + (25 * round(d))
	end;     }
var
   width, height : integer;
begin
		 //checker om dette vindue er så tæt på et andet, at der skal snappes

		 result := false;
		 GetWindowRect(hwn, hwPos);

		 width := myPos.Right - myPos.Left;
		 height := myPos.Bottom - myPos.Top;

		 //snap to my left side to hws right side?
		 if (abs((mouseCursor.x - mouseX) - hwPos.right) <= radius) and (hwPos.Top <= myPos.Bottom) and (hwPos.Bottom >= myPos.Top) then
     begin
			result := true;
			myPos.Left := hwPos.Right
		 end else

		 //snap to my left side to hws left side?
		 if (abs((mouseCursor.x - mouseX) - hwPos.Left) <= radius) and ((abs(hwPos.Top - myPos.Bottom) <= radius) or (abs(myPos.Top - hwPos.Bottom) <= radius)) then
		 begin
			result := true;
			myPos.Left := hwPos.Left;
			if DragBorder in [WMSZ_LEFT, WMSZ_TOPLEFT, WMSZ_BOTTOMLEFT] then
				Width := myPos.Right - myPos.Left
		 end else

		 //snap to my right side to hws left side?
		 if (abs(((mouseCursor.x - mouseX) + (myPos.Right - myPos.Left)) - hwPos.left) <= radius) and (hwPos.Top <= myPos.Bottom) and (hwPos.Bottom >= myPos.Top) then
		 begin
			result := true;
			if DragBorder in [WMSZ_RIGHT, WMSZ_TOPRIGHT, WMSZ_BOTTOMRIGHT] then
			begin
				myPos.Right := hwPos.Left;
				Width := MyPos.Right - MyPos.Left
			end else
				myPos.Left := hwPos.Left - (myPos.Right - myPos.Left)
		 end else

		 //snap to my right side to hws right side?
		 if (abs(((mouseCursor.x - mouseX) + (myPos.Right - myPos.Left)) - hwPos.Right) <= radius) and ((abs(hwPos.Top - myPos.Bottom) <= radius) or (abs(myPos.Top - hwPos.Bottom) <= radius)) then
		 begin
			result := true;
			if DragBorder in [WMSZ_RIGHT, WMSZ_TOPRIGHT, WMSZ_BOTTOMRIGHT] then
				inc(Width, hwPos.Right - myPos.Right)
			else
				myPos.Left := hwPos.Right - (myPos.Right - myPos.Left)
		 end else
		 //////////////////////////////////////////////////////////////////////////////
		 if firstRun then
		 begin
//			if DragBorder >= 0 then
//				width := GetDivByTen(width);
			if not (DragBorder in [WMSZ_RIGHT, WMSZ_TOPRIGHT, WMSZ_BOTTOMRIGHT]) then
				myPos.Left := mouseCursor.x - mouseX;
		 end;

		 //snap to my top side to hws bottom side?
		 if (abs((mouseCursor.y - mouseY) - hwPos.Bottom) <= radius) and (hwPos.Left <= myPos.Right) and (hwPos.Right >= myPos.Left) then
		 begin
					result := true;
          myPos.Top := hwPos.Bottom
		 end else

     //snap to my top side to hws top side?
		 if (abs((mouseCursor.y - mouseY) - hwPos.Top) <= radius) and ((hwPos.Left = myPos.Right) or (hwPos.Right = myPos.Left)) then
     begin
			result := true;
			myPos.Top := hwPos.Top;
			if DragBorder in [WMSZ_TOP, WMSZ_TOPLEFT, WMSZ_TOPRIGHT] then
				Height := myPos.Bottom - myPos.Top
		 end else

		 //snap to my bottom side to hws top side?
     if (abs(((mouseCursor.y - mouseY) + (myPos.Bottom - myPos.Top)) - hwPos.Top) <= radius) and (hwPos.Left <= myPos.Right) and (hwPos.Right >= myPos.Left) then
		 begin
			result := true;
			if DragBorder in [WMSZ_BOTTOM, WMSZ_BOTTOMLEFT, WMSZ_BOTTOMRIGHT] then
			begin
				myPos.Bottom := hwPos.Top;
				Height := MyPos.Bottom - MyPos.Top
			end else
				myPos.Top := hwPos.Top - (myPos.Bottom - myPos.Top)
		 end else

		 //snap to my bottom side to hws bottom side?
		 if (abs(((mouseCursor.y - mouseY) + (myPos.Bottom - myPos.Top)) - hwPos.Bottom) <= radius) and ((hwPos.Left = myPos.Right) or (hwPos.Right = myPos.Left)) then
		 begin
			result := true;
			if DragBorder in [WMSZ_BOTTOM, WMSZ_BOTTOMLEFT, WMSZ_BOTTOMRIGHT] then
				inc(Height, hwPos.Bottom - myPos.Bottom)
			else
				myPos.Top := hwPos.Bottom - (myPos.Bottom - myPos.Top)
		 end else

		 if firstRun then
			if not (DragBorder in [WMSZ_BOTTOM, WMSZ_BOTTOMLEFT, WMSZ_BOTTOMRIGHT]) then
				myPos.Top := mouseCursor.y - mouseY;

		 if not (DragBorder in [WMSZ_LEFT, WMSZ_TOPLEFT, WMSZ_BOTTOMLEFT]) then
			myPos.Right := myPos.Left + width;
		 if not (DragBorder in [WMSZ_TOP, WMSZ_TOPLEFT, WMSZ_TOPRIGHT]) then
			myPos.Bottom := myPos.Top + height
end;

function TSnapWin.SnapToScreen(const mouseCursor: TPoint; var myPos: TRect):boolean;
var
	 d : TRect; //desktop
begin
     result := false;

     SystemParametersInfo(SPI_GETWORKAREA,0,@d,0);

     //snap to my left side to the screen's left side?
		 if (abs((mouseCursor.x - mouseX) - d.Left) <= standardRadius) then
		 begin
          result := true;
          myPos.Left := d.Left
     end else

     //snap to my right side to the screen's right side?
     if (abs(((mouseCursor.x - mouseX) + (myPos.Right - myPos.Left)) - d.Right) <= standardRadius) then
     begin
          result := true;
          myPos.Left := d.Right - (myPos.Right - myPos.Left)
     end;

		 //snap to my Top side to the screen's Top side?
     if (abs((mouseCursor.y - mouseY) - d.Top) <= standardRadius) then
		 begin
          result := true;
          myPos.Top := d.Top
     end else

     //snap to my bottom side to the screen's bottom side?
		 if (abs(((mouseCursor.y - mouseY) + (myPos.Bottom - myPos.Top)) - d.Bottom) <= standardRadius) then
		 begin
          result := true;
          myPos.Top := d.Bottom - (myPos.Bottom - myPos.Top)
     end;

		 myPos.Right := myPos.Left + width;
		 myPos.Bottom := myPos.Top + height
end;

procedure TSnapWin.CheckSnap(var r:TRect; const mouseCursor : TPoint; radius : integer; DragBorder: Integer);
var
  r2 : TRect;
  sn : TSnapWin;
  i : integer;
	firstRun : boolean;
begin
     snappedTo := 0;
     firstRun := true;
     for i:=0 to owner.list.count-1 do
     begin
          sn := TSnapWin(owner.list.items[i]);
					if (sn <> self) and sn.notCovered then
					begin
							 if CloseToMe(sn.hwToMoveWith, mouseCursor, r, r2, firstRun, radius, DragBorder) then
							 begin
										snappedTo := sn.hwToMoveWith;
										deltaX := r.Left - r2.Left;
										deltaY := r.Top - r2.Top
							 end;
							 firstRun := false
					end
		 end;

		 if (DragBorder < 0) and SnapToScreenBorder then
				SnaptoScreen(mouseCursor, r)
end;

function comparePoints(const p1, p2 :TPoint):boolean;
begin
		 result := (p1.x = p2.x) and (p1.y = p2.y)
end;

procedure TSnapWin.NewWndProc(var Msg: TMessage);
var
  r,r2 : TRect;
  sn : TSnapWin;
	i, DragBorder : integer;
	iconic : boolean;
	ShowFlag: LongInt;
  wl, wh: integer;

begin
	 	 with Msg do
		 begin
					case Msg of
							 WM_ENTERSIZEMOVE : if canHookToOthers then
							 begin
										GetWindowRect(hwToMoveWith, r);

										mouseX := mouse.CursorPos.x - r.left;
										mouseY := mouse.CursorPos.y - r.top;

										for i:=0 to owner.list.count-1 do
										begin
												 sn := TSnapWin(owner.list.items[i]);
												 sn.notCovered := isWindowVisible(sn.hwToMoveWith) and not IsWindowCovered(sn.hwToMoveWith)
										end;
										if FSetDoubleBufferedOnResize and assigned(Fform) then
											FForm.DoubleBuffered := true
							 end;

							 WM_EXITSIZEMOVE : if canHookToOthers then
							 begin
										GetWindowRect(hwToMoveWith, r);
										mouseX := 0;
                    mouseY := 0;
										CheckSnap(r, Point(r.Left, r.Top), 1, -1);
										if FSetDoubleBufferedOnResize and assigned(Fform) then
											FForm.DoubleBuffered := false
               end;

						 	 WM_MOVING, WM_SIZING : if canHookToOthers then
							 begin
										r:=TRect(PRect(lParam)^);
										if Msg = WM_Sizing then
										begin
											DragBorder := Wparam;
											mouseX := mouse.CursorPos.x - r.left;
											mouseY := mouse.CursorPos.y - r.top;
											width := r.Right - r.Left;
											height := r.Bottom - r.Top
										end
										else DragBorder := -1;
										CheckSnap(r, mouse.CursorPos, standardRadius, DragBorder);
										PRect(lparam)^:=r
							 end;

						 	 WM_MOVE :
							 begin
								if moveHookedWindows then
								begin
									GetWindowRect(hwToMoveWith, r);
									iconic := IsIconic(hwToMoveWith);
									for i:=0 to owner.list.count-1 do
									begin
										sn := TSnapWin(owner.list.items[i]);
										if not sn.moveHookedWindows and (sn.snappedTo = hwToMoveWith) then
										begin
											if not sn.SnappedWindowIsMinimized and iconic then	//winamp er lige blevet minimeret er lige blevet
												ShowWindow(sn.hwToMoveWith, SW_MINIMIZE)//sn.Fform.WindowState := wsMinimized
											else if sn.SnappedWindowIsMinimized and not iconic then //winamp er lige blevet restored
												ShowWindow(sn.hwToMoveWith, SW_RESTORE)
											else
											begin
												if (width <> r.Right - r.Left) and (sn.deltaX = width) then
													sn.deltaX := r.Right - r.Left;
												if (height <> r.Bottom - r.Top) and (sn.deltaY = height) then
													sn.deltaY := r.Bottom - r.Top;

												GetWindowRect(sn.hwToMoveWith, r2);
												if not comparePoints(Point(LParamLo + sn.deltaX, LParamHi + sn.deltaY), r2.TopLeft) then
												begin
													sn.lastPos := r2;
													if sn.WindowClosed then
														ShowFlag := SWP_NOSIZE or SWP_NOACTIVATE or SWP_NOZORDER
													else ShowFlag := SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOACTIVATE;
                          if hw = hwToMoveWith then
                          begin
                          	wl := LParamLo;
                            wh := LParamHi
                          end else
                          begin
                          	wl := r.Left;
                            wh := r.Top
                          end;
                          if wh < 35536 then
                          begin
														SetWindowPos(sn.hwToMoveWith, HWND_TOPMOST, wl + sn.deltaX, wh + sn.deltaY, 0, 0, ShowFlag);
														if not sn.AlwaysOnTop and not sn.WindowClosed then
															SetWindowPos(sn.hwToMoveWith, HWND_NOTOPMOST, wl + sn.deltaX, wh + sn.deltaY, 0, 0, ShowFlag)
                          end
												end
											end
										end
										else
										begin
											if not Fwinamp5styleWindow and not sn.moveHookedWindows and (sn.snappedTo = 0) and (sn.showHideWith = hwToMoveWith) and (windowMinimized <> iconic) and assigned(sn.Fform) then    // vis med winamp
											begin
                        if iconic then
                        	PostMessage(sn.hw, WM_USER+100, 0, 0)  //Hide
                        else
                        	PostMessage(sn.hw, WM_USER+100, 0, 1)	//Show
											end;

											if (sn.showHideWith = 0) and assigned(sn.Fform) and sn.fForm.Visible and (sn.Fform.BorderStyle = bssizetoolwin) and iconic and not isIconic(sn.hwToMoveWith) then
												begin
													if (NextWindowToGetFocus(hwToMoveWith) = sn.hwToMoveWith) or not IsWindowCovered(sn.hwToMoveWith) then
                          begin
                        	 	with sn.Fform do
                               SetWindowPos(Handle,
                               HWND_TOPMOST,
                               Left,
                               Top,
                               Width,
                               Height,
                               SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
												 		//sn.ChangeToToolWin := true;
												 		sn.restoreBorderStyleTime.Enabled := true
                          end
												end
										end;
										
										if not sn.moveHookedWindows and (sn.snappedTo <> hwToMoveWith) and sn.SnappedWindowIsMinimized and not iconic then
											sn.owner.CheckAllSnaps
									end; //of for
									if sn.snappedTo = hwToMoveWith then
										sn.SnappedWindowIsMinimized := iconic;
									windowMinimized := iconic
								end
							 end;

						 	 WM_SIZE :
							 begin
										GetWindowRect(hwToMoveWith, r);
										if moveHookedWindows then
										begin
												 for i:=0 to owner.list.count-1 do
												 begin
															sn := TSnapWin(owner.list.items[i]);
															if not sn.moveHookedWindows and (sn.snappedTo = hwToMoveWith) then
															begin
																	 if (width <> r.Right - r.Left) and (sn.deltaX = width) then
																			sn.deltaX := r.Right - r.Left;
																	 if (height <> r.Bottom - r.Top) and (sn.deltaY = height) then
																			sn.deltaY := r.Bottom - r.Top;
																	 GetWindowRect(sn.hwToMoveWith, r2);
																	 if not comparePoints(Point(r.Left + sn.deltaX, r.Top + sn.deltaY), r2.TopLeft) then
																	 begin
																				//sn.lastPos := r2;
																				SetWindowPos(sn.hwToMoveWith, HWND_NOTOPMOST, r.Left + sn.deltaX, r.Top + sn.deltaY, 0, 0, SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_SHOWWINDOW)
																	 end
															end
												 end
										end;
										width := r.Right - r.Left;
										height := r.Bottom - r.Top;
							 end;

               WM_SETFOCUS, WM_KILLFOCUS:
               begin
               		if Fwinamp5styleWindow then
                  begin
                    if Lparam = 0 then
                    begin
                    	PostMessage(hw, msg, wparam, 1)
                    end
                    else
                    begin
                      iconic := not IsWindowVisible(hw);

                      if windowMinimized <> iconic then
                      begin
	                      for i:=0 to owner.list.count-1 do
	                      begin
	                        sn := TSnapWin(owner.list.items[i]);
	                        if not sn.moveHookedWindows and {(sn.snappedTo = 0) and} (sn.showHideWith = hwToMoveWith) and assigned(sn.Fform) then    // vis med winamp
	                        begin
	                          if iconic then
	                          begin
	                            PostMessage(sn.hw, WM_USER+100, 0, 0);  //Hide
//	                            OutputDebugString('Iconic')
	                          end
	                          else
	                          begin
	                            PostMessage(sn.hw, WM_USER+100, 0, 1);	//Show
	//                            OutputDebugString('Visible')
	                          end
	                        end;
	                      end;
  	                    windowMinimized := iconic;
                      end;
                    end;
                  end
               end;


							 WM_ACTIVATE :
							 begin
								if moveHookedWindows and (wParamLo <> WA_INACTIVE) and not IsIconic(hwToMoveWith) then   //"not IsIconic(hwToMoveWith)" forhindrer at Winamp bliver mærkeligt lille og gemmer sig omkring "Start-knappen" i taskbaren
								begin
									for i:=0 to owner.list.count-1 do
									begin
										sn := TSnapWin(owner.list.items[i]);
										if not sn.moveHookedWindows and ((sn.snappedTo = hwToMoveWith) or (sn.showHideWith = hwToMoveWith)) then
											if (not sn.WindowClosed) then
											begin
                      	SetWindowPos(sn.hwToMoveWith, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
                        SetWindowPos(hw, HWND_TOP, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
                      end
									end;
								//self.owner.CheckAllSnaps
								end
							 end
					end;
					result:=CallWindowProc(FOldWndProc, hw, Msg, WParam, LParam);
		 end;
end;


end.
