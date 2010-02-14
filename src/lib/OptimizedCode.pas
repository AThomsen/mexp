unit OptimizedCode;

interface
	Function Trunc(const X: Double): Integer;

implementation

function Trunc(const X : Double) : Integer;
var
  OldCW, NewCW : Word;
asm
  fnstcw OldCW     {Save Current Control Word}
  mov    ax, OldCW
  and    ax, $F7FF {Clear Bit 11}
  or     ax, $0700 {Set Bits 8, 9 and 10}
  mov    NewCW, ax {Bits 8/9 = Precision, Bits 10/11 = Rounding Mode}
  fldcw  NewCW     {Set Round to -ve Infinity Mode with 64 Bit Precision}
  fld    X
  fistp  Result
  fldcw  OldCW     {Restore Original Control Word}
end;

END.
