unit SpecialPanel;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
	ExtCtrls;

type
	TOnPaint = procedure(Sender: TObject; Canvas: TCanvas) of object;

	TSpecialPanel = class(TPanel)
	private
		FOnPaint: TOnPaint;
		FinheritedPaint: Boolean;

		Procedure WMEraseBkGnd( Var msg: TWMEraseBkGnd ); message WM_ERASEBKGND;
		{ Private declarations }
	protected
			procedure paint; override;
		{ Protected declarations }
	public
		constructor Create(AOwner: TComponent); override;
//		procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
		{ Public declarations }
	published
		property	OnPaint : TOnPaint    read FonPaint  write FonPaint;
		property	InheritedPaint: Boolean read FinheritedPaint write FinheritedPaint;
		{ Published declarations }
	end;
procedure Register;

implementation

constructor TSpecialPanel.Create(AOwner: TComponent);
begin
	inherited;
	ControlStyle :=ControlStyle - [CsOpaque];
	doublebuffered := true
end;

Procedure TSpecialPanel.WMEraseBkGnd( Var msg: TWMEraseBkGnd );
begin
 //	msg.result := 1;
end;

procedure TSpecialPanel.paint;

begin
//	if FinheritedPaint or (csDesigning in ComponentState) then
		inherited paint;
	if assigned(FOnPaint) then
		FOnPaint(Self, Canvas);
end;

{procedure TSpecialPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
	if (ALeft <> Left) or (ATop <> Top) or
		(AWidth <> Width) or (AHeight <> Height) then
	begin
		if HandleAllocated and not IsIconic(Handle) then
			begin
				SetWindowPos(Handle, 0, ALeft, ATop, AWidth, AHeight,
					SWP_NOREDRAW + SWP_NOZORDER + SWP_NOACTIVATE);
				Repaint;
				if Parent <> nil then
					Parent.Repaint;
				Align := Align;
			end
		else
			inherited SetBounds(ALeft, ATop, AWidth, AHeight);
	end;
end; }

procedure Register;
begin
	RegisterComponents('MEXP', [TSpecialPanel]);
end;

end.
