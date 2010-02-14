object CddbForm: TCddbForm
  Left = 314
  Top = 350
  Width = 823
  Height = 570
  Caption = 'CDDB lookup'
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 812
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 815
    Height = 151
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object Tree: TVirtualStringTree
      Left = 0
      Top = 17
      Width = 815
      Height = 117
      Align = alClient
      CheckImageKind = ckXP
      Colors.TreeLineButtonColor = clBlack
      DragMode = dmAutomatic
      DragType = dtVCL
      Header.AutoSizeIndex = -1
      Header.DefaultHeight = 17
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'MS Sans Serif'
      Header.Font.Style = []
      Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
      Header.Style = hsPlates
      HintMode = hmHint
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toDisableDrawSelection, toExtendedFocus, toFullRowSelect]
      OnChecked = TreeChecked
      OnColumnResize = TreeColumnResize
      OnCompareNodes = TreeCompareNodes
      OnDblClick = TreeDblClick
      OnDragAllowed = TreeDragAllowed
      OnDragOver = TreeDragOver
      OnDragDrop = TreeDragDrop
      OnEditing = TreeEditing
      OnFreeNode = TreeFreeNode
      OnGetText = TreeGetText
      OnGetHint = TreeGetHint
      OnHeaderClick = TreeHeaderClick
      OnNewText = TreeNewText
      Columns = <
        item
          Position = 1
          Width = 120
          WideText = 'File'
        end
        item
          Position = 2
          Width = 120
          WideText = 'Title'
        end
        item
          MaxWidth = 40
          Position = 3
          Width = 40
          WideText = 'Track'
        end
        item
          MaxWidth = 48
          MinWidth = 48
          Position = 4
          Width = 48
          WideText = 'Length'
        end
        item
          Color = clSilver
          MaxWidth = 10
          MinWidth = 4
          Options = [coEnabled, coParentBidiMode, coVisible]
          Position = 5
          Width = 4
        end
        item
          MaxWidth = 48
          MinWidth = 48
          Position = 6
          Width = 48
          WideText = 'Length'
        end
        item
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
          Position = 7
          Width = 100
          WideText = 'Artist'
        end
        item
          Position = 9
          Width = 150
          WideText = 'Title'
        end
        item
          MaxWidth = 40
          Position = 8
          Width = 40
          WideText = 'Track'
        end
        item
          Position = 10
          Width = 130
          WideText = 'Comment'
        end
        item
          MaxWidth = 31
          MinWidth = 31
          Position = 0
          Width = 31
          WideText = 'Tag'
        end>
    end
    object Panel2: TPanel
      Left = 0
      Top = 134
      Width = 815
      Height = 17
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object Label5: TLabel
        Left = 8
        Top = 4
        Width = 269
        Height = 13
        Caption = '  Use drag'#39'n'#39'drop to reorder the tracks (hold shift to swap)'
      end
      object SameArtist: TCheckBox
        Left = 320
        Top = 0
        Width = 217
        Height = 17
        Caption = 'All tracks has the same artist'
        TabOrder = 0
        OnClick = SameArtistClick
      end
      object AutoOrderBtn: TButton
        Left = 537
        Top = 0
        Width = 150
        Height = 18
        Caption = 'Auto-order tracks'
        Enabled = False
        TabOrder = 1
        OnClick = AutoOrderBtnClick
      end
      object autoAutoOrder: TCheckBox
        Left = 696
        Top = 0
        Width = 137
        Height = 17
        Caption = ' on every cd-load'
        TabOrder = 2
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 815
      Height = 17
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label1: TLabel
        Left = 8
        Top = 0
        Width = 62
        Height = 13
        Caption = 'Original data:'
      end
      object cddbDataLabel: TLabel
        Left = 384
        Top = 0
        Width = 57
        Height = 13
        Caption = 'CDDB data:'
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 151
    Width = 815
    Height = 392
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    OnResize = Panel4Resize
    object Status: TLabel
      Left = 0
      Top = 363
      Width = 815
      Height = 13
      Align = alBottom
    end
    object QueryGrp: TGroupBox
      Left = 8
      Top = 8
      Width = 521
      Height = 169
      Caption = 'Query '
      TabOrder = 0
      object Label2: TLabel
        Left = 16
        Top = 24
        Width = 193
        Height = 89
        AutoSize = False
        Caption = 
          'CDDB can be queried using the order and length of the tracks.'#13#10'M' +
          'ake sure all tracks are present, and that they are correctly sor' +
          'ted.'
        WordWrap = True
      end
      object Label3: TLabel
        Left = 248
        Top = 24
        Width = 263
        Height = 13
        AutoSize = False
        Caption = 'Search after artists and/or album in the CDDB database'
        WordWrap = True
      end
      object ArtistLabel: TLabel
        Left = 248
        Top = 60
        Width = 23
        Height = 13
        Caption = 'Artist'
      end
      object AlbumLabel: TLabel
        Left = 248
        Top = 92
        Width = 29
        Height = 13
        Caption = 'Album'
      end
      object Bevel1: TBevel
        Left = 232
        Top = 16
        Width = 9
        Height = 121
        Shape = bsLeftLine
      end
      object QueryFakeIdBtn: TButton
        Left = 16
        Top = 112
        Width = 193
        Height = 25
        Caption = 'Search'
        TabOrder = 0
        OnClick = QueryFakeIdBtnClick
      end
      object QueryArtistAlbumBtn: TButton
        Left = 296
        Top = 112
        Width = 193
        Height = 25
        Caption = 'Search'
        TabOrder = 1
        OnClick = QueryArtistAlbumBtnClick
      end
      object ArtistEdit: TEdit
        Left = 296
        Top = 52
        Width = 193
        Height = 21
        TabOrder = 2
      end
      object AlbumEdit: TEdit
        Left = 296
        Top = 84
        Width = 193
        Height = 21
        TabOrder = 3
      end
      object AutoLoadCD: TCheckBox
        Left = 168
        Top = 146
        Width = 209
        Height = 17
        Caption = 'Auto. download best match'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
    end
    object GroupBox1: TGroupBox
      Left = 536
      Top = 8
      Width = 281
      Height = 345
      Caption = 'Search results '
      TabOrder = 1
      object cdTree: TVirtualStringTree
        Left = 8
        Top = 23
        Width = 265
        Height = 116
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
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnChange = cdTreeChange
        OnCompareNodes = cdTreeCompareNodes
        OnFreeNode = cdTreeFreeNode
        OnGetText = cdTreeGetText
        Columns = <>
      end
      object showCorrectTracks: TCheckBox
        Left = 8
        Top = 140
        Width = 265
        Height = 17
        Caption = 'Show only albums with the correct number of tracks'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = showCorrectTracksClick
      end
      object cdInfoPanel: TPanel
        Left = 2
        Top = 168
        Width = 277
        Height = 175
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        Visible = False
        object Label6: TLabel
          Left = 8
          Top = 12
          Width = 60
          Height = 13
          AutoSize = False
          Caption = 'Artist'
        end
        object Label7: TLabel
          Left = 8
          Top = 38
          Width = 60
          Height = 13
          AutoSize = False
          Caption = 'Album'
        end
        object Label8: TLabel
          Left = 8
          Top = 64
          Width = 60
          Height = 13
          AutoSize = False
          Caption = 'Year'
        end
        object Label9: TLabel
          Left = 8
          Top = 88
          Width = 60
          Height = 13
          AutoSize = False
          Caption = 'Genre'
        end
        object Label10: TLabel
          Left = 8
          Top = 114
          Width = 57
          Height = 13
          AutoSize = False
          Caption = 'Ext. data'
        end
        object cddbExt: TLabel
          Left = 64
          Top = 114
          Width = 209
          Height = 55
          AutoSize = False
        end
        object cddbArtist: TEdit
          Left = 64
          Top = 8
          Width = 201
          Height = 21
          TabOrder = 0
        end
        object cddbAlbum: TEdit
          Left = 64
          Top = 34
          Width = 201
          Height = 21
          TabOrder = 1
        end
        object cddbYear: TEdit
          Left = 64
          Top = 60
          Width = 201
          Height = 21
          TabOrder = 2
        end
        object cddbGenre: TEdit
          Left = 64
          Top = 86
          Width = 201
          Height = 21
          TabOrder = 3
        end
      end
    end
    object SaveOptGroupBox: TGroupBox
      Left = 248
      Top = 184
      Width = 281
      Height = 169
      Caption = 'Save options '
      TabOrder = 2
      object Bevel2: TBevel
        Left = 16
        Top = 56
        Width = 249
        Height = 9
        Shape = bsTopLine
      end
      object updateTags: TCheckBox
        Left = 16
        Top = 20
        Width = 121
        Height = 17
        Caption = 'Update ID3 tags'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object saveArtist: TCheckBox
        Left = 16
        Top = 72
        Width = 122
        Height = 17
        Caption = 'Artist'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object saveTitle: TCheckBox
        Left = 144
        Top = 72
        Width = 134
        Height = 17
        Caption = 'Title'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object saveAlbum: TCheckBox
        Left = 16
        Top = 96
        Width = 122
        Height = 17
        Caption = 'Album'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object saveTrack: TCheckBox
        Left = 144
        Top = 96
        Width = 134
        Height = 17
        Caption = 'Track'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object saveComment: TCheckBox
        Left = 144
        Top = 120
        Width = 134
        Height = 17
        Caption = 'Comment'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object saveYear: TCheckBox
        Left = 16
        Top = 120
        Width = 122
        Height = 17
        Caption = 'Year'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object saveGenre: TCheckBox
        Left = 16
        Top = 144
        Width = 122
        Height = 17
        Caption = 'Genre'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
      object saveCompilation: TCheckBox
        Left = 144
        Top = 144
        Width = 129
        Height = 17
        Caption = 'Compilation'
        TabOrder = 8
      end
      object SpecifyTagsBtn: TButton
        Left = 136
        Top = 16
        Width = 113
        Height = 25
        Caption = 'Specify tags...'
        TabOrder = 9
        OnClick = SpecifyTagsBtnClick
      end
    end
    object pbar: TProgressBar
      Left = 0
      Top = 376
      Width = 815
      Height = 16
      Align = alBottom
      Min = 0
      Max = 100
      TabOrder = 3
      Visible = False
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 184
      Width = 233
      Height = 169
      Caption = 'Options '
      TabOrder = 4
      object Label4: TLabel
        Left = 8
        Top = 16
        Width = 139
        Height = 13
        Caption = 'Query Server (freedb / cddb):'
      end
      object Bevel3: TBevel
        Left = 16
        Top = 105
        Width = 201
        Height = 7
        Shape = bsTopLine
      end
      object Label11: TLabel
        Left = 8
        Top = 64
        Width = 199
        Height = 13
        Caption = 'Artist/album search Server (freedb server):'
      end
      object Label12: TLabel
        Left = 24
        Top = 128
        Width = 99
        Height = 13
        Caption = 'artist / title seperator:'
      end
      object Label13: TLabel
        Left = 16
        Top = 112
        Width = 49
        Height = 13
        Caption = 'Advanced'
      end
      object FakeServerEdit: TEdit
        Left = 16
        Top = 32
        Width = 210
        Height = 21
        TabOrder = 0
        Text = 'freedb.org'
      end
      object SearchServerEdit: TEdit
        Left = 15
        Top = 80
        Width = 210
        Height = 21
        TabOrder = 1
        Text = 'freedb.org'
      end
      object artistTitleSep: TEdit
        Left = 152
        Top = 124
        Width = 25
        Height = 21
        TabOrder = 2
        Text = ' / '
      end
      object reparseBtn: TButton
        Left = 24
        Top = 144
        Width = 105
        Height = 18
        Caption = 're-parse'
        TabOrder = 3
        OnClick = reparseBtnClick
      end
      object userBtn: TButton
        Left = 160
        Top = 16
        Width = 65
        Height = 17
        Caption = 'user...'
        TabOrder = 4
        OnClick = userBtnClick
      end
    end
    object Savebtn: TButton
      Left = 536
      Top = 352
      Width = 140
      Height = 25
      Caption = '&Save'
      Enabled = False
      TabOrder = 6
      OnClick = SavebtnClick
    end
    object Button1: TButton
      Left = 672
      Top = 352
      Width = 144
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 1
      TabOrder = 5
    end
  end
  object IdHttp: TIdHTTP
    MaxLineAction = maSplit
    ReadTimeout = 10000
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
    Left = 496
    Top = 600
  end
end
