unit ColorConv;

interface

uses Graphics;

type
    TRGB = record
        R: Integer;
        G: Integer;
        B: Integer;
end;
type
    THLS = record
        H: Integer;
        L: Integer;
        S: Integer;
end;
type
    THWB = record
        H: Integer;
        W: Integer;
        B: Integer;
end;

function ColorToRGB(PColor: TColor): TRGB;
function RGBToColor(PR,PG,PB: Integer): TColor;
function RGBToCol(PRGB: TRGB): TColor;
function RGBToHLS(PRGB: TRGB): THLS;
function HLSToRGB(PHLS: THLS): TRGB;
function min3(P1,P2,P3: double): Double;
function max3(P1,P2,P3: double): Double;

function mixColors(color1:TColor; color2:Tcolor):TColor;
function changeBrightness(InColor:Tcolor; Delta:Integer; LowSaturation:Boolean=true):Tcolor;
implementation

function mixColors(color1:TColor; color2:Tcolor):TColor;
var      fRGB1, fRGB2, res: TRGB;
begin
     fRGB1 := ColorToRGB(color1);
     fRGB2 := ColorToRGB(color2);

     res.R := (fRGB1.R + fRGB2.R) div 2;
     res.G := (fRGB1.G + fRGB2.G) div 2;
     res.B := (fRGB1.B + fRGB2.B) div 2;

     result := RGBtoCol(res)
end;

function changeBrightness(InColor:Tcolor; Delta:Integer; LowSaturation:Boolean=true):Tcolor;
var
        fRGB : TRGB;
        fHLS : THLS;
begin
        fHLS := RGBtoHLS(ColorToRGB(InColor));
        if fHLS.L + delta > 240 then fHLS.L := 240 else
        if fHLS.L + delta < 0 then fHLS.L := 0 else
        inc(fHLS.L, delta);
        if LowSaturation then fHLS.S := 30;
        fRGB := HLStoRGB(fHLS);
        result := RGBtoCol(fRGB) 
end;

function RGBToColor(PR,PG,PB: Integer): TColor;
begin
    Result := TColor((PB * 65536) + (PG * 256) + PR);
end;

function ColorToRGB(PColor: TColor): TRGB;
var
    i: Integer;
begin
    i := PColor;
    Result.R := 0;
    Result.G := 0;
    Result.B := 0;
    while i - 65536 >= 0 do begin i := i - 65536; Result.B := Result.B + 1; end;
    while i - 256 >= 0 do begin i := i - 256; Result.G := Result.G + 1; end;
    Result.R := i;
end;

function RGBToCol(PRGB: TRGB): TColor;
begin
    Result := RGBToColor(PRGB.R,PRGB.G,PRGB.B);
end;

function RGBToHLS(PRGB: TRGB): THLS;
var
    LR,LG,LB,LH,LL,LS,LMin,LMax: double;
    LHLS: THLS;
    i: Integer;
begin
    LR := PRGB.R / 256;
    LG := PRGB.G / 256;
    LB := PRGB.B / 256;
    LMin := min3(LR,LG,LB);
    LMax := max3(LR,LG,LB);
    LL := (LMax + LMin)/2;
    if LMin = LMax then begin
        LH := 0;
        LS := 0;
        Result.H := round(LH * 256);
        Result.L := round(LL * 256);
        Result.S := round(LS * 256);
        exit;
    end;
    If LL < 0.5 then LS := (LMax - LMin) / (LMax + LMin);
    If LL >= 0.5 then LS := (LMax-LMin) / (2.0 - LMax - LMin);
    If LR = LMax then LH := (LG - LB)/(LMax - LMin);
    If LG = LMax then LH := 2.0 + (LB - LR) / (LMax - LMin);
    If LB = LMax then LH := 4.0 + (LR - LG) / (LMax - LMin);
    Result.H := round(LH * 42.6);
    Result.L := round(LL * 256);
    Result.S := round(LS * 256);
end;

function HLSToRGB(PHLS: THLS): TRGB;
var
    LR,LG,LB,LH,LL,LS: double;
    LHLS: THLS;
    L1,L2: Double;
begin
    LH := PHLS.H / 255;
    LL := PHLS.L / 255;
    LS := PHLS.S / 255;
    if LS = 0 then begin
        Result.R := PHLS.L;
        Result.G := PHLS.L;
        Result.B := PHLS.L;
        Exit;
    end;
    If LL < 0.5 then L2 := LL * (1.0 + LS);
    If LL >= 0.5 then L2 := LL + LS - LL * LS;
    L1 := 2.0 * LL - L2;
    LR := LH + 1.0/3.0;
    if LR < 0 then LR := LR + 1.0;
    if LR > 1 then LR := LR - 1.0;
    If 6.0 * LR < 1 then LR := L1+(L2 - L1) * 6.0 * LR
    Else if 2.0 * LR < 1 then LR := L2
    Else if 3.0*LR < 2 then LR := L1 + (L2 - L1) * ((2.0 / 3.0) - LR) * 6.0
    Else LR := L1;
    LG := LH;
    if LG < 0 then LG := LG + 1.0;
    if LG > 1 then LG := LG - 1.0;
    If 6.0 * LG < 1 then LG := L1+(L2 - L1) * 6.0 * LG
    Else if 2.0*LG < 1 then LG := L2
    Else if 3.0*LG < 2 then LG := L1 + (L2 - L1) * ((2.0 / 3.0) - LG) * 6.0
    Else LG := L1;
    LB := LH - 1.0/3.0;
    if LB < 0 then LB := LB + 1.0;
    if LB > 1 then LB := LB - 1.0;
    If 6.0 * LB < 1 then LB := L1+(L2 - L1) * 6.0 * LB
    Else if 2.0*LB < 1 then LB := L2
    Else if 3.0*LB < 2 then LB := L1 + (L2 - L1) * ((2.0 / 3.0) - LB) * 6.0
    Else LB := L1;
    Result.R := round(LR * 255);
    Result.G := round(LG * 255);
    Result.B := round(LB * 255);
end;

function max3(P1,P2,P3: double): Double;
begin
    Result := -1;
    if (P1 > P2) then begin
        if (P1 > P3) then begin
            Result := P1;
        end else begin
            Result := P3;
        end;
    end else if P2 > P3 then begin
        result := P2;
    end else result := P3;
end;

function min3(P1,P2,P3: double): Double;
begin
    Result := -1;
    if (P1 < P2) then begin
        if (P1 < P3) then begin
            Result := P1;
        end else begin
            Result := P3;
        end;
    end else if P2 < P3 then begin
        result := P2;
    end else result := P3;
end;

end.
