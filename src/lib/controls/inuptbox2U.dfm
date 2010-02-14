object InputBox2: TInputBox2
  Left = 355
  Top = 211
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'InputBox2'
  ClientHeight = 108
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 262
    Height = 108
    Align = alClient
    BevelInner = bvLowered
    FullRepaint = False
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 2
      Width = 258
      Height = 47
      Alignment = taCenter
      AutoSize = False
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ShowAccelChar = False
      Layout = tlCenter
      WordWrap = True
    end
    object Button1: TButton
      Left = 40
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
    object Button2: TButton
      Left = 144
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
      OnClick = Button2Click
    end
    object Edit1: TEdit
      Left = 16
      Top = 48
      Width = 225
      Height = 21
      TabOrder = 0
      Visible = False
    end
    object Pbar: TProgressBar
      Left = 2
      Top = 96
      Width = 258
      Height = 10
      Align = alBottom
      Min = 0
      Max = 100
      TabOrder = 3
      Visible = False
    end
    object Button3: TButton
      Left = 96
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Button3'
      ModalResult = 3
      TabOrder = 4
      Visible = False
    end
  end
end
