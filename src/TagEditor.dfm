object Editor: TEditor
  Left = 978
  Top = 336
  Width = 637
  Height = 610
  BorderIcons = [biMinimize]
  Caption = 'Tag editor'
  Color = clBtnFace
  Constraints.MinHeight = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 561
    Width = 629
    Height = 22
    Align = alBottom
    TabOrder = 0
    object SaveBtn: TButton
      Left = 0
      Top = 0
      Width = 89
      Height = 22
      Caption = 'Save'
      TabOrder = 0
      OnClick = SaveBtnClick
    end
    object CancelBtn: TButton
      Left = 88
      Top = 0
      Width = 105
      Height = 22
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 1
      OnClick = CancelBtnClick
    end
    object cleanNewStrings: TCheckBox
      Left = 416
      Top = 2
      Width = 201
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Autoformat new text'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object pbar: TProgressBar
    Left = 0
    Top = 553
    Width = 629
    Height = 8
    Align = alBottom
    Smooth = True
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 474
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 2
    object Bevel4: TBevel
      Left = 456
      Top = 9
      Width = 169
      Height = 193
      Shape = bsFrame
    end
    object LyricsBox: TGroupBox
      Left = 456
      Top = 208
      Width = 169
      Height = 265
      Caption = 'Lyrics '
      TabOrder = 0
      Visible = False
      object Bevel7: TBevel
        Left = 8
        Top = 214
        Width = 145
        Height = 9
        Shape = bsBottomLine
      end
      object netStatus: TLabel
        Left = 2
        Top = 246
        Width = 165
        Height = 17
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
      end
      object LyricsList: TVirtualStringTree
        Left = 2
        Top = 16
        Width = 164
        Height = 201
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        BorderWidth = 1
        Color = clBtnFace
        Colors.UnfocusedSelectionColor = clSilver
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
        TabOrder = 0
        TreeOptions.PaintOptions = [toShowDropmark, toThemeAware, toUseBlendedImages]
        OnCompareNodes = LyricsListCompareNodes
        OnDblClick = LyricsListDblClick
        OnFreeNode = LyricsListFreeNode
        OnGetText = LyricsListGetText
        Columns = <>
      end
      object GetFromInternet: TCheckBox
        Left = 16
        Top = 230
        Width = 137
        Height = 17
        Caption = 'Get from internet'
        TabOrder = 1
        OnClick = GetFromInternetClick
      end
    end
    object GroupsBox: TGroupBox
      Left = 456
      Top = 208
      Width = 169
      Height = 265
      Caption = 'Groups '
      Constraints.MaxWidth = 169
      Constraints.MinWidth = 169
      TabOrder = 1
      object Bevel5: TBevel
        Left = 8
        Top = 212
        Width = 145
        Height = 9
        Shape = bsBottomLine
      end
      object GroupCheck: TVirtualStringTree
        Tag = 10
        Left = 8
        Top = 24
        Width = 153
        Height = 193
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        CheckImageKind = ckXP
        Color = clBtnFace
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
        TabOrder = 1
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick]
        TreeOptions.PaintOptions = [toUseBlendedImages]
        OnGetText = GroupCheckGetText
        Columns = <>
      end
      object SaveGroups: TCheckBox
        Tag = 10
        Left = 16
        Top = 244
        Width = 137
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Save groups in tag'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 0
        OnClick = SaveGroupsClick
      end
      object CBcompilation: TCheckBox
        Tag = 10
        Left = 56
        Top = 224
        Width = 97
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Compilation'
        TabOrder = 2
        OnClick = SaveGroupsClick
      end
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 449
      Height = 474
      ActivePage = TabValues
      Images = ImageList1
      MultiLine = True
      TabOrder = 2
      OnChange = PageControl1Change
      object TabValues: TTabSheet
        Caption = 'Database'
        ImageIndex = 1
        object Label9: TLabel
          Left = 56
          Top = 172
          Width = 34
          Height = 13
          Caption = 'Genre'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label27: TLabel
          Left = 1
          Top = 10
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Track #'
          FocusControl = Track
        end
        object Label28: TLabel
          Left = 1
          Top = 36
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Artist'
          FocusControl = Artist
        end
        object Label29: TLabel
          Left = 1
          Top = 62
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'T&itle'
          FocusControl = Title
        end
        object Label30: TLabel
          Left = 1
          Top = 88
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'A&lbum'
          FocusControl = Album
        end
        object Label31: TLabel
          Left = 312
          Top = 114
          Width = 45
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Year'
          FocusControl = year
        end
        object Label32: TLabel
          Left = 1
          Top = 140
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Comment'
          FocusControl = comment
        end
        object Label67: TLabel
          Left = 184
          Top = 10
          Width = 56
          Height = 13
          Caption = 'T&otal tracks'
          FocusControl = TotalTracks
        end
        object Label70: TLabel
          Left = 1
          Top = 114
          Width = 104
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Part of set'
          FocusControl = PartOfSet
        end
        object Label72: TLabel
          Left = 184
          Top = 114
          Width = 61
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'of totally'
        end
        object Label74: TLabel
          Left = 16
          Top = 236
          Width = 89
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Custom fields'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label71: TLabel
          Left = 1
          Top = 348
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Artist &sort order'
          FocusControl = ArtistSortOrder
        end
        object Track: TEdit
          Tag = 10
          Left = 112
          Top = 6
          Width = 48
          Height = 21
          MaxLength = 3
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = TRCKChange
        end
        object Artist: TJvComboBox
          Tag = 10
          Left = 112
          Top = 32
          Width = 300
          Height = 21
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          Sorted = True
          TabOrder = 1
          OnChange = ArtistChange
          OnDropDown = ArtistDropDown
          OnExit = ArtistExit
        end
        object Title: TJvComboBox
          Tag = 10
          Left = 112
          Top = 58
          Width = 300
          Height = 21
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          Sorted = True
          TabOrder = 2
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object Album: TJvComboBox
          Tag = 10
          Left = 112
          Top = 84
          Width = 300
          Height = 21
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          Sorted = True
          TabOrder = 3
          OnChange = ArtistChange
          OnDropDown = AlbumDropDown
          OnExit = ArtistExit
        end
        object genreCover: TCheckBox
          Tag = 10
          Left = 48
          Top = 186
          Width = 57
          Height = 23
          Alignment = taLeftJustify
          Caption = 'Cover'
          TabOrder = 4
          OnKeyPress = genreCoverKeyPress
          OnMouseUp = genreCoverMouseUp
        end
        object genreRemix: TCheckBox
          Tag = 10
          Left = 48
          Top = 202
          Width = 57
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Remix'
          TabOrder = 5
          OnKeyPress = genreCoverKeyPress
          OnMouseUp = genreCoverMouseUp
        end
        object Genre: TVirtualStringTree
          Tag = 10
          Left = 112
          Top = 168
          Width = 233
          Height = 57
          Color = clWhite
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
          TabOrder = 6
          TreeOptions.MiscOptions = [toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick]
          TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowHorzGridLines, toShowTreeLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toDisableDrawSelection, toFullRowSelect]
          OnCreateEditor = TCONCreateEditor
          OnEdited = GenreEdited
          OnEditing = TIPLEditing
          OnExit = COMMExit
          OnFocusChanged = TMCLFocusChanged
          OnFreeNode = GenreFreeNode
          OnGetText = TCONGetText
          Columns = <>
        end
        object AddGenre: TButton
          Left = 344
          Top = 168
          Width = 70
          Height = 28
          Caption = 'Add'
          TabOrder = 7
          OnClick = AddGenreClick
        end
        object DelGenre: TButton
          Left = 344
          Top = 196
          Width = 70
          Height = 28
          Caption = 'Del'
          TabOrder = 8
          OnClick = DelGenreClick
        end
        object year: TEdit
          Tag = 10
          Left = 368
          Top = 110
          Width = 41
          Height = 21
          MaxLength = 4
          TabOrder = 9
          OnChange = TRCKChange
        end
        object comment: TEdit
          Tag = 10
          Left = 112
          Top = 136
          Width = 300
          Height = 21
          TabOrder = 10
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object GroupBox2: TGroupBox
          Left = 0
          Top = 368
          Width = 441
          Height = 58
          Align = alBottom
          Caption = 'Copy from '
          TabOrder = 11
          object CFROM1010: TRadioButton
            Left = 8
            Top = 16
            Width = 65
            Height = 17
            Caption = 'None'
            TabOrder = 0
            OnClick = CFROM_Click
          end
          object CFROM1011: TRadioButton
            Left = 72
            Top = 16
            Width = 57
            Height = 17
            Caption = 'Id3v1'
            TabOrder = 1
            OnClick = CFROM_Click
          end
          object CFROM1012: TRadioButton
            Left = 144
            Top = 16
            Width = 65
            Height = 17
            Caption = 'Id3v2'
            TabOrder = 2
            OnClick = CFROM_Click
          end
          object CFROM1013: TRadioButton
            Left = 216
            Top = 16
            Width = 57
            Height = 17
            Caption = 'Ape'
            TabOrder = 3
            OnClick = CFROM_Click
          end
          object CFROM1014: TRadioButton
            Left = 288
            Top = 16
            Width = 57
            Height = 17
            Caption = 'WMA'
            TabOrder = 4
            OnClick = CFROM_Click
          end
          object CFROM1015: TRadioButton
            Left = 368
            Top = 16
            Width = 49
            Height = 17
            Caption = 'Ogg'
            TabOrder = 5
            OnClick = CFROM_Click
          end
          object SyncTabs: TCheckBox
            Left = 8
            Top = 36
            Width = 425
            Height = 17
            Caption = 'Update file tags when editing database values'
            Checked = True
            ParentShowHint = False
            ShowHint = True
            State = cbChecked
            TabOrder = 6
          end
        end
        object TotalTracks: TEdit
          Tag = 10
          Left = 248
          Top = 6
          Width = 43
          Height = 21
          TabOrder = 12
          OnChange = TRCKChange
        end
        object PartOfSet: TEdit
          Tag = 10
          Left = 112
          Top = 110
          Width = 41
          Height = 21
          MaxLength = 4
          TabOrder = 13
          OnChange = TRCKChange
        end
        object totalParts: TEdit
          Tag = 10
          Left = 248
          Top = 110
          Width = 41
          Height = 21
          MaxLength = 4
          TabOrder = 14
          OnChange = TRCKChange
        end
        object CustomFieldTree: TVirtualStringTree
          Tag = 10
          Left = 112
          Top = 232
          Width = 300
          Height = 108
          Colors.TreeLineButtonColor = clBlack
          Header.AutoSizeIndex = 1
          Header.DefaultHeight = 17
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoVisible]
          Header.Style = hsPlates
          TabOrder = 15
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toHideSelection, toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toExtendedFocus]
          OnBeforeCellPaint = CustomFieldTreeBeforeCellPaint
          OnEditing = CustomFieldTreeEditing
          OnFocusChanged = CustomFieldTreeFocusChanged
          OnFocusChanging = CustomFieldTreeFocusChanging
          OnGetText = CustomFieldTreeGetText
          OnInitNode = CustomFieldTreeInitNode
          OnNewText = CustomFieldTreeNewText
          Columns = <
            item
              Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
              Position = 0
              Width = 120
              WideText = 'Field'
            end
            item
              Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
              Position = 1
              Width = 176
              WideText = 'Value'
            end>
        end
        object ArtistSortOrder: TJvComboBox
          Tag = 10
          Left = 112
          Top = 344
          Width = 300
          Height = 21
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          Sorted = True
          TabOrder = 16
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
      end
      object TabId3v1: TTabSheet
        Caption = 'Id3v1'
        object Label18: TLabel
          Left = 1
          Top = 10
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Track #'
        end
        object Label17: TLabel
          Left = 1
          Top = 36
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Artist'
        end
        object Label16: TLabel
          Left = 1
          Top = 60
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Title'
        end
        object Label22: TLabel
          Left = 1
          Top = 88
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Album'
        end
        object Label19: TLabel
          Left = 1
          Top = 114
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Year'
        end
        object Label20: TLabel
          Left = 176
          Top = 114
          Width = 29
          Height = 13
          Caption = 'Genre'
        end
        object Label21: TLabel
          Left = 1
          Top = 142
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Comment'
        end
        object Bevel3: TBevel
          Left = 0
          Top = 232
          Width = 417
          Height = 9
          Shape = bsBottomLine
        end
        object Id3v1Track: TEdit
          Tag = 11
          Left = 112
          Top = 6
          Width = 48
          Height = 21
          MaxLength = 3
          TabOrder = 0
          OnChange = TRCKChange
        end
        object Id3v1Artist: TJvComboBox
          Tag = 11
          Left = 112
          Top = 32
          Width = 300
          Height = 21
          ItemHeight = 0
          MaxLength = 30
          Sorted = True
          TabOrder = 1
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object Id3v1Title: TJvComboBox
          Tag = 11
          Left = 112
          Top = 58
          Width = 300
          Height = 21
          ItemHeight = 0
          MaxLength = 30
          Sorted = True
          TabOrder = 2
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object Id3v1Album: TJvComboBox
          Tag = 11
          Left = 112
          Top = 84
          Width = 300
          Height = 21
          ItemHeight = 0
          MaxLength = 30
          Sorted = True
          TabOrder = 3
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object Id3v1Year: TEdit
          Tag = 11
          Left = 112
          Top = 112
          Width = 41
          Height = 21
          MaxLength = 4
          TabOrder = 4
          OnChange = TRCKChange
        end
        object Id3v1Comment: TEdit
          Tag = 11
          Left = 112
          Top = 140
          Width = 300
          Height = 21
          MaxLength = 28
          TabOrder = 5
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object Id3v1Genre: TJvComboBox
          Tag = 11
          Left = 224
          Top = 112
          Width = 188
          Height = 21
          ItemHeight = 0
          MaxLength = 30
          Sorted = True
          TabOrder = 6
          OnChange = ArtistChange
        end
        object GroupBox3: TGroupBox
          Left = 0
          Top = 388
          Width = 441
          Height = 38
          Align = alBottom
          Caption = 'Copy from '
          TabOrder = 7
          object CFROM1111: TRadioButton
            Left = 8
            Top = 16
            Width = 65
            Height = 17
            Caption = 'None'
            TabOrder = 0
            OnClick = CFROM_Click
          end
          object CFROM1110: TRadioButton
            Left = 72
            Top = 16
            Width = 89
            Height = 17
            Caption = 'Database'
            TabOrder = 1
            OnClick = CFROM_Click
          end
          object CFROM1112: TRadioButton
            Left = 168
            Top = 16
            Width = 65
            Height = 17
            Caption = 'Id3v2'
            TabOrder = 2
            OnClick = CFROM_Click
          end
          object CFROM1113: TRadioButton
            Left = 248
            Top = 16
            Width = 57
            Height = 17
            Caption = 'Ape'
            TabOrder = 3
            OnClick = CFROM_Click
          end
        end
      end
      object TabId3v2: TTabSheet
        Caption = 'Id3v2'
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 546
          Height = 418
          AutoSize = True
          BevelOuter = bvNone
          TabOrder = 0
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 546
            Height = 32
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label14: TLabel
              Left = 1
              Top = 10
              Width = 100
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Track #'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label40: TLabel
              Left = 184
              Top = 10
              Width = 56
              Height = 13
              Caption = 'Total tracks'
            end
            object Label35: TLabel
              Left = 312
              Top = 10
              Width = 20
              Height = 13
              Caption = 'BPM'
            end
            object TRCK: TEdit
              Tag = 12
              Left = 112
              Top = 6
              Width = 48
              Height = 21
              TabOrder = 0
              OnChange = TRCKChange
            end
            object TRCKtotal: TEdit
              Tag = 12
              Left = 248
              Top = 6
              Width = 42
              Height = 21
              TabOrder = 1
              OnChange = TRCKChange
            end
            object TBPM: TEdit
              Tag = 12
              Left = 344
              Top = 6
              Width = 65
              Height = 21
              TabOrder = 2
              OnChange = ArtistChange
            end
          end
          object PanelTitle: TPanel
            Left = 0
            Top = 58
            Width = 546
            Height = 26
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Label26: TLabel
              Left = 16
              Top = 55
              Width = 71
              Height = 13
              Hint = 'Content group description'
              Caption = 'Content Group'
            end
            object Label2: TLabel
              Left = 1
              Top = 4
              Width = 100
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Title'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object label37: TLabel
              Left = 57
              Top = 34
              Width = 36
              Height = 13
              Caption = 'Subtitle'
            end
            object Label38: TLabel
              Left = 32
              Top = 79
              Width = 56
              Height = 13
              Hint = 'Interpreted, remixed, or otherwise modified by'
              Caption = 'Remixed by'
            end
            object Bevel1: TBevel
              Left = 16
              Top = 100
              Width = 417
              Height = 5
              Shape = bsBottomLine
            end
            object TIT1: TEdit
              Tag = 12
              Left = 112
              Top = 48
              Width = 300
              Height = 21
              TabOrder = 0
              OnChange = ArtistChange
            end
            object TIT2: TJvComboBox
              Tag = 12
              Left = 112
              Top = 0
              Width = 278
              Height = 21
              ItemHeight = 0
              Sorted = True
              TabOrder = 1
              OnChange = ArtistChange
              OnExit = ArtistExit
            end
            object TIT3: TEdit
              Tag = 12
              Left = 112
              Top = 27
              Width = 300
              Height = 21
              TabOrder = 2
              OnChange = ArtistChange
            end
            object TPE4: TEdit
              Tag = 12
              Left = 112
              Top = 73
              Width = 300
              Height = 21
              TabOrder = 3
              OnChange = ArtistChange
            end
            object ToggleTitle: TButton
              Left = 394
              Top = 2
              Width = 17
              Height = 17
              Caption = '+'
              TabOrder = 4
              OnClick = ToggleTitleClick
            end
          end
          object PanelArtist: TPanel
            Left = 0
            Top = 32
            Width = 546
            Height = 26
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object Label1: TLabel
              Left = 1
              Top = 4
              Width = 100
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Lead Artist'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label4: TLabel
              Left = 9
              Top = 34
              Width = 82
              Height = 13
              Caption = 'Band / Orchestra'
            end
            object Label39: TLabel
              Left = 41
              Top = 56
              Width = 50
              Height = 13
              Caption = 'Conductor'
            end
            object Label36: TLabel
              Left = 24
              Top = 88
              Width = 65
              Height = 13
              Hint = 'Original Artist - cover of a previously released song'
              Caption = 'Original Artist'
            end
            object Label8: TLabel
              Left = 41
              Top = 116
              Width = 48
              Height = 13
              Caption = 'Composer'
            end
            object Bevel2: TBevel
              Left = 16
              Top = 170
              Width = 417
              Height = 5
              Shape = bsBottomLine
            end
            object Label76: TLabel
              Left = 1
              Top = 148
              Width = 88
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Artist &sort order'
              FocusControl = TSOP
            end
            object TPE1: TJvComboBox
              Tag = 12
              Left = 112
              Top = 0
              Width = 278
              Height = 21
              ItemHeight = 0
              Sorted = True
              TabOrder = 0
              OnChange = ArtistChange
              OnExit = ArtistExit
            end
            object TPE2: TEdit
              Tag = 12
              Left = 112
              Top = 28
              Width = 300
              Height = 21
              TabOrder = 1
              OnChange = ArtistChange
            end
            object TPE3: TEdit
              Tag = 12
              Left = 112
              Top = 49
              Width = 300
              Height = 21
              TabOrder = 2
              OnChange = ArtistChange
            end
            object TOPE: TEdit
              Tag = 12
              Left = 112
              Top = 82
              Width = 300
              Height = 21
              TabOrder = 3
              OnChange = ArtistChange
            end
            object TCOM: TEdit
              Tag = 12
              Left = 112
              Top = 112
              Width = 300
              Height = 21
              TabOrder = 4
              OnChange = ArtistChange
            end
            object ToggleArtist: TButton
              Left = 394
              Top = 2
              Width = 17
              Height = 17
              Caption = '+'
              TabOrder = 5
              OnClick = ToggleArtistClick
            end
            object TSOP: TJvComboBox
              Tag = 12
              Left = 112
              Top = 143
              Width = 305
              Height = 21
              ItemHeight = 0
              ParentShowHint = False
              ShowHint = True
              Sorted = True
              TabOrder = 6
              OnChange = ArtistChange
              OnExit = ArtistExit
            end
          end
          object PanelAlbum: TPanel
            Left = 0
            Top = 84
            Width = 546
            Height = 334
            Align = alTop
            AutoSize = True
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            object Label3: TLabel
              Left = 1
              Top = 4
              Width = 100
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Album'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label41: TLabel
              Left = 1
              Top = 54
              Width = 100
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Language'
            end
            object Label6: TLabel
              Left = 32
              Top = 80
              Width = 34
              Height = 13
              Caption = 'Genre'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LangLabel: TLabel
              Left = 232
              Top = 244
              Width = 47
              Height = 13
              Caption = 'Language'
              Enabled = False
            end
            object DizLabel: TLabel
              Left = 56
              Top = 270
              Width = 77
              Height = 13
              Caption = 'Short discription'
              Enabled = False
            end
            object TextLabel: TLabel
              Left = 112
              Top = 296
              Width = 22
              Height = 13
              Caption = 'Text'
              Enabled = False
            end
            object Label73: TLabel
              Left = 1
              Top = 30
              Width = 104
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = '&Part of set'
              FocusControl = TPOS
            end
            object Label75: TLabel
              Left = 184
              Top = 30
              Width = 61
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'of totally'
            end
            object Label5: TLabel
              Left = 296
              Top = 30
              Width = 61
              Height = 13
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Year'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Bevel10: TBevel
              Left = 64
              Top = 144
              Width = 342
              Height = 9
              Shape = bsTopLine
            end
            object Label7: TLabel
              Left = 2
              Top = 136
              Width = 55
              Height = 13
              Caption = 'Comment'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object TALB: TJvComboBox
              Tag = 12
              Left = 112
              Top = 0
              Width = 300
              Height = 21
              Hint = 'Album/Movie/Show title'
              ItemHeight = 0
              Sorted = True
              TabOrder = 0
              OnChange = ArtistChange
              OnExit = ArtistExit
            end
            object CommTree: TVirtualStringTree
              Tag = 12
              Left = 8
              Top = 154
              Width = 401
              Height = 81
              Colors.TreeLineButtonColor = clBlack
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -9
              Font.Name = 'Tahoma'
              Font.Style = []
              Header.AutoSizeIndex = -1
              Header.DefaultHeight = 17
              Header.Font.Charset = DEFAULT_CHARSET
              Header.Font.Color = clWindowText
              Header.Font.Height = -11
              Header.Font.Name = 'MS Sans Serif'
              Header.Font.Style = []
              Header.Height = 18
              Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoVisible]
              HintAnimation = hatNone
              ParentFont = False
              TabOrder = 1
              TreeOptions.MiscOptions = [toInitOnSave, toToggleOnDblClick]
              TreeOptions.PaintOptions = [toShowHorzGridLines, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
              TreeOptions.SelectionOptions = [toDisableDrawSelection, toFullRowSelect]
              OnBeforeCellPaint = CommTreeBeforeCellPaint
              OnChange = CommTreeChange
              OnCreateEditor = CommTreeCreateEditor
              OnEdited = GenreEdited
              OnFreeNode = CommTreeFreeNode
              OnGetText = CommTreeGetText
              OnInitNode = CommTreeInitNode
              OnNewText = CommTreeNewText
              Columns = <
                item
                  Options = [coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
                  Position = 0
                  Width = 70
                  WideText = 'Language'
                end
                item
                  Options = [coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
                  Position = 1
                  Width = 116
                  WideText = 'Short des.'
                end
                item
                  Options = [coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
                  Position = 2
                  Width = 215
                  WideText = 'Text'
                end>
            end
            object TLAN: TJvComboBox
              Tag = 12
              Left = 112
              Top = 52
              Width = 300
              Height = 21
              ItemHeight = 0
              TabOrder = 2
              OnChange = ArtistChange
              OnClick = ArtistChange
            end
            object CommAdd: TButton
              Left = 0
              Top = 234
              Width = 89
              Height = 25
              Caption = 'Add'
              TabOrder = 3
              OnClick = CommAddClick
            end
            object CommDel: TButton
              Left = 88
              Top = 234
              Width = 98
              Height = 25
              Caption = 'Del'
              TabOrder = 4
              OnClick = CommDelClick
              OnDragOver = CommDelDragOver
            end
            object V2Cover: TCheckBox
              Tag = 12
              Left = 48
              Top = 98
              Width = 57
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Cover'
              TabOrder = 5
              OnKeyPress = genreCoverKeyPress
              OnMouseUp = genreCoverMouseUp
            end
            object V2Remix: TCheckBox
              Tag = 12
              Left = 48
              Top = 114
              Width = 57
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Remix'
              TabOrder = 6
              OnKeyPress = genreCoverKeyPress
              OnMouseUp = genreCoverMouseUp
            end
            object COMMdiz: TEdit
              Left = 152
              Top = 266
              Width = 257
              Height = 21
              Enabled = False
              TabOrder = 7
              OnChange = COMMdizChange
              OnExit = COMMdizExit
            end
            object COMMtext: TMemo
              Left = 152
              Top = 288
              Width = 257
              Height = 46
              Enabled = False
              TabOrder = 8
              OnChange = COMMtextChange
              OnExit = COMMdizExit
            end
            object COMMlanguage: TJvComboBox
              Left = 296
              Top = 242
              Width = 113
              Height = 21
              Color = clWhite
              Enabled = False
              ItemHeight = 0
              ParentFlat = False
              Sorted = True
              TabOrder = 9
              OnChange = COMMlanguageChange
              OnClick = COMMlanguageClick
              OnExit = COMMlanguageExit
            end
            object TCON: TVirtualStringTree
              Tag = 12
              Left = 112
              Top = 80
              Width = 154
              Height = 57
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
              TabOrder = 10
              TreeOptions.MiscOptions = [toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick]
              TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowHorzGridLines, toShowTreeLines, toThemeAware, toUseBlendedImages]
              TreeOptions.SelectionOptions = [toDisableDrawSelection, toFullRowSelect]
              OnCreateEditor = TCONCreateEditor
              OnEdited = GenreEdited
              OnEditing = TIPLEditing
              OnExit = COMMExit
              OnFocusChanged = TMCLFocusChanged
              OnFreeNode = GenreFreeNode
              OnGetText = TCONGetText
              Columns = <>
            end
            object AddTCON: TButton
              Left = 280
              Top = 80
              Width = 73
              Height = 25
              Caption = 'Add'
              TabOrder = 11
              OnClick = AddTCONClick
            end
            object DelTCON: TButton
              Left = 280
              Top = 104
              Width = 75
              Height = 25
              Caption = 'Del'
              TabOrder = 12
              OnClick = DelTCONClick
            end
            object TPOS: TEdit
              Tag = 12
              Left = 112
              Top = 26
              Width = 41
              Height = 21
              MaxLength = 4
              TabOrder = 13
              OnChange = TRCKChange
            end
            object TPOStotal: TEdit
              Tag = 12
              Left = 248
              Top = 26
              Width = 41
              Height = 21
              MaxLength = 4
              TabOrder = 14
              OnChange = TRCKChange
            end
            object TYER: TEdit
              Tag = 12
              Left = 368
              Top = 26
              Width = 41
              Height = 21
              TabOrder = 15
              OnChange = TRCKChange
            end
          end
        end
        object v2Scroll: TScrollBar
          Left = 425
          Top = 0
          Width = 16
          Height = 388
          Align = alRight
          Kind = sbVertical
          Max = 597
          PageSize = 484
          TabOrder = 1
          OnScroll = v2ScrollScroll
        end
        object GroupBox4: TGroupBox
          Left = 0
          Top = 388
          Width = 441
          Height = 38
          Align = alBottom
          Caption = 'Copy from '
          TabOrder = 2
          object CFROM1212: TRadioButton
            Left = 8
            Top = 16
            Width = 65
            Height = 17
            Caption = 'None'
            TabOrder = 0
            OnClick = CFROM_Click
          end
          object CFROM1210: TRadioButton
            Left = 72
            Top = 16
            Width = 89
            Height = 17
            Caption = 'Database'
            TabOrder = 1
            OnClick = CFROM_Click
          end
          object CFROM1211: TRadioButton
            Left = 168
            Top = 16
            Width = 65
            Height = 17
            Caption = 'Id3v1'
            TabOrder = 2
            OnClick = CFROM_Click
          end
          object CFROM1213: TRadioButton
            Left = 248
            Top = 16
            Width = 57
            Height = 17
            Caption = 'Ape'
            TabOrder = 3
            OnClick = CFROM_Click
          end
        end
      end
      object TabApe: TTabSheet
        Caption = 'Ape'
        ImageIndex = 5
        object Label33: TLabel
          Left = 1
          Top = 10
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Track #'
        end
        object Label34: TLabel
          Left = 1
          Top = 36
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Artist'
        end
        object Label42: TLabel
          Left = 1
          Top = 62
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Title'
        end
        object Label43: TLabel
          Left = 1
          Top = 88
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Album'
        end
        object Label44: TLabel
          Left = 257
          Top = 114
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Year'
        end
        object Label45: TLabel
          Left = 72
          Top = 170
          Width = 29
          Height = 13
          Caption = 'Genre'
        end
        object Label68: TLabel
          Left = 176
          Top = 10
          Width = 56
          Height = 13
          Caption = 'Total tracks'
        end
        object Label77: TLabel
          Left = 1
          Top = 114
          Width = 104
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '&Part of set'
          FocusControl = ApePartOfSet
        end
        object Label78: TLabel
          Left = 184
          Top = 114
          Width = 61
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'of totally'
        end
        object Label79: TLabel
          Left = 1
          Top = 196
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Artist &sort order'
          FocusControl = ApeArtistSortOrder
        end
        object Label46: TLabel
          Left = 1
          Top = 140
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Comment'
        end
        object Label86: TLabel
          Left = 44
          Top = 220
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'Other fields'
        end
        object ApeTrack: TEdit
          Tag = 13
          Left = 112
          Top = 6
          Width = 48
          Height = 21
          MaxLength = 3
          TabOrder = 0
          OnChange = TRCKChange
        end
        object ApeArtist: TJvComboBox
          Tag = 13
          Left = 112
          Top = 32
          Width = 300
          Height = 21
          ItemHeight = 0
          Sorted = True
          TabOrder = 1
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object ApeTitle: TJvComboBox
          Tag = 13
          Left = 112
          Top = 58
          Width = 300
          Height = 21
          ItemHeight = 0
          Sorted = True
          TabOrder = 2
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object ApeAlbum: TJvComboBox
          Tag = 13
          Left = 112
          Top = 84
          Width = 300
          Height = 21
          ItemHeight = 0
          Sorted = True
          TabOrder = 3
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object ApeYear: TEdit
          Tag = 13
          Left = 368
          Top = 110
          Width = 41
          Height = 21
          MaxLength = 4
          TabOrder = 4
          OnChange = TRCKChange
        end
        object ApeGenre: TJvComboBox
          Tag = 13
          Left = 112
          Top = 168
          Width = 300
          Height = 21
          ItemHeight = 0
          Sorted = True
          TabOrder = 5
          OnChange = ArtistChange
        end
        object GroupBox5: TGroupBox
          Left = 0
          Top = 388
          Width = 441
          Height = 38
          Align = alBottom
          Caption = 'Copy from '
          TabOrder = 6
          object CFROM1313: TRadioButton
            Left = 8
            Top = 16
            Width = 65
            Height = 17
            Caption = 'None'
            TabOrder = 0
            OnClick = CFROM_Click
          end
          object CFROM1310: TRadioButton
            Left = 72
            Top = 16
            Width = 89
            Height = 17
            Caption = 'Database'
            TabOrder = 1
            OnClick = CFROM_Click
          end
          object CFROM1311: TRadioButton
            Left = 168
            Top = 16
            Width = 65
            Height = 17
            Caption = 'Id3v1'
            TabOrder = 2
            OnClick = CFROM_Click
          end
          object CFROM1312: TRadioButton
            Left = 248
            Top = 16
            Width = 57
            Height = 17
            Caption = 'Id3v2'
            TabOrder = 3
            OnClick = CFROM_Click
          end
        end
        object ApeTotalTracks: TEdit
          Tag = 13
          Left = 240
          Top = 6
          Width = 41
          Height = 21
          TabOrder = 7
          OnChange = TRCKChange
        end
        object ApePartOfSet: TEdit
          Tag = 13
          Left = 112
          Top = 110
          Width = 41
          Height = 21
          MaxLength = 4
          TabOrder = 8
          OnChange = TRCKChange
        end
        object ApeTotalParts: TEdit
          Tag = 13
          Left = 248
          Top = 110
          Width = 41
          Height = 21
          MaxLength = 4
          TabOrder = 9
          OnChange = TRCKChange
        end
        object ApeArtistSortOrder: TJvComboBox
          Tag = 13
          Left = 112
          Top = 192
          Width = 300
          Height = 21
          ItemHeight = 0
          ParentShowHint = False
          ShowHint = True
          Sorted = True
          TabOrder = 10
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object ApeComment: TEdit
          Tag = 13
          Left = 112
          Top = 136
          Width = 300
          Height = 21
          TabOrder = 11
          OnChange = ArtistChange
          OnExit = ArtistExit
        end
        object ApeOtherFields: TVirtualStringTree
          Tag = 13
          Left = 111
          Top = 220
          Width = 300
          Height = 105
          Colors.TreeLineButtonColor = clBlack
          Header.AutoSizeIndex = 1
          Header.DefaultHeight = 17
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoAutoResize, hoColumnResize, hoVisible]
          Header.Style = hsPlates
          TabOrder = 12
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toHideSelection, toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toExtendedFocus]
          OnBeforeCellPaint = OggOtherFieldsBeforeCellPaint
          OnEdited = OggOtherFieldsEdited
          OnEditing = OggOtherFieldsEditing
          OnGetText = OggOtherFieldsGetText
          OnMouseUp = wmaOtherFieldsMouseUp
          OnNewText = OggOtherFieldsNewText
          Columns = <
            item
              Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
              Position = 0
              Width = 100
              WideText = 'Field'
            end
            item
              Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
              Position = 1
              Width = 200
              WideText = 'Value'
            end>
        end
        object Button1: TButton
          Left = 64
          Top = 248
          Width = 41
          Height = 28
          Caption = 'Add'
          TabOrder = 13
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 64
          Top = 284
          Width = 41
          Height = 29
          Caption = 'Del'
          TabOrder = 14
          OnClick = Button2Click
        end
      end
      object TabWMA: TTabSheet
        Caption = 'WMA'
        ImageIndex = 6
        OnShow = TabWMAShow
        object Panel6: TPanel
          Left = 1
          Top = 6
          Width = 411
          Height = 439
          AutoSize = True
          BevelOuter = bvNone
          TabOrder = 1
          object Label47: TLabel
            Left = 0
            Top = 4
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Track #'
          end
          object Label48: TLabel
            Left = 0
            Top = 30
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Artist'
          end
          object Label49: TLabel
            Left = 0
            Top = 56
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Title'
          end
          object Label50: TLabel
            Left = 0
            Top = 82
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Album'
          end
          object Label80: TLabel
            Left = 0
            Top = 108
            Width = 104
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Part of set'
            FocusControl = WMAPartOfSet
          end
          object Label52: TLabel
            Left = 0
            Top = 134
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Comment'
          end
          object Label53: TLabel
            Left = 71
            Top = 164
            Width = 29
            Height = 13
            Caption = 'Genre'
          end
          object Label61: TLabel
            Left = 0
            Top = 194
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Rating'
          end
          object Label62: TLabel
            Left = 0
            Top = 220
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Copyright'
          end
          object Label63: TLabel
            Left = 0
            Top = 246
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Album cover URL'
          end
          object Label64: TLabel
            Left = 0
            Top = 274
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Promotion URL'
          end
          object Label82: TLabel
            Left = 0
            Top = 308
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Artist &sort order'
          end
          object Label81: TLabel
            Left = 183
            Top = 108
            Width = 61
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'of totally'
          end
          object Label51: TLabel
            Left = 295
            Top = 108
            Width = 61
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Year'
          end
          object Label87: TLabel
            Left = 43
            Top = 334
            Width = 56
            Height = 13
            Alignment = taRightJustify
            Caption = 'Other fields'
          end
          object WMAtrack: TEdit
            Tag = 14
            Left = 111
            Top = 0
            Width = 48
            Height = 21
            TabOrder = 0
            OnChange = TRCKChange
          end
          object WMAArtist: TJvComboBox
            Tag = 14
            Left = 111
            Top = 26
            Width = 300
            Height = 21
            ItemHeight = 0
            Sorted = True
            TabOrder = 1
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WMATitle: TJvComboBox
            Tag = 14
            Left = 111
            Top = 52
            Width = 300
            Height = 21
            ItemHeight = 0
            Sorted = True
            TabOrder = 2
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WMAAlbum: TJvComboBox
            Tag = 14
            Left = 111
            Top = 78
            Width = 300
            Height = 21
            ItemHeight = 0
            Sorted = True
            TabOrder = 3
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WMAPartOfSet: TEdit
            Tag = 14
            Left = 111
            Top = 104
            Width = 41
            Height = 21
            MaxLength = 4
            TabOrder = 4
            OnChange = TRCKChange
          end
          object WMAComment: TEdit
            Tag = 14
            Left = 111
            Top = 130
            Width = 300
            Height = 21
            TabOrder = 5
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WMAGenre: TJvComboBox
            Tag = 14
            Left = 111
            Top = 162
            Width = 300
            Height = 21
            ItemHeight = 0
            Sorted = True
            TabOrder = 6
            OnChange = ArtistChange
          end
          object WMARating: TEdit
            Tag = 14
            Left = 111
            Top = 192
            Width = 300
            Height = 21
            TabOrder = 7
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WMACopyright: TEdit
            Tag = 14
            Left = 111
            Top = 218
            Width = 300
            Height = 21
            TabOrder = 8
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WMAAlbumCover: TEdit
            Tag = 14
            Left = 111
            Top = 244
            Width = 300
            Height = 21
            TabOrder = 9
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WMAPromotion: TEdit
            Tag = 14
            Left = 111
            Top = 270
            Width = 300
            Height = 21
            TabOrder = 10
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WMAartistSortOrder: TJvComboBox
            Tag = 14
            Left = 111
            Top = 306
            Width = 300
            Height = 21
            ItemHeight = 0
            ParentShowHint = False
            ShowHint = True
            Sorted = True
            TabOrder = 11
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WMATotalParts: TEdit
            Tag = 14
            Left = 247
            Top = 104
            Width = 41
            Height = 21
            MaxLength = 4
            TabOrder = 12
            OnChange = TRCKChange
          end
          object WMAYear: TEdit
            Tag = 14
            Left = 367
            Top = 104
            Width = 41
            Height = 21
            MaxLength = 4
            TabOrder = 13
            OnChange = TRCKChange
          end
          object wmaOtherFields: TVirtualStringTree
            Tag = 14
            Left = 110
            Top = 334
            Width = 300
            Height = 105
            Colors.TreeLineButtonColor = clBlack
            Header.AutoSizeIndex = 1
            Header.DefaultHeight = 17
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoVisible]
            Header.Style = hsPlates
            TabOrder = 14
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHideSelection, toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            OnBeforeCellPaint = OggOtherFieldsBeforeCellPaint
            OnEdited = OggOtherFieldsEdited
            OnEditing = OggOtherFieldsEditing
            OnGetText = OggOtherFieldsGetText
            OnMouseUp = wmaOtherFieldsMouseUp
            OnNewText = OggOtherFieldsNewText
            Columns = <
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 0
                Width = 100
                WideText = 'Field'
              end
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 1
                Width = 200
                WideText = 'Value'
              end>
          end
          object Button3: TButton
            Left = 63
            Top = 362
            Width = 41
            Height = 28
            Caption = 'Add'
            TabOrder = 15
            OnClick = Button3Click
          end
          object Button4: TButton
            Left = 63
            Top = 398
            Width = 41
            Height = 29
            Caption = 'Del'
            TabOrder = 16
            OnClick = Button4Click
          end
        end
        object GroupBox6: TGroupBox
          Left = 0
          Top = 388
          Width = 441
          Height = 38
          Align = alBottom
          Caption = 'Copy from '
          TabOrder = 0
          object CFROM1414: TRadioButton
            Left = 8
            Top = 16
            Width = 65
            Height = 17
            Caption = 'None'
            TabOrder = 0
            OnClick = CFROM_Click
          end
          object CFROM1410: TRadioButton
            Left = 88
            Top = 16
            Width = 89
            Height = 17
            Caption = 'Database'
            TabOrder = 1
            OnClick = CFROM_Click
          end
        end
        object scbWma: TScrollBar
          Left = 425
          Top = 0
          Width = 16
          Height = 388
          Align = alRight
          Kind = sbVertical
          LargeChange = 32
          Max = 32
          PageSize = 1
          TabOrder = 2
          OnScroll = scbWmaScroll
        end
      end
      object TabOgg: TTabSheet
        Caption = 'Ogg Vorbis'
        ImageIndex = 7
        object GroupBox7: TGroupBox
          Left = 0
          Top = 388
          Width = 441
          Height = 38
          Align = alBottom
          Caption = 'Copy from '
          TabOrder = 0
          object CFROM1515: TRadioButton
            Left = 8
            Top = 16
            Width = 65
            Height = 17
            Caption = 'None'
            TabOrder = 0
            OnClick = CFROM_Click
          end
          object CFROM1510: TRadioButton
            Left = 88
            Top = 16
            Width = 89
            Height = 17
            Caption = 'Database'
            TabOrder = 1
            OnClick = CFROM_Click
          end
        end
        object Panel5: TPanel
          Left = 1
          Top = 4
          Width = 441
          Height = 389
          BevelOuter = bvNone
          TabOrder = 1
          object Label54: TLabel
            Left = 0
            Top = 6
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Track #'
          end
          object Label69: TLabel
            Left = 191
            Top = 6
            Width = 56
            Height = 13
            Caption = 'Total tracks'
          end
          object Label85: TLabel
            Left = 0
            Top = 256
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Artist &sort order'
            FocusControl = OggArtistSortOrder
          end
          object Label66: TLabel
            Left = 0
            Top = 222
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Version'
          end
          object Label65: TLabel
            Left = 0
            Top = 196
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Copyright'
          end
          object Label60: TLabel
            Left = 71
            Top = 166
            Width = 29
            Height = 13
            Caption = 'Genre'
          end
          object Label59: TLabel
            Left = 0
            Top = 136
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Comment'
          end
          object Label83: TLabel
            Left = 0
            Top = 110
            Width = 104
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = '&Part of set'
            FocusControl = OggPartOfSet
          end
          object Label57: TLabel
            Left = 0
            Top = 84
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Album'
          end
          object Label56: TLabel
            Left = 0
            Top = 58
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Title'
          end
          object Label55: TLabel
            Left = 0
            Top = 32
            Width = 100
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Artist'
          end
          object Label58: TLabel
            Left = 295
            Top = 110
            Width = 61
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Year'
          end
          object Label84: TLabel
            Left = 44
            Top = 284
            Width = 56
            Height = 13
            Alignment = taRightJustify
            Caption = 'Other fields'
          end
          object OggTrack: TEdit
            Tag = 15
            Left = 111
            Top = 2
            Width = 48
            Height = 21
            TabOrder = 0
            OnChange = TRCKChange
          end
          object OggTotalTracks: TEdit
            Tag = 15
            Left = 255
            Top = 2
            Width = 42
            Height = 21
            TabOrder = 1
            OnChange = TRCKChange
          end
          object OggArtistSortOrder: TJvComboBox
            Tag = 15
            Left = 111
            Top = 252
            Width = 300
            Height = 21
            ItemHeight = 0
            ParentShowHint = False
            ShowHint = True
            Sorted = True
            TabOrder = 2
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object OggVersion: TEdit
            Tag = 15
            Left = 111
            Top = 220
            Width = 300
            Height = 21
            TabOrder = 3
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object OggCopyright: TEdit
            Tag = 15
            Left = 111
            Top = 194
            Width = 300
            Height = 21
            TabOrder = 4
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object OggGenre: TJvComboBox
            Tag = 15
            Left = 111
            Top = 164
            Width = 300
            Height = 21
            ItemHeight = 0
            Sorted = True
            TabOrder = 5
            OnChange = ArtistChange
          end
          object OggComment: TEdit
            Tag = 15
            Left = 111
            Top = 132
            Width = 300
            Height = 21
            TabOrder = 6
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object OggPartOfSet: TEdit
            Tag = 15
            Left = 111
            Top = 106
            Width = 41
            Height = 21
            MaxLength = 4
            TabOrder = 7
            OnChange = TRCKChange
          end
          object OggAlbum: TJvComboBox
            Tag = 15
            Left = 111
            Top = 80
            Width = 300
            Height = 21
            ItemHeight = 0
            Sorted = True
            TabOrder = 8
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object OggTitle: TJvComboBox
            Tag = 15
            Left = 111
            Top = 54
            Width = 300
            Height = 21
            ItemHeight = 0
            Sorted = True
            TabOrder = 9
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object OggArtist: TJvComboBox
            Tag = 15
            Left = 111
            Top = 28
            Width = 300
            Height = 21
            ItemHeight = 0
            Sorted = True
            TabOrder = 10
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object OggYear: TEdit
            Tag = 15
            Left = 367
            Top = 106
            Width = 41
            Height = 21
            MaxLength = 4
            TabOrder = 11
            OnChange = TRCKChange
          end
          object OggOtherFields: TVirtualStringTree
            Tag = 15
            Left = 111
            Top = 284
            Width = 300
            Height = 105
            Colors.TreeLineButtonColor = clBlack
            Header.AutoSizeIndex = 1
            Header.DefaultHeight = 17
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoVisible]
            Header.Style = hsPlates
            TabOrder = 12
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHideSelection, toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            OnBeforeCellPaint = OggOtherFieldsBeforeCellPaint
            OnEdited = OggOtherFieldsEdited
            OnEditing = OggOtherFieldsEditing
            OnGetText = OggOtherFieldsGetText
            OnInitNode = CustomFieldTreeInitNode
            OnMouseUp = wmaOtherFieldsMouseUp
            OnNewText = OggOtherFieldsNewText
            Columns = <
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 0
                Width = 100
                WideText = 'Field'
              end
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 1
                Width = 200
                WideText = 'Value'
              end>
          end
          object btnAddOggOtherField: TButton
            Left = 64
            Top = 312
            Width = 41
            Height = 28
            Caption = 'Add'
            TabOrder = 13
            OnClick = btnAddOggOtherFieldClick
          end
          object btnDelOggOtherField: TButton
            Left = 64
            Top = 348
            Width = 41
            Height = 29
            Caption = 'Del'
            TabOrder = 14
            OnClick = btnDelOggOtherFieldClick
          end
        end
        object scrollBarOgg: TScrollBar
          Left = 425
          Top = 0
          Width = 16
          Height = 388
          Align = alRight
          Kind = sbVertical
          PageSize = 0
          TabOrder = 2
          Visible = False
          OnScroll = scrollBarOggScroll
        end
      end
      object TabId3v2X1: TTabSheet
        Caption = 'Id3v2 - Extra'
        OnShow = TabId3v2X1Show
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 425
          Height = 507
          BevelOuter = bvNone
          TabOrder = 0
          object Label11: TLabel
            Left = 34
            Top = 16
            Width = 47
            Height = 13
            Caption = 'Copyright'
          end
          object Label25: TLabel
            Left = 44
            Top = 42
            Width = 41
            Height = 13
            Hint = 'the owner or licensee of the file and it'#39's contents'
            Caption = 'Licensee'
          end
          object Label24: TLabel
            Left = 42
            Top = 68
            Width = 43
            Height = 13
            Caption = 'Publisher'
          end
          object Label13: TLabel
            Left = 32
            Top = 99
            Width = 56
            Height = 13
            Caption = 'Encoded by'
          end
          object Label10: TLabel
            Left = 48
            Top = 133
            Width = 42
            Height = 13
            Caption = 'Lyrics by'
          end
          object Label12: TLabel
            Left = 76
            Top = 162
            Width = 19
            Height = 13
            Caption = 'URL'
          end
          object Label15: TLabel
            Left = 16
            Top = 302
            Width = 117
            Height = 13
            Caption = 'Musicians (Id3v2.4 only)'
          end
          object Label23: TLabel
            Left = 16
            Top = 406
            Width = 206
            Height = 13
            Caption = 'Involved people (Producers, Technicians..)'
          end
          object Label88: TLabel
            Left = 14
            Top = 182
            Width = 56
            Height = 13
            Alignment = taRightJustify
            Caption = 'Other fields'
          end
          object TCOP: TEdit
            Tag = 12
            Left = 112
            Top = 12
            Width = 300
            Height = 21
            TabOrder = 0
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object TOWN: TEdit
            Tag = 12
            Left = 112
            Top = 38
            Width = 300
            Height = 21
            TabOrder = 1
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object TPUB: TEdit
            Tag = 12
            Left = 112
            Top = 64
            Width = 300
            Height = 21
            TabOrder = 2
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object TENC: TEdit
            Tag = 12
            Left = 112
            Top = 94
            Width = 300
            Height = 21
            TabOrder = 3
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object TEXT: TEdit
            Tag = 12
            Left = 112
            Top = 128
            Width = 300
            Height = 21
            TabOrder = 4
            OnChange = ArtistChange
            OnExit = ArtistExit
          end
          object WXXX: TEdit
            Tag = 12
            Left = 112
            Top = 158
            Width = 297
            Height = 21
            TabOrder = 5
            OnChange = ArtistChange
          end
          object TMCL: TVirtualStringTree
            Tag = 12
            Left = 48
            Top = 320
            Width = 361
            Height = 81
            Colors.TreeLineButtonColor = clBlack
            Header.AutoSizeIndex = -1
            Header.DefaultHeight = 17
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Height = 18
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoVisible]
            HintAnimation = hatNone
            TabOrder = 6
            TreeOptions.AutoOptions = [toAutoTristateTracking]
            TreeOptions.MiscOptions = [toEditable, toGridExtensions, toInitOnSave, toEditOnClick]
            TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowHorzGridLines, toShowVertGridLines, toThemeAware]
            TreeOptions.SelectionOptions = [toDisableDrawSelection, toExtendedFocus]
            OnEdited = GenreEdited
            OnEditing = TIPLEditing
            OnExit = COMMExit
            OnFocusChanged = TMCLFocusChanged
            OnFreeNode = TMCLFreeNode
            OnGetText = TMCLGetText
            OnNewText = TIPLNewText
            Columns = <
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 0
                Width = 171
                WideText = 'Instrument'
              end
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 1
                Width = 190
                WideText = 'Name'
              end>
          end
          object AddMusiciansBut: TButton
            Left = 8
            Top = 336
            Width = 33
            Height = 25
            Caption = 'Add'
            TabOrder = 7
            OnClick = AddMusiciansButClick
          end
          object DelMusiciansBut: TButton
            Left = 8
            Top = 368
            Width = 33
            Height = 25
            Caption = 'Del'
            TabOrder = 8
            OnClick = DelMusiciansButClick
          end
          object TIPL: TVirtualStringTree
            Tag = 12
            Left = 48
            Top = 424
            Width = 361
            Height = 81
            Colors.TreeLineButtonColor = clBlack
            Header.AutoSizeIndex = -1
            Header.DefaultHeight = 17
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Height = 18
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoVisible]
            HintAnimation = hatNone
            TabOrder = 9
            TreeOptions.AutoOptions = [toAutoTristateTracking]
            TreeOptions.MiscOptions = [toEditable, toGridExtensions, toInitOnSave]
            TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowHorzGridLines, toShowVertGridLines]
            TreeOptions.SelectionOptions = [toDisableDrawSelection, toExtendedFocus, toMultiSelect]
            OnEdited = GenreEdited
            OnEditing = TIPLEditing
            OnExit = COMMExit
            OnFocusChanged = TMCLFocusChanged
            OnFreeNode = TMCLFreeNode
            OnGetText = TMCLGetText
            OnInitNode = TIPLInitNode
            OnNewText = TIPLNewText
            Columns = <
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 0
                Width = 171
                WideText = 'Role'
              end
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 1
                Width = 190
                WideText = 'Name'
              end>
          end
          object AddInvPeopleBut: TButton
            Left = 8
            Top = 440
            Width = 33
            Height = 25
            Caption = 'Add'
            TabOrder = 10
            OnClick = AddInvPeopleButClick
          end
          object DelInvPeopleBut: TButton
            Left = 8
            Top = 472
            Width = 33
            Height = 25
            Caption = 'Del'
            TabOrder = 11
            OnClick = DelInvPeopleButClick
          end
          object Id3v2OtherFields: TVirtualStringTree
            Tag = 12
            Left = 48
            Top = 200
            Width = 363
            Height = 93
            Colors.TreeLineButtonColor = clBlack
            Header.AutoSizeIndex = 1
            Header.DefaultHeight = 17
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoVisible]
            Header.Style = hsPlates
            TabOrder = 12
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHideSelection, toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            OnBeforeCellPaint = Id3v2OtherFieldsBeforeCellPaint
            OnEdited = OggOtherFieldsEdited
            OnEditing = Id3v2OtherFieldsEditing
            OnGetText = Id3v2OtherFieldsGetText
            OnMouseUp = wmaOtherFieldsMouseUp
            OnNewText = Id3v2OtherFieldsNewText
            Columns = <
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 0
                Width = 44
                WideText = 'Field'
              end
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 1
                Width = 159
                WideText = 'Description'
              end
              item
                Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
                Position = 2
                Width = 160
                WideText = 'Value'
              end>
          end
          object Button5: TButton
            Left = 8
            Top = 216
            Width = 33
            Height = 25
            Caption = 'Add'
            TabOrder = 13
            OnClick = Button5Click
          end
          object Button6: TButton
            Left = 8
            Top = 252
            Width = 33
            Height = 25
            Caption = 'Del'
            TabOrder = 14
            OnClick = Button6Click
          end
        end
        object v2ExtraScroll: TScrollBar
          Left = 425
          Top = 0
          Width = 16
          Height = 426
          Align = alRight
          Kind = sbVertical
          Max = 597
          PageSize = 484
          TabOrder = 1
          OnScroll = v2ExtraScrollScroll
        end
      end
      object TabLyrics: TTabSheet
        Caption = 'Lyrics'
        ImageIndex = 2
        object LyricsMemo: TMemo
          Left = 0
          Top = 0
          Width = 441
          Height = 426
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
          WordWrap = False
          OnExit = UpdateCheckBoxes
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Stream info'
        ImageIndex = 3
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 441
          Height = 417
          Caption = ' Stream info '
          TabOrder = 0
          object MpegInfo: TLabel
            Left = 24
            Top = 16
            Width = 401
            Height = 393
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
        end
      end
    end
    object CBhasId3v1Tag: TCheckBox
      Left = 464
      Top = 18
      Width = 81
      Height = 17
      Caption = 'Id3v1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object CBhasId3v2Tag: TCheckBox
      Left = 464
      Top = 37
      Width = 81
      Height = 17
      Caption = 'Id3v2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object HasLyrics: TCheckBox
      Left = 464
      Top = 129
      Width = 113
      Height = 17
      Caption = 'Lyrics'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object Id3v2VerPanel: TPanel
      Left = 527
      Top = 36
      Width = 60
      Height = 18
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 6
      object id3v23: TRadioButton
        Left = 0
        Top = 0
        Width = 28
        Height = 17
        Caption = '3'
        TabOrder = 0
      end
      object id3v24: TRadioButton
        Left = 32
        Top = 1
        Width = 28
        Height = 17
        Caption = '4'
        TabOrder = 1
      end
    end
    object tagLyrics: TCheckBox
      Left = 472
      Top = 147
      Width = 97
      Height = 17
      Caption = 'in file tag'
      TabOrder = 7
    end
    object Lyrics3v1: TCheckBox
      Left = 472
      Top = 163
      Width = 121
      Height = 17
      Caption = 'as lyrics3 v 1.00'
      TabOrder = 8
      OnClick = Lyrics3v1Click
    end
    object Lyrics3v2: TCheckBox
      Left = 472
      Top = 179
      Width = 121
      Height = 17
      Caption = 'as lyrics3 v 2.00'
      TabOrder = 9
      OnClick = Lyrics3v2Click
    end
    object CBhasApeTag: TCheckBox
      Left = 464
      Top = 65
      Width = 97
      Height = 17
      Caption = 'Ape tag'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
    end
    object CBHasWMAtag: TCheckBox
      Left = 464
      Top = 81
      Width = 97
      Height = 17
      Caption = 'WMA tag'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
    end
    object CBhasOggTag: TCheckBox
      Left = 464
      Top = 97
      Width = 97
      Height = 17
      Caption = 'Ogg tag'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
    end
  end
  object Stat: TVirtualStringTree
    Left = 0
    Top = 474
    Width = 629
    Height = 79
    Align = alClient
    BevelOuter = bvNone
    BevelKind = bkSoft
    BorderStyle = bsNone
    CheckImageKind = ckXP
    Colors.TreeLineButtonColor = clBlack
    Header.AutoSizeIndex = -1
    Header.DefaultHeight = 17
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoVisible]
    HintMode = hmHint
    ParentShowHint = False
    ScrollBarOptions.ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 3
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toDisableDrawSelection, toFullRowSelect, toMultiSelect]
    OnChange = StatChange
    OnFreeNode = StatFreeNode
    OnGetText = StatGetText
    OnGetHint = StatGetHint
    Columns = <
      item
        Position = 0
        Width = 296
        WideText = 'Filename'
      end
      item
        Alignment = taCenter
        Position = 1
        Width = 70
        WideText = 'Read/write'
      end
      item
        Position = 2
        Width = 130
        WideText = 'Status'
      end
      item
        Alignment = taCenter
        Position = 3
        Width = 60
        WideText = 'Changed'
      end
      item
        Alignment = taCenter
        Position = 4
        Width = 71
        WideText = 'Tags'
      end>
  end
  object ReadMpegInfo: TBMDThread
    Priority = tpLowest
    UpdateEnabled = True
    OnExecute = ReadMpegInfoExecute
    OnStart = ReadMpegInfoStart
    Left = 568
    Top = 648
  end
  object ImageList1: TImageList
    Left = 432
    Top = 648
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000730000008C0000008400000084000000840000008400000039000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6D6C6009C6B
      6B009C6B6B009C6B6B009C6B6B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B69C8300E0B68C00E0B68C00E0B68C00E0B68C00CCA58800666666000000
      0000000000000000000000000000000000000000000000000000000000000000
      8C0000008C0000008C00000094000000940000008C000000840000007B000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000636B7300636B7300636B7300636B7300000000000000
      0000000000000000000000000000000000000000000000000000ADDEAD00CEEF
      C600FFFFE700FFFFE700FFFFE700FFFFFF00EFEFD600B5AD94009C6B6B009C6B
      6B00000000000000000000000000000000000000000000000000E1BA9100E0B7
      8E00E2BA8F00E8BF9500ECC39900EEC49900ECC19700E4BC9300E2B88F00D2B0
      8B00756975000000000000000000000000000000000000000000000094000000
      9400000094000000A5000000A5000000A50000009C000000940000008C000000
      840000008C00000000000000000000000000000000000000000000000000636B
      73004284CE00527BBD00B58C7B00CE845A00DE9C7300AD949400527BBD00636B
      73000000000000000000000000000000000000000000CEAD9400EFF7D600FFFF
      E700FFFFE700FFFFE700EFF7DE00CEEFC6009CD6B500BDE7B500F7F7E7009C6B
      6B000000000000000000000000000000000000000000E2BC9500E2BC9500E9C1
      9A00FFD8AF008C4E3000B36F4400B36F4400B6683A00EDBC8F00F1C8A000E5BF
      9900DDB58D007569750000000000000000000000000000009C000000A5002121
      AD00FFFFFF000000A5000000AD000000B5000000AD004A4ABD00FFFFFF000000
      8C0000008C0000008400000000000000000000000000000000006BB5F7006B8C
      8C00F7D6A500FFDEB500FFE7BD00F7EFD600DE9C7300CE845A00F7EFD6001863
      EF00636B730000000000000000000000000000000000CEAD9400FFFFE700FFFF
      E700FFFFE700CEAD9400ADDEAD00ADDEAD00CEEFC600F7F7E700FFFFFF009C6B
      6B000000000000000000000000000000000000000000E4C09D00EBC8A400FFD6
      B200FFDCB300FFFFD60036000000982B0000AC765100FFE5BC00FFDBB400F4CF
      AC00E9C6A100A9947E0000000000000000002929BD000000A5000000B500CECE
      A500FFFFFF00FFFFFF000000AD000000B5004A4ABD00FFFFFF00FFFFFF008484
      AD0000009C000000940000000800000000000000000000000000187BF700EFB5
      8C00F7DEAD00FFE7BD00FFEFDE00EFBD9400CE845A00F7DEAD00FFF7EF00FFFF
      FF0084B5F7005A6B7B00000000000000000000000000CEAD9400FFFFE700EFF7
      DE00E7EFCE00AD6B5A00E7AD6B00E7AD8C00F7F7E700FFFFFF00FFFFFF009C6B
      6B0000000000000000000000000000000000E4B5A000E7C8A800FDDBB700FFDE
      BA00FFDBB900FFEFC900360000009A2F0000CE9D7A00FFDDB900FFDBB700FFDF
      BD00F4CFAC00E6C4A10066666600000000000000A5000000B5000000C6000000
      BD00C6C6A500FFFFFF00FFFFFF005252DE00FFFFF700FFFFFF006B6B94000000
      BD000000AD0000009C0000006B0000000000000000008CADDE00E7A57300F7E7
      CE00F7E7C600FFF7EF00FFFFF700EFB58C00CE845A00FFE7BD00FFFFFF00FFFF
      F700FFFFFF00CEEFF70052A5F7000000000000000000CEAD9400CEEFC600ADDE
      AD00ADDEAD00E7EFCE00BD7B7B00E7AD8400DECEA500FFFFFF00FFFFFF009C6B
      6B0000000000000000000000000000000000E6C6A600F2D5B800FFE4C300FFDF
      BD00FFE0C000FFF1D000360000009A2F0000CE9D7A00FFE0C000FFDFBD00FFE2
      C200FFE0C000F2D1B30090847800000000000808B5000000C6000000CE000000
      CE000000BD00D6D6BD00FFFFFF00FFFFFF00FFFFFF008484AD000000C6000000
      C6000000BD000000A50000009C000000000000000000219CF700DE945A00FFF7
      E700FFFFF700FFFFFF00EFBD9400DE9C7300EFBD9400FFF7E700FFFFFF00FFFF
      FF00FFFFFF004A8463005A84B5000000000000000000CEAD9400ADDEAD00CEEF
      C600EFF7DE00EFF7DE00DE9C5A00CE6B0000E7AD7B00E7AD9400F7F7E7009C6B
      6B0000000000000000000000000000000000EED6BD00FFE1C500FFE5CA00FFE4
      C700FFE1C500FFF2D500360000009A2F0000D0A07D00FFE5C900FFE4C500FFE4
      C700FFEBCF00F3D9BE00B59A7F00000000000808C6000808D6000808DE000000
      D6000000D600424AC600FFFFFF00FFFFFF00FFFFF7000000C6000000CE000000
      CE000000C6000000B5000000BD000000000000000000219CF700F7EFD600F7EF
      D600FFFFFF00FFFFFF00EFB58C00CE845A00FFDEB500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00009C1800636B73000000000000000000CEAD9400CEEFC600EFF7
      DE00FFFFE700FFFFFF00FFFFFF00CE7B2100CE6B0000DE9C6300DE945A009C6B
      6B0000000000000000000000000000000000EFD8C400FFE8D100FFE8D100FFE5
      CE00FFE7CF00FFFFEB0036000000992F0000CDA08200FFE7CF00FFE6CD00FFE6
      CD00FFF0D800FAE1C700B4997D00000000001010CE001010E7001010EF000000
      E7004242CE00FFFFF700FFFFFF00FFFFF700FFFFFF00FFFFFF000000CE000000
      D6000808CE000000BD000000B500000000008CADDE00428C5A00FFFFFF00FFFF
      FF00FFFFFF00EFBD9400CE845A00DE9C7300FFE7BD00FFF7E700FFFFFF00FFFF
      FF0084B5F7007BB5FF00000000000000000000000000CEAD9400FFFFE700FFFF
      E700FFFFE700FFFFFF00F7F7E700D6EFC600CE7B2100CE6B0000BD7339004A4A
      420000000000000000000000000000000000F1DFD000FFECD900FFEDD500FFE8
      D200FFF5E2002B000000851C00007D150000CDA08200FFEBD400FFE8D200FFEB
      D400FFF9E600FFE8D200B4997D00000000001818D6001818F7001818FF004A4A
      E700FFFFF700FFFFFF0073739C000000D600CECEAD00FFFFFF00FFFFFF000000
      E7000808DE000808C600000094000000000052A5F700B58C7B00FFFFFF00FFFF
      FF00FFFFFF0084B5F700428CD600F7E7CE00FFFFF700FFFFFF00FFFFFF00FFFF
      FF004A9CFF00636B7300000000000000000000000000CEAD9400FFFFE700F7F7
      E700DEEFD600CEEFC600ADDEAD00ADDEAD00ADDEAD00CEAD9400AD6B5A00AD7B
      73004A4A4200000000000000000000000000F1E1CF00FFF0E000FFF5E200FFED
      DA00FFEFDC00FFFEEE00FFFFF800FFFFFB00FFF9E600FFEDDA00FFECD900FFEF
      DC00FFFFF100FFEDDD00B69C8300000000003131E7002929FF002929FF00D6D6
      BD00FFFFFF006B6B94000000EF000000E7000000D600BDBD9C00FFFFFF007373
      BD001010E7001010CE005A5A6B0000000000219CF700F7E7CE007BB5FF007BB5
      FF00000000000000000000000000397BEF00FFFFFF00FFFFFF00FFFFFF00C6E7
      F7005AB5FF0000000000000000000000000000000000CEAD9400EFF7DE00CEEF
      C600BDE7B500ADDEAD00ADDEAD00ADDEAD00CEEFC600F7F7E700CE7B2900CE6B
      00004A4A42009C6B6B000000000000000000ECD1B600FFF0E300FFFFF500FFF2
      E300FFF2E100FFFFF100652B1000922B0000FFFFFD00FFF0E300FFF0E000FFFF
      F300FFFFFF00FFF0E3000000000000000000000000002929FF004A4AFF004A4A
      FF006B6B84001010FF000000FF000000F7000808FF001818F7004A4A94002121
      FF002121EF001010D60000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007BB5FF00FFFFFF0052B5
      FF00636B730000000000000000000000000000000000CEAD9400ADDEAD00ADDE
      AD00ADDEAD00CEEFC600F7F7E700F7F7E700FFFFFF00FFFFFF00FFFFFF00D673
      1000CE7B2100B5AD9400000000000000000000000000FCF5ED00FFFFFF00FFFF
      FB00FFF6E900FFFFFF00851C00009D2B0000CFAA9600FFF6E900FFFFF700FFFF
      FF00FFFFFF00E0C2A300000000000000000000000000000000004242FF006B6B
      FF008484FF007373FF005252FF004242FF004A4AFF005252FF004A4AFF003939
      FF002121F7000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005284AD005AB5
      FF000000000000000000000000000000000000000000CEAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009C6B
      6B00D67310009C6B6B00000000000000000000000000E9CBAD00FFFFF800FFFF
      FF00FFFFFF00FFFFFF0060554E004D352C00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FBF6E8000000000000000000000000000000000000000000000000004A4A
      FF007B7BFF00A5A5FF00A5A5FF009C9CFF008484FF006B6BFF004A4AFF002121
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEAD9400DECEBD0021AD
      BD00DECEBD0073A5AD00CEAD9400DEEFCE009C6B6B00FFFFFF0021ADBD009C6B
      6B00000000000000000000000000000000000000000000000000EBCFB300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8EE
      E500000000000000000000000000000000000000000000000000000000000000
      00003939FF006363FF008484FF007B7BFF006363FF003939FF006B6BF7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000029B5CE009C6B
      6B0029B5CE009C6B6B0094AD9C009C6B6B00C6AD9400947B730073A5AD009C6B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000F3E4D400FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7ECE100D3A3A6000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFF01FFFFFC1FFF01F
      E00FFC3FC00FC007C007E00F800F80038003C007800F80030001C003800F0001
      00018001800F000100018001800F000100018001800F000100010003800F0001
      000100038007000100010E07800300038003FF8780038003C007FFCF80038007
      E00FFFFF800FC00FF01FFFFFC00FF01F00000000000000000000000000000000
      000000000000}
  end
  object UndoImages: TImageList
    Left = 496
    Top = 648
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052100000521000005210
      0000521000005210000052080000521000005210000052100000520800005210
      0000521000005210000052100000000000000000000052100000521000005210
      0000521000005210000052080000521000005210000052100000521000005210
      0000521000005210000052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052100000F7FFF700FFF7
      FF00FFFFFF00FFFFFF00FFFFFF00F7FFF700F7FFF700FFFFFF00F7FFFF00F7F7
      FF00F7F7FF00FFF7FF0052100000000000000000000052100000FFFFFF00FFFF
      F700F7F7F700F7FFF700FFFFF700FFFFFF00FFFFFF00FFF7FF00F7FFFF00FFFF
      F700FFFFF700FFF7F70052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052100000F7FFFF00FFFF
      FF00F7FFF700FFFFFF00FFF7F700FFFFFF00FFFFFF00F7FFFF00FFFFFF00FFFF
      F700FFFFF700FFFFFF0052100000000000000000000052100000F7F7F700FFFF
      FF00FFFFFF00F7FFFF00FFF7FF00FFF7FF00FFF7FF00FFFFF700F7FFFF00F7FF
      FF00F7FFFF00F7FFF70052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400840000000000000000000000000000000000000000000000000000008400
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052100000F7FFFF00FFFF
      FF00F7FFF700FFFFFF00FFF7F700FFFFFF00FFFFFF00F7FFFF00FFFFFF00FFFF
      F700FFFFF700FFFFFF0052100000000000000000000052100000F7F7F700FFFF
      FF00FFFFFF00F7FFFF00FFF7FF00FFF7FF00FFF7FF00FFFFF700F7FFFF00F7FF
      FF00F7FFFF00F7FFF70052100000000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000840000008484840000000000000000000000000000000000848484008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000052100000F7FFFF00FFFF
      F700F7FFFF00FFFFF700FFFFF700F7FFFF00F7FFFF00FFFFFF00F7FFF700FFFF
      F700FFFFF700FFF7F70052100000000000000000000052080000F7FFFF00FFFF
      FF00FFF7F700008C0000008C000000840000FFF7FF00F7FFFF00FFFFF700FFF7
      FF00FFF7FF00F7F7FF0052100000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000052100000F7F7F700F7F7
      F700F7F7F700F7F7F700FFF7F700FFFFFF00FFFFFF00FFF7FF00FFFFFF00FFFF
      FF00FFFFFF00F7FFF70052100000000000000000000052100000F7FFFF00FFF7
      F700008C0000008C0000008C0000008C0000008C0000FFF7FF00FFF7FF00FFFF
      FF00FFFFFF00F7FFF70052100000000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000052100000F7F7F700EFF7
      F700F7F7F700EFF7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7FF00F7FF
      F700F7FFF700FFF7FF0052100000000000000000000052100000F7F7F700F7F7
      FF000084000000840000FFFFFF00008C0000008C0000008C0000FFF7FF00F7F7
      FF00F7F7FF00F7FFFF0052100000000000000000000000000000840000008400
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000840000008400000000000000000000000000000052100000F7F7F700EFF7
      F700F7F7F700EFF7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7FF00F7FF
      F700F7FFF700FFF7FF0052100000000000000000000052100000F7F7F700F7F7
      FF0000840000FFF7FF00FFFFFF00FFF7FF00008C0000008C0000008C0000F7F7
      FF00F7F7FF00F7FFFF0052100000000000000000000000000000840000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000840000008484840000000000000000000000000000000000848484008400
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000008400000000000000000000000000000052100000EFEFEF00E7EF
      EF00E7EFEF00EFEFEF00EFEFF700EFEFF700EFEFF700F7F7F700F7F7F700F7F7
      F700F7F7F700FFFFFF0052100000000000000000000052100000E7EFF700EFEF
      EF0000840000F7F7F700F7F7F700FFF7FF00FFF7FF00008C0000008C0000F7FF
      F700F7FFF700FFFFFF0052100000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000848484000000000000000000000000000000000000000000000000008484
      8400840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000052100000E7E7EF00E7E7
      E700E7E7E700E7EFEF00EFEFEF00E7EFEF00E7EFEF00EFEFEF00EFF7EF00F7F7
      F700F7F7F700F7FFFF005210000000000000000000005A100000E7E7E700E7E7
      E700E7E7EF00E7EFEF00EFEFEF00EFEFEF00EFEFEF00F7EFF700008C0000FFF7
      FF00FFF7FF00F7F7F70052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052100000DEE7E700DEE7
      E700DEE7E700E7E7E700E7EFE700E7EFEF00E7EFEF00E7E7EF00EFEFEF00EFEF
      F700EFEFF700EFF7F7005210000000000000000000005A100000D6DEE700DEDE
      DE00D6DEDE00DEE7DE00DEE7E700E7E7E700E7E7E700E7E7EF00EFEFEF00EFF7
      F700EFF7F700F7F7F70052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052100000DEDEE700D6E7
      DE00DEE7E700DEE7E700DEE7E700DEE7E700DEE7E700E7E7E700E7E7EF00EFEF
      EF00EFEFEF00EFF7F7005210000000000000000000005A100000D6DEDE00CEDE
      DE00D6DEDE00D6DEDE00D6DEDE00D6DEE700D6DEE700DEE7DE00E7E7E700E7EF
      E700E7EFE700E7EFEF0052080000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052100000D6E7E700DEDE
      E700DEDEE700DEE7E700DEE7E700DEE7E700DEE7E700E7E7E700DEE7E700E7EF
      EF00E7EFEF00EFEFEF0052100000000000000000000052100000CED6DE00D6D6
      DE00D6D6D600D6D6DE00D6D6DE00D6DEDE00D6DEDE00DEDEDE00DEDEDE00D6E7
      E700D6E7E700E7E7EF0052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052100000521000005210
      0000521000005210000052100000521000005210000052100000521000005210
      00005210000052100000521000000000000000000000521000005A1000005210
      000052100000521000005A100000521000005210000052080000521000005210
      0000521000005210000052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF80018001
      FFFFFFFF80018001FFFFFFFF80018001FFE7E7FF80018001C1F3CF8380018001
      C3FBDFC380018001C7FBDFE380018001CBFBDFD380018001DCF3CF3B80018001
      FF07E0FF80018001FFFFFFFF80018001FFFFFFFF80018001FFFFFFFF80018001
      FFFFFFFF80018001FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object LyricsThread: TBMDThread
    Priority = tpLower
    UpdateEnabled = False
    OnExecute = LyricsThreadExecute
    Left = 536
    Top = 648
  end
  object readFileThread: TBMDThread
    RefreshInterval = 50
    UpdateEnabled = False
    OnExecute = readFileThreadExecute
    Left = 568
    Top = 616
  end
  object IdHttp: TIdHTTP
    MaxLineAction = maSplit
    ReadTimeout = 8000
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
    Left = 536
    Top = 616
  end
  object SaveThread: TBMDThread
    UpdateEnabled = False
    OnExecute = SaveThreadExecute
    Left = 568
    Top = 584
  end
  object timFocusSecondColumn: TTimer
    Enabled = False
    Interval = 50
    OnTimer = timFocusSecondColumnTimer
    Left = 4
    Top = 44
  end
end
