object pref: Tpref
  Left = 402
  Top = 432
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 440
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pbar: TProgressBar
    Left = 0
    Top = 404
    Width = 688
    Height = 12
    Align = alBottom
    Smooth = True
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 416
    Width = 688
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    Color = 9790756
    TabOrder = 1
    object Label555: TLabel
      Left = 216
      Top = 6
      Width = 34
      Height = 13
      Caption = 'MEXP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object FPUrlLabel2: TFPUrlLabel
      Left = 552
      Top = 8
      Width = 33
      Height = 12
      Cursor = crHandPoint
      LabelType = hmMAIL
      URLColStd = clSilver
      Effect98 = True
      Caption = 'E-mail'
      URL = 'mexp@mexp.dk'
      MailSubject = 'MEXP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object FPUrlLabel1: TFPUrlLabel
      Left = 600
      Top = 8
      Width = 41
      Height = 12
      Cursor = crHandPoint
      URLColStd = clSilver
      Effect98 = True
      Caption = 'web site'
      URL = 'www.mexp.dk'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -9
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object SaveButton: TButton
      Left = 0
      Top = 0
      Width = 89
      Height = 25
      Caption = 'Save'
      TabOrder = 0
      OnClick = SaveButtonClick
    end
    object CloseButton: TButton
      Left = 88
      Top = 0
      Width = 105
      Height = 25
      Cancel = True
      Caption = 'Close'
      TabOrder = 1
      OnClick = CloseButtonClick
    end
  end
  object PrefTree: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 121
    Height = 404
    Align = alLeft
    BevelOuter = bvNone
    BevelKind = bkSoft
    BorderStyle = bsNone
    ButtonFillMode = fmShaded
    BorderWidth = 2
    ClipboardFormats.Strings = (
      'Plain text'
      'Unicode text'
      'Virtual Tree Data')
    Colors.BorderColor = clNavy
    Colors.HotColor = clBlack
    Colors.TreeLineButtonColor = clBlack
    Header.AutoSizeIndex = 0
    Header.DefaultHeight = 17
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = -1
    Header.Options = [hoColumnResize, hoDrag]
    HintAnimation = hatNone
    IncrementalSearch = isAll
    Indent = 8
    Margin = 2
    ScrollBarOptions.ScrollBars = ssNone
    TabOrder = 2
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
    TreeOptions.PaintOptions = [toHideFocusRect, toHotTrack, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnChange = PrefTreeChange
    OnFreeNode = PrefTreeFreeNode
    OnGetText = PrefTreeGetText
    Columns = <>
  end
  object PC: TPageControl
    Left = 121
    Top = 0
    Width = 567
    Height = 404
    ActivePage = TSUsers
    Align = alClient
    MultiLine = True
    TabOrder = 3
    OnChange = PCChange
    object TSMyMusic: TTabSheet
      BorderWidth = 2
      Caption = 'My Music'
      ImageIndex = 10
      TabVisible = False
      OnShow = TSMyMusicShow
      object loadinglabel: TLabel
        Left = 0
        Top = 377
        Width = 555
        Height = 13
        Align = alBottom
        AutoSize = False
        Caption = 'My music'
        ShowAccelChar = False
      end
      object Label2: TLabel
        Left = 0
        Top = 4
        Width = 120
        Height = 13
        Caption = 'Primary database name :'
      end
      object harddisk: TEdit
        Left = 8
        Top = 18
        Width = 249
        Height = 17
        AutoSize = False
        TabOrder = 0
        Text = 'My Music'
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 44
        Width = 265
        Height = 165
        Caption = 'MP3 paths to scan '
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 18
          Width = 237
          Height = 24
          Caption = 
            'NOTE: Do not add subdirectories of an already added directory si' +
            'nce the search is recursive'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Button1: TButton
          Left = 24
          Top = 136
          Width = 105
          Height = 20
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 128
          Top = 136
          Width = 113
          Height = 20
          TabOrder = 1
          OnClick = Button2Click
        end
        object paths: TJvTextListBox
          Left = 24
          Top = 48
          Width = 217
          Height = 89
          ItemHeight = 13
          TabOrder = 2
          OnClick = pathsClick
        end
      end
      object GroupBox9: TGroupBox
        Left = 272
        Top = 44
        Width = 241
        Height = 165
        Caption = 'Exclude list '
        TabOrder = 2
        object Label9: TLabel
          Left = 8
          Top = 16
          Width = 171
          Height = 24
          Alignment = taCenter
          Caption = 
            'Don'#39't add files where any of these strings appears in their file' +
            'name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Button10: TButton
          Left = 16
          Top = 136
          Width = 105
          Height = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = Button10Click
        end
        object Button9: TButton
          Left = 120
          Top = 136
          Width = 97
          Height = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = Button9Click
        end
        object excl: TJvTextListBox
          Left = 16
          Top = 48
          Width = 201
          Height = 89
          ItemHeight = 13
          TabOrder = 2
        end
      end
      object MyMusicTextColor: TGroupBox
        Left = 0
        Top = 216
        Width = 265
        Height = 73
        Hint = 
          'Each database can have it'#39's own color.'#13#10'This gives a better view' +
          ' of which song is stored on what media'
        Caption = 'Text color '
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        object Cpanel: TJvColorButton
          Left = 32
          Top = 40
          Width = 97
          Height = 22
          OtherCaption = '&Other...'
          Options = []
          TabOrder = 1
          TabStop = False
        end
        object cbUseCustomDbColor: TCheckBox
          Left = 16
          Top = 16
          Width = 241
          Height = 17
          Caption = 'Use custom'
          TabOrder = 0
          OnClick = cbUseCustomDbColorClick
        end
      end
      object ScanPlay: TCheckBox
        Tag = 1
        Left = 272
        Top = 328
        Width = 241
        Height = 17
        Caption = 'Scan Playlists'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object AaddGroups: TCheckBox
        Tag = 1
        Left = 272
        Top = 312
        Width = 241
        Height = 17
        Caption = 'Auto-add groups'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object repairVBRCB: TCheckBox
        Left = 8
        Top = 314
        Width = 257
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
        Caption = 'Repair VBR headers'
        TabOrder = 6
      end
      object Button19: TButton
        Left = 400
        Top = 8
        Width = 105
        Height = 25
        TabOrder = 7
        OnClick = Button19Click
      end
      object ScanButton: TButton
        Left = 280
        Top = 8
        Width = 105
        Height = 25
        TabOrder = 8
        OnClick = ScanButtonClick
      end
      object GroupBox1: TGroupBox
        Left = 272
        Top = 216
        Width = 241
        Height = 97
        Caption = '"Copy to my music" function '
        TabOrder = 9
        object Label3: TLabel
          Left = 8
          Top = 16
          Width = 130
          Height = 13
          Caption = 'Copy files to this directory:'
        end
        object Label16: TLabel
          Left = 4
          Top = 58
          Width = 153
          Height = 36
          Caption = 
            'It is recommended to add this path, or its parent path to the sc' +
            'an-list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object MyMusicPattern: TEdit
          Tag = 1
          Left = 8
          Top = 32
          Width = 225
          Height = 21
          TabOrder = 0
        end
        object Button14: TButton
          Left = 168
          Top = 56
          Width = 65
          Height = 17
          TabOrder = 1
          OnClick = Button14Click
        end
      end
      object CalcCRCcb: TCheckBox
        Left = 8
        Top = 296
        Width = 257
        Height = 17
        Caption = 'Calculate CRC (slow)'
        Checked = True
        State = cbChecked
        TabOrder = 10
      end
    end
    object TSId3: TTabSheet
      BorderWidth = 2
      Caption = 'Tag correcting'
      ImageIndex = 11
      TabVisible = False
      object Label11: TLabel
        Left = 232
        Top = 216
        Width = 125
        Height = 13
        Caption = 'If artist is undefined, use:'
      end
      object Label10: TLabel
        Left = 250
        Top = 84
        Width = 253
        Height = 26
        Caption = 
          'If the title in the ID3 tag is cropped, correct the title using ' +
          'the filename'
        WordWrap = True
      end
      object Label84: TLabel
        Left = 250
        Top = 144
        Width = 252
        Height = 26
        Caption = 
          'Use first and second subdirectories to find out artist and/or al' +
          'bum'
        WordWrap = True
        OnClick = Label84Click
      end
      object Label7: TLabel
        Left = 0
        Top = 0
        Width = 217
        Height = 321
        AutoSize = False
        Caption = 
          'When a file is scanned, and no metatags'#13#10'are found, MEXP tries t' +
          'o measure'#13#10'artist, title, album and track data for the file.'#13#10'By' +
          ' analysing the file'#39's environment'#13#10'(sorrounding files, playlists' +
          ' a.o.), and parsing '#13#10'the filename and file directories, this da' +
          'ta is '#13#10'displayed in the database, the file'#39's metadata'#13#10'is not m' +
          'odified in any way while scanning!'#13#10'Also, if a file contains met' +
          'adata, this may '#13#10'not always be the correct data.'#13#10'MEXPwill try ' +
          'to correct these data as well.'#13#10'Some users might want to disable' +
          ' some of these '#13#10'tag-correcting and tag-measuring features.'#13#10#13#10'I' +
          'f you are unsure, you should leave them '#13#10'all on by default'
        Transparent = True
        WordWrap = True
      end
      object lblEmail: TLabel
        Left = 232
        Top = 296
        Width = 28
        Height = 13
        Caption = 'E-mail'
      end
      object unknown: TEdit
        Tag = 1
        Left = 248
        Top = 232
        Width = 161
        Height = 20
        AutoSize = False
        TabOrder = 0
        Text = 'Unknown'
      end
      object Convertunder: TCheckBox
        Tag = 1
        Left = 232
        Top = 40
        Width = 290
        Height = 17
        Caption = 'Convert "_" to " "'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object removeBrackets: TCheckBox
        Tag = 1
        Left = 232
        Top = 64
        Width = 290
        Height = 17
        Caption = 'Remove brackets'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object correcttitle: TCheckBox
        Tag = 1
        Left = 232
        Top = 88
        Width = 17
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object advTrackCalc: TCheckBox
        Tag = 1
        Left = 232
        Top = 120
        Width = 290
        Height = 17
        Caption = 'Advanced Track calculation'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object UseSubAlbum: TCheckBox
        Tag = 1
        Left = 232
        Top = 144
        Width = 17
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object CorrectCasing: TCheckBox
        Tag = 1
        Left = 232
        Top = 192
        Width = 290
        Height = 17
        Caption = 'Correct upper/lower case'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object SkipId3v1Genre: TCheckBox
        Tag = 1
        Left = 232
        Top = 264
        Width = 290
        Height = 17
        Caption = 'If Id3v2 has Genre, don'#39't use Genre from Id3v1'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
      object CorrectTags: TCheckBox
        Tag = 1
        Left = 232
        Top = 8
        Width = 289
        Height = 17
        Caption = 'CorrectTags'
        Checked = True
        State = cbChecked
        TabOrder = 8
      end
      object txtEmail: TEdit
        Tag = 1
        Left = 248
        Top = 312
        Width = 169
        Height = 21
        TabOrder = 9
      end
    end
    object TSShortCuts: TTabSheet
      BorderWidth = 2
      Caption = 'Shortcuts'
      ImageIndex = 11
      TabVisible = False
      object WarningHotLabel: TLabel
        Left = 0
        Top = 320
        Width = 44
        Height = 13
        Caption = 'Warning:'
        Visible = False
      end
      object HotTree: TVirtualStringTree
        Left = 8
        Top = 8
        Width = 449
        Height = 225
        ClipboardFormats.Strings = (
          'Plain text'
          'Unicode text'
          'Virtual Tree Data')
        Colors.BorderColor = clWindowText
        Colors.HotColor = clBlack
        Colors.TreeLineButtonColor = clBlack
        Header.AutoSizeIndex = -1
        Header.DefaultHeight = 17
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Height = 20
        Header.Options = [hoVisible]
        Header.Style = hsPlates
        HintAnimation = hatNone
        IncrementalSearch = isAll
        TabOrder = 0
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnChange = HotTreeChange
        OnGetText = HotTreeGetText
        Columns = <
          item
            Color = clWindow
            Options = [coEnabled, coParentBidiMode, coVisible]
            Position = 0
            Width = 322
            WideText = 'Command'
          end
          item
            Color = clWindow
            Options = [coEnabled, coParentBidiMode, coVisible]
            Position = 1
            Width = 104
            WideText = 'Shortcut'
          end>
      end
      object GroupBox12: TGroupBox
        Left = 176
        Top = 240
        Width = 161
        Height = 73
        Caption = 'Special keys '
        TabOrder = 1
        object specialKeyAlt: TCheckBox
          Left = 16
          Top = 16
          Width = 41
          Height = 17
          Caption = 'Alt'
          TabOrder = 0
        end
        object specialKeyCtrl: TCheckBox
          Left = 56
          Top = 16
          Width = 49
          Height = 17
          Caption = 'Ctrl'
          TabOrder = 1
        end
        object SpecialKeyShift: TCheckBox
          Left = 104
          Top = 16
          Width = 49
          Height = 17
          Caption = 'Shift'
          TabOrder = 2
        end
        object UseEnterKeyBtn: TButton
          Left = 16
          Top = 34
          Width = 129
          Height = 17
          Caption = 'Use enter key'
          TabOrder = 3
          OnClick = UseEnterKeyBtnClick
        end
        object UseSpaceKeyBtn: TButton
          Left = 16
          Top = 50
          Width = 129
          Height = 17
          Caption = 'Use space key'
          TabOrder = 4
          OnClick = UseEnterKeyBtnClick
        end
      end
      object GroupBox21: TGroupBox
        Left = 0
        Top = 240
        Width = 169
        Height = 73
        Caption = 'Assign shortcut '
        TabOrder = 2
        object Label26: TLabel
          Left = 8
          Top = 14
          Width = 121
          Height = 13
          Caption = 'Enter new shortcut here:'
        end
        object HotKey1: THotKey
          Left = 16
          Top = 30
          Width = 137
          Height = 19
          HotKey = 0
          InvalidKeys = []
          Modifiers = []
          TabOrder = 0
        end
        object Button11: TButton
          Left = 16
          Top = 47
          Width = 137
          Height = 21
          Caption = 'Apply to selected'
          TabOrder = 1
          OnClick = Button11Click
        end
      end
    end
    object TSUsers: TTabSheet
      BorderWidth = 2
      Caption = 'TSUsers'
      ImageIndex = 3
      TabVisible = False
      OnShow = TSUsersShow
      object usernamel: TLabel
        Left = 8
        Top = 48
        Width = 505
        Height = 13
        AutoSize = False
        Caption = 'Current user: default'
      end
      object Label5: TLabel
        Left = 8
        Top = 64
        Width = 505
        Height = 13
        AutoSize = False
        Caption = 'Database and other settings are currently saved in:'
      end
      object userdir: TLabel
        Left = 24
        Top = 80
        Width = 433
        Height = 13
        AutoSize = False
        Caption = 'userdir'
        Transparent = True
      end
      object Label105: TLabel
        Left = 0
        Top = 377
        Width = 555
        Height = 13
        Align = alBottom
        Alignment = taCenter
        Caption = 'Restart Winamp for this setting to take effect'
      end
      object AllowMU: TCheckBox
        Left = 8
        Top = 16
        Width = 369
        Height = 17
        Caption = 'Enable Multiple Users to have their own database and settings'
        TabOrder = 0
        OnClick = AllowMUClick
      end
      object UserPanel: TPanel
        Left = 24
        Top = 112
        Width = 425
        Height = 121
        AutoSize = True
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label106: TLabel
          Left = 168
          Top = 16
          Width = 257
          Height = 52
          Caption = 
            'All unchecked user have their own settings and database. '#13#10#13#10'Che' +
            'cked user shares the same settings and database'
          WordWrap = True
        end
        object userlist: TCheckListBox
          Left = 0
          Top = 0
          Width = 160
          Height = 121
          Align = alLeft
          ItemHeight = 13
          TabOrder = 0
        end
      end
    end
    object TSabout: TTabSheet
      Caption = 'About'
      ImageIndex = 5
      TabVisible = False
      object Label89: TLabel
        Left = 0
        Top = 0
        Width = 559
        Height = 41
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = ' M  E  X  P '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -27
        Font.Name = 'Arial Black'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label90: TLabel
        Left = 0
        Top = 41
        Width = 559
        Height = 12
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = #169'  2 0 1 0   -  A n d e r s   T h  o m s e n'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5197647
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label92: TLabel
        Left = 0
        Top = 355
        Width = 191
        Height = 13
        Align = alBottom
        Alignment = taCenter
        Caption = 'Please report all bugs and comments to '
      end
      object FPUrlLabel3: TFPUrlLabel
        Left = 0
        Top = 381
        Width = 92
        Height = 13
        Cursor = crHandPoint
        LabelType = hmMAIL
        Effect98 = True
        Caption = 'mexp@mexp.dk'
        URL = 'mexp@mexp.dk'
        MailSubject = 'MEXP'
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Alignment = taCenter
        ParentFont = False
      end
      object FPUrlLabel8: TFPUrlLabel
        Left = 0
        Top = 368
        Width = 268
        Height = 13
        Cursor = crHandPoint
        Effect98 = True
        Caption = 'Support and bug-reporting forums on mexp.dk'
        URL = 'www.mexp.dk/forums.shtml'
        MailSubject = 'MEXP'
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Alignment = taCenter
        ParentFont = False
      end
      object Label4: TLabel
        Left = 120
        Top = 120
        Width = 361
        Height = 145
        AutoSize = False
        Caption = 
          'MEXP is free software: you can redistribute it and/or modify'#13#10'it' +
          ' under the terms of the GNU General Public License as published ' +
          'by'#13#10'the Free Software Foundation, either version 3 of the Licens' +
          'e, or'#13#10'(at your option) any later version.'#13#10#13#10'MEXP is distribute' +
          'd in the hope that it will be useful,'#13#10'but WITHOUT ANY WARRANTY;' +
          ' without even the implied warranty of'#13#10'MERCHANTABILITY or FITNES' +
          'S FOR A PARTICULAR PURPOSE.  See the'#13#10'GNU General Public License' +
          ' for more details.'#13#10#13#10'You should have received a copy of the GNU' +
          ' General Public License'#13#10'along with MEXP.  If not, see <http://w' +
          'ww.gnu.org/licenses/>.'
        ShowAccelChar = False
      end
    end
    object TSDailyScan: TTabSheet
      BorderWidth = 2
      Caption = 'TSDailyScan'
      ImageIndex = 12
      TabVisible = False
      object Bevel3: TBevel
        Left = 0
        Top = 208
        Width = 217
        Height = 9
        Shape = bsBottomLine
      end
      object Label108: TLabel
        Left = 0
        Top = 232
        Width = 233
        Height = 26
        AutoSize = False
        Caption = 'After scanning, rename '#13#10'and/or move the file to:'
        WordWrap = True
      end
      object Label43: TLabel
        Left = 256
        Top = 152
        Width = 249
        Height = 177
        AutoSize = False
        Caption = 
          'Here you can specify a list of file paths that will be automatic' +
          'ally scanned when the plugin starts. '#13#10#13#10'The directories that ar' +
          'e checked in the list are being monitored, so that every time a ' +
          'new file is copied or moved to the directory, it is scanned, and' +
          ' eventually renamed and moved to a different directory. This is ' +
          'handy to use with download-managers and file-sharing programs li' +
          'ke Kazaa or WinMX. '
        WordWrap = True
      end
      object AutoScanSub: TCheckBox
        Tag = 1
        Left = 0
        Top = 152
        Width = 233
        Height = 17
        Caption = 'Scan subdirectories'
        TabOrder = 0
      end
      object OnlyScanOnceADay: TCheckBox
        Tag = 1
        Left = 0
        Top = 176
        Width = 233
        Height = 17
        Caption = 'Only scan once a day'
        TabOrder = 1
      end
      object AutoScanMoveToPath: TEdit
        Tag = 1
        Left = 0
        Top = 264
        Width = 193
        Height = 21
        TabOrder = 2
      end
      object Button5: TButton
        Left = 192
        Top = 264
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 3
        OnClick = Button5Click
      end
      object AutoScanPaths: TCheckListBox
        Left = 0
        Top = 0
        Width = 505
        Height = 121
        ItemHeight = 13
        TabOrder = 4
      end
      object Button17: TButton
        Left = 0
        Top = 288
        Width = 97
        Height = 17
        TabOrder = 7
        OnClick = Button14Click
      end
      object Button16: TButton
        Left = 256
        Top = 120
        Width = 249
        Height = 25
        TabOrder = 6
        OnClick = Button16Click
      end
      object Button12: TButton
        Left = 0
        Top = 120
        Width = 256
        Height = 25
        TabOrder = 5
        OnClick = Button12Click
      end
    end
    object TSFontsColors: TTabSheet
      BorderWidth = 2
      Caption = 'TSFontsColors'
      ImageIndex = 11
      TabVisible = False
      OnShow = TSFontsColorsShow
      object Label8: TLabel
        Left = 16
        Top = 32
        Width = 51
        Height = 13
        Caption = 'Font name'
      end
      object Label21: TLabel
        Left = 208
        Top = 32
        Width = 43
        Height = 13
        Caption = 'Font size'
      end
      object MainListColorNote: TLabel
        Left = 288
        Top = 88
        Width = 215
        Height = 36
        Caption = 
          'Note that at item in the Main List and Tree has the color that i' +
          's assigned to its database'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label36: TLabel
        Left = 8
        Top = 0
        Width = 115
        Height = 19
        Caption = 'Fonts && Colors'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel12: TBevel
        Left = 8
        Top = 14
        Width = 522
        Height = 9
        Shape = bsBottomLine
      end
      object Panel16: TPanel
        Left = 16
        Top = 88
        Width = 257
        Height = 288
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object FontColorPanel: TPanel
          Left = 0
          Top = 0
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label19: TLabel
            Left = 0
            Top = 8
            Width = 50
            Height = 13
            Caption = 'Font Color'
          end
          object FontColor: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
        object Backgroundcolorpanel: TPanel
          Left = 0
          Top = 28
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Label101: TLabel
            Left = 0
            Top = 8
            Width = 82
            Height = 13
            Caption = 'Background color'
          end
          object Backgroundcolor: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
        object SelTextColorPanel: TPanel
          Left = 0
          Top = 56
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object Label22: TLabel
            Left = 0
            Top = 8
            Width = 90
            Height = 13
            Caption = 'Selected text color'
          end
          object SelTextColor: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
        object SelBarFocusedPanel: TPanel
          Left = 0
          Top = 84
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object Label23: TLabel
            Left = 0
            Top = 8
            Width = 137
            Height = 13
            Caption = 'Selection bar color (focused)'
          end
          object SelBarFocused: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
        object SelBarUnFocusedPanel: TPanel
          Left = 0
          Top = 112
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object Label24: TLabel
            Left = 0
            Top = 8
            Width = 149
            Height = 13
            Caption = 'Selection bar color (unfocused)'
          end
          object SelBarUnfocused: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
        object playingtxtcolorpanel: TPanel
          Left = 0
          Top = 224
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 5
          object Label95: TLabel
            Left = 0
            Top = 8
            Width = 91
            Height = 13
            Caption = '"Playing" text color'
          end
          object playingtextcolor: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
        object headerColorPanel: TPanel
          Left = 0
          Top = 196
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 6
          object Label115: TLabel
            Left = 0
            Top = 8
            Width = 61
            Height = 13
            Caption = 'Header color'
          end
          object headerColor: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
        object HeaderTextColorPanel: TPanel
          Left = 0
          Top = 140
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 7
          object Label116: TLabel
            Left = 0
            Top = 8
            Width = 84
            Height = 13
            Caption = 'Header text color'
          end
          object HeaderTextColor: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
        object SearchFontColorPanel: TPanel
          Left = 0
          Top = 168
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 8
          object Label25: TLabel
            Left = 0
            Top = 8
            Width = 105
            Height = 13
            Caption = 'Search field font color'
          end
          object SearchFontColor: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
        object KillTextColorPanel: TPanel
          Left = 0
          Top = 252
          Width = 257
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 9
          object Label38: TLabel
            Left = 0
            Top = 8
            Width = 69
            Height = 13
            Caption = '"Kill" text color'
          end
          object KillTextColor: TJvColorButton
            Left = 192
            Top = 0
            Width = 49
            OtherCaption = '&Other...'
            Options = []
            TabOrder = 0
            TabStop = False
          end
        end
      end
      object FB: TJvFontComboBox
        Left = 16
        Top = 48
        Width = 177
        Height = 22
        DroppedDownWidth = 177
        MaxMRUCount = 0
        FontName = 'System'
        ItemIndex = 0
        Sorted = False
        TabOrder = 1
      end
      object FontSize: TSpinEdit
        Left = 208
        Top = 48
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object FontBold: TCheckBox
        Left = 296
        Top = 48
        Width = 73
        Height = 17
        Caption = 'Bold'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object FontItalic: TCheckBox
        Left = 376
        Top = 48
        Width = 97
        Height = 17
        Caption = 'Italic'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsItalic]
        ParentFont = False
        TabOrder = 4
      end
    end
    object TSid3Editor: TTabSheet
      BorderWidth = 2
      Caption = 'TSid3Editor'
      ImageIndex = 11
      TabVisible = False
      object GroupBox22: TGroupBox
        Left = 8
        Top = 0
        Width = 513
        Height = 185
        Caption = 'Default settings  '
        TabOrder = 0
        object Id3_autoformatNewText: TCheckBox
          Tag = 1
          Left = 16
          Top = 16
          Width = 353
          Height = 17
          Caption = 'Autoformat new text'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object Id3_SyncTabs: TCheckBox
          Tag = 1
          Left = 16
          Top = 32
          Width = 345
          Height = 17
          Caption = 'Update file tags when editing database values'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 1
        end
        object Id3_SaveGroups: TCheckBox
          Tag = 1
          Left = 16
          Top = 48
          Width = 353
          Height = 17
          Caption = 'Save groups in file tag (Id3v2, Ogg, WMA, APE)'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 2
        end
        object Id3_AutoCopyFromDB: TCheckBox
          Tag = 1
          Left = 16
          Top = 96
          Width = 353
          Height = 17
          Caption = 'Activate "copy from database" when adding new tag'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object ID3_AlwaysCopyFromDB: TCheckBox
          Tag = 1
          Left = 16
          Top = 80
          Width = 353
          Height = 17
          Caption = 'Always activate "Copy from database"'
          TabOrder = 4
        end
        object ID3_AutoGetLyrics: TCheckBox
          Tag = 1
          Left = 16
          Top = 112
          Width = 353
          Height = 17
          Caption = 'Automatically retreive lyrics if connected to the internet'
          TabOrder = 5
        end
        object ID3_EnableOnTabChange: TCheckBox
          Tag = 1
          Left = 16
          Top = 64
          Width = 353
          Height = 17
          Caption = 'When entering a disabled tag-tab, enable it'
          TabOrder = 6
        end
        object StripId3v2FromUnsupported: TCheckBox
          Tag = 1
          Left = 16
          Top = 160
          Width = 377
          Height = 17
          Caption = 
            'Strip Id3v2 tags from files that does not support it (Ape, Ogg, ' +
            'WMA, Mpc)'
          TabOrder = 7
        end
        object CloseEditorAfterSave: TCheckBox
          Tag = 1
          Left = 16
          Top = 128
          Width = 225
          Height = 17
          Caption = 'Close editor window after save'
          TabOrder = 8
        end
        object HideOnEdit: TCheckBox
          Tag = 1
          Left = 16
          Top = 144
          Width = 225
          Height = 17
          Caption = 'Hide Winamp when editing tags'
          Checked = True
          State = cbChecked
          TabOrder = 9
        end
      end
      object GroupBox8: TGroupBox
        Left = 8
        Top = 192
        Width = 513
        Height = 89
        Caption = 'Editing values in the main list / tree / CDDB '
        TabOrder = 1
        object Label55: TLabel
          Left = 8
          Top = 40
          Width = 305
          Height = 41
          AutoSize = False
          Caption = 'note'
          WordWrap = True
        end
        object MainListUpdateTags: TCheckBox
          Tag = 1
          Left = 16
          Top = 16
          Width = 233
          Height = 17
          Caption = 'Update file tags, if the file(s) has any'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object forceId3v1: TCheckBox
          Tag = 1
          Left = 328
          Top = 40
          Width = 57
          Height = 17
          Caption = 'Id3v1'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object forceId3v2: TCheckBox
          Tag = 1
          Left = 384
          Top = 40
          Width = 57
          Height = 17
          Caption = 'Id3v2'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object forceApe: TCheckBox
          Tag = 1
          Left = 456
          Top = 40
          Width = 49
          Height = 17
          Caption = 'Ape'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object ForceOgg: TCheckBox
          Tag = 1
          Left = 376
          Top = 64
          Width = 73
          Height = 17
          Caption = 'Ogg Vorbis'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object ForceWMA: TCheckBox
          Tag = 1
          Left = 456
          Top = 64
          Width = 49
          Height = 17
          Caption = 'WMA'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
      end
      object GroupBox31: TGroupBox
        Left = 8
        Top = 288
        Width = 513
        Height = 49
        Caption = 'SDB'
        TabOrder = 2
        object saveDBNote: TLabel
          Left = 264
          Top = 14
          Width = 241
          Height = 27
          AutoSize = False
          Caption = 'saveDBNote'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object SaveDB: TCheckBox
          Tag = 1
          Left = 24
          Top = 16
          Width = 233
          Height = 17
          Caption = 'SaveDB'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
      end
    end
    object TScheckNewVer: TTabSheet
      BorderWidth = 2
      Caption = 'New version'
      ImageIndex = 12
      TabVisible = False
      object CheckNewVerLabel: TLabel
        Left = 56
        Top = 128
        Width = 401
        Height = 113
        Alignment = taCenter
        AutoSize = False
      end
      object Button18: TButton
        Left = 136
        Top = 96
        Width = 225
        Height = 25
        Caption = 'Check for new version'
        TabOrder = 0
        OnClick = Button18Click
      end
      object BtnGotoHomepage: TButton
        Left = 176
        Top = 248
        Width = 145
        Height = 25
        Caption = 'Go to website!'
        TabOrder = 1
        Visible = False
        OnClick = BtnGotoHomepageClick
      end
    end
    object TScredits: TTabSheet
      BorderWidth = 2
      Caption = 'TScredits'
      ImageIndex = 13
      TabVisible = False
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 555
        Height = 390
        Align = alClient
        AutoSize = True
        BevelOuter = bvNone
        Caption = 'Panel2'
        TabOrder = 0
        object Label44: TLabel
          Left = 0
          Top = 0
          Width = 223
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'Written, produced and directed by'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label45: TLabel
          Left = 0
          Top = 13
          Width = 80
          Height = 26
          Align = alTop
          Alignment = taCenter
          Caption = 'Anders Thomsen'#13#10' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label46: TLabel
          Left = 0
          Top = 39
          Width = 264
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'Additional code / third-part components'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label47: TLabel
          Left = 0
          Top = 52
          Width = 61
          Height = 52
          Align = alTop
          Alignment = taCenter
          Caption = 'Mike Lischke'#13#10'James Webb'#13#10'Jurgen Faul'#13#10' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label50: TLabel
          Left = 0
          Top = 104
          Width = 149
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'Ideas and beta-testing'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label51: TLabel
          Left = 0
          Top = 117
          Width = 153
          Height = 169
          Align = alTop
          Alignment = taCenter
          Caption = 
            'Peter Tr'#252'bger'#13#10'Anders Krog'#13#10'Twan'#13#10'Annihilator'#13#10'Lars Jensen [www.' +
            'exenova.dk]'#13#10'DreamCool'#13#10'Penny Lane (English Pub)'#13#10'Darkcristal'#13#10'C' +
            'arlos Andr'#233's Osorio Gonz'#225'lez'#13#10'Erik O'#39'Berg'#13#10'Tibor Sz'#246'ke'#13#10'And many' +
            ' others!'#13#10' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label49: TLabel
          Left = 0
          Top = 299
          Width = 72
          Height = 52
          Align = alTop
          Alignment = taCenter
          Caption = 'Martin Nilsson'#13#10'Alon Gingold'#13#10'Martin Hammer'#13#10' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label48: TLabel
          Left = 0
          Top = 286
          Width = 64
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = 'Thanks to'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label53: TLabel
          Left = 0
          Top = 351
          Width = 555
          Height = 13
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'If anybody'#39's missing on the list, please e-mail me'
        end
      end
    end
    object TSgeneralSettings: TTabSheet
      Caption = 'General settings'
      ImageIndex = 14
      TabVisible = False
      object GroupBox17: TGroupBox
        Left = 8
        Top = 64
        Width = 217
        Height = 57
        Caption = 'Save search '
        TabOrder = 0
        object savesearch: TCheckBox
          Tag = 1
          Left = 16
          Top = 16
          Width = 174
          Height = 17
          Caption = 'Save search string on exit'
          TabOrder = 0
        end
        object savetreeselection: TCheckBox
          Tag = 1
          Left = 16
          Top = 32
          Width = 177
          Height = 17
          Caption = 'Save tree selection(s)'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
      object GroupBox20: TGroupBox
        Left = 240
        Top = 96
        Width = 225
        Height = 97
        Caption = 'Drag'#39'n'#39'Drop'
        TabOrder = 1
        object Label102: TLabel
          Left = 24
          Top = 64
          Width = 183
          Height = 13
          Caption = '(enable dropping files in Explorer ect.)'
          OnClick = Label102Click
        end
        object Label103: TLabel
          Left = 24
          Top = 32
          Width = 182
          Height = 13
          Caption = '(faster reading by MEXP and Winamp)'
          OnClick = Label103Click
        end
        object Label54: TLabel
          Left = 8
          Top = 80
          Width = 198
          Height = 13
          Caption = 'This setting can be toggled using Alt-key.'
        end
        object dragplaylist: TRadioButton
          Tag = 1
          Left = 8
          Top = 16
          Width = 201
          Height = 17
          Caption = 'Generate playlist from selection'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object dragfiles: TRadioButton
          Tag = 1
          Left = 8
          Top = 48
          Width = 193
          Height = 17
          Caption = 'Drag files'
          TabOrder = 1
        end
      end
      object loadon: TRadioGroup
        Tag = 1
        Left = 8
        Top = 0
        Width = 217
        Height = 57
        Caption = 'Load database'
        ItemIndex = 1
        Items.Strings = (
          'On Winamp startup'
          'First time showed')
        TabOrder = 2
      end
      object GroupBox6: TGroupBox
        Left = 240
        Top = 0
        Width = 225
        Height = 89
        Caption = 'Program icons '
        TabOrder = 3
        object sit: TCheckBox
          Tag = 1
          Left = 16
          Top = 20
          Width = 193
          Height = 17
          Hint = 'Restart Winamp to take effect'
          Caption = 'Show icon in taskbar'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object IconInSystray: TCheckBox
          Tag = 1
          Left = 16
          Top = 40
          Width = 193
          Height = 17
          Caption = 'Show icon in systray'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object showhide: TCheckBox
          Tag = 1
          Left = 16
          Top = 62
          Width = 201
          Height = 17
          Caption = 'Show / hide with Winamp'
          TabOrder = 2
        end
      end
      object TrayIconOptions: TRadioGroup
        Tag = 1
        Left = 240
        Top = 200
        Width = 225
        Height = 65
        Caption = 'TrayIconOptions'
        ItemIndex = 1
        Items.Strings = (
          '1'
          '2')
        TabOrder = 4
      end
      object GroupBox14: TGroupBox
        Left = 240
        Top = 272
        Width = 225
        Height = 57
        Caption = 'Show hints '
        TabOrder = 5
        object showhnt: TCheckBox
          Tag = 1
          Left = 16
          Top = 24
          Width = 185
          Height = 17
          Caption = 'Show hints / tooltip'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
      end
      object Scrollbars: TRadioGroup
        Tag = 1
        Left = 8
        Top = 128
        Width = 217
        Height = 73
        Caption = 'Scrollbars '
        ItemIndex = 2
        Items.Strings = (
          'Regular'
          'Flat'
          'Winamp style')
        TabOrder = 6
      end
      object GroupBox27: TGroupBox
        Left = 8
        Top = 208
        Width = 217
        Height = 81
        Caption = 'Groups '
        TabOrder = 7
        object ShowGroupsInTree: TCheckBox
          Tag = 1
          Left = 16
          Top = 40
          Width = 193
          Height = 17
          Caption = 'Show Groups in Tree'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = ShowGroupsInTreeClick
        end
        object ShowGroupsAtFilter: TCheckBox
          Tag = 1
          Left = 16
          Top = 16
          Width = 185
          Height = 17
          Caption = 'Show "Groups" menu '
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object ShowGroupSettingsInTree: TCheckBox
          Tag = 1
          Left = 24
          Top = 60
          Width = 177
          Height = 17
          Caption = 'Show Groups settings'
          TabOrder = 2
        end
      end
      object SelectionRectangle: TRadioGroup
        Tag = 1
        Left = 8
        Top = 296
        Width = 217
        Height = 41
        Caption = 'Selection rectangle '
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'Outlined'
          'Solid')
        TabOrder = 8
      end
    end
    object TSmainListSettings: TTabSheet
      Caption = 'Main List'
      ImageIndex = 15
      TabVisible = False
      OnShow = TSmainListSettingsShow
      object dontAddIfExistsInWinplayText: TLabel
        Left = 298
        Top = 72
        Width = 225
        Height = 33
        AutoSize = False
        WordWrap = True
        OnClick = dontAddIfExistsInWinplayTextClick
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 128
        Width = 249
        Height = 89
        Caption = 'Free text Search in these fields: '
        TabOrder = 0
        object SearchInFields: TCheckListBox
          Left = 8
          Top = 16
          Width = 233
          Height = 65
          OnClickCheck = SearchInFieldsClickCheck
          Columns = 2
          ItemHeight = 13
          TabOrder = 0
        end
      end
      object GroupBox11: TGroupBox
        Left = 8
        Top = 0
        Width = 249
        Height = 121
        Caption = 'Auto search '
        TabOrder = 1
        object Panel15: TPanel
          Left = 8
          Top = 86
          Width = 233
          Height = 26
          AutoSize = True
          BevelOuter = bvNone
          Caption = 'Panel15'
          ParentColor = True
          TabOrder = 0
          Visible = False
          object Label14: TLabel
            Left = 0
            Top = 0
            Width = 145
            Height = 26
            Caption = 'Start searching when no keys have been pressed for'
            WordWrap = True
          end
          object Label15: TLabel
            Left = 212
            Top = 13
            Width = 21
            Height = 13
            Caption = 'ms.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object autoquery: TSpinEdit
            Tag = 1
            Left = 152
            Top = 4
            Width = 57
            Height = 22
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            Increment = 50
            MaxValue = 0
            MinValue = 0
            ParentFont = False
            TabOrder = 0
            Value = 150
          end
        end
        object SearchMode: TRadioGroup
          Tag = 1
          Left = 8
          Top = 16
          Width = 233
          Height = 65
          Caption = 'Search Mode'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Search as you type'
            'Search after xxx ms time'
            'Search on Enter')
          ParentFont = False
          TabOrder = 1
          OnClick = SearchModeClick
          OnEnter = SearchModeEnter
        end
      end
      object dblclick: TRadioGroup
        Tag = 2
        Left = 272
        Top = 0
        Width = 249
        Height = 65
        Caption = 'Doubleclicking the list '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Play'
          'Enqueue'
          'Enqueue and play'
          'Punch in'
          'Punch in and play')
        TabOrder = 2
      end
      object DeOp: TRadioGroup
        Tag = 2
        Left = 8
        Top = 224
        Width = 249
        Height = 33
        BiDiMode = bdLeftToRight
        Caption = 'Default operator  in search string '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Or'
          'And')
        ParentBiDiMode = False
        TabOrder = 3
      end
      object GroupBox19: TGroupBox
        Left = 272
        Top = 104
        Width = 249
        Height = 41
        Caption = 'Focus playing song on change '
        TabOrder = 4
        object FollowPlayingML: TCheckBox
          Tag = 1
          Left = 16
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Enabled'
          TabOrder = 0
        end
      end
      object fzcol: TRadioGroup
        Tag = 1
        Left = 272
        Top = 256
        Width = 121
        Height = 57
        Caption = 'File Size Column '
        ItemIndex = 0
        Items.Strings = (
          'Show in Kbytes'
          'Show in Bytes')
        TabOrder = 5
      end
      object SRcol: TRadioGroup
        Tag = 1
        Left = 400
        Top = 256
        Width = 121
        Height = 57
        Caption = 'Sample Rate Column '
        ItemIndex = 0
        Items.Strings = (
          'Show in KHz'
          'Show in Hz')
        TabOrder = 6
      end
      object ColumnsGroupBox: TGroupBox
        Left = 272
        Top = 152
        Width = 249
        Height = 97
        Caption = 'ColumnsGroupBox'
        TabOrder = 7
        object AutoResizeColumns: TCheckBox
          Tag = 1
          Left = 16
          Top = 16
          Width = 222
          Height = 17
          Caption = 'Auto resize columns'
          TabOrder = 0
          Visible = False
        end
        object AutoResizeColumnHeaders: TCheckBox
          Tag = 2
          Left = 16
          Top = 24
          Width = 222
          Height = 17
          Caption = 'AutoResizeColumnHeaders'
          ParentShowHint = False
          ShowHint = False
          TabOrder = 1
        end
        object HideInfoShownInTree: TCheckBox
          Tag = 2
          Left = 16
          Top = 48
          Width = 222
          Height = 17
          Caption = 'HideInfoShownInTree'
          TabOrder = 2
        end
      end
      object EnterInSearchfield: TRadioGroup
        Tag = 1
        Left = 8
        Top = 264
        Width = 249
        Height = 73
        Caption = 'Pressing '#39'Enter'#39' in search field '
        ItemIndex = 0
        Items.Strings = (
          'Nothing'
          'Play all'
          'Enqueue all')
        TabOrder = 8
      end
      object CaseSensitiveSort: TCheckBox
        Tag = 1
        Left = 280
        Top = 320
        Width = 241
        Height = 17
        Caption = 'CaseSensitiveSort'
        TabOrder = 9
      end
      object dontAddIfExistsInWinplay: TCheckBox
        Tag = 1
        Left = 280
        Top = 72
        Width = 17
        Height = 17
        TabOrder = 10
      end
      object cbShowTotalDurationLabel: TCheckBox
        Tag = 1
        Left = 280
        Top = 344
        Width = 233
        Height = 17
        Caption = 'cbShowTotalDurationLabel'
        TabOrder = 11
      end
    end
    object TStreeSettings: TTabSheet
      Caption = 'Tree'
      ImageIndex = 16
      TabVisible = False
      OnShow = TStreeSettingsShow
      object GroupBox7: TGroupBox
        Left = 8
        Top = 0
        Width = 249
        Height = 57
        Caption = 'Tree '
        TabOrder = 0
        object Label88: TLabel
          Left = 26
          Top = 22
          Width = 201
          Height = 27
          AutoSize = False
          Caption = 'Auto adjust tree width/height on resize'
          WordWrap = True
          OnClick = Label88Click
        end
        object GroupBox10: TGroupBox
          Left = 20
          Top = 300
          Width = 233
          Height = 121
          Caption = 'Exclude list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label12: TLabel
            Left = 16
            Top = 16
            Width = 86
            Height = 91
            Caption = 
              'If any of the string in this list appears in a filename, the art' +
              'ist is not displayed in the tree'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Button8: TButton
            Left = 120
            Top = 96
            Width = 41
            Height = 17
            Caption = 'Add'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object Button7: TButton
            Left = 176
            Top = 96
            Width = 41
            Height = 17
            Caption = 'Del'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object Aatw: TCheckBox
          Tag = 1
          Left = 8
          Top = 20
          Width = 17
          Height = 17
          TabOrder = 1
        end
      end
      object GroupBox16: TGroupBox
        Left = 264
        Top = 0
        Width = 249
        Height = 161
        Caption = 'Auto reset search '
        TabOrder = 1
        object Label17: TLabel
          Left = 26
          Top = 48
          Width = 215
          Height = 73
          AutoSize = False
          Caption = 
            'This timer is reset everytime a new searchstring is applied. If ' +
            'the selection in the tree is changed after the time has elapsed,' +
            ' the searchstring is cleared'
          WordWrap = True
          OnClick = Label17Click
        end
        object Label18: TLabel
          Left = 192
          Top = 22
          Width = 16
          Height = 13
          Caption = 'sec'
        end
        object Label20: TLabel
          Left = 26
          Top = 118
          Width = 215
          Height = 35
          AutoSize = False
          Caption = 
            'Select the root of the current database if the search string is ' +
            'changed'
          WordWrap = True
          OnClick = Label20Click
        end
        object Label52: TLabel
          Left = 24
          Top = 24
          Width = 69
          Height = 13
          Caption = 'Timer interval:'
        end
        object resettime: TSpinEdit
          Tag = 1
          Left = 144
          Top = 16
          Width = 41
          Height = 22
          AutoSize = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object enablereset: TCheckBox
          Tag = 1
          Left = 8
          Top = 66
          Width = 17
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object treeviceversa: TCheckBox
          Tag = 1
          Left = 8
          Top = 120
          Width = 17
          Height = 17
          TabOrder = 2
        end
      end
      object GroupBox28: TGroupBox
        Left = 8
        Top = 128
        Width = 249
        Height = 97
        Caption = 'Tagging '
        TabOrder = 2
        object Label27: TLabel
          Left = 26
          Top = 18
          Width = 192
          Height = 26
          Caption = 
            'Allow tagging / copying / moving files by dropping them on the t' +
            'ree'
          WordWrap = True
          OnClick = Label27Click
        end
        object TreeTagging: TCheckBox
          Tag = 1
          Left = 8
          Top = 24
          Width = 17
          Height = 17
          TabOrder = 0
          OnClick = TreeTaggingClick
        end
        object TreeTagShowConfirm: TCheckBox
          Tag = 1
          Left = 8
          Top = 72
          Width = 209
          Height = 17
          Caption = 'Show confirmation dialog'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object TreeTagAltPressed: TCheckBox
          Tag = 1
          Left = 8
          Top = 48
          Width = 233
          Height = 17
          Caption = 'Alt must be pressed'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
      object DblClkTree: TRadioGroup
        Tag = 1
        Left = 8
        Top = 64
        Width = 249
        Height = 57
        Caption = 'DblClkTree'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'toggle'
          'play'
          'enqueue')
        TabOrder = 3
      end
      object CompilationPlacement: TRadioGroup
        Tag = 1
        Left = 8
        Top = 232
        Width = 249
        Height = 73
        Caption = 'Placement of Compilation nodes '
        ItemIndex = 1
        Items.Strings = (
          'before'
          'merge with other nodes'
          'after')
        TabOrder = 4
      end
      object GroupBox37: TGroupBox
        Left = 264
        Top = 168
        Width = 249
        Height = 73
        Caption = 'Playlists '
        TabOrder = 5
        object RelativePaths: TCheckBox
          Tag = 1
          Left = 8
          Top = 24
          Width = 233
          Height = 17
          Caption = 'Relative playlist paths'
          TabOrder = 0
        end
      end
    end
    object TSwaPlaylist: TTabSheet
      Caption = 'Winamp playlist'
      ImageIndex = 17
      TabVisible = False
      object GroupBox15: TGroupBox
        Left = 8
        Top = 0
        Width = 265
        Height = 145
        Caption = 'Winamp playlist enty formatting '
        TabOrder = 0
        object Label57: TLabel
          Left = 8
          Top = 96
          Width = 249
          Height = 41
          AutoSize = False
          Caption = 'Use...'
          WordWrap = True
        end
        object Label58: TLabel
          Left = 8
          Top = 56
          Width = 89
          Height = 13
          Caption = '"Compilation" files:'
        end
        object WinPlayTitleFormatEdit: TEdit
          Tag = 1
          Left = 16
          Top = 24
          Width = 233
          Height = 21
          TabOrder = 0
          Text = '%artist% - %title%'
        end
        object WinPlayCompilationTitleFormatEdit: TEdit
          Tag = 1
          Left = 16
          Top = 72
          Width = 233
          Height = 21
          TabOrder = 1
          Text = '%album% - %artist% - %title%'
        end
        object WinPlayCompilationEnabled: TCheckBox
          Tag = 1
          Left = 160
          Top = 54
          Width = 97
          Height = 17
          Caption = 'enable'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = WinPlayCompilationEnabledClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 280
        Top = 120
        Width = 241
        Height = 81
        Caption = 'Continous play '
        TabOrder = 1
        object Label40: TLabel
          Left = 26
          Top = 16
          Width = 207
          Height = 57
          AutoSize = False
          Caption = 
            'Update playlist everytime the main list changes / filtered.'#13#10'Thi' +
            's might be slow on large playlists'
          WordWrap = True
          OnClick = Label40Click
        end
        object updateContPlayOnFilter: TCheckBox
          Tag = 1
          Left = 8
          Top = 16
          Width = 14
          Height = 17
          TabOrder = 0
        end
      end
      object ignoreDuplicatesSettings: TRadioGroup
        Tag = 1
        Left = 280
        Top = 0
        Width = 241
        Height = 65
        Caption = 'Ignore duplicates'
        ItemIndex = 0
        Items.Strings = (
          'Ignore new'
          'Replace current')
        TabOrder = 2
      end
      object GroupBox18: TGroupBox
        Left = 280
        Top = 72
        Width = 241
        Height = 41
        Caption = 'Focus playing song on change '
        TabOrder = 3
        object FollowPlayingWA: TCheckBox
          Tag = 1
          Left = 16
          Top = 16
          Width = 113
          Height = 17
          Caption = 'Enable'
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 152
        Width = 265
        Height = 177
        Caption = 'Control Winamp Playlist '
        TabOrder = 4
        object Label41: TLabel
          Left = 26
          Top = 16
          Width = 231
          Height = 153
          AutoSize = False
          Caption = 'text'
          WordWrap = True
          OnClick = Label41Click
        end
        object ControlPlaylist: TCheckBox
          Tag = 1
          Left = 8
          Top = 24
          Width = 16
          Height = 17
          TabOrder = 0
          OnClick = ControlPlaylistClick
        end
      end
      object GroupBox30: TGroupBox
        Left = 280
        Top = 208
        Width = 241
        Height = 121
        Caption = 'Show columns in Winamp playlist '
        TabOrder = 5
        object Label28: TLabel
          Left = 8
          Top = 40
          Width = 225
          Height = 73
          AutoSize = False
          Caption = 'txt'
          WordWrap = True
        end
        object WinplayShowColumns: TCheckBox
          Tag = 1
          Left = 8
          Top = 16
          Width = 225
          Height = 17
          Caption = 'Enable'
          TabOrder = 0
          OnClick = WinplayShowColumnsClick
        end
      end
    end
    object TSquickList: TTabSheet
      Caption = 'Quicklist'
      ImageIndex = 17
      TabVisible = False
      object QuicklistClick: TRadioGroup
        Tag = 2
        Left = 8
        Top = 104
        Width = 265
        Height = 89
        Caption = 'Doubleclick in Quicklist Songs '
        ItemIndex = 1
        Items.Strings = (
          'Add entire list and play selected'
          'Play selected song'
          'Enqueue selected song'
          'Punch in selected song')
        TabOrder = 0
      end
      object GroupBox13: TGroupBox
        Left = 8
        Top = 0
        Width = 265
        Height = 97
        Caption = 'Top list '
        TabOrder = 1
        object Label13: TLabel
          Left = 24
          Top = 48
          Width = 132
          Height = 13
          Caption = 'Numbers of songs in the list'
        end
        object toplist: TCheckBox
          Tag = 1
          Left = 16
          Top = 24
          Width = 177
          Height = 17
          Caption = 'IncludeTop List in Quicklist'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object topnr: TSpinEdit
          Tag = 1
          Left = 200
          Top = 44
          Width = 49
          Height = 22
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = []
          MaxValue = 100
          MinValue = 5
          ParentFont = False
          TabOrder = 1
          Value = 40
        end
        object topcountshow: TCheckBox
          Tag = 1
          Left = 112
          Top = 72
          Width = 121
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Show Play Count'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
    end
    object TSskin: TTabSheet
      Caption = 'Skin'
      ImageIndex = 17
      TabVisible = False
      OnShow = TSskinShow
      object GroupBox23: TGroupBox
        Left = 0
        Top = 0
        Width = 521
        Height = 249
        Caption = 'Select skin '
        TabOrder = 0
        object SkinAuthorLabel: TLabel
          Left = 208
          Top = 56
          Width = 33
          Height = 13
          Caption = 'Author'
        end
        object SkinCorrespondingWinampLabel: TLabel
          Left = 208
          Top = 96
          Width = 305
          Height = 33
          AutoSize = False
          Caption = 'Corresponds to'
          WordWrap = True
        end
        object SkinCommentsLabelValue: TLabel
          Left = 224
          Top = 168
          Width = 281
          Height = 73
          AutoSize = False
          Caption = 'SkinCommentsLabelValue'
          WordWrap = True
        end
        object GetMoreSkinsLabel: TFPUrlLabel
          Left = 312
          Top = 16
          Width = 199
          Height = 13
          Cursor = crHandPoint
          URLColStd = clNavy
          Effect98 = True
          Caption = 'Get more skins here'
          URL = 'www.mexp.dk/skins'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          AutoSize = False
          Alignment = taRightJustify
          ParentFont = False
        end
        object skinAuthorLink: TFPUrlLabel
          Left = 248
          Top = 72
          Width = 47
          Height = 13
          Cursor = crHandPoint
          URLColStd = clNavy
          Effect98 = True
          Caption = 'authorlink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object SkinWinampLink: TFPUrlLabel
          Left = 248
          Top = 128
          Width = 69
          Height = 13
          Cursor = crHandPoint
          URLColStd = clNavy
          Effect98 = True
          Caption = 'winampskinlink'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
        end
        object lblSkinComment: TLabel
          Left = 208
          Top = 152
          Width = 74
          Height = 13
          Caption = 'lblSkinComment'
        end
        object SkinBox: TListBox
          Left = 16
          Top = 16
          Width = 177
          Height = 225
          ItemHeight = 13
          TabOrder = 0
          OnClick = SkinBoxClick
        end
        object EditSkinBtn: TButton
          Left = 206
          Top = 16
          Width = 75
          Height = 25
          Caption = 'Edit skin'
          TabOrder = 1
          Visible = False
          OnClick = EditSkinBtnClick
        end
      end
      object GroupBox24: TGroupBox
        Left = 0
        Top = 256
        Width = 521
        Height = 57
        Caption = 'Settings '
        TabOrder = 1
        object AutoChangeSkin: TCheckBox
          Tag = 1
          Left = 16
          Top = 16
          Width = 137
          Height = 17
          Caption = 'Auto change Skin'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object AllowColorOverride: TCheckBox
          Tag = 1
          Left = 16
          Top = 32
          Width = 137
          Height = 17
          Caption = 'Allow color override'
          TabOrder = 1
          OnClick = AllowColorOverrideClick
        end
      end
      object GroupBox29: TGroupBox
        Left = 0
        Top = 320
        Width = 521
        Height = 41
        Caption = 'Background image '
        TabOrder = 2
        object txtBackgroundImageFilename: TEdit
          Tag = 1
          Left = 16
          Top = 16
          Width = 457
          Height = 21
          TabOrder = 0
        end
        object btnBrowseBackgroundFile: TButton
          Left = 480
          Top = 16
          Width = 35
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = btnBrowseBackgroundFileClick
        end
      end
    end
    object TSpartyMode: TTabSheet
      Caption = 'TSpartyMode'
      ImageIndex = 17
      TabVisible = False
      object GroupBox25: TGroupBox
        Left = 0
        Top = 296
        Width = 521
        Height = 41
        Caption = 'Lock Windows '
        TabOrder = 0
        object LockAltTab: TCheckBox
          Tag = 1
          Left = 16
          Top = 16
          Width = 153
          Height = 17
          Caption = 'Alt+Tab / Alt+Escape'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object LockCtrlAltDel: TCheckBox
          Tag = 1
          Left = 168
          Top = 16
          Width = 113
          Height = 17
          Caption = 'Ctrl+Alt+Del'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
      object GroupBox26: TGroupBox
        Left = 0
        Top = 0
        Width = 521
        Height = 289
        Caption = 'Party mode options '
        TabOrder = 1
        object Label61: TLabel
          Left = 355
          Top = 164
          Width = 29
          Height = 13
          Caption = 'tracks'
        end
        object DisableTagging: TCheckBox
          Tag = 1
          Left = 16
          Top = 48
          Width = 250
          Height = 17
          Caption = 'Disable tagging'
          TabOrder = 0
        end
        object DisableDeleteFromHD: TCheckBox
          Tag = 1
          Left = 16
          Top = 72
          Width = 250
          Height = 17
          Caption = 'Disable delete from HD'
          TabOrder = 1
        end
        object DisableOrganizeDuplicateFiles: TCheckBox
          Tag = 1
          Left = 16
          Top = 96
          Width = 250
          Height = 17
          Caption = 'Disable organize/find duplicate files'
          TabOrder = 2
        end
        object DisableEditQuicklist: TCheckBox
          Tag = 1
          Left = 16
          Top = 120
          Width = 250
          Height = 17
          Caption = 'Disable edit quicklist'
          TabOrder = 3
        end
        object DisableEditPlaylist: TCheckBox
          Tag = 1
          Left = 16
          Top = 144
          Width = 250
          Height = 17
          Caption = 'Disable edit playlists (tree)'
          TabOrder = 4
        end
        object DisableDeleteMoveWinampPlaylist: TCheckBox
          Tag = 1
          Left = 16
          Top = 168
          Width = 250
          Height = 17
          Caption = 'Disable delete/move in Winamp Playlist'
          TabOrder = 5
        end
        object DisableDBmanagement: TCheckBox
          Tag = 1
          Left = 16
          Top = 24
          Width = 250
          Height = 17
          Caption = 'Disable database management'
          TabOrder = 6
        end
        object AlwaysEnqueueToWP: TCheckBox
          Tag = 1
          Left = 16
          Top = 192
          Width = 250
          Height = 17
          Caption = 'Always enqueue files to Winamp Playlist'
          TabOrder = 7
        end
        object AlwaysEnableKill: TCheckBox
          Tag = 1
          Left = 272
          Top = 24
          Width = 246
          Height = 17
          Caption = 'Always enable "kill after play"'
          TabOrder = 8
        end
        object partyDisableRemote: TCheckBox
          Tag = 1
          Left = 272
          Top = 48
          Width = 246
          Height = 17
          Caption = 'Disable "Remote"'
          TabOrder = 9
        end
        object PartyDisableVolumeControl: TCheckBox
          Tag = 1
          Left = 272
          Top = 72
          Width = 246
          Height = 17
          Caption = 'Disable volume control'
          TabOrder = 10
        end
        object PartyDisablePlaybackControls: TCheckBox
          Tag = 1
          Left = 272
          Top = 96
          Width = 246
          Height = 17
          Caption = 'Disable playback controls'
          TabOrder = 11
        end
        object PartyAllKeySearches: TCheckBox
          Tag = 1
          Left = 272
          Top = 120
          Width = 246
          Height = 17
          Caption = 'Everywhere, all typing is send to filter'
          TabOrder = 12
        end
        object PartyLockColumns: TCheckBox
          Tag = 1
          Left = 16
          Top = 216
          Width = 250
          Height = 17
          Caption = 'Lock columns'
          TabOrder = 13
        end
        object PartyLimitMouse: TCheckBox
          Tag = 1
          Left = 16
          Top = 240
          Width = 249
          Height = 17
          Caption = 'PartyLimitMouse'
          TabOrder = 14
        end
        object KeepPlaylistAtMaximum: TCheckBox
          Tag = 1
          Left = 272
          Top = 144
          Width = 241
          Height = 17
          Caption = 'Keep Winamp playlist at maximum'
          TabOrder = 15
        end
        object KeepPlaylistAtNumber: TSpinEdit
          Tag = 1
          Left = 293
          Top = 161
          Width = 52
          Height = 22
          MaxValue = 2147483647
          MinValue = 1
          TabOrder = 16
          Value = 20
        end
      end
    end
    object TSshowCover: TTabSheet
      ImageIndex = 18
      TabVisible = False
      OnShow = TSshowCoverShow
      object GroupBox32: TGroupBox
        Left = 0
        Top = 0
        Width = 521
        Height = 137
        Caption = 'GroupBox32'
        TabOrder = 0
        object ShowCover: TCheckBox
          Tag = 1
          Left = 16
          Top = 24
          Width = 489
          Height = 17
          Caption = 'ShowCover'
          TabOrder = 0
          OnClick = ShowCoverClick
        end
        object CoverShowHideMB: TCheckBox
          Tag = 1
          Left = 16
          Top = 48
          Width = 497
          Height = 17
          Caption = 'CoverShowHideMB'
          Checked = True
          Enabled = False
          State = cbChecked
          TabOrder = 1
        end
      end
    end
    object TSfileTypes: TTabSheet
      ImageIndex = 19
      TabVisible = False
      object Label59: TLabel
        Left = 8
        Top = 0
        Width = 142
        Height = 13
        Caption = 'File types supported by MEXP'
      end
      object FileTypeList: TListBox
        Left = 0
        Top = 16
        Width = 185
        Height = 297
        ItemHeight = 13
        TabOrder = 0
        OnClick = FileTypeListClick
      end
      object FTDeleteSelectedBtn: TButton
        Left = 96
        Top = 320
        Width = 89
        Height = 25
        Caption = 'Delete selected'
        Enabled = False
        TabOrder = 1
        OnClick = FTDeleteSelectedBtnClick
      end
      object FTSaveAsNewBtn: TButton
        Left = 0
        Top = 320
        Width = 89
        Height = 25
        Caption = 'New'
        TabOrder = 2
        OnClick = FTSaveAsNewBtnClick
      end
      object GroupBoxSelectedFiletype: TGroupBox
        Left = 192
        Top = 12
        Width = 329
        Height = 333
        Caption = 'Selected file type '
        TabOrder = 3
        Visible = False
        object Label29: TLabel
          Left = 16
          Top = 28
          Width = 52
          Height = 13
          Caption = 'Long name'
        end
        object Label30: TLabel
          Left = 16
          Top = 60
          Width = 55
          Height = 13
          Caption = 'Short name'
        end
        object Label31: TLabel
          Left = 16
          Top = 92
          Width = 71
          Height = 13
          Caption = 'File extensions'
        end
        object Label60: TLabel
          Left = 16
          Top = 120
          Width = 64
          Height = 13
          Caption = 'Content type'
        end
        object LongNameEdit: TEdit
          Left = 128
          Top = 24
          Width = 193
          Height = 21
          TabOrder = 0
          OnChange = LongNameEditChange
        end
        object ShortNameEdit: TEdit
          Left = 128
          Top = 56
          Width = 193
          Height = 21
          TabOrder = 1
          OnChange = LongNameEditChange
        end
        object FileExtEdit: TEdit
          Left = 128
          Top = 88
          Width = 193
          Height = 21
          TabOrder = 2
          OnChange = LongNameEditChange
        end
        object FTAudioCB: TCheckBox
          Left = 128
          Top = 120
          Width = 89
          Height = 17
          Caption = 'Audio'
          TabOrder = 3
          OnClick = LongNameEditChange
        end
        object FTVideoCB: TCheckBox
          Left = 224
          Top = 120
          Width = 89
          Height = 17
          Caption = 'Video'
          TabOrder = 4
          OnClick = LongNameEditChange
        end
        object SupportsId3v2: TCheckBox
          Left = 128
          Top = 168
          Width = 185
          Height = 17
          Caption = 'Supports Id3v2'
          TabOrder = 5
          OnClick = LongNameEditChange
        end
        object SupportsId3v1: TCheckBox
          Left = 128
          Top = 152
          Width = 185
          Height = 17
          Caption = 'Supports ID3v1'
          TabOrder = 6
          OnClick = LongNameEditChange
        end
        object SupportsApeV1: TCheckBox
          Left = 128
          Top = 192
          Width = 185
          Height = 17
          Caption = 'Supports Ape v.1 tags'
          TabOrder = 7
          OnClick = LongNameEditChange
        end
        object SupportsApeV2: TCheckBox
          Left = 128
          Top = 208
          Width = 177
          Height = 17
          Caption = 'Supports Ape v.2 tags'
          TabOrder = 8
          OnClick = LongNameEditChange
        end
      end
    end
    object TStreeViewModes: TTabSheet
      ImageIndex = 20
      TabVisible = False
      OnShow = TStreeViewModesShow
      object ViewModesLabel: TLabel
        Left = 8
        Top = 0
        Width = 4
        Height = 13
        Caption = '-'
      end
      object TreeStructureLabel: TLabel
        Left = 208
        Top = 0
        Width = 4
        Height = 13
        Caption = '-'
      end
      object TreeStructureTree: TVirtualStringTree
        Left = 200
        Top = 16
        Width = 313
        Height = 153
        ButtonFillMode = fmShaded
        Colors.TreeLineButtonColor = clBlack
        DragMode = dmAutomatic
        DragOperations = [doMove]
        DragType = dtVCL
        Header.AutoSizeIndex = 0
        Header.DefaultHeight = 17
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.MainColumn = -1
        Header.Options = [hoColumnResize, hoDrag]
        TabOrder = 0
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnChange = TreeStructureTreeChange
        OnDragOver = TreeStructureTreeDragOver
        OnDragDrop = TreeStructureTreeDragDrop
        OnGetText = TreeStructureTreeGetText
        OnMouseDown = TreeStructureTreeMouseDown
        Columns = <>
      end
      object TreeStructureList: TVirtualStringTree
        Left = 0
        Top = 16
        Width = 185
        Height = 257
        Colors.TreeLineButtonColor = clBlack
        DragMode = dmAutomatic
        DragOperations = [doMove]
        DragType = dtVCL
        Header.AutoSizeIndex = 0
        Header.DefaultHeight = 17
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.MainColumn = -1
        Header.Options = [hoColumnResize, hoDrag]
        TabOrder = 1
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnChange = TreeStructureListChange
        OnDragOver = TreeStructureListDragOver
        OnDragDrop = TreeStructureListDragDrop
        OnEditing = TreeStructureListEditing
        OnFreeNode = TreeStructureListFreeNode
        OnGetText = TreeStructureListGetText
        OnNewText = TreeStructureListNewText
        Columns = <>
      end
      object DeleteTreeStructureBtn: TButton
        Left = 96
        Top = 280
        Width = 89
        Height = 25
        Caption = 'Delete'
        Enabled = False
        TabOrder = 2
        OnClick = DeleteTreeStructureBtnClick
      end
      object NewTreeStructureBtn: TButton
        Left = 0
        Top = 280
        Width = 89
        Height = 25
        Caption = 'New'
        TabOrder = 3
        OnClick = NewTreeStructureBtnClick
      end
      object NewTreeStructureNodeBtn: TButton
        Left = 200
        Top = 176
        Width = 129
        Height = 25
        Caption = 'NewTreeStructureNodeBtn'
        Enabled = False
        TabOrder = 4
        OnClick = NewTreeStructureNodeBtnClick
      end
      object DeleteTreeStructureNodeBtn: TButton
        Left = 336
        Top = 176
        Width = 129
        Height = 25
        Caption = 'DeleteTreeStructureNodeBtn'
        Enabled = False
        TabOrder = 5
        OnClick = DeleteTreeStructureNodeBtnClick
      end
      object RevertSelectedTreeStructureBtn: TButton
        Left = 0
        Top = 312
        Width = 89
        Height = 25
        Caption = 'RevertSelectedTreeStructureBtn'
        Enabled = False
        TabOrder = 6
        OnClick = RevertSelectedTreeStructureBtnClick
      end
      object RevertAllTreeStructuresBtn: TButton
        Left = 96
        Top = 312
        Width = 89
        Height = 25
        Caption = 'RevertAllTreeStructuresBtn'
        TabOrder = 7
        OnClick = RevertAllTreeStructuresBtnClick
      end
      object IndividualSO: TCheckBox
        Tag = 1
        Left = 0
        Top = 344
        Width = 409
        Height = 17
        Caption = 'Databases can have different view modes'
        TabOrder = 8
      end
      object GroupBoxSelectedTreeViewNode: TGroupBox
        Left = 200
        Top = 208
        Width = 313
        Height = 129
        Caption = 'Selected node '
        TabOrder = 9
        Visible = False
        object Label6: TLabel
          Left = 10
          Top = 104
          Width = 196
          Height = 13
          Caption = 'Minimum number of tracks to show node:'
          Layout = tlCenter
          WordWrap = True
        end
        object Label32: TLabel
          Left = 11
          Top = 24
          Width = 94
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tree node contents'
        end
        object Label42: TLabel
          Left = 11
          Top = 74
          Width = 43
          Height = 13
          Caption = 'Order by'
        end
        object seTreeMinCount: TSpinEdit
          Left = 264
          Top = 99
          Width = 41
          Height = 22
          MaxValue = 5000
          MinValue = 1
          TabOrder = 0
          Value = 1
          OnChange = seTreeMinCountChange
        end
        object TreeStructureNodeContent: TComboBox
          Left = 136
          Top = 20
          Width = 169
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnChange = TreeStructureNodeContentChange
        end
        object TreeStructureNodeIncludeCompilationsCB: TCheckBox
          Left = 9
          Top = 48
          Width = 296
          Height = 17
          Alignment = taLeftJustify
          Caption = 'TreeStructureNodeIncludeCompilationsCB'
          TabOrder = 2
          OnClick = TreeStructureNodeIncludeCompilationsCBClick
        end
        object cbTreeSort: TComboBox
          Left = 136
          Top = 72
          Width = 169
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 3
          OnChange = cbTreeSortChange
        end
      end
    end
    object TSfields: TTabSheet
      ImageIndex = 21
      TabVisible = False
      OnShow = TSfieldsShow
      object Label56: TLabel
        Left = 8
        Top = 0
        Width = 112
        Height = 13
        Caption = 'Custom database fields'
      end
      object AddFieldButton: TButton
        Left = 0
        Top = 320
        Width = 89
        Height = 25
        Caption = 'Add'
        TabOrder = 0
        OnClick = AddFieldButtonClick
      end
      object RemoveFieldButton: TButton
        Left = 96
        Top = 320
        Width = 89
        Height = 25
        Caption = 'Remove'
        Enabled = False
        TabOrder = 1
        OnClick = RemoveFieldButtonClick
      end
      object SelectedFieldGroupBox: TGroupBox
        Left = 192
        Top = 12
        Width = 321
        Height = 333
        Caption = 'Selected field '
        TabOrder = 2
        Visible = False
        object Name: TLabel
          Left = 16
          Top = 24
          Width = 27
          Height = 13
          Caption = 'Name'
        end
        object Label39: TLabel
          Left = 16
          Top = 56
          Width = 21
          Height = 13
          Caption = 'Icon'
        end
        object FieldName: TEdit
          Left = 128
          Top = 24
          Width = 177
          Height = 21
          TabOrder = 0
        end
        object FieldIcon: TComboBox
          Left = 256
          Top = 56
          Width = 49
          Height = 22
          Style = csOwnerDrawFixed
          ItemHeight = 16
          TabOrder = 1
          OnDrawItem = FieldIconDrawItem
        end
        object PageControl1: TPageControl
          Left = 8
          Top = 80
          Width = 305
          Height = 249
          ActivePage = TabSheet1
          TabOrder = 2
          object TabSheet1: TTabSheet
            BorderWidth = 4
            Caption = 'Id3v2'
            object FPUrlLabel11: TFPUrlLabel
              Left = 0
              Top = 0
              Width = 289
              Height = 13
              Cursor = crHandPoint
              URLColStd = clSilver
              Effect98 = True
              Caption = 'Read more about available Id3v2-frames by clicking here'
              URL = 'www.id3.org/id3v2.4.0-frames.txt'
              Align = alTop
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsUnderline]
              ParentFont = False
            end
            object rbtId3v2FieldType: TRadioGroup
              Left = 0
              Top = 18
              Width = 289
              Height = 89
              Caption = 'Frame type '
              Items.Strings = (
                'No Id3v2 tag'
                'Comment frame (COMM)'
                'User defined text information frame (TXXX)'
                'Other text frame (T***)')
              TabOrder = 0
              OnClick = rbtId3v2FieldTypeClick
            end
            object Panel3: TPanel
              Left = 0
              Top = 112
              Width = 289
              Height = 105
              BevelOuter = bvNone
              TabOrder = 1
              object pnlId3v2FieldDefaultLanguage: TPanel
                Left = 0
                Top = 56
                Width = 289
                Height = 49
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object Label68: TLabel
                  Left = 0
                  Top = 8
                  Width = 112
                  Height = 13
                  Caption = 'Default language in tag'
                end
                object cbId3v2FieldLanguage: TComboBox
                  Left = 136
                  Top = 4
                  Width = 153
                  Height = 21
                  Style = csDropDownList
                  ItemHeight = 0
                  TabOrder = 0
                end
                object chkFieldId3v2ReadFromAllLanguages: TCheckBox
                  Left = 0
                  Top = 28
                  Width = 273
                  Height = 17
                  Alignment = taLeftJustify
                  Caption = 'Read from all languages and write to the default'
                  TabOrder = 1
                end
              end
              object pnlId3v2FieldDescription: TPanel
                Left = 0
                Top = 28
                Width = 289
                Height = 28
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 2
                object Label69: TLabel
                  Left = 0
                  Top = 8
                  Width = 83
                  Height = 13
                  Caption = 'Description in tag'
                end
                object FieldId3v2Description: TEdit
                  Left = 136
                  Top = 4
                  Width = 153
                  Height = 21
                  TabOrder = 0
                end
              end
              object pnlId3v2FieldFrameName: TPanel
                Left = 0
                Top = 0
                Width = 289
                Height = 28
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                object Label33: TLabel
                  Left = 0
                  Top = 8
                  Width = 59
                  Height = 13
                  Caption = 'Frame name'
                end
                object FieldId3v2Name: TEdit
                  Left = 136
                  Top = 4
                  Width = 153
                  Height = 21
                  TabOrder = 0
                end
              end
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'Ogg'
            ImageIndex = 1
            object Label34: TLabel
              Left = 8
              Top = 24
              Width = 59
              Height = 13
              Caption = 'Frame name'
            end
            object FieldOggName: TEdit
              Left = 128
              Top = 20
              Width = 161
              Height = 21
              TabOrder = 0
            end
          end
          object TabSheet3: TTabSheet
            Caption = 'Ape'
            ImageIndex = 2
            object Label35: TLabel
              Left = 8
              Top = 24
              Width = 59
              Height = 13
              Caption = 'Frame name'
            end
            object FieldApeName: TEdit
              Left = 128
              Top = 20
              Width = 161
              Height = 21
              TabOrder = 0
            end
          end
          object TabSheet4: TTabSheet
            Caption = 'WMA'
            ImageIndex = 3
            object Label37: TLabel
              Left = 8
              Top = 24
              Width = 59
              Height = 13
              Caption = 'Frame name'
            end
            object FieldWmaName: TEdit
              Left = 128
              Top = 20
              Width = 161
              Height = 21
              TabOrder = 0
            end
          end
        end
      end
      object FieldTree: TVirtualStringTree
        Left = 0
        Top = 16
        Width = 185
        Height = 297
        Colors.TreeLineButtonColor = clBlack
        Header.AutoSizeIndex = 0
        Header.DefaultHeight = 17
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.MainColumn = -1
        Header.Options = [hoColumnResize, hoDrag]
        TabOrder = 3
        TextMargin = 0
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnFocusChanging = FieldTreeFocusChanging
        OnGetText = FieldTreeGetText
        Columns = <>
      end
    end
    object TStreeCovers: TTabSheet
      ImageIndex = 22
      TabVisible = False
      object GroupBox38: TGroupBox
        Left = 0
        Top = 0
        Width = 513
        Height = 241
        Caption = 'Cover thumbnails '
        TabOrder = 0
        object Label62: TLabel
          Left = 40
          Top = 64
          Width = 73
          Height = 13
          Caption = 'Maximum width'
        end
        object Label63: TLabel
          Left = 40
          Top = 88
          Width = 77
          Height = 13
          Caption = 'Maximum height'
        end
        object Label64: TLabel
          Left = 181
          Top = 64
          Width = 12
          Height = 13
          Caption = 'px'
        end
        object Label65: TLabel
          Left = 181
          Top = 88
          Width = 12
          Height = 13
          Caption = 'px'
        end
        object Label66: TLabel
          Left = 40
          Top = 128
          Width = 32
          Height = 13
          Caption = 'Border'
        end
        object Label67: TLabel
          Left = 181
          Top = 124
          Width = 12
          Height = 13
          Caption = 'px'
        end
        object treeCoverWidth: TSpinEdit
          Tag = 1
          Left = 128
          Top = 64
          Width = 49
          Height = 22
          Increment = 10
          MaxValue = 800
          MinValue = 10
          TabOrder = 0
          Value = 100
        end
        object treeCoverHeight: TSpinEdit
          Tag = 1
          Left = 128
          Top = 88
          Width = 49
          Height = 22
          Increment = 10
          MaxValue = 800
          MinValue = 10
          TabOrder = 1
          Value = 100
        end
        object treeCoverBorder: TSpinEdit
          Tag = 1
          Left = 128
          Top = 120
          Width = 49
          Height = 22
          MaxValue = 100
          MinValue = 0
          TabOrder = 2
          Value = 2
        end
        object cbTreeCoverIncludeAlbumName: TCheckBox
          Tag = 1
          Left = 40
          Top = 160
          Width = 137
          Height = 17
          Caption = 'Include album name'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object chkLoadThumbsInBackground: TCheckBox
          Tag = 1
          Left = 40
          Top = 184
          Width = 465
          Height = 17
          Caption = 'Load thumbnails in background (recommended for slow computers)'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object cbShowCoverInTree: TCheckBox
          Tag = 2
          Left = 16
          Top = 24
          Width = 281
          Height = 17
          Caption = 'Show covers in the Tree'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
      end
    end
  end
  object scanpopup: TPopupMenu
    Left = 24
    Top = 232
    object Scan1: TMenuItem
      Caption = 'Scan'
      OnClick = Scan1Click
    end
    object Scannewremovedeadfiles1: TMenuItem
      Caption = 'Update'
      OnClick = Scannewremovedeadfiles1Click
    end
  end
  object IdHttp: TIdHTTP
    MaxLineAction = maSplit
    ReadTimeout = 5000
    AllowCookies = False
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0'
    HTTPOptions = [hoForceEncodeParams]
    Left = 56
    Top = 128
  end
  object UserFileFind: TJvSearchFiles
    DirOption = doExcludeSubDirs
    Options = [soSearchDirs]
    DirParams.FileMasks.Strings = (
      '*')
    FileParams.FileMasks.Strings = (
      '*.*')
    Left = 72
    Top = 264
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'JPEG Image File|*.jpg;*.jpeg'
    Left = 45
    Top = 302
  end
end
