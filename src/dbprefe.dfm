object dbpref: Tdbpref
  Left = 396
  Top = 406
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Add database'
  ClientHeight = 416
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object loadinglabel: TLabel
    Left = 0
    Top = 387
    Width = 507
    Height = 13
    Align = alBottom
  end
  object pbar: TProgressBar
    Left = 0
    Top = 400
    Width = 507
    Height = 16
    Align = alBottom
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 360
    Width = 507
    Height = 27
    Align = alBottom
    TabOrder = 1
    object Scanbut: TButton
      Left = 0
      Top = 0
      Width = 121
      Height = 25
      Caption = 'Scan and save'
      TabOrder = 0
      OnClick = ScanbutClick
    end
    object Button3: TButton
      Left = 120
      Top = 0
      Width = 89
      Height = 25
      Caption = 'Save'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button2: TButton
      Left = 208
      Top = 0
      Width = 105
      Height = 25
      Caption = 'Cancel'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 507
    Height = 360
    Align = alClient
    TabOrder = 2
    object GroupBox1: TGroupBox
      Left = 8
      Top = 5
      Width = 489
      Height = 228
      Caption = 'Location'
      TabOrder = 0
      object Label6: TLabel
        Left = 8
        Top = 76
        Width = 26
        Height = 13
        Caption = 'Path:'
      end
      object Label7: TLabel
        Left = 8
        Top = 28
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object Color: TLabel
        Left = 8
        Top = 56
        Width = 25
        Height = 13
        Caption = 'Color'
      end
      object Cpanel: TJvColorButton
        Left = 288
        Top = 52
        Width = 185
        Height = 22
        OtherCaption = '&Other...'
        Options = []
        TabOrder = 11
        TabStop = False
      end
      object name: TEdit
        Left = 56
        Top = 24
        Width = 417
        Height = 21
        TabOrder = 0
      end
      object recsub: TCheckBox
        Left = 248
        Top = 160
        Width = 225
        Height = 17
        Hint = 'Scan all subdirectories'
        Caption = 'Recurse subdirectories'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object readonly: TRadioButton
        Left = 248
        Top = 88
        Width = 233
        Height = 17
        Caption = 'Media is read-only (cd-roms a.o.)'
        Checked = True
        TabOrder = 2
        TabStop = True
      end
      object notreadonly: TRadioButton
        Left = 248
        Top = 108
        Width = 233
        Height = 17
        Caption = 'Media is not read-only (zip-drive a.o.)'
        TabOrder = 3
      end
      object Button1: TButton
        Left = 56
        Top = 160
        Width = 89
        Height = 17
        Caption = 'Add'
        TabOrder = 4
        OnClick = Button1Click
      end
      object Button4: TButton
        Left = 144
        Top = 160
        Width = 89
        Height = 17
        Caption = 'Remove'
        TabOrder = 5
        OnClick = Button4Click
      end
      object network: TRadioButton
        Left = 248
        Top = 128
        Width = 233
        Height = 17
        Caption = 'Network'
        TabOrder = 6
      end
      object CalcCRCcb: TCheckBox
        Left = 8
        Top = 184
        Width = 473
        Height = 17
        Caption = 'CalcCRCcb'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
      object repairVBRCB: TCheckBox
        Left = 8
        Top = 203
        Width = 473
        Height = 17
        Hint = 
          'VBR (Variable Bitrate) mp3'#39's should contain a special header'#13#10'th' +
          'at contains information on the number of mpeg-frames in the file' +
          '.'#13#10'Without this data, it is impossible to determine the correct ' +
          'duration of the file.'#13#10'This is why some programs, like Winamp, d' +
          'isplays the duration the file wrong,'#13#10'and sometimes has a jumpy ' +
          'position-slider.'#13#10#13#10'To correctly measure the duration of these f' +
          'iles, MEXP scans the entire file and'#13#10'calculates the correct ave' +
          'rage bitrate and duration, however, scanning the entire'#13#10'files c' +
          'an take a few seconds.'#13#10#13#10'MEXP can compose and write a new VBR-h' +
          'eader based on these measured data.'#13#10'This will avoid problems wh' +
          'en playing in Winamp and keep MEXP from scanning'#13#10'the entire fil' +
          'e the next time the file is scanned'
        Caption = 'repait heads'
        TabOrder = 8
      end
      object path: TJvTextListBox
        Left = 56
        Top = 80
        Width = 177
        Height = 81
        ItemHeight = 13
        TabOrder = 9
      end
      object cbUseCustomColor: TCheckBox
        Left = 56
        Top = 56
        Width = 225
        Height = 17
        Caption = 'cbUseCustomColor'
        TabOrder = 10
        OnClick = cbUseCustomColorClick
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 237
      Width = 489
      Height = 116
      Caption = 'Exclude list'
      TabOrder = 1
      object Label3: TLabel
        Left = 16
        Top = 16
        Width = 197
        Height = 26
        Caption = 
          'Add / don'#39't add files where these strings appears in their filen' +
          'ame'
        WordWrap = True
      end
      object Button6: TButton
        Left = 360
        Top = 88
        Width = 105
        Height = 17
        Caption = 'Delete'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 256
        Top = 88
        Width = 105
        Height = 17
        Caption = 'Add'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = Button7Click
      end
      object excl: TJvTextListBox
        Left = 256
        Top = 11
        Width = 209
        Height = 78
        ItemHeight = 13
        TabOrder = 2
      end
    end
  end
  object scanpopup: TPopupMenu
    Left = 432
    Top = 140
    object Scan1: TMenuItem
      Caption = 'Scan'
      OnClick = Scan1Click
    end
    object Scannewremovedeadfiles1: TMenuItem
      Caption = 'Scan new / remove dead files'
      OnClick = Scannewremovedeadfiles1Click
    end
  end
  object clrlabel: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = clrlabelTimer
    Left = 456
    Top = 160
  end
end
