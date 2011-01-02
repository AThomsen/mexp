unit FPUrlLabel;
{
FPURLLabel Ver. 1.5.0.1 for Delphi 2 and 3:
Developed by Filippo Passeggieri inspirated by some advices in the UDDF site.
Initially, I thought to sell FPUrlLabel at 250USD, but on second thought
I decided, being my first component, it had to be FREEWARE. :-)
If you have suggestions, bug reports please E-Mail me at:
   passeggieri@geocities.com

P.S: I want to thank everyone who wrote me for URLLabel/FPUrlLabel. I want to
     apologize if sometimes I didn't answer promptly but I can assure you I read
     it all your messages and someone will surely see that with the addition of
     his/her suggestions. Thanks again!!!!

---------------------------------------------------------------------------
  ATTENTION!!!!!
  Use FPUrlLabel component at your own risk!!! I decline any responsibility.
----------------------------------------------------------------------------

History:
31/07/98 - Some little retouches: - 1.5.0.1
           + Added support for NEWS (hmNews)
           + Added Enabled and Visible property
30/07/98 - Again, after requests and suggestions: - Ver 1.5.0.0
           + At the end, PopupMenu is a reality.
           + Thanks to Troy a silly bug was corrected (from the very first release):
             http:\\ is now http:// (Smiles are not allowed!! ":-)" )
           + Added some codes to check the availability of a browser.
           + Corrected several errors.

           I think that now FPUrlLabel is more flexible than ever

20/06/98 - After many requests and suggestions: - Ver 1.4.5.0
           + URL property has been added.
           + MailSubject property added.
           + Improved About Dialog
           + URLLabel is now named FPURLLAbel; This was necessary to prevent
             confusion since there are other components called URLLabel.

03/05/98 - You can now set LabelType property using the right click when FPUrlLabel
           is selected;
           Added an About Dialog in the Object Inspector. - Ver 1.4.0.1
17/03/98 - Corrected minor bugs. - Ver 1.4.0.0
14/03/98 - Sincronized property URLColStd with Font property
           Replaced the ugly cursor crHandPoint with browser like one.

13/03/98 - Received an improved version by CT Koo (Thanks a lot!!!); This versiona can now:
           + Create a custom label type and on click event which allow user to define custom
              onclick event.
           + Add AllowDown property, it act like button down.
           + In mouse up event, font change to standard when effect98 is false.

26/12/97 - Corrected several bugs. - Ver 1.3.0.1
21/12/97 - Added effect like Win98/IE4 (property Effect98). - Ver 1.3.0.0
16/11/97 - Added support for FTP (property HTTPorMail is now called LabelType);
           Now cursor is browser-like. - Ver 1.2.0.0
06/11/97 - Corrected minor bugs. - Ver 1.1.0.0
04/11/97 - Added support to choose different colors if TFPUrlLabel is pressed
           or not(properties SetColStd, SetColPre).
02/11/97 - Added support for Mail (property HTTPorMail).
31/10/97 - First release.
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,ShellApi, DesignIntf, ExtCtrls, Menus, Clipbrd;

type
  TURL = String;
  TMailSubject = String;

  TLabelType = (hmHTTP, hmMAIL, hmFTP, hmNews, hmCUSTOM);

{  TAbout = class(TPropertyEditor)
  public
  	procedure Edit; override;
  	function GetAttributes: TPropertyAttributes; override;
  	function GetValue: string; override;
  end;
  }

  TFPUrlLabel=class(TCustomLabel)
  private
    { Private declarations }
//    FAbout: TAbout;
    FURL: TURL;
    FMailSubject: string;
    FPopupMenu: TPopupMenu;
    FMenuItem: TMenuItem;
    FLabelType: TLabelType;
    FColStd : TColor;
    FColPre : TColor;
    FAllowDown : Boolean;
    FEffect98: Boolean;
    function GetFont: TFont;
    procedure SetFont(Value: TFont);
    procedure URLMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure URLMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetLabelType(Value: TLabelType);
    procedure SetColStd(Value: TColor);
    procedure SetColPre(Value: TColor);
    procedure SetAllowDown(Value: Boolean);
    procedure SetEffect98(Value: Boolean);
  protected
    { Protected declarations }
    procedure Click; override;
    procedure PopupClick(Sender: TObject);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
              X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
              X, Y: Integer); override;
  public
    { Public declarations }
    constructor Create( AOwner : TComponent); override;
    destructor Destroy; override;
    procedure OpenObject(sObjectPath : PChar);
  published
    { Published declarations }
//    property About: TAbout
//       read FAbout
//       write FAbout;

    property LabelType : TLabelType
       read FLabelType
       write SetLabelType
       default hmHTTP;

    property URLColStd: TColor
       read FColStd
       write SetColStd
       default clBlue;

    property URLColPre: TColor
       read FColPre
       write SetColPre
       default clRed;

    property AllowDown : Boolean
       read FAllowDown
       write SetAllowDown
       default False;

    property Effect98 : Boolean
       read FEffect98
       write SetEffect98
       default False;

    property Caption;

    property URL: TURL
        read FURL
        write FURL;

    property MailSubject: TMailSubject
        read FMailSubject
        write FMAilSubject;

    property WordWrap;
    property Align;

    property Font:TFont
       read GetFont
       write SetFont;

    property AutoSize;
    property Alignment;
    property Visible;
    property Enabled;
    property ParentFont;
    property Transparent;
    property Hint;
    property ShowHint;
    property OnClick;
  end;

procedure Register;

implementation

//uses FPURLLblEdt;

{$R FPUrlLabel.dcr}
{$R FPUrlLabel.res}

Const
   crCoolHand = -21;
   HTTP = 'http://';
   MAIL = 'mailto:';
   FTP = 'ftp://';
   NEWS = 'news://';

constructor TFPUrlLabel.Create( AOwner : TComponent);
begin
   inherited Create(AOwner);
   Screen.Cursors[crCoolHand] := LoadCursor(HInstance, 'FPCOOLHAND');
   Cursor := crCoolHand;
   FAllowDown := false;
   FEffect98 := false;
   FColStd := clBlue;
   FColPre := clRed;
   font.color := URLColStd;
   font.Style := [fsUnderline];

   FPopupMenu := TPopupMenu.Create(Self);
   FMenuItem := TMenuItem.Create(FPopupMenu);
   FMenuItem.Caption := '&Copy';
   FMenuItem.OnClick := PopupClick;
   FPopupMenu.Items.Add(FMenuItem);
   FPopupMenu.AutoPopup:= true;
end;

destructor TFPUrlLabel.Destroy;
begin
   FMenuItem.Destroy;
   inherited Destroy;
end;

procedure TFPUrlLabel.PopupClick;
begin
   if FURL <> '' then Clipboard.AsText := FUrl
     else Clipboard.AsText := Caption;
end;

procedure TFPUrlLabel.URLMouseEnter(var Message: TMessage);
begin
   if Effect98 then
   begin
      font.color := URLColPre;
      if FLabelType <> hmCUSTOM then font.Style := font.Style + [fsUnderline];
      Invalidate
   end;
end;

procedure TFPUrlLabel.URLMouseLeave(var Message: TMessage);
begin
   if Effect98 then
   begin
      font.color := URLColStd;
      if FLabelType <> hmCUSTOM then
        font.Style := font.Style - [fsUnderline]; //[]
      Invalidate
   end;
end;

procedure TFPUrlLabel.SetAllowDown(Value:Boolean);
begin
   if FAllowDown <> Value then
   begin
     FAllowDown := Value;
     Invalidate;
   end;
end;

procedure TFPUrlLabel.SetEffect98(Value:Boolean);
begin
   if FEffect98 <> Value then
   begin
     FEffect98 := Value;
     if FEffect98 then font.Style := font.Style -[fsUnderline]
      else if LabelType <> hmCustom then Font.Style := font.Style + [fsUnderline];

     Invalidate;
   end;
end;

procedure TFPUrlLabel.SetLabelType;
begin
   if FLabelType <> Value then
   begin
      FLabelType := Value;

      if {(FLabelType = hmCustom) or } Effect98 then font.Style := font.Style -[fsUnderline]//[]
      else
         font.Style := font.Style +[fsUnderline]; //[fsUnderline]

      Invalidate;
   end;
end;

function TFPUrlLabel.GetFont: TFont;
begin
   Result := inherited Font;
end;

procedure TFPUrlLabel.SetFont;
begin
   inherited Font := Value;
   FColStd := Font.Color;
end;

procedure TFPUrlLabel.SetColStd;
begin
   if (FColStd <> Value) then
   begin
     FColStd := Value;
     Font.Color := FColStd;
     Invalidate;
   end
end;

procedure TFPUrlLabel.SetColPre;
begin
   if FColPre <> Value then
   begin
     FColPre := Value;
     Invalidate;
   end;
end;

procedure TFPUrlLabel.OpenObject(sObjectPath : PChar);
begin
   if FLabelType <> hmHTTP then
     ShellExecute(0, Nil, sObjectPath, Nil, Nil, SW_NORMAL)
   else
   begin
        if ShellExecute(Application.Handle,PChar('open'),sObjectPath,PChar(''),nil,
           SW_NORMAL) < 33 then
        if ShellExecute(Application.Handle,PChar('open'),PChar('netscape.exe'),sObjectPath,
           nil,SW_NORMAL) < 32 then
        if ShellExecute(Application.Handle,PChar('open'),PChar('iexplore.exe'),sObjectPath
           ,nil,SW_NORMAL) < 32 then
           ShowMessage ('Sorry your browser could not be found');
   end;
end;

procedure TFPUrlLabel.Click;
var
  TempString : array[0..79] of char;
  szApp, szChoice : string;

begin
   Inherited Click;

   if FUrl = '' then
      szChoice := Caption
   else
      szChoice := FUrl;

   if FLabelType = hmCUSTOM then szApp := szChoice
   else
     if FLabelType = hmHTTP then szApp := HTTP+szChoice
     else
       if FLabelType = hmFTP then  szApp := FTP+szChoice
       else
         if FLabelType = hmNews then  szApp := NEWS+szChoice
         else szApp := MAIL+szChoice + '?subject=' + FMailSubject;

     StrPCopy(TempString,szApp);
     OpenObject(TempString)
end;

procedure TFPUrlLabel.MouseDown(Button: TMouseButton; Shift: TShiftState;
              X, Y: Integer);
var
  CursorPos: TPoint;
begin
   inherited MouseDown(Button,Shift,X,Y);
   if Button = mbLeft then
   begin
      if AllowDown then Top:=Top+1;
      font.color := URLColPre;
   end
     else
   if (Button = mbRight) and ((LabelType = hmHttp) or (LabelType = hmMail)
       or (LabelType = hmNews)) then
   begin
      GetCursorPos(CursorPos);
      FPopupMenu.Popup(CursorPos.X,CursorPos.y);
   end
end;

procedure TFPUrlLabel.MouseUp(Button: TMouseButton; Shift: TShiftState;
              X, Y: Integer);
begin
   inherited MouseUp(Button,Shift,X,Y);
   if not Effect98 then font.color := URLColStd;
   if AllowDown then
      if Button = mbLeft then Top:=Top-1;
end;

{procedure TAbout.Edit;
begin
   ShowAbout;
end;


function TAbout.GetAttributes: TPropertyAttributes;
begin
    Result := [paMultiSelect, paDialog, paReadOnly];
end;

function TAbout.GetValue: string;
begin
    Result := '[about]';
end;
 }

procedure Register;
begin
//   RegisterPropertyEditor(TypeInfo(TAbout), TFPUrlLabel, 'ABOUT', TAbout);

   RegisterComponents('Freeware', [TFPURLLabel]);
//   FPURLLblEdt.Register;
end;

end.
