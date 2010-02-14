unit inuptbox2U;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, Forms,
	StdCtrls, ExtCtrls, ComCtrls, math;

type
  TInputBox2 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Pbar: TProgressBar;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    Focused:TWinControl;
    CancelPressed : boolean;
    { Public declarations }
  end;

var
  InputBox2: TInputBox2;

implementation

uses defs, MainForm;

{$R *.DFM}

procedure TInputBox2.FormCreate(Sender: TObject);
begin
     Icon := MainFormInstance.Icon1.picture.icon;
     CancelPressed := false
end;

procedure TInputBox2.Button2Click(Sender: TObject);
begin
     CancelPressed := true
end;

procedure TInputBox2.FormShow(Sender: TObject);
Function setButtonWidth(con:TButton): Integer;
begin
	if con.Visible then
  begin
  	con.Width := max(con.width, GetTextWidth(con.caption, con.font)+26);
    result := con.Width
  end
  else
  	result := 0
end;
var
	buttonbottom, totalButtonWidth: integer;
begin
   buttonbottom := height - min(button1.top, button2.top);
   label1.AutoSize := true;
   width := max(label1.width + 50, 270);
   height := max(label1.height + 40 + buttonBottom, 135);

   label1.Top := 20;
   label1.Left := (width div 2) - (label1.width div 2);

   if button1.visible then button1.top := height -buttonBottom;
   if button2.visible then button2.top := height -buttonBottom;
   if button3.visible then button3.top := height -buttonBottom;

   totalButtonWidth := setButtonWidth(button1);
   inc(totalButtonWidth, setButtonWidth(button2));
   inc(totalButtonWidth, setButtonWidth(button3));

	if totalButtonWidth + 64 > Width then
  begin
  	Width := totalButtonWidth + 64;
    label1.Left := (width div 2) - (label1.width div 2)
  end;

   if button1.visible and button2.Visible and button3.visible then
   begin
        button1.left := 10;
        button3.left := panel1.clientWidth - 10 - button3.width;
        button2.left := Button1.Left + Button1.Width + (Button3.Left - (Button1.Left + Button1.Width)) div 2 - button2.width div 2
   end else
   begin
        if button1.visible and button2.visible then
        begin
             button1.left := (width div 2) - button1.Width - 30;
             button2.left := (width div 2) + 30
        end else
        if button1.Visible then
           button1.Left := (width div 2) - (button1.width div 2)
        else if button2.Visible then
             button2.Left := (width div 2) - (button2.width div 2)
   end;
   FocusControl(Focused)
end;

end.
