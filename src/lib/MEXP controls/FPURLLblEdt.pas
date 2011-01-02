unit FPURLLblEdt;

{
FPURLLabel Ver. 1.5.0.1 for Delphi 2 and 3:
Developed by Filippo Passeggieri inspirated by some advices in the UDDF site.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FPURLLabel, DesignIntf, DesignEditors, ExtCtrls;

type
  TFPURLLabelEditor = class ( TComponentEditor )
     function GetVerbCount: Integer; override;
     function GetVerb(Index: Integer): string; override;
     procedure ExecuteVerb(Index: Integer); override;
  end;

  TFPURLLabelAboutDlg = class(TForm)
    Button1: TButton;
    Bevel1: TBevel;
    Label3: TLabel;
    lbName: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Image1: TImage;
    FPUrlLabel1: TFPUrlLabel;
    FPUrlLabel3: TFPUrlLabel;
    FPUrlLabel2: TFPUrlLabel;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const
   FPURLLabelVERSION = 'FPURLLabel 1.5.0.1';

procedure Register;

procedure ShowAbout;

implementation

{$R *.DFM}

  procedure ShowAbout;
  var F: TFPURLLabelAboutDlg;
  begin
     F := TFPURLLabelAboutDlg.Create(Application);
     F.LbName.caption := FPURLLabelVERSION;
     F.ShowModal;
     F.Free;
  end;

  function TFPURLLabelEditor.GetVerbCount: Integer;
  begin
     Result := 7;
  end;

  function TFPURLLabelEditor.GetVerb(Index: Integer): String;
  begin
     case Index of
     0: Result := 'About FPURLLabel';
     1: Result := '-';
     2: Result := 'C&ustom';
     3: Result := 'F&tp';
     4: Result := '&Mail';
     5: Result := '&News';
     6: Result := '&Http';
     end;
  end;

  procedure TFPURLLabelEditor.ExecuteVerb(Index: Integer);
  begin
     case Index of
        0: begin
             ShowAbout;
           end;
        2: begin
              TFPURLLabel(Component).LabelType := hmCUSTOM;
              Designer.Modified;
           end;
        3: begin
              TFPURLLabel(Component).LabelType := hmFtp;
              Designer.Modified;
           end;
        4: begin
              TFPURLLabel(Component).LabelType := hmMail;
              Designer.Modified;
           end;
        5: begin
              TFPURLLabel(Component).LabelType := hmNews;
              Designer.Modified;
           end;
        6: begin
              TFPURLLabel(Component).LabelType := hmHttp;
              Designer.Modified;
           end;
     end;
  end;

  procedure Register;
  begin
      RegisterComponentEditor(TFPURLLabel, TFPURLLabelEditor);
  end;


end.
