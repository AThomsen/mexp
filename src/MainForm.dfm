object MainForm: TMainForm
  Left = 778
  Top = 158
  Cursor = crArrow
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'MEXP'
  ClientHeight = 561
  ClientWidth = 756
  Color = clWhite
  Constraints.MinHeight = 275
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poDefault
  Scaled = False
  ShowHint = True
  OnActivate = FormActivate
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnPaint = FormPaint
  OnResize = FormResize
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Icon1: TImage
    Left = 576
    Top = 112
    Width = 32
    Height = 32
    AutoSize = True
    Picture.Data = {
      055449636F6E0000010001001010000000000000680500001600000028000000
      1000000020000000010008000000000000010000000000000000000000000000
      0000000000000000800000000080000080800000000080008000800000808000
      C0C0C000C0DCC000A6CAF00004040400080808000C0C0C001111110016161600
      1C1C1C002222220029292900555555004D4D4D00424242003939390081818100
      8100000000810000818100000000810081008100008181003300000066000000
      99000000CC00000000330000333300006633000099330000CC330000FF330000
      00660000336600006666000099660000CC660000FF6600000099000033990000
      6699000099990000CC990000FF99000000CC000033CC000066CC000099CC0000
      CCCC0000FFCC000066FF000099FF0000CCFF0000000033003300330066003300
      99003300CC003300FF00330000333300333333006633330099333300CC333300
      FF33330000663300336633006666330099663300CC663300FF66330000993300
      339933006699330099993300CC993300FF99330000CC330033CC330066CC3300
      99CC3300CCCC3300FFCC330033FF330066FF330099FF3300CCFF3300FFFF3300
      00006600330066006600660099006600CC006600FF0066000033660033336600
      6633660099336600CC336600FF33660000666600336666006666660099666600
      CC66660000996600339966006699660099996600CC996600FF99660000CC6600
      33CC660099CC6600CCCC6600FFCC660000FF660033FF660099FF6600CCFF6600
      FF00CC00CC00FF00009999009933990099009900CC0099000000990033339900
      66009900CC339900FF00990000669900336699006633990099669900CC669900
      FF339900339999006699990099999900CC999900FF99990000CC990033CC9900
      66CC660099CC9900CCCC9900FFCC990000FF990033FF990066CC990099FF9900
      CCFF9900FFFF99000000CC00330099006600CC009900CC00CC00CC0000339900
      3333CC006633CC009933CC00CC33CC00FF33CC000066CC003366CC0066669900
      9966CC00CC66CC00FF6699000099CC003399CC006699CC009999CC00CC99CC00
      FF99CC0000CCCC0033CCCC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC00
      33FFCC0066FF990099FFCC00CCFFCC00FFFFCC003300CC006600FF009900FF00
      0033CC003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366FF00
      6666CC009966FF00CC66FF00FF66CC000099FF003399FF006699FF009999FF00
      CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCCFF00
      33FFFF0066FFCC0099FFFF00CCFFFF00FF66660066FF6600FFFF66006666FF00
      FF66FF0066FFFF00C1C1C1005F5F5F00777777008686860096969600CBCBCB00
      B2B2B200D7D7D700DDDDDD00E3E3E300EAEAEA00F1F1F100F8F8F800FFFBF000
      A0A0A40080808000FF00000000FF0000FFFF00000000FF00FF00FF0000FFFF00
      FFFFFF0000000000001717171F1F1F00000000000000001E1716ED989892161F
      1F00000000001E7372729D9898989898EB1F0000001E739808727272729D9808
      98EB1F00000072BBFFF172727272F2FF08981F0000734F7208C272727272F1F1
      9898161F00724F4F4F7298C2C298729D9898981F004F4F4F4F72C2FFFFF17272
      9D98983F004F4F4F4F72C2FFFFF172727298981700724F4F4F7298C2C2987272
      7298981700732E5008C272727272C2F09D98921700007298FFF14F4F4F4FF1FF
      089817000000987298504F4F4F4F720898731E0000000098722E4F4F4F505072
      731E0000000000000098724F4F7298001E000000000000000000000000000000
      00000000F81FFFFFE007FFFFC003FFFF8001FFFF8001FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF8001FFFF8001FFFFC003FFFFE007FFFF
      F81FFFFF}
    Transparent = True
    Visible = False
  end
  object pbar: TGauge
    Left = 176
    Top = 312
    Width = 145
    Height = 9
    BackColor = 3223857
    ForeColor = 4210688
    Progress = 50
    ShowText = False
    Visible = False
  end
  object Icon2: TImage
    Left = 616
    Top = 112
    Width = 32
    Height = 32
    AutoSize = True
    Picture.Data = {
      055449636F6E0000010001001010000000000000680500001600000028000000
      1000000020000000010008000000000000010000000000000000000000000000
      0000000000000000800000000080000080800000000080008000800000808000
      C0C0C000C0DCC000A6CAF00004040400080808000C0C0C001111110016161600
      1C1C1C002222220029292900555555004D4D4D00424242003939390081818100
      8100000000810000818100000000810081008100008181003300000066000000
      99000000CC00000000330000333300006633000099330000CC330000FF330000
      00660000336600006666000099660000CC660000FF6600000099000033990000
      6699000099990000CC990000FF99000000CC000033CC000066CC000099CC0000
      CCCC0000FFCC000066FF000099FF0000CCFF0000000033003300330066003300
      99003300CC003300FF00330000333300333333006633330099333300CC333300
      FF33330000663300336633006666330099663300CC663300FF66330000993300
      339933006699330099993300CC993300FF99330000CC330033CC330066CC3300
      99CC3300CCCC3300FFCC330033FF330066FF330099FF3300CCFF3300FFFF3300
      00006600330066006600660099006600CC006600FF0066000033660033336600
      6633660099336600CC336600FF33660000666600336666006666660099666600
      CC66660000996600339966006699660099996600CC996600FF99660000CC6600
      33CC660099CC6600CCCC6600FFCC660000FF660033FF660099FF6600CCFF6600
      FF00CC00CC00FF00009999009933990099009900CC0099000000990033339900
      66009900CC339900FF00990000669900336699006633990099669900CC669900
      FF339900339999006699990099999900CC999900FF99990000CC990033CC9900
      66CC660099CC9900CCCC9900FFCC990000FF990033FF990066CC990099FF9900
      CCFF9900FFFF99000000CC00330099006600CC009900CC00CC00CC0000339900
      3333CC006633CC009933CC00CC33CC00FF33CC000066CC003366CC0066669900
      9966CC00CC66CC00FF6699000099CC003399CC006699CC009999CC00CC99CC00
      FF99CC0000CCCC0033CCCC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC00
      33FFCC0066FF990099FFCC00CCFFCC00FFFFCC003300CC006600FF009900FF00
      0033CC003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366FF00
      6666CC009966FF00CC66FF00FF66CC000099FF003399FF006699FF009999FF00
      CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCCFF00
      33FFFF0066FFCC0099FFFF00CCFFFF00FF66660066FF6600FFFF66006666FF00
      FF66FF0066FFFF00C1C1C1005F5F5F00777777008686860096969600CBCBCB00
      B2B2B200D7D7D700DDDDDD00E3E3E300EAEAEA00F1F1F100F8F8F800FFFBF000
      A0A0A40080808000FF00000000FF0000FFFF00000000FF00FF00FF0000FFFF00
      FFFFFF0000000000000000000000000000000000000000000016ED9898921600
      000000000000007372729D9898989898EB0000000000739808727272729D9808
      98EB0000000072BBFFF172727272F2FF0898000000734F7208C272727272F1F1
      9898160000724F4F4F7298C2C298729D98989800004F4F4F4F72C2FFFFF17272
      9D989800004F4F4F4F72C2FFFFF172727298980000724F4F4F7298C2C2987272
      7298980000732E5008C272727272C2F09D98920000007298FFF14F4F4F4FF1FF
      089800000000987298504F4F4F4F72089873000000000098722E4F4F4F505072
      73000000000000000098724F4F72980000000000000000000000000000000000
      00000000FFFFFFFFF81FFFFFE007FFFFC003FFFFC003FFFF8001FFFF8001FFFF
      8001FFFF8001FFFF8001FFFF8001FFFFC003FFFFC003FFFFE007FFFFF81FFFFF
      FFFFFFFF}
    Transparent = True
    Visible = False
  end
  object tabelpanel: TSpecialPanel
    Left = 48
    Top = 24
    Width = 473
    Height = 257
    BevelOuter = bvNone
    Caption = 'tabelpanel'
    Color = clBlack
    FullRepaint = False
    TabOrder = 0
    InheritedPaint = False
    object tabelpanellow: TSpecialPanel
      Left = 158
      Top = 0
      Width = 315
      Height = 257
      BevelOuter = bvNone
      Color = clBlack
      FullRepaint = False
      TabOrder = 0
      OnCanResize = tabelpanellowCanResize
      InheritedPaint = False
      object TabelScrollV: TWinampScrollVert
        Left = 296
        Top = 24
        Width = 13
        Height = 105
        Color = 4862257
        TabOrder = 5
        OnMouseMove = TabelScrollVMouseMove
        Bitmapped = False
        BM_UpArrowHeight = 0
        TrackbarYpos = 20
        BM_TtrackbarStopFromBottom = 0
        SMin = 0
        SMax = 200
        PageSize = 0
        Position = 10
        ShowSlider = True
        OnScroll = TabelScrollVScroll
        OnGetImage = TreeScrollHGetImage
        Horizontal = False
        PaintLeft = False
        PaintTop = False
        PaintRight = True
        PaintBottom = False
      end
      object WinPlayScrollV: TWinampScrollVert
        Left = 301
        Top = 160
        Width = 13
        Height = 105
        Color = 4862257
        TabOrder = 6
        OnMouseMove = WinPlayScrollVMouseMove
        Bitmapped = False
        BM_UpArrowHeight = 0
        TrackbarYpos = 20
        BM_TtrackbarStopFromBottom = 0
        SMin = 0
        SMax = 200
        PageSize = 0
        Position = 10
        ShowSlider = True
        OnScroll = WinPlayScrollVScroll
        OnGetImage = TreeScrollHGetImage
        Horizontal = False
        PaintLeft = False
        PaintTop = False
        PaintRight = True
        PaintBottom = False
      end
      object TabelScrollH: TWinampScrollVert
        Left = 16
        Top = 104
        Width = 177
        Height = 13
        Color = 4862257
        TabOrder = 7
        OnMouseMove = TabelScrollHMouseMove
        Bitmapped = False
        BM_UpArrowHeight = 0
        TrackbarYpos = 20
        BM_TtrackbarStopFromBottom = 0
        SMin = 0
        SMax = 0
        PageSize = 0
        Position = 0
        ShowSlider = True
        OnScroll = TabelScrollHScroll
        OnGetImage = TreeScrollHGetImage
        Horizontal = True
        PaintLeft = False
        PaintTop = True
        PaintRight = False
        PaintBottom = False
      end
      object Winplaylist: TVirtualStringTreeEx
        Left = 8
        Top = 208
        Width = 241
        Height = 25
        AutoScrollDelay = 300
        AutoScrollInterval = 100
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ClipboardFormats.Strings = (
          'Virtual Tree Data')
        Color = clBlack
        Colors.BorderColor = clWindowText
        Colors.FocusedSelectionColor = clMaroon
        Colors.FocusedSelectionBorderColor = clMaroon
        Colors.HotColor = clBlack
        Colors.UnfocusedSelectionColor = 4210816
        Colors.UnfocusedSelectionBorderColor = 4210816
        Colors.TreeLineButtonColor = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Header.AutoSizeIndex = -1
        Header.DefaultHeight = 17
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.MainColumn = -1
        Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoOwnerDraw]
        Header.PopupMenu = WPcolumnPopup
        Header.Style = hsPlates
        HintAnimation = hatNone
        HintMode = hmHint
        Indent = 0
        Margin = 2
        ParentFont = False
        PopupMenu = Winplaypop
        ScrollBarOptions.ScrollBars = ssNone
        SelectionBlendFactor = 100
        StateImages = tabelImages
        TabOrder = 3
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus, toAutoChangeScale]
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toLevelSelectConstraint, toMultiSelect, toRightClickSelect]
        TreeOptions.StringOptions = []
        OnAfterCellPaint = WinplaylistAfterCellPaint
        OnBeforeItemErase = WinplaylistBeforeItemErase
        OnBeforePaint = WinplaylistBeforePaint
        OnCompareNodes = WinplaylistCompareNodes
        OnDblClick = winplaylistDblClick
        OnDragAllowed = WinPlayListDragAllowed
        OnDragOver = WinPlayListDragOver
        OnDragDrop = WinPlayListDragDrop
        OnFocusChanged = WinplaylistFocusChanged
        OnFreeNode = WinplaylistFreeNode
        OnGetText = WinPlayListGetText
        OnPaintText = WinplaylistPaintText
        OnGetHint = WinplaylistGetHint
        OnGetUserClipboardFormats = tabelGetUserClipboardFormats
        OnHeaderClick = WinplaylistHeaderClick
        OnHeaderDragged = WinplaylistHeaderDragged
        OnHeaderDraw = tabelHeaderDraw
        OnHeaderMouseMove = WinplaylistHeaderMouseMove
        OnHeaderMouseUp = WinplaylistHeaderMouseUp
        OnHotChange = WinplaylistHotChange
        OnKeyDown = winplaylistKeyDown
        OnKeyPress = treeKeyPress
        OnMouseDown = WinplaylistMouseDown
        OnMouseMove = WinplaylistMouseMove
        OnRenderOLEData = tabelRenderOLEData
        OnResize = WinplaylistResize
        OnScroll = WinPlayListScroll
        OnUpdating = treeUpdating
        Columns = <>
      end
      object WPbarLow: TWApanel
        Left = 16
        Top = 244
        Width = 289
        Height = 13
        BevelOuter = bvNone
        Color = 4862257
        FullRepaint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10395294
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnMouseMove = WPbarLowMouseMove
        OnResize = WPbarLowResize
        InheritedPaint = False
        Ext3d = True
        Ext3dWidth = 1
        PaintLeft = False
        PaintTop = True
        PaintRight = True
        PaintBottom = False
        object FileInfoLabel: TLabel
          Left = 0
          Top = 0
          Width = 4
          Height = 13
          Align = alLeft
          Caption = '-'
          Color = 4210816
          ParentColor = False
          Transparent = True
          OnMouseMove = FileInfoLabelMouseMove
        end
        object winplaylistTimeLabel: TLabel
          Left = 285
          Top = 0
          Width = 4
          Height = 12
          Cursor = crArrow
          Hint = 'Clear Playlist'
          Alignment = taRightJustify
          Caption = '-'
          Color = clLime
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          Transparent = True
          Layout = tlCenter
          OnMouseMove = winplaylistTimeLabelMouseMove
        end
        object WinplaylistCurrentTimeLabel: TLabel
          Left = 119
          Top = 1
          Width = 4
          Height = 12
          Cursor = crArrow
          Alignment = taCenter
          Caption = '-'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Transparent = True
          Layout = tlCenter
          OnMouseDown = WinplaylistCurrentTimeLabelMouseDown
          OnMouseMove = WinplaylistCurrentTimeLabelMouseMove
        end
      end
      object filterbar: TWApanel
        Left = 0
        Top = 0
        Width = 315
        Height = 14
        Hint = 'Walla'
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = 'Main list'
        Color = 4862257
        FullRepaint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10395294
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnMouseDown = filterbarMouseDown
        OnResize = filterbarResize
        InheritedPaint = False
        Ext3d = True
        Ext3dWidth = 1
        PaintLeft = False
        PaintTop = True
        PaintRight = True
        PaintBottom = True
        object searchlabel: TLabel
          Left = 48
          Top = 1
          Width = 40
          Height = 12
          Hint = 'Click here to save or load seach strings'
          Caption = 'Search: '
          Color = 8404992
          FocusControl = f0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          PopupMenu = lss
          ShowHint = True
          Transparent = True
          Layout = tlCenter
          OnClick = searchlabelClick
        end
        object grouplabel: TLabel
          Left = 278
          Top = 0
          Width = 37
          Height = 14
          Cursor = crArrow
          Hint = 'Select which groups to show'
          Align = alRight
          Caption = 'Groups '
          Color = 8404992
          FocusControl = f0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          PopupMenu = lss
          ShowHint = True
          Transparent = True
          Layout = tlCenter
          OnMouseDown = grouplabelMouseDown
        end
        object lblMainListCount: TLabel
          Left = 225
          Top = 0
          Width = 65
          Height = 12
          Cursor = crArrow
          Alignment = taRightJustify
          Caption = 'time/filesize'
          Color = clLime
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          Transparent = True
          Layout = tlCenter
        end
        object f0: TEdit
          Left = 88
          Top = -1
          Width = 145
          Height = 12
          Hint = 'Enter search string here. Use quotes, + and - operators'
          AutoSize = False
          BorderStyle = bsNone
          Color = 4862257
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = lss
          ShowHint = True
          TabOrder = 0
          OnChange = f0Change
          OnKeyDown = f0KeyDown
          OnKeyPress = f0KeyPress
        end
      end
      object WPbar: TWApanel
        Left = 0
        Top = 196
        Width = 241
        Height = 13
        Cursor = crVSplit
        BevelOuter = bvNone
        Color = 4862257
        FullRepaint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10395294
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnMouseDown = treeplbarMouseDown
        OnMouseMove = WPbarMouseMove
        OnMouseUp = WPbarMouseUp
        InheritedPaint = False
        Ext3d = True
        Ext3dWidth = 1
        PaintLeft = False
        PaintTop = False
        PaintRight = True
        PaintBottom = True
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 41
          Height = 13
          Align = alLeft
          Caption = ' Playlist'
          Color = 4210816
          ParentColor = False
          Transparent = True
          OnMouseDown = plabel2MouseDown
          OnMouseMove = Label1MouseMove
        end
        object MinimizeWinplay: TLabel
          Left = 222
          Top = 0
          Width = 19
          Height = 13
          Cursor = crArrow
          Hint = 'Hide Quicklist'
          Align = alRight
          Caption = ' 6 '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8421440
          Font.Height = -9
          Font.Name = 'Webdings'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Transparent = True
          Layout = tlBottom
          OnClick = MinimizeWinplayClick
          OnMouseMove = MinimizeWinplayMouseMove
        end
        object ClearButton: TLabel
          Left = 191
          Top = 0
          Width = 31
          Height = 13
          Cursor = crArrow
          Hint = 'Clear Playlist'
          Align = alRight
          Caption = ' Clear '
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Transparent = True
          Layout = tlCenter
          OnMouseDown = ClearButtonMouseDown
          OnMouseMove = ClearButtonMouseMove
        end
      end
      object tabel: TVirtualStringTreeEx
        Left = 8
        Top = 12
        Width = 281
        Height = 83
        AutoScrollDelay = 300
        AutoScrollInterval = 100
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ButtonFillMode = fmShaded
        ClipboardFormats.Strings = (
          'Virtual Tree Data')
        Color = clBlack
        Colors.BorderColor = clWindowText
        Colors.FocusedSelectionColor = clMaroon
        Colors.FocusedSelectionBorderColor = clMaroon
        Colors.GridLineColor = 33023
        Colors.HotColor = clBlack
        Colors.UnfocusedSelectionColor = 4210816
        Colors.UnfocusedSelectionBorderColor = 4210816
        Colors.TreeLineButtonColor = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Header.AutoSizeIndex = -1
        Header.Background = 4862257
        Header.DefaultHeight = 17
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clBlack
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Height = 16
        Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoHotTrack, hoOwnerDraw, hoRestrictDrag, hoShowSortGlyphs, hoVisible, hoFullRepaintOnResize]
        Header.PopupMenu = columnpopup
        Header.Style = hsPlates
        HintAnimation = hatNone
        HintMode = hmHint
        LineStyle = lsSolid
        ParentFont = False
        ScrollBarOptions.AlwaysVisible = True
        ScrollBarOptions.ScrollBars = ssNone
        SelectionBlendFactor = 100
        StateImages = tabelImages
        TabOrder = 2
        TreeOptions.AnimationOptions = [toAnimatedToggle]
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toDisableAutoscrollOnFocus, toAutoChangeScale]
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toLevelSelectConstraint, toMultiSelect, toRightClickSelect]
        TreeOptions.StringOptions = []
        OnAfterCellPaint = tabelAfterCellPaint
        OnBeforeItemErase = tabelBeforeItemErase
        OnBeforePaint = tabelBeforePaint
        OnChange = tabelChange
        OnCompareNodes = tabelCompareNodes
        OnDblClick = TabelDblClick
        OnDragAllowed = tabelDragAllowed
        OnDragOver = tabelDragOver
        OnDragDrop = tabelDragDrop
        OnEditing = tabelEditing
        OnFocusChanged = tabelFocusChanged
        OnFocusChanging = tabelFocusChanging
        OnGetText = tabelGetText
        OnPaintText = tabelPaintText
        OnGetImageIndex = tabelGetImageIndex
        OnGetHint = tabelGetHint
        OnGetPopupMenu = tabelGetPopupMenu
        OnGetUserClipboardFormats = tabelGetUserClipboardFormats
        OnHeaderClick = tabelHeaderClick
        OnHeaderDraw = tabelHeaderDraw
        OnHeaderMouseMove = tabelHeaderMouseMove
        OnHeaderMouseUp = tabelHeaderMouseUp
        OnHotChange = tabelHotChange
        OnInitNode = tabelInitNode
        OnKeyDown = TabelKeyDown
        OnKeyPress = FormKeyPress
        OnMouseDown = TabelMouseDown
        OnMouseMove = tabelMouseMove
        OnMouseUp = tabelMouseUp
        OnNewText = tabelNewText
        OnRenderOLEData = tabelRenderOLEData
        OnResize = tabelResize
        OnScroll = tabelScroll
        OnUpdating = treeUpdating
        Columns = <
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAutoSpring, coAllowFocus]
            Position = 0
            Style = vsOwnerDraw
            WideText = 'File'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus]
            Position = 1
            Style = vsOwnerDraw
            Tag = 1
            WideText = 'Artist'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus]
            Position = 3
            Style = vsOwnerDraw
            Tag = 2
            WideText = 'Title'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus]
            Position = 4
            Style = vsOwnerDraw
            Tag = 3
            WideText = 'Album'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus]
            Position = 5
            Style = vsOwnerDraw
            Tag = 4
            WideText = 'Genre'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
            Position = 6
            Style = vsOwnerDraw
            Tag = 5
            WideText = 'Year'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAutoSpring, coAllowFocus]
            Position = 7
            Style = vsOwnerDraw
            Tag = 6
            WideText = 'Comment'
          end
          item
            Alignment = taRightJustify
            Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
            Position = 8
            Style = vsOwnerDraw
            Tag = 33
            WideText = 'Track'
          end
          item
            Alignment = taRightJustify
            Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
            Position = 9
            Style = vsOwnerDraw
            Tag = 8
            WideText = 'Kbps'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
            Position = 10
            Style = vsOwnerDraw
            Tag = 18
            WideText = 'Khz'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
            Position = 11
            Style = vsOwnerDraw
            Tag = 12
            WideText = 'Channels'
          end
          item
            Alignment = taRightJustify
            Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
            Position = 12
            Style = vsOwnerDraw
            Tag = 9
            WideText = 'Length'
          end
          item
            Alignment = taRightJustify
            Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
            Position = 13
            Style = vsOwnerDraw
            Tag = 17
            WideText = 'File Size'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAutoSpring, coAllowFocus]
            Position = 14
            Style = vsOwnerDraw
            Tag = 10
            WideText = 'Location'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAutoSpring, coAllowFocus]
            Position = 15
            Style = vsOwnerDraw
            Tag = 15
            WideText = 'Groups'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAutoSpring, coAllowFocus]
            Position = 16
            Style = vsOwnerDraw
            Tag = 19
            WideText = 'File path'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAutoSpring, coAllowFocus]
            Position = 17
            Style = vsOwnerDraw
            Tag = 20
            WideText = 'File name'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAutoSpring, coAllowFocus]
            Position = 18
            Style = vsOwnerDraw
            Tag = 60
            WideText = 'Quality'
          end
          item
            Alignment = taCenter
            Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus]
            Position = 19
            Style = vsOwnerDraw
            Tag = 25
            WideText = 'Type'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
            Position = 20
            Style = vsOwnerDraw
            Tag = 30
            WideText = 'Created'
          end
          item
            Position = 21
            Style = vsOwnerDraw
            Tag = 31
            WideText = 'Changed'
          end
          item
            Position = 23
            Style = vsOwnerDraw
            Tag = 26
            WideText = 'Tags'
          end
          item
            Alignment = taCenter
            MinWidth = 20
            Position = 24
            Style = vsOwnerDraw
            Tag = 27
            WideText = 'Lyrics'
          end
          item
            Alignment = taRightJustify
            Position = 25
            Style = vsOwnerDraw
            Tag = 36
            WideText = 'POS'
          end
          item
            Alignment = taCenter
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
            Position = 26
            Style = vsOwnerDraw
            Tag = 37
            WideText = 'Rating'
          end
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
            Position = 2
            Style = vsOwnerDraw
            Tag = 23
            WideText = 'Artist sort order'
          end
          item
            Alignment = taRightJustify
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
            Position = 22
            Style = vsOwnerDraw
            Tag = 28
            WideText = 'Auto-scanned'
          end
          item
            Alignment = taRightJustify
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus]
            Position = 27
            Style = vsOwnerDraw
            Tag = 13
            WideText = 'Playcount'
          end>
      end
      object WinPlayScrollH: TWinampScrollVert
        Left = 32
        Top = 232
        Width = 177
        Height = 13
        Color = 4862257
        TabOrder = 8
        OnMouseMove = WinPlayScrollHMouseMove
        Bitmapped = False
        BM_UpArrowHeight = 0
        TrackbarYpos = 20
        BM_TtrackbarStopFromBottom = 0
        SMin = 0
        SMax = 0
        PageSize = 0
        Position = 0
        ShowSlider = True
        OnScroll = WinPlayScrollHScroll
        OnGetImage = TreeScrollHGetImage
        Horizontal = True
        PaintLeft = False
        PaintTop = True
        PaintRight = False
        PaintBottom = False
      end
    end
    object treepanel: TSpecialPanel
      Left = 0
      Top = 0
      Width = 150
      Height = 257
      BevelOuter = bvNone
      Color = clBlack
      FullRepaint = False
      TabOrder = 1
      OnCanResize = treepanelCanResize
      InheritedPaint = False
      object PlaylistboxScrollV: TWinampScrollVert
        Left = 137
        Top = 96
        Width = 13
        Height = 41
        Color = 4862257
        TabOrder = 5
        Bitmapped = False
        BM_UpArrowHeight = 0
        TrackbarYpos = 20
        BM_TtrackbarStopFromBottom = 0
        SMin = 0
        SMax = 200
        PageSize = 0
        Position = 10
        ShowSlider = True
        OnScroll = PlaylistboxScrollVScroll
        OnGetImage = TreeScrollHGetImage
        Horizontal = False
        PaintLeft = False
        PaintTop = False
        PaintRight = True
        PaintBottom = False
      end
      object plconScrollV: TWinampScrollVert
        Left = 137
        Top = 160
        Width = 13
        Height = 49
        Color = 4862257
        TabOrder = 6
        Bitmapped = False
        BM_UpArrowHeight = 0
        TrackbarYpos = 20
        BM_TtrackbarStopFromBottom = 0
        SMin = 0
        SMax = 200
        PageSize = 0
        Position = 10
        ShowSlider = True
        OnScroll = plconScrollVScroll
        OnGetImage = TreeScrollHGetImage
        Horizontal = False
        PaintLeft = False
        PaintTop = False
        PaintRight = True
        PaintBottom = False
      end
      object treepanellow: TSpecialPanel
        Left = 0
        Top = 0
        Width = 150
        Height = 75
        Align = alTop
        BevelOuter = bvNone
        Color = clBlack
        FullRepaint = False
        TabOrder = 0
        InheritedPaint = False
        object TreeScrollV: TWinampScrollVert
          Left = 137
          Top = 12
          Width = 13
          Height = 50
          Align = alRight
          Color = 4862257
          TabOrder = 2
          Bitmapped = False
          BM_UpArrowHeight = 0
          TrackbarYpos = 20
          BM_TtrackbarStopFromBottom = 0
          SMin = 0
          SMax = 200
          PageSize = 0
          Position = 10
          ShowSlider = True
          OnScroll = TreeScrollVScroll
          OnGetImage = TreeScrollHGetImage
          Horizontal = False
          PaintLeft = True
          PaintTop = False
          PaintRight = False
          PaintBottom = False
        end
        object TreeScrollH: TWinampScrollVert
          Left = 0
          Top = 62
          Width = 150
          Height = 13
          Align = alBottom
          Color = 4862257
          TabOrder = 3
          Bitmapped = False
          BM_UpArrowHeight = 0
          TrackbarYpos = 20
          BM_TtrackbarStopFromBottom = 0
          SMin = 0
          SMax = 0
          PageSize = 0
          Position = 0
          ShowSlider = True
          OnScroll = TreeScrollHScroll
          OnGetImage = TreeScrollHGetImage
          Horizontal = True
          PaintLeft = True
          PaintTop = True
          PaintRight = False
          PaintBottom = False
        end
        object Panel1: TWApanel
          Left = 0
          Top = 0
          Width = 150
          Height = 12
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = 'Tree'
          Color = 4862257
          FullRepaint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10395294
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnMouseDown = Panel1MouseDown
          InheritedPaint = False
          Ext3d = True
          Ext3dWidth = 1
          PaintLeft = True
          PaintTop = True
          PaintRight = False
          PaintBottom = True
          object AllButton: TLabel
            Left = 121
            Top = 0
            Width = 29
            Height = 12
            Cursor = crArrow
            Hint = 'Select the root of the current database'
            Align = alRight
            Caption = '  All   '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -9
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Transparent = True
            Layout = tlCenter
            OnClick = AllButtonClick
          end
          object CollapseButton: TLabel
            Left = 77
            Top = 0
            Width = 44
            Height = 12
            Cursor = crArrow
            Hint = 'Collapse all'
            Align = alRight
            Caption = 'Collapse '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -9
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Transparent = True
            Layout = tlCenter
            OnClick = CollapseButtonClick
          end
        end
        object tree: TVirtualStringTreeEx
          Left = 0
          Top = 12
          Width = 137
          Height = 50
          Align = alClient
          AutoScrollDelay = 300
          AutoScrollInterval = 100
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          CheckImageKind = ckCustom
          ClipboardFormats.Strings = (
            'Virtual Tree Data')
          Color = clBlack
          Colors.BorderColor = clWindowText
          Colors.FocusedSelectionColor = clMaroon
          Colors.FocusedSelectionBorderColor = clMaroon
          Colors.GridLineColor = clRed
          Colors.HotColor = clBlack
          Colors.TreeLineColor = clHighlight
          Colors.UnfocusedSelectionColor = 4210816
          Colors.UnfocusedSelectionBorderColor = 4210816
          Colors.TreeLineButtonColor = clWhite
          CustomCheckImages = imgLstCheckIcons
          DragOperations = [doCopy, doMove, doLink]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 16777088
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Header.AutoSizeIndex = 0
          Header.DefaultHeight = 17
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          Header.PopupMenu = columnpopup
          HintAnimation = hatNone
          HintMode = hmHint
          IncrementalSearch = isVisibleOnly
          Indent = 10
          LineStyle = lsSolid
          Margin = 2
          ParentFont = False
          PopupMenu = treepop
          ScrollBarOptions.ScrollBars = ssNone
          SelectionBlendFactor = 100
          StateImages = TreeImgs
          TabOrder = 1
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoChangeScale]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toWheelPanning, toVariableNodeHeight]
          TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toGhostedIfUnfocused]
          TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
          TreeOptions.StringOptions = []
          OnAfterCellPaint = treeAfterCellPaint
          OnAfterPaint = treeAfterPaint
          OnBeforeItemErase = treeBeforeItemErase
          OnBeforePaint = treeBeforePaint
          OnChange = treeChange
          OnChecked = treeChecked
          OnChecking = treeChecking
          OnCollapsed = treeCollapsed
          OnCompareNodes = treeCompareNodes
          OnDblClick = treeDblClick
          OnDragAllowed = treeDragAllowed
          OnDragOver = treeDragOver
          OnDragDrop = treeDragDrop
          OnEditing = treeEditing
          OnEnter = treeEnter
          OnExpanded = treeCollapsed
          OnFreeNode = treeFreeNode
          OnGetText = treeGetText
          OnPaintText = treePaintText
          OnGetImageIndex = treeGetImageIndex
          OnGetHint = treeGetHint
          OnGetUserClipboardFormats = tabelGetUserClipboardFormats
          OnIncrementalSearch = treeIncrementalSearch
          OnInitNode = treeInitNode
          OnKeyDown = treeKeyDown
          OnKeyPress = treeKeyPress
          OnKeyUp = treeKeyUp
          OnLoadNode = treeLoadNode
          OnMeasureItem = treeMeasureItem
          OnMouseDown = treeMouseDown
          OnNewText = treeNewText
          OnRenderOLEData = tabelRenderOLEData
          OnScroll = treeScroll
          OnUpdating = treeUpdating
          OnGetNodeWidth = treeGetNodeWidth
          Columns = <>
        end
      end
      object plconbar: TWApanel
        Left = 0
        Top = 136
        Width = 153
        Height = 12
        Cursor = crVSplit
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Color = 4862257
        FullRepaint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 15724527
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnMouseDown = treeplbarMouseDown
        OnMouseMove = plconbarMouseMove
        OnMouseUp = plconbarMouseUp
        InheritedPaint = False
        Ext3d = True
        Ext3dWidth = 1
        PaintLeft = True
        PaintTop = True
        PaintRight = False
        PaintBottom = True
        object MinimizeQ2: TLabel
          Left = 134
          Top = 0
          Width = 19
          Height = 12
          Cursor = crArrow
          Hint = 'Hide Quicklist Songs Window'
          Align = alRight
          Caption = ' 5 '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -9
          Font.Name = 'Webdings'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Transparent = True
          Layout = tlBottom
          OnClick = MinimizeQ2Click
        end
        object PLCONlabel: TLabel
          Left = 0
          Top = 0
          Width = 78
          Height = 12
          Align = alLeft
          Caption = ' Quicklist songs'
          Color = 4210816
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10395294
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          OnMouseDown = PLCONlabelMouseDown
          OnMouseMove = PLCONlabelMouseMove
          OnMouseUp = PLCONlabelMouseUp
        end
      end
      object treeplbar: TWApanel
        Left = 0
        Top = 80
        Width = 145
        Height = 13
        Cursor = crVSplit
        BevelOuter = bvNone
        Color = 4862257
        FullRepaint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -9
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnMouseDown = treeplbarMouseDown
        OnMouseMove = treeplbarMouseMove
        OnMouseUp = WPbarMouseUp
        InheritedPaint = False
        Ext3d = True
        Ext3dWidth = 1
        PaintLeft = True
        PaintTop = True
        PaintRight = False
        PaintBottom = True
        object plabel1: TLabel
          Left = 0
          Top = 0
          Width = 47
          Height = 13
          Align = alLeft
          Caption = ' Quicklist'
          Color = 4210816
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10395294
          Font.Height = -9
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          OnMouseDown = plabel1MouseDown
          OnMouseMove = plabel1MouseMove
          OnMouseUp = plabel1MouseUp
        end
        object MinimizeQ1: TLabel
          Left = 126
          Top = 0
          Width = 19
          Height = 13
          Cursor = crArrow
          Hint = 'Hide Quicklist'
          Align = alRight
          Caption = ' 5 '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -9
          Font.Name = 'Webdings'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Transparent = True
          Layout = tlBottom
          OnClick = MinimizeQ1Click
        end
      end
      object playlistbox: TVirtualStringTreeEx
        Left = 0
        Top = 96
        Width = 129
        Height = 41
        AutoScrollInterval = 100
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ClipboardFormats.Strings = (
          'Plain text'
          'Unicode text'
          'Virtual Tree Data')
        Color = clBlack
        Colors.BorderColor = clWindowText
        Colors.FocusedSelectionColor = clMaroon
        Colors.FocusedSelectionBorderColor = clMaroon
        Colors.HotColor = clBlack
        Colors.UnfocusedSelectionColor = 4210816
        Colors.UnfocusedSelectionBorderColor = 4210816
        Colors.TreeLineButtonColor = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
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
        Margin = 2
        ParentFont = False
        PopupMenu = plboxpopup
        ScrollBarOptions.ScrollBars = ssNone
        SelectionBlendFactor = 100
        TabOrder = 3
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoChangeScale]
        TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toDisableDrawSelection, toExtendedFocus, toFullRowSelect, toRightClickSelect]
        OnBeforeItemErase = playlistboxBeforeItemErase
        OnBeforePaint = playlistboxBeforePaint
        OnChange = playlistboxChange
        OnCompareNodes = playlistboxCompareNodes
        OnDblClick = playlistboxDblClick
        OnDragAllowed = playlistboxDragAllowed
        OnDragOver = playlistboxDragOver
        OnDragDrop = playlistboxDragDrop
        OnFreeNode = playlistboxFreeNode
        OnGetText = playlistboxGetText
        OnPaintText = playlistboxPaintText
        OnGetUserClipboardFormats = tabelGetUserClipboardFormats
        OnKeyDown = playlistboxKeyDown
        OnKeyPress = treeKeyPress
        OnRenderOLEData = tabelRenderOLEData
        OnScroll = playlistboxScroll
        OnUpdating = treeUpdating
        Columns = <>
      end
      object plCon: TVirtualStringTreeEx
        Left = 0
        Top = 152
        Width = 137
        Height = 105
        AutoScrollInterval = 100
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ClipboardFormats.Strings = (
          'Plain text'
          'Unicode text'
          'Virtual Tree Data')
        Color = clBlack
        Colors.BorderColor = clWindowText
        Colors.FocusedSelectionColor = clMaroon
        Colors.FocusedSelectionBorderColor = clMaroon
        Colors.HotColor = clBlack
        Colors.UnfocusedSelectionColor = 4210816
        Colors.UnfocusedSelectionBorderColor = 4210816
        Colors.TreeLineButtonColor = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
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
        Margin = 2
        ParentFont = False
        ScrollBarOptions.ScrollBars = ssNone
        SelectionBlendFactor = 100
        TabOrder = 4
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoChangeScale]
        TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMultiSelect, toRightClickSelect]
        OnBeforeItemErase = plConBeforeItemErase
        OnBeforePaint = plConBeforePaint
        OnCompareNodes = plConCompareNodes
        OnDblClick = plconDblClick
        OnDragAllowed = plconDragAllowed
        OnDragOver = plconDragOver
        OnDragDrop = plconDragDrop
        OnFreeNode = plConFreeNode
        OnGetText = plconGetText
        OnPaintText = plConPaintText
        OnGetPopupMenu = plconGetPopupMenu
        OnGetUserClipboardFormats = tabelGetUserClipboardFormats
        OnKeyDown = plconKeyDown
        OnKeyPress = treeKeyPress
        OnRenderOLEData = tabelRenderOLEData
        OnScroll = plConScroll
        OnUpdating = treeUpdating
        Columns = <>
      end
    end
    object TabelBar: TWApanel
      Left = 152
      Top = 0
      Width = 9
      Height = 257
      Cursor = crHSplit
      BevelOuter = bvNone
      Color = 4862257
      FullRepaint = False
      TabOrder = 2
      OnMouseDown = treeplbarMouseDown
      OnMouseMove = TabelBarMouseMove
      OnMouseUp = WPbarMouseUp
      InheritedPaint = False
      Ext3d = True
      Ext3dWidth = 1
      PaintLeft = False
      PaintTop = True
      PaintRight = True
      PaintBottom = True
    end
  end
  object sliderr: TSpecialPanel
    Left = 48
    Top = 412
    Width = 350
    Height = 12
    BevelOuter = bvNone
    Color = clBlack
    UseDockManager = False
    FullRepaint = False
    TabOrder = 1
    Visible = False
    OnMouseDown = sliderrMouseDown
    OnMouseMove = sliderrMouseMove
    OnMouseUp = sliderrMouseUp
    OnPaint = sliderrPaint
    InheritedPaint = False
  end
  object LowerSmallPanel: TWApanel
    Left = 80
    Top = 448
    Width = 113
    Height = 65
    TabOrder = 2
    OnPaint = LowerSmallPanelPaint
    InheritedPaint = False
    Ext3d = False
    Ext3dWidth = 0
    PaintLeft = False
    PaintTop = False
    PaintRight = False
    PaintBottom = False
  end
  object Configmenu: TPopupMenu
    Tag = 9
    Images = imagesMenu
    MenuAnimation = [maNone]
    OnPopup = ConfigmenuPopup
    Left = 432
    Top = 440
    object test2: TMenuItem
      Caption = 'test'
      Visible = False
      OnClick = test2Click
    end
    object xml1: TMenuItem
      Caption = 'xml'
      Visible = False
    end
    object Generalconfiguration1: TMenuItem
      Tag = 1
      Caption = 'Setup'
      ImageIndex = 11
      OnClick = Generalconfiguration1Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object Winamp1: TMenuItem
      Tag = 6
      Caption = 'Show/hide Winamp'
      object ToggleWinamp1: TMenuItem
        Tag = 7
        Caption = 'Main'
        OnClick = ToggleWinamp1Click
      end
      object TogglePlaylist1: TMenuItem
        Tag = 8
        Caption = 'Playlist'
        OnClick = TogglePlaylist1Click
      end
      object ToggleEqulizer1: TMenuItem
        Tag = 9
        Caption = 'Equalizer'
        OnClick = ToggleEqulizer1Click
      end
      object ToggleVideo1: TMenuItem
        Tag = 14
        Caption = 'Video'
        Visible = False
        OnClick = ToggleVideo1Click
      end
      object ToggleMinibrowser1: TMenuItem
        Tag = 13
        Caption = 'Minibrowser'
        OnClick = ToggleMinibrowser1Click
      end
      object StartVISplugin1: TMenuItem
        Tag = 11
        Caption = 'Visualization'
        OnClick = StartVISplugin1Click
      end
      object ShowWinampPreferences1: TMenuItem
        Tag = 10
        Caption = 'Preferences'
        OnClick = ShowWinampPreferences1Click
      end
    end
    object Help1: TMenuItem
      Tag = 2
      Caption = 'Help'
      OnClick = Help1Click
    end
    object Partymode1: TMenuItem
      Caption = 'Party mode'
      OnClick = Partymode1Click
    end
    object aot: TMenuItem
      Tag = 3
      Caption = 'Always on top'
      OnClick = aotClick
    end
    object Undo2: TMenuItem
      Tag = 5
      Caption = 'Undo...'
      OnClick = Undo2Click
    end
    object SaveDatabase1: TMenuItem
      Tag = 12
      Caption = 'Save Database'
      OnClick = SaveDatabase1Click
    end
    object N17: TMenuItem
      Caption = 'Create menufile'
      Visible = False
    end
    object Closewinamp1: TMenuItem
      Tag = 4
      Caption = 'Exit winamp'
      OnClick = Closewinamp1Click
    end
    object test1: TMenuItem
      Caption = 'test'
      Visible = False
      OnClick = test1Click
    end
  end
  object filespopup: TPopupMenu
    Tag = 1
    Images = imagesMenu
    OnPopup = filespopupPopup
    Left = 528
    Top = 112
    object StartSearch1: TMenuItem
      Tag = 1
      Caption = 'Start Search'
      ShortCut = 16397
      Visible = False
      OnClick = StartSearch1Click
    end
    object Play1: TMenuItem
      Tag = 2
      Caption = 'Play'
      Default = True
      ImageIndex = 0
      ShortCut = 13
      OnClick = Play1Click
    end
    object Addtoplaylist1: TMenuItem
      Tag = 3
      Caption = 'Enqueue'
      ImageIndex = 1
      object Enqueue2: TMenuItem
        Tag = 4
        Caption = 'Enqueue'
        Default = True
        ImageIndex = 1
        ShortCut = 45
        OnClick = Addselected1Click
      end
      object Enqueueandplay1: TMenuItem
        Tag = 5
        Caption = 'Enqueue and play'
        ImageIndex = 0
        OnClick = Enqueueandplay1Click
      end
    end
    object Punchin2: TMenuItem
      Tag = 6
      Caption = 'Punch in'
      ImageIndex = 2
      object Punchin3: TMenuItem
        Tag = 7
        Caption = 'Punch in'
        Default = True
        ImageIndex = 2
        ShortCut = 16429
        OnClick = Punchin3Click
      end
      object Punchinandplay2: TMenuItem
        Tag = 8
        Caption = 'Punch in and play'
        ImageIndex = 0
        OnClick = Punchinandplay2Click
      end
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object PlayAll: TMenuItem
      Tag = 17
      Caption = 'Play all'
      ImageIndex = 3
      ShortCut = 32781
      OnClick = Playall1Click
    end
    object Addalltoplaylist1: TMenuItem
      Tag = 18
      Caption = 'Enqueue all'
      ImageIndex = 4
      ShortCut = 32813
      OnClick = Addall1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Refresh1: TMenuItem
      Tag = 16
      Caption = 'Refresh'
      ImageIndex = 10
      ShortCut = 116
      OnClick = Refresh1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Tags1: TMenuItem
      Tag = 20
      Caption = 'Tags'
      ImageIndex = 6
      object EditTagNew: TMenuItem
        Tag = 21
        Caption = 'Edit Tag...'
        Default = True
        ImageIndex = 6
        ShortCut = 32819
        OnClick = EditTagNewClick
      end
      object Cuttag1: TMenuItem
        Tag = 43
        Caption = 'Trim tag...'
        ShortCut = 32820
        OnClick = Cuttag1Click
      end
      object CDDB1: TMenuItem
        Tag = 47
        Caption = 'CDDB lookup...'
        OnClick = CDDB1Click
      end
      object Changetracknumberto1231: TMenuItem
        Tag = 23
        Caption = 'Change track number to 1,2,3...'
        Hint = 
          'Adds track number to every file selected, starting from 1, next ' +
          'selected file is track number 2, next is 3..'
        OnClick = Changetracknumberto1231Click
      end
      object Editcolumn1: TMenuItem
        Tag = 24
        Caption = 'Edit column'
        ShortCut = 113
        OnClick = Editcolumn1Click
      end
      object Editcolumnsequal1: TMenuItem
        Tag = 50
        Caption = 'Edit column (sequentially)'
        ShortCut = 8305
        OnClick = Editcolumnsequal1Click
      end
      object N30: TMenuItem
        Caption = '-'
      end
      object RemoveAutoScannedflag1: TMenuItem
        Tag = 67
        Caption = 'Remove Auto-Scanned flag'
        OnClick = RemoveAutoScannedflag1Click
      end
      object Compilation1: TMenuItem
        Tag = 49
        Caption = 'Compilation'
        ShortCut = 32835
        OnClick = Compilation1Click
      end
      object Groups1: TMenuItem
        Tag = 69
        Caption = 'Groups'
        ImageIndex = 7
      end
      object Rating1: TMenuItem
        Tag = 60
        Caption = 'Rating'
        ImageIndex = 9
        object Notrated1: TMenuItem
          Tag = 61
          Caption = 'Not rated'
          OnClick = Notrated1Click
        end
        object N1Bad1: TMenuItem
          Tag = 62
          Caption = '1'
          OnClick = Notrated1Click
        end
        object N28: TMenuItem
          Tag = 63
          Caption = '2'
          OnClick = Notrated1Click
        end
        object N31: TMenuItem
          Tag = 64
          Caption = '3'
          OnClick = Notrated1Click
        end
        object N41: TMenuItem
          Tag = 65
          Caption = '4'
          OnClick = Notrated1Click
        end
        object N51: TMenuItem
          Tag = 66
          Caption = '5'
          OnClick = Notrated1Click
        end
      end
      object Switch1: TMenuItem
        Tag = 36
        Caption = 'Swap'
        object ArtistTitle1: TMenuItem
          Tag = 37
          Caption = 'Artist <-> Title'
          OnClick = ArtistTitle1Click
        end
        object ArtistAlbum1: TMenuItem
          Tag = 38
          Caption = 'Artist <-> Album'
          OnClick = ArtistAlbum1Click
        end
        object AlbumTitle1: TMenuItem
          Tag = 39
          Caption = 'Album <-> Title'
          OnClick = AlbumTitle1Click
        end
      end
    end
    object File1: TMenuItem
      Tag = 40
      Caption = 'Files'
      ImageIndex = 12
      object UpdateID3tag1: TMenuItem
        Tag = 22
        Caption = 'Reread file-information'
        ShortCut = 8308
        OnClick = UpdateID3tag1Click
      end
      object WriteId3v11: TMenuItem
        Tag = 41
        Caption = 'Write Id3v1'
        OnClick = WriteId3v11Click
      end
      object WriteId3v21: TMenuItem
        Tag = 42
        Caption = 'Write Id3v2'
        OnClick = WriteId3v21Click
      end
      object mniWriteAllSupportedTags: TMenuItem
        Tag = 45
        Caption = 'Write all supported tags'
        ShortCut = 32855
        OnClick = mniWriteAllSupportedTagsClick
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object Explorer1: TMenuItem
        Tag = 54
        Caption = 'Open in Explorer'
        ShortCut = 24645
        OnClick = Explorer1Click
      end
      object Removefromdatabase1: TMenuItem
        Tag = 52
        Caption = 'Remove from database'
        ShortCut = 16430
        OnClick = Removefromdatabase1Click
      end
      object Deletefilefromharddisk1: TMenuItem
        Tag = 26
        Caption = 'Delete files from drive'
        ShortCut = 8238
        OnClick = Deletefilefromharddisk1Click
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object CopyToMyMusic1: TMenuItem
        Tag = 27
        Caption = 'Copy to My Music'
        OnClick = CopyToMyMusic
      end
      object DuplicateWizard1: TMenuItem
        Tag = 48
        Caption = 'Scan for duplicates...'
        OnClick = DuplicateWizard1Click
      end
      object Organizefiles2: TMenuItem
        Tag = 44
        Caption = 'Organize files...'
        ShortCut = 16463
        OnClick = Organizefiles2Click
      end
    end
    object Deletefromplaylist1: TMenuItem
      Tag = 25
      Caption = 'Delete from playlist'
      ShortCut = 46
      OnClick = Deletefromplaylist1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Selectall1: TMenuItem
      Tag = -28
      AutoHotkeys = maAutomatic
      Caption = 'Select all'
      ShortCut = 16449
      Visible = False
      OnClick = Selectall1Click
    end
    object Removeallfilters1: TMenuItem
      Tag = -29
      Caption = 'Remove all filters'
      ShortCut = 16472
      Visible = False
      OnClick = Removeallfilters1Click
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object Savetoplaylist1: TMenuItem
      Tag = 30
      Caption = 'Save list'
      ImageIndex = 13
      object Selected1: TMenuItem
        Tag = 53
        Caption = 'Selected'
        object Addselectedtonewplaylist2: TMenuItem
          Tag = 31
          Caption = 'Add to new playlist'
          OnClick = Addselectedtonewplaylist1Click
        end
        object Addselectedtoexistingplaylist1: TMenuItem
          Tag = 32
          Caption = 'Add to existing playlist'
          OnClick = SaveselectedinPlaylist1Click
        end
        object TabelAddtoquicklist1: TMenuItem
          Tag = 19
          Caption = 'Add to quicklist'
        end
      end
      object All1: TMenuItem
        Tag = 51
        Caption = 'All'
        object Addalltonewplaylist1: TMenuItem
          Tag = 33
          Caption = 'Add to new playlist'
          OnClick = Addalltonewplaylist1Click
        end
        object Addalltoexistingplaylist1: TMenuItem
          Tag = 34
          Caption = 'Add to existing playlist'
          OnClick = Addalltoexistingplaylist1Click
        end
        object SavetoHTML1: TMenuItem
          Tag = 35
          Caption = 'Save to HTML (importable by Excel)'
          OnClick = SavetoHTML1Click
        end
      end
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object Options1: TMenuItem
      Tag = 68
      Caption = 'Options'
      ImageIndex = 11
      object Onlyshowaviablefiles1: TMenuItem
        Tag = 46
        Caption = 'Only show available files'
        OnClick = Onlyshowaviablefiles1Click
      end
      object DblClickoptions1: TMenuItem
        Tag = 10
        Caption = 'DblClick options'
        object Play11: TMenuItem
          Tag = 11
          Caption = 'Play'
          RadioItem = True
          OnClick = menuitembblclick1Click
        end
        object Enqueue1: TMenuItem
          Tag = 12
          Caption = 'Enqueue'
          RadioItem = True
          OnClick = menuitembblclick1Click
        end
        object menuitembblclick1: TMenuItem
          Tag = 13
          Caption = 'Enqueue and play'
          RadioItem = True
          OnClick = menuitembblclick1Click
        end
        object Punchin1: TMenuItem
          Tag = 14
          Caption = 'Punch in'
          RadioItem = True
          OnClick = menuitembblclick1Click
        end
        object Punchinandplay1: TMenuItem
          Tag = 15
          Caption = 'Punch in and play'
          RadioItem = True
          OnClick = menuitembblclick1Click
        end
      end
      object continuousPlay1: TMenuItem
        Tag = 9
        Caption = 'Continuous Play'
        object Enabled1: TMenuItem
          Tag = 55
          Caption = 'Enable/disable'
          OnClick = continuousPlay1Click
        end
        object N27: TMenuItem
          Caption = '-'
        end
        object frommainlist1: TMenuItem
          Tag = 56
          Caption = 'next from main list'
          Checked = True
          GroupIndex = 1
          RadioItem = True
          OnClick = frommainlist1Click
        end
        object randomfrommainlist1: TMenuItem
          Tag = 59
          Caption = 'random from main list'
          GroupIndex = 1
          RadioItem = True
          OnClick = randomfrommainlist1Click
        end
        object randomfromcurrentdatabase1: TMenuItem
          Tag = 57
          Caption = 'random from current database'
          GroupIndex = 1
          RadioItem = True
          OnClick = randomfromcurrentdatabase1Click
        end
        object randomfromallavailabledatabases1: TMenuItem
          Tag = 58
          Caption = 'random from all available databases'
          GroupIndex = 1
          RadioItem = True
          OnClick = randomfromallavailabledatabases1Click
        end
      end
    end
  end
  object lss: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = lssPopup
    Left = 248
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'm3u'
    Filter = 'Winamp Playlist|*.m3u'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 464
    Top = 440
  end
  object OpenDlg: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 192
    Top = 352
  end
  object treepop: TPopupMenu
    Tag = 3
    Images = imagesMenu
    OnPopup = treepopPopup
    Left = 16
    Top = 40
    object Playallsongsinthisfolder1: TMenuItem
      Tag = 1
      Caption = 'Play all songs in this folder'
      ImageIndex = 0
      ShortCut = 16397
      OnClick = Playallsongsinthisfolder1Click
    end
    object Enqueallsongsinthisfolder1: TMenuItem
      Tag = 2
      Caption = 'Enqueue all songs in this folder'
      ImageIndex = 1
      ShortCut = 45
      OnClick = Enqueallsongsinthisfolder1Click
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object Collapseall1: TMenuItem
      Tag = 3
      Caption = 'Collapse all'
      ShortCut = 16451
      OnClick = Collapseall1Click
    end
    object Expandall1: TMenuItem
      Tag = 4
      Caption = 'Expand all'
      ShortCut = 16453
      OnClick = Expandall1Click
    end
    object SelecttherootofthecurrentdatabaseCtrlR1: TMenuItem
      Tag = -5
      Caption = 'Select root'
      ShortCut = 16466
      OnClick = SelecttherootofthecurrentdatabaseCtrlR1Click
    end
    object Selectnoneshowalldatabases1: TMenuItem
      Tag = 6
      Caption = 'Show all databases'
      ShortCut = 16462
      OnClick = Selectnoneshowalldatabases1Click
    end
    object ViewModeMenuItem: TMenuItem
      Tag = 7
      Caption = 'View mode'
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object Showmedia1: TMenuItem
        Tag = 13
        Caption = 'Show location'
        Checked = True
        GroupIndex = 1
        OnClick = Showmedia1Click
      end
      object Showcovers1: TMenuItem
        Caption = 'Show covers'
        GroupIndex = 1
        OnClick = Showcovers1Click
      end
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Updatetree1: TMenuItem
      Tag = 14
      Caption = 'Refresh'
      ImageIndex = 10
      ShortCut = 116
      OnClick = Updatetree1Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object Addplaylist1: TMenuItem
      Tag = 15
      Caption = 'Add playlist'
      OnClick = Addplaylist1Click
    end
    object Deleteplaylist2: TMenuItem
      Tag = 16
      Caption = 'Delete playlist'
      OnClick = Deleteplaylist2Click
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object Databases1: TMenuItem
      Tag = 29
      Caption = 'Databases'
      object Playallsongs1: TMenuItem
        Tag = 30
        Caption = 'Play all songs in all databases'
        OnClick = Playallsongs1Click
      end
      object Playallsongsinselecteddatabase1: TMenuItem
        Tag = 31
        Caption = 'Play all songs in selected database'
        OnClick = Playallsongsinselecteddatabase1Click
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object Scanforchanges1: TMenuItem
        Tag = 28
        Caption = 'Scan for changes'
        OnClick = Scanforchanges1Click
      end
      object Removeselectedfromdatabase1: TMenuItem
        Tag = 32
        Caption = 'Remove selected from database'
        ShortCut = 16430
        OnClick = Removeselectedfromdatabase1Click
      end
      object Rename1: TMenuItem
        Tag = 19
        Caption = 'Rename'
        ShortCut = 113
        OnClick = Rename1Click
      end
      object Propertiesfor1: TMenuItem
        Tag = 20
        Caption = 'Properties...'
        OnClick = Propertiesfor1Click
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object Addlocation1: TMenuItem
        Tag = 17
        Caption = 'Add database...'
        OnClick = Addlocation1Click
      end
      object Deleteselecteddatabase1: TMenuItem
        Tag = 18
        Caption = 'Delete database...'
        OnClick = Deleteselecteddatabase1Click
      end
    end
    object Tagging1: TMenuItem
      Tag = 22
      Caption = 'Tags'
      ImageIndex = 6
      object Edittag1: TMenuItem
        Tag = 23
        Caption = 'Edit tag...'
        ImageIndex = 6
        ShortCut = 32819
        OnClick = Edittag1Click
      end
      object TreeExchangeAristAlbum: TMenuItem
        Caption = 'Tag:'
        OnClick = TreeExchangeAristAlbumClick
      end
      object Trimtag1: TMenuItem
        Tag = 21
        Caption = 'Trim tag...'
        OnClick = Trimtag1Click
      end
      object CDDBlookup1: TMenuItem
        Tag = 8
        Caption = 'CDDB lookup...'
        OnClick = CDDBlookup1Click
      end
    end
    object Files1: TMenuItem
      Tag = 27
      Caption = 'Files'
      ImageIndex = 12
      object Scanforduplicates1: TMenuItem
        Tag = 24
        Caption = 'Scan for duplicates...'
        OnClick = Scanforduplicates1Click
      end
      object Organizefiles1: TMenuItem
        Tag = 25
        Caption = 'Organize files...'
        OnClick = Organizefiles1Click
      end
    end
    object ToggleExpanded1: TMenuItem
      Tag = 26
      Caption = 'Toggle Expanded'
      ShortCut = 13
      Visible = False
      OnClick = ToggleExpanded1Click
    end
    object N32: TMenuItem
      Caption = '-'
    end
    object Reloadcover1: TMenuItem
      Tag = 33
      Caption = 'Reload cover'
      OnClick = Reloadcover1Click
    end
  end
  object plboxpopup: TPopupMenu
    Tag = 4
    Images = imagesMenu
    OnPopup = plboxpopupPopup
    Left = 16
    Top = 152
    object LoadinWinamp1: TMenuItem
      Tag = 1
      Caption = 'Play in Winamp'
      Default = True
      ImageIndex = 0
      OnClick = LoadinWinamp1Click
    end
    object EnqueueinWinamp1: TMenuItem
      Tag = 2
      Caption = 'Enqueue in Winamp'
      ImageIndex = 1
      OnClick = EnqueueinWinamp1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Newplaylist1: TMenuItem
      Tag = 3
      Caption = 'New Quicklist'
      OnClick = Newplaylist1Click
    end
    object Deleteplaylist1: TMenuItem
      Tag = 4
      Caption = 'Delete Quicklist'
      OnClick = Deleteplaylist1Click
    end
    object RenameQuicklist1: TMenuItem
      Tag = 5
      Caption = 'Rename Quicklist'
      OnClick = RenameQuicklist1Click
    end
    object Repairquicklist1: TMenuItem
      Tag = 6
      Caption = 'Repair Quicklist'
      OnClick = Repairquicklist1Click
    end
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '*.html'
    Filter = 'HTML files|*.html'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 128
    Top = 320
  end
  object qlsongspop: TPopupMenu
    Tag = 6
    OnPopup = qlsongspopPopup
    Left = 128
    Top = 280
    object Enqueue3: TMenuItem
      Tag = 12
      Caption = 'Enqueue in Winamp playlist'
      ShortCut = 45
      OnClick = Enqueue3Click
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object MoveUp1: TMenuItem
      Tag = 1
      Caption = 'Move Up'
      OnClick = MoveUp1Click
    end
    object MoveDown1: TMenuItem
      Tag = 2
      Caption = 'Move Down'
      OnClick = MoveDown1Click
    end
    object Delete1: TMenuItem
      Tag = 3
      Caption = 'Delete'
      ShortCut = 46
      OnClick = Delete1Click
    end
    object Doubleclickoptions1: TMenuItem
      Tag = 4
      Caption = 'Doubleclick options'
      object Addentirelistandplayselected1: TMenuItem
        Tag = 5
        Caption = 'Add entire list and play selected'
        RadioItem = True
        OnClick = Addentirelistandplayselected1Click
      end
      object Playselectedsong1: TMenuItem
        Tag = 6
        Caption = 'Play selected song'
        Checked = True
        RadioItem = True
        OnClick = Addentirelistandplayselected1Click
      end
      object Enqueselectedsong1: TMenuItem
        Tag = 7
        Caption = 'Enque selected song'
        RadioItem = True
        OnClick = Addentirelistandplayselected1Click
      end
      object Punchinselected1: TMenuItem
        Tag = 8
        Caption = 'Punch in selected'
        RadioItem = True
        OnClick = Addentirelistandplayselected1Click
      end
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object Refresh3: TMenuItem
      Tag = 9
      Caption = 'Refresh'
      ShortCut = 116
      OnClick = Refresh3Click
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object Sort1: TMenuItem
      Tag = 10
      Caption = 'Sort'
      OnClick = Sort1Click
    end
    object Shuffle1: TMenuItem
      Tag = 11
      Caption = 'Shuffle'
      OnClick = Shuffle1Click
    end
  end
  object filtertimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = filtertimerTimer
    Left = 536
    Top = 16
  end
  object groupmenu: TPopupMenu
    Images = imgLstCheckIcons
    OnPopup = groupmenuPopup
    Left = 592
    Top = 43
    object gmenuitem1: TMenuItem
      Caption = 'gmenuitem'
      OnClick = gmenuitem1Click
    end
  end
  object columnpopup: TPopupMenu
    OnPopup = columnpopupPopup
    Left = 592
    Top = 72
  end
  object slidertimer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = slidertimerTimer
    Left = 400
    Top = 440
  end
  object TopListPop: TPopupMenu
    Tag = 7
    OnPopup = TopListPopPopup
    Left = 160
    Top = 280
    object Playedtimes1: TMenuItem
      Caption = 'Played times'
      Enabled = False
    end
    object Resetcounter1: TMenuItem
      Tag = 1
      Caption = 'Reset counter'
      OnClick = Resetcounter1Click
    end
    object Resetallfiles1: TMenuItem
      Tag = 2
      Caption = 'Reset all files'
      OnClick = Resetallfiles1Click
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object Refresh4: TMenuItem
      Tag = 3
      Caption = 'Refresh'
      ShortCut = 116
      OnClick = Refresh3Click
    end
  end
  object autoresettabel: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = autoresettabelTimer
    Left = 592
    Top = 248
  end
  object global: TPopupMenu
    Tag = 5
    OnPopup = globalPopup
    Left = 8
    Top = 448
    object DeleteWinampPlaylist1: TMenuItem
      Tag = 1
      Caption = 'Delete Winamp Playlist'
      ShortCut = 49240
      OnClick = Clearall1Click
    end
    object Preferences1: TMenuItem
      Tag = 2
      Caption = 'Preferences'
      ShortCut = 16464
      OnClick = Generalconfiguration1Click
    end
    object Clearfilter1: TMenuItem
      Tag = 3
      Caption = 'Clear filter'
      ShortCut = 16465
      OnClick = Removeallfilters1Click
    end
    object Selecttherootofthecurrentdatabase1: TMenuItem
      Tag = 4
      Caption = 'Select the root of the current database'
      ShortCut = 16466
      OnClick = SelecttherootofthecurrentdatabaseCtrlR1Click
    end
    object Selectnone1: TMenuItem
      Tag = 10
      Caption = 'Clear Tree selection'
      ShortCut = 16462
      OnClick = Selectnone1Click
    end
    object Mainlistfocused1: TMenuItem
      Tag = 5
      Caption = 'Focus Main list'
      ShortCut = 117
      OnClick = Mainlistfocused1Click
    end
    object TreeFocused1: TMenuItem
      Tag = 6
      Caption = 'Focus Tree'
      ShortCut = 118
      OnClick = TreeFocused1Click
    end
    object PlaylistFocused1: TMenuItem
      Tag = 7
      Caption = 'Focus Playlist'
      ShortCut = 119
      OnClick = PlaylistFocused1Click
    end
    object QuicklistselectorFocused1: TMenuItem
      Tag = 8
      Caption = 'Focus Quicklist selector'
      ShortCut = 122
      OnClick = QuicklistselectorFocused1Click
    end
    object QuicklistsongsFocused1: TMenuItem
      Tag = 9
      Caption = 'Focus Quicklist songs'
      ShortCut = 123
      OnClick = QuicklistsongsFocused1Click
    end
    object Previous1: TMenuItem
      Caption = 'Previous'
      ShortCut = 16474
      OnClick = Previous1Click
    end
    object Play3: TMenuItem
      Caption = 'Play'
      ShortCut = 16472
      OnClick = Play3Click
    end
    object Pause1: TMenuItem
      Caption = 'Pause'
      ShortCut = 16451
      OnClick = Pause1Click
    end
    object Stop1: TMenuItem
      Caption = 'Stop'
      ShortCut = 16470
      OnClick = Stop1Click
    end
    object Next1: TMenuItem
      Caption = 'Next'
      ShortCut = 16450
      OnClick = Next1Click
    end
  end
  object autoresettree: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = autoresettreeTimer
    Left = 632
    Top = 248
  end
  object Winplaypop: TPopupMenu
    Tag = 2
    Images = imagesMenu
    MenuAnimation = [maTopToBottom]
    OnPopup = WinplaypopPopup
    Left = 528
    Top = 208
    object Play2: TMenuItem
      Tag = 1
      Caption = 'Play'
      ImageIndex = 0
      ShortCut = 13
      OnClick = winplaylistDblClick
    end
    object EnqueueDequeue1: TMenuItem
      Tag = 19
      Caption = 'Enqueue / Dequeue'
      ShortCut = 16453
      OnClick = EnqueueDequeue1Click
    end
    object Punchin4: TMenuItem
      Tag = 38
      Caption = 'Punch in'
      ImageIndex = 2
      ShortCut = 16464
      OnClick = Punchin4Click
    end
    object Moveup2: TMenuItem
      Tag = 3
      Caption = 'Move up'
      OnClick = Moveup2Click
    end
    object Movedown2: TMenuItem
      Tag = 4
      Caption = 'Move down'
      OnClick = Movedown2Click
    end
    object Delete2: TMenuItem
      Tag = 5
      Caption = 'Delete'
      ShortCut = 46
      OnClick = Delete2Click
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object ToggleKill1: TMenuItem
      Tag = 6
      Caption = 'Kill after play'
      ShortCut = 16459
      OnClick = ToggleKill1Click
    end
    object AutosetKillafterplay1: TMenuItem
      Tag = 18
      Caption = 'Auto-set "Kill after play"'
      OnClick = AutosetKillafterplay1Click
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object Sort2: TMenuItem
      Tag = 7
      Caption = 'Sort'
      object ByTitle1: TMenuItem
        Tag = 8
        Caption = 'By Title'
        OnClick = ByTitle1Click
      end
      object Byfilename1: TMenuItem
        Tag = 9
        Caption = 'By filename'
        OnClick = Byfilename1Click
      end
      object Bypathandfilename1: TMenuItem
        Tag = 10
        Caption = 'By path and filename'
        OnClick = Bypathandfilename1Click
      end
    end
    object Shuffle2: TMenuItem
      Tag = 11
      Caption = 'Shuffle'
      OnClick = Shuffle2Click
    end
    object Shuffleselected1: TMenuItem
      Tag = 40
      Caption = 'Shuffle selected'
      OnClick = Shuffleselected1Click
    end
    object Ignoreduplicates1: TMenuItem
      Tag = 16
      Caption = 'Ignore duplicates'
      OnClick = Ignoreduplicates1Click
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object Refresh2: TMenuItem
      Tag = 14
      Caption = 'Refresh'
      ImageIndex = 10
      ShortCut = 116
      OnClick = Refresh2Click
    end
    object Edittag2: TMenuItem
      Tag = 12
      Caption = 'Edit tag'
      ImageIndex = 6
      ShortCut = 32819
      OnClick = Edittag2Click
    end
    object Findindatabase1: TMenuItem
      Tag = 13
      Caption = 'Find in database'
      ShortCut = 32
      OnClick = Findindatabase1Click
    end
    object Openinexplorer1: TMenuItem
      Tag = 39
      Caption = 'Open in Explorer'
      ShortCut = 24645
      OnClick = Openinexplorer1Click
    end
    object Savelist1: TMenuItem
      Tag = 30
      Caption = 'Save list'
      object Selected2: TMenuItem
        Tag = 36
        Caption = 'Selected'
        object Addtonewplaylist2: TMenuItem
          Tag = 31
          Caption = 'Add to new playlist'
          OnClick = Addtonewplaylist2Click
        end
        object Addtoexistingplaylist2: TMenuItem
          Tag = 32
          Caption = 'Add to existing playlist'
          OnClick = Addtoexistingplaylist2Click
        end
        object WinplaylistAddToQuicklist: TMenuItem
          Tag = 17
          Caption = 'Add to Quicklist'
        end
      end
      object All2: TMenuItem
        Tag = 37
        Caption = 'All'
        object Addtonewplaylist1: TMenuItem
          Tag = 33
          Caption = 'Add to new playlist'
          OnClick = Addtonewplaylist1Click
        end
        object Addtoexistingplaylist1: TMenuItem
          Tag = 34
          Caption = 'Add to existing playlist'
          OnClick = Addtoexistingplaylist1Click
        end
        object SaveasQuicklist1: TMenuItem
          Tag = 15
          Caption = 'Save as Quicklist'
          OnClick = SaveasQuicklist1Click
        end
        object SavetoHTMLimportablebyExcel1: TMenuItem
          Tag = 35
          Caption = 'Save to HTML (importable by Excel)'
          OnClick = SavetoHTMLimportablebyExcel1Click
        end
      end
    end
    object Undo1: TMenuItem
      Tag = 2
      Caption = 'Undo'
      ShortCut = 24666
      OnClick = Undo1Click
    end
  end
  object sliderenable: TTimer
    Enabled = False
    OnTimer = sliderenableTimer
    Left = 264
    Top = 480
  end
  object TreeStimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TreeStimerTimer
    Left = 48
    Top = 280
  end
  object TreeImgs: TImageList
    AllocBy = 0
    Left = 240
    Top = 352
  end
  object JvDeviceChanged1: TJvComputerInfoEx
    OnDeviceAdded = JvDeviceChanged1DeviceArrived
    OnDeviceRemoved = JvDeviceChanged1DeviceRemoveCompleted
    Left = 24
    Top = 352
  end
  object ClearPopup: TPopupMenu
    Tag = 8
    OnPopup = ClearPopupPopup
    Left = 344
    Top = 288
    object Clearall1: TMenuItem
      Tag = 1
      Caption = 'Remove all'
      Default = True
      ShortCut = 49240
      OnClick = Clearall1Click
    end
    object ClearSelected1: TMenuItem
      Tag = 2
      Caption = 'Remove Selected'
      ShortCut = 46
      OnClick = ClearSelected1Click
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object Cropselected1: TMenuItem
      Tag = 3
      Caption = 'Crop selected'
      OnClick = Cropselected1Click
    end
    object Clearallbutplaying1: TMenuItem
      Tag = 4
      Caption = 'Remove all but playing'
      OnClick = Clearallbutplaying1Click
    end
    object Cleardupes1: TMenuItem
      Tag = 5
      Caption = 'Remove dupes'
      Enabled = False
      OnClick = Cleardupes1Click
    end
  end
  object DirSpyTimer: TTimer
    Enabled = False
    Interval = 8000
    OnTimer = DirSpyTimerTimer
    Left = 560
    Top = 280
  end
  object AutoscanThread: TBMDThread
    OnExecute = AutoScanThreadExecute
    Left = 560
    Top = 336
  end
  object EditColumnSequalTimer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = EditColumnSequalTimerTimer
    Left = 424
    Top = 352
  end
  object ScanThread: TBMDThread
    Priority = tpLower
    OnExecute = ScanThreadExecute
    Left = 560
    Top = 376
  end
  object showMainFormTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = showMainFormTimerTimer
    Left = 304
    Top = 424
  end
  object WPcolumnPopup: TPopupMenu
    OnPopup = WPcolumnPopupPopup
    Left = 448
    Top = 288
  end
  object SkinFileFind: TJvSearchFiles
    DirOption = doExcludeSubDirs
    Options = [soSearchFiles, soSorted]
    FileParams.SearchTypes = [stFileMask]
    FileParams.FileMasks.Strings = (
      '*.mxs')
    Left = 120
    Top = 384
  end
  object FileFind1: TJvSearchFiles
    Options = [soOwnerData, soSearchFiles]
    ErrorResponse = erIgnore
    FileParams.SearchTypes = [stFileMask, stMinSize]
    FileParams.MinSize = 1
    OnFindFile = FileFind1FindFile
    OnAbort = FileFind1Abort
    Left = 80
    Top = 384
  end
  object QuickListFF: TJvSearchFiles
    DirOption = doExcludeSubDirs
    Options = [soSearchFiles, soSorted]
    ErrorResponse = erIgnore
    FileParams.SearchTypes = [stFileMask]
    FileParams.FileMasks.Strings = (
      '*.m3u')
    Left = 48
    Top = 384
  end
  object DragFF: TJvSearchFiles
    Options = [soSearchFiles, soSorted]
    FileParams.SearchTypes = [stFileMask, stMinSize]
    FileParams.MinSize = 1
    FileParams.FileMasks.Strings = (
      '*.*')
    Left = 160
    Top = 384
  end
  object CreateFileListFF: TJvSearchFiles
    DirOption = doExcludeSubDirs
    FileParams.SearchTypes = [stFileMask]
    Left = 200
    Top = 384
  end
  object FilesInSubdirCountFF: TJvSearchFiles
    DirOption = doExcludeSubDirs
    Options = [soSearchDirs]
    FileParams.SearchTypes = [stFileMask]
    Left = 240
    Top = 384
  end
  object SpyFF: TJvSearchFiles
    FileParams.SearchTypes = [stFileMask]
    Left = 280
    Top = 384
  end
  object coverFF: TJvSearchFiles
    DirOption = doExcludeSubDirs
    Options = [soSearchFiles, soSorted]
    FileParams.SearchTypes = [stFileMask]
    FileParams.FileMasks.Strings = (
      '*.jpg'
      '*.jpeg'
      '*.bmp'
      '*.gif'
      '*.png')
    Left = 320
    Top = 384
  end
  object coverThread: TBMDThread
    Priority = tpLowest
    OnExecute = coverThreadExecute
    Left = 560
    Top = 416
  end
  object tabelImages: TImageList
    AllocBy = 0
    Left = 272
    Top = 352
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000631010006310
      10005A1010006310100063101000631018006310180063101000631018006310
      10006310100063101000631010000000000000000000000000005A1000005210
      0000521000005210000052100000521000005210000052100000521000005A10
      0000521000005210000052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000F7F7
      F700F7F7FF00F7F7F700F7F7F700FFF7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F7006310100000000000000000000000000052100000FFF7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F70052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F7006310100000000000000000000000000052100000F7F7
      F700F7F7F700F7F7F700F7F7FF00FFF7FF00F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F70052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F7006310100000000000000000000000000052100000F7FF
      F700F7F7FF00F7F7F700F7F7F70000840000F7F7F700F7F7F700F7F7F700F7F7
      F700FFF7F700F7F7FF0052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F7006310100000000000000000000000000052100000F7F7
      F700F7F7F700F7F7F700008C0000008C000000840000F7F7F700FFF7F700F7F7
      F700F7F7F700F7F7FF005A100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000F7F7
      F700F7F7F700F7F7F700EFF7F700FFF7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F7006310100000000000000000000000000052100000F7F7
      F700FFF7F700008C0000008C0000008C0000008C0000008C0000F7F7F700F7F7
      F700FFF7F700F7F7F7005A100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000EFEF
      EF00EFEFEF00EFEFF700EFF7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700631010000000000000000000000000005A100000EFF7
      F700EFF7F7000084000000840000FFF7F700008C0000008C0000008C0000F7F7
      F700F7F7FF00F7F7F70052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000E7EF
      EF00E7EFE700E7EFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00F7F7F700EFF7
      F700F7F7F700F7F7F7006310100000000000000000000000000052100000E7EF
      EF00EFEFEF0000840000EFEFF700F7EFF700F7F7F700008C0000008C0000008C
      0000F7F7F700FFF7F70052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000E7E7
      E700DEE7E700DEE7E700E7E7E700E7EFE700E7EFEF00EFEFEF00EFEFEF00EFEF
      EF00F7EFF700F7F7F700631010000000000000000000000000005A100000DEE7
      E700DEE7E700DEE7E700E7E7E700E7E7E700EFEFEF00F7EFF700088C0000008C
      0000F7F7F700F7F7F70052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000D6DE
      E700DEDEDE00DEE7DE00DEE7E700DEE7E700E7E7E700E7E7EF00EFE7EF00E7EF
      EF00E7EFEF00EFEFF700631010000000000000000000000000005A100000D6DE
      DE00D6DEDE00D6DEDE00DEDEDE00DEDEDE00DEE7E700E7E7E700E7E7EF000084
      0000EFEFEF00EFEFEF005A100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000DEDE
      DE00D6DEDE00DEDEDE00DEDEE700DEDEE700DEE7E700DEE7E700E7E7E700E7E7
      E700EFEFEF00EFEFEF00631010000000000000000000000000005A100000D6D6
      DE00CEDED600D6D6D600D6DEDE00D6DEDE00D6DEDE00DEDEDE00DEE7E700DEE7
      E700E7E7E700E7EFEF0052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063101000D6DE
      DE00DEDEE700DEDEE700DEDEE700DEE7DE00DEE7E700DEE7E700DEE7E700E7E7
      EF00E7E7EF00E7EFEF006310100000000000000000000000000052100000CED6
      DE00CED6D600CED6D600D6D6DE00D6D6DE00CEDEDE00D6DEDE00D6DEDE00DEDE
      DE00D6E7E700DEE7EF0052100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000631010006310
      1000631010006310100063101000631010006310100063101000631010006310
      1000631010006310100063101000000000000000000000000000521000005A10
      000052100000521000005A1000005A10000052100000521000005A1000005210
      0000521000005A1000005A100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000C001C00100000000
      C001C00100000000C001C00100000000C001C00100000000C001C00100000000
      C001C00100000000C001C00100000000C001C00100000000C001C00100000000
      C001C00100000000C001C00100000000C001C00100000000C001C00100000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object NextPopUp: TPopupMenu
    Left = 472
    Top = 496
    object Next2: TMenuItem
      Caption = 'Next                                 (Click)'
      OnClick = Next2Click
    end
    object Fastforward5seconds1: TMenuItem
      Caption = 'Fastforward 5 seconds    (Shift + Click)'
      OnClick = Fastforward5seconds1Click
    end
    object Endoflist1: TMenuItem
      Caption = 'End of list                         (Ctrl + Click)'
      OnClick = Endoflist1Click
    end
    object NextinMainlistAltClick1: TMenuItem
      Caption = 'Next in Main list                (Alt + Click)'
      OnClick = NextinMainlistAltClick1Click
    end
  end
  object StopPopup: TPopupMenu
    Left = 440
    Top = 496
    object StopClick1: TMenuItem
      Caption = 'Stop                           (Click)'
      OnClick = StopClick1Click
    end
    object StopwithFadeout1: TMenuItem
      Caption = 'Stop w/ fadeout        (Shift + Click)'
      OnClick = StopwithFadeout1Click
    end
    object Stopaftercurrent1: TMenuItem
      Caption = 'Stop after current     (Ctrl + Click)'
      OnClick = Stopaftercurrent1Click
    end
  end
  object PlayPopUp: TPopupMenu
    Left = 408
    Top = 496
    object Playrestaart1: TMenuItem
      Caption = 'Play/restart           (Click)'
      OnClick = Playrestaart1Click
    end
    object OpenfileCtrlClick1: TMenuItem
      Caption = 'Open file...            (Shift + Click)'
      OnClick = OpenfileCtrlClick1Click
    end
    object OpenlocationShiftClick1: TMenuItem
      Caption = 'Open location...    (Ctrl + Click)'
      OnClick = OpenlocationShiftClick1Click
    end
  end
  object PrevPopUp: TPopupMenu
    Left = 376
    Top = 496
    object PreviousClick1: TMenuItem
      Caption = 'Previous                      (Click)'
      OnClick = PreviousClick1Click
    end
    object Revind5seconds1: TMenuItem
      Caption = 'Revind 5 seconds        (Shift + Click)'
      OnClick = Revind5seconds1Click
    end
    object Startoflist1: TMenuItem
      Caption = 'Start of list                  (Ctrl + Click)'
      OnClick = Startoflist1Click
    end
    object PreviousinMainlistAltClick1: TMenuItem
      Caption = 'Previous in Main list     (Alt + Click)'
      OnClick = PreviousinMainlistAltClick1Click
    end
  end
  object TimerUpdateLblMainlistCount: TTimer
    Enabled = False
    Interval = 5
    OnTimer = TimerUpdateLblMainlistCountTimer
    Left = 480
    Top = 368
  end
  object imagesMenu: TImageList
    Left = 344
    Top = 352
    Bitmap = {
      494C01010E001300040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000069512C00FFC56F00FFC6
      7100FFC77200FFC77200FFC67000FFC46C00FFC26700FFBF5F00FFBB5400FFB5
      4500FFAD3300FFA6200069420700000000000000000069512C00FFC56F00FFC6
      7100FFC77200FFC77200FFC67000FFC46C00FFC26700FFBF5F00FFBB5400FFB5
      4500FFAD3300FFA6200069420700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFC06100FFC266000094
      D0000094D000FFC36900FFC26700FFC16300FFBE5C00FFBA5300FFB64800FFB0
      3900FFA92700FFA31800FF9E0D000000000000000000FFC06100FFC26600FFC3
      6900FFC36A00FFC36900D1A86B00524D4600C69F6400FFBA5300FFB64800FFB0
      3900FFA92700FFA31800FF9E0D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFBA52000094D00072D4
      F90072D4F9000094D0000094D0000094D0000094D000FFB44300FFAF3700FFAA
      2A00FFA41C00FF9F1000FF9D09000000000000000000FFBA5200FFBC5800FFBD
      5B00FFBE5D00EEB66200777065001A1A1A006E675D00E8AC5100FFAF3700FFAA
      2A00FFA41C00FF9F1000FF9D0900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFB13C000094D000B7F0
      FF00B7F0FF005BDBFF005BDBFF005BDBFF0052D6FD000094D0000094D000FFA4
      1B00FFA01100FF9D0A00FF9B05000000000000000000FFB13C00FFB44300FFB5
      4700EFAF4F008F8A81005050500000000000111111006F6B6400E9A23700FFA4
      1B00FFA01100FF9D0A00FF9B0500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFA826000094D0000094
      D000A8E3F60069ECFF0069ECFF0069ECFF0069ECFF0069ECFF0069ECFF000094
      D000FF9D0900FF9B0500FF9A03000000000000000000FFA82600FFAA2B00EEA7
      3B008B857A008A8A8A006D6D6D001C1C1C0000000000080808006B686300EA9B
      2500FF9D0900FF9B0500FF9A0300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFA115000094D0000094
      D00072CCF00092FDFF007AFDFF007AFDFF007AFDFF007AFDFF007AFDFF0082EE
      FF000094D000FF9A0200FF9901000000000000000000FFA11500E69A2800988E
      800041414100646464008E8E8E005454540000000000212121000C0C0C00716C
      6400E3941D00FF9A0200FF990100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF9D0A000094D0004EC0
      F0000094D000D7FFFF00A7FFFF009BFFFF008EFFFF008EFFFF008EFFFF0096F0
      FF000094D000FF990100FF9901000000000000000000FF9D0A007B6F5E005B5B
      5B002A2A2A002727270068686800090909004A4A4A00B1B1B100565656000202
      02005F584D00AC792E00FF990100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF9B04000094D0008BDE
      FD005BDBFF000094D0000094D0000094D000D7F9FD00BBFFFF00B7FFFF00B1F0
      FF00B1F0FF000094D000FF9B05000000000000000000FF9B04001B1B1B000606
      06003C3C3C00484848000B0B0B0041414100BFBFBF00E2E2E200EEEEEE006F6F
      6F00212121001B1B1A00FF9B0500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF9900000094D000A0F2
      FF0071F4FF0071F4FF0071F4FF0071F4FF000094D0000094D0000094D0000094
      D0000094D0000094D000FF9E0C000000000000000000FF990000442900000000
      0000050505001212120043434300BDBDBD00DCDCDC00FBFBFB00FFFFFF00F3F3
      F30045454500120B0100FF9E0C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF9A02000094D000ACF4
      FD007EFFFF007EFFFF009AFFFF00B1FFFF009FFFFF0085FFFF007EFFFF004AB7
      DB00FFA51F00FFA41C00FFA217000000000000000000FF9A0200F29305003E26
      0200000000003A3A3A00C1C1C100D9D9D900FBFBFB00FFFFFF00FFFFFF00AEAE
      AE005C421B00D5891800FFA21700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF9B0600FF9D0A004AB7
      DB00C7FFFF00BFFFFF00BFFFFF004AB7DB004AB7DB004AB7DB004AB7DB004AB7
      DB00FFAE3500FFAC3000FFA929000000000000000000FF9B0600FF9D0A00FD9E
      10003C26050011111100A2A2A200FFFFFF00FFFFFF00FFFFFF00A9A9A900614B
      2A00FEAD3500FFAC3000FFA92900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF9D0A00FFA01100FFA4
      1C004AB7DB004AB7DB004AB7DB00FFB44400FFB74A00FFB94F00FFB95000FFB9
      4F00FFB74C00FFB54700FFB23F000000000000000000FF9D0A00FFA01100FFA4
      1C00FDA827003E2A0C001E1E1E00CDCDCD00FFFFFF00ABABAB00604C2E00FFB9
      4F00FFB74C00FFB54700FFB23F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF9F0F00FFA41B00FFAA
      2A00FFB03900FFB54500FFB95000FFBC5700FFBE5D00FFC06100FFC06200FFC0
      6100FFBF5F00FFBD5A00FFBA53000000000000000000FF9F0F00FFA41B00FFAA
      2A00FFB03900F8B043004834170030303000767676006A563900FFC06200FFC0
      6100FFBF5F00FFBD5A00FFBA5300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000069430900FFA82500FFAF
      3700FFB64800FFBB5400FFBF5E00FFC16400FFC36900FFC46C00FFC56D00FFC5
      6D00FFC36A00FFC26600694F2800000000000000000069430900FFA82500FFAF
      3700FFB64800FFBB5400FFBF5E00FFC16400FFC36900FFC46C00FFC56D00FFC5
      6D00FFC36A00FFC26600694F2800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000001010100020303000405
      050006080800080B0B000A0D0D000A0D0D000A0D0D000A0D0D00090C0C00070A
      0A00050707000304040001020200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000069512C00FFC56F00FFC6
      7100FFC77200FFC77200FFC67000FFC46C00FFC26700FFBF5F00FFBB5400FFB5
      4500FFAD3300FFA620006942070000000000000000006A522E00FFC77300FFC9
      7800FFCB7D00FFCD8100FFCE8300FFCC8100FFCB7D00FFC87500FFC36900FFBC
      5600FFB24000FFA929006B450B00010101000000000069512C00FFC56F00FFC6
      7100FFC77200FFC77200E9B56600BC915000A67E4300BC8D4600E9AB4D00FFB5
      4500FFAD3300FFA6200069420700000000000000000069512C00FEC46F00FEC5
      7100E7B56700C1985B007F633800898989007E7E7E007A746A00D89F4700FFB5
      4500FFAD3300FFA62000694207000000000000000000FFC06100FFC26600FFC3
      6900FEC36A00C49E6400927E60006C665D006C665C00927B5900C4964F00FEB0
      3900FFA92700FFA31800FF9E0D000000000000000000FFC16300FFC56D00FFC8
      7600A9A17800406E7200A9A58200FFD28E00FFD08900D9B97D0070836E009F93
      6000FFB23F00FFA92600FFA114000101010000000000FFC06100F0B76000E1AC
      5D00F0B86400E7B15F008263350001B4B30000B3B30001B3B300825D2500E79F
      3400FFA92700FFA31800FF9E0D000000000000000000FFC06100FEC16600FBC0
      6700E0AC5D00B48C50006A512A009C9C9C0090909000857F7500CD923A00FEAF
      3900FFA92700FFA31800FF9E0D000000000000000000FFBA5200FFBC5800F0B4
      5B005C5D5C005B973B007CC91E00BBEF0900E8EF0900C9B31E0097743B005D5C
      5C00F09E2200FF9F1000FF9D09000000000000000000FFBB5500FFC06300FFC6
      7100406E700000B1DA00006787006988820099A18A0030677300009BBE000080
      A3009F8E5200FFA82700FFA113000101010000000000FFBA5200C18E430044AD
      9300A77C3D007B5C2C0000C2C20000FFFF0000FFFF0000FFFF0000C4C4008257
      1500E8951900FF9F1000FF9D09000000000000000000FFBA5200FCBA5700F3B4
      5700D39E4D00A67E420060472100AEAEAE00A2A2A200928C8200C5872B00F9A6
      2900FEA31C00FF9F1000FF9D09000000000000000000FFB13C00FEB443005C5D
      5C0038AE2E0033FF000068FF0000B1FF0000F7FF0000FFC90000FF790000AE4C
      2E005D5C5C00FE9D0A00FF9B05000000000001010100FFB44300FFBC5700FFC4
      6D005076730000ABD10000D8FF000094B5000069870000C5E30000E0FF000068
      8700CFA55500FFAC2F00FFA216000304040000000000FFB13C009166260000FF
      FF000705020000D0D00000FFFF00105750003F4A2D000D615B0000FFFF0004B6
      B300B1710E00FF9D0A00FF9B05000000000000000000FDB03C00F5AD4000E09F
      3E00B782330086632E004B351400BFBFBF00B4B4B4009E988E00A96F1800E593
      1900F99C1100FE9C0A00FF9B05000000000000000000FFA82600C48E3D003B97
      420000FF05000BFF000033FF00008BFF0000F7FF0000FF9F0000FF3C0000FF0D
      0000973B3D00C4842400FF9A03000000000001020200FFAC3000FFB54600FFC1
      63009F9E7B000085A30000E4FF0000E7FF0000EAFF0000EDFF0000D1EC00205E
      6F00FFBD5900FFAE3400FFA319000406060000000000FFA826008055160000FF
      FF0000DADA0000FFFF00303D2600C1801E00E3951E00C57F16005F3C080000FF
      FF00A9680600FF9B0500FF9A03000000000000000000F8A32500E6992700C283
      240091621C0071583100BBB7B100CECECE00C5C5C500AAA49B00917A5700BB74
      0B00E9900800FB990500FF9A03000000000000000000FFA11500927346001EC9
      480000FF320000FF1F0000FF050033FF0000F7FF0000FF3C0000FF000500FF00
      1D00C91E3D0092703E00FF9901000000000003040400FFA72300FFB03A00FFBD
      5C00798B770000607E0000EDFF0000F4FF0000F7FF0000F4FF0000ADC7006080
      7A00C9A86300FFAF3800FFA31A000608080000000000FFA1150080520C0000FF
      FF0000FFFF0000C2C2004F320700DF8D1200FFA01200FF9F0E00DF890900BD74
      0500DD860300FE990200FF9901000000000000000000F2991400D38714009E65
      100077552300A79D8D00E5E5E500DDDDDD00D4D4D400CBCBCB00AFA99F00997F
      5800C6780300F1920200FF9901000000000000000000FF9D0A006C62540009EF
      730000FF760000FF760000FF760000FF7600FF006E00FF006E00FF006E00FF00
      6E00EF096C006C625300FF9901000000000004050500FFA41A00E9A43600697B
      62000070900000D4F60000EAFF0000F7FF0000FFFF0000F7FF0000EAFF0000A7
      C7000056740089835100FFA41D00070A0A0000000000FF9D0A009F62070000FF
      FF0000FFFF0000FFFF0006E7E300C6790600E38A0500A7660300834F01007C4F
      050097640900DD850100FF9901000000000000000000EC910900C57A09008B60
      1F00B0A49200F5F5F500EFEFEF00E9E9E900E1E1E100D9D9D900D0D0D000B7B0
      A500AA8A5900E1870100FF9901000000000000000000FF9B04006C62530009EF
      A80000FFBD0000FFD10000FFEF0000D4FF000000FF00E100FF00FF00E500FF00
      C500EF09A9006C625400FF9B05000000000004060600FFA21600807C4A000090
      B50000D2FF0000DAFF0000E7FF0000F4FF0000F7FF0000F4FF0000EDFF0000E0
      FF0000C5EC00005F7E00DF9B2900080B0B0000000000FF9B0400DD8703009762
      08007C4D0400834F0100A7640000E3880100C678020006E7E30000FFFF0000FD
      FD0000FCFC009F610400FF9B05000000000000000000EA8E0400C37805007748
      0200F7F7F700F7F7F700F7F7F7008A530100915702005D390100DEDEDE00D6D6
      D600C2B8AA00D6820500FF9B05000000000000000000FF99000092703E001EC9
      B40000FFEF0000FCFF0000D4FF000073FF000000FF007D00FF00E100FF00FF00
      FA00C91EB80092724200FF9E0C000000000004050500FF9E0D00E99D24006976
      5600004E6B00004E6B000057740000EDFF0000EAFF0000A4BE00004E6B00004E
      6B00205C680089824D00FFA61F000608080000000000FF990000FE980100DD85
      0200BD730300DF880500FF9D0900FF9D0B00DF8B0C004F31050000C2C20000FF
      FF0000FFFF0080500700FF9E0C000000000000000000ED8E0000CE820F008550
      0100F7F7F700F7F7F700E4DBCD00BA771500C98F390080500700EAEAEA00E3E3
      E300CFC5B700D9870C00FF9E0C000000000000000000FF9A0200C48424003B97
      960000F3FF0000D4FF00009AFF000048FF000000FF004E00FF00A600FF00E100
      FF00963B9700C48A3300FFA217000000000003040400FF9E0C00FFA21800FFAB
      2E00FFB84D00FFC46D005077750000B2D10000DDFF0000688700CFB67F00FFC3
      6900FFB74D00FFAE3500FFA724000406060000000000FF9A0200FF9B0500A967
      050000FFFF005F3B0600C57C1000E3911600C17D1600303C230000FFFF0000DA
      DA0000FFFF0080520E00FFA217000000000000000000F4940200DF8D1100AA68
      0500F7F7F700F7F7F700E6DDCE00C67E1300D38D23009B651300F4F4F400EEEE
      EE00C6A77800E9961A00FFA217000000000000000000FF9B0600FE9D0A005C5D
      5D002E98AE0000ABFF000073FF000032FF000000FF003600FF007D00FF008A2E
      AE005D5C5D00FEAC3000FFA929000000000001020200FF9D0C00FFA21600FFA8
      2600FFB24000FFBD5A009F996E000081A30000C3EC00205E6E00FFC77300FFC0
      6300FFB95000FFB13D00FFAC30000304040000000000FF9B0600FF9D0A00B170
      0D0004B6B30000FFFF000D615A003F492A001057500000FFFF0000D0D0000705
      020000FFFF0091621B00FFA929000000000000000000FA980600EF940B00D787
      0D00AE6F1000F7F7F700D8C09C00DF962700EB9F2F00C5872A00F7F7F700CDB1
      8800DB963000F9A82F00FFA929000000000000000000FF9D0A00FFA01100F09E
      22005C5C5D003B6D97001E5AC900092BEF000909EF003A1EC9005E3B97005C5C
      5D00F0AF4D00FFB54700FFB23F000000000001010100FF9E0C00FFA11500FFA8
      2600FFB13B00FFB95000DFB26200005F7E000077990089907000FFC56E00FFC1
      6400FFBC5800FFB74C00FFB341000101010000000000FF9D0A00FFA01100E895
      19008256140000C4C40000FFFF0000FFFF0000FFFF0000C2C2007B592700A779
      340044AB8E00C1893600FFB23F000000000000000000FE9C0A00F99C1100F4A6
      3100E99A2300DD962B00E59F3600F6AE4100FAB34900ECAB4900E0A24600E7A8
      4800F9B24B00FFB54700FFB23F000000000000000000FF9F0F00FFA41B00FFAA
      2A00FEB03900C4954D00927B58006C655C006C665C00927D5E00C49C6000FEC0
      6100FFBF5F00FFBD5A00FFBA53000000000000000000FF9F0F00FFA41B00FFAB
      2C00FFB34000FFBA5100FFBF6000DFB56B00AFA07000FFC77200FFC56E00FFC3
      6800FFC06200FFBD5A00FFBA53000000000000000000FF9F0F00FFA41B00FFAA
      2A00E79F3400825C230001B3B30000B3B30001B3B30082623100E7AE5900F0B5
      5B00E1A95400F0B25500FFBA53000000000000000000FF9F0F00FDA21B00FDA9
      2A00FEB03A00FFB64600FFB95000FFBC5700FFBE5D00FFC06100FFC06200FFC0
      6100FFBF5F00FFBD5A00FFBA5300000000000000000069430900FFA82500FFAF
      3700FFB64800FFBB5400FFBF5E00FFC16400FFC36900FFC46C00FFC56D00FFC5
      6D00FFC36A00FFC26600694F2800000000000000000069430900FFA82500FFAF
      3800FFB74B00FFBD5900FFC26500FFC46D00FFC77200FFC77300FFC77200FFC6
      7000FFC36B00FFC26600694F2800000000000000000069430900FFA82500FFAF
      3700FFB64800E9AB4D00BC8D4500A67E4100BC904D00E9B36300FFC56D00FFC5
      6D00FFC36A00FFC26600694F2800000000000000000069430900FFA82500FFAF
      3700FFB64800FFBB5400FFBF5E00FFC16400FFC36900FFC46C00FFC56D00FFC5
      6D00FFC36A00FFC26600694F2800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000010101000102020003040400040505000406060003040400020303000101
      0100010101000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF000000000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000000000BFBFBF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000004050500080B0B000E13
      1300161D1D001D272700232F2F002734340027343400243030001E282800161E
      1E000E131300080B0B000405050000000000BFBFBF00D9D3CA00756C5F001410
      0900141009001410090014100900140F0800140F0800140F0700140F0700140E
      0500140E040075685400D9D0C100BFBFBF0000000000FCFCFC00FCFCFC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000069512C00FFC56F00FFC6
      7100FFC77200DBAF6A00C3B79300FFC46C00FFC26700FFBF5F00FFBB5400FFB5
      4500FFAD3300FFA620006942070000000000030404006E593600FFCA7C00FFCE
      8600FFD38F00FFD69800FFD89C00FFD89D00FFD69A00FFD39100FFCD8200FFC5
      6D00FFB95100FFAE33006E4A120003040400BFBFBF00FFEFD7006D665B000E0B
      06000E0B06000E0B06000E0B06000E0A05000E0A05000E0A04000E0A04000E09
      03000E0902006D635200FFE7C200BFBFBF0000000000EEEEEE00D3D3D300E7E7
      E700FCFCFC000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFC06100FFC26600F9BF
      6800AF94630099B2B700DFFCFF00B6BDAC00FFBE5C00FFBA5300FFB64800FFB0
      3900FFA92700FFA31800FF9E0D0000000000070A0A00FFC56F00FFCC7E00FFD2
      8E00FFD79C00E4C5B200A08ED300A08FD500A08ED300AD98C900E4BFA400FFCB
      7D00FFBE5B00FFB13A00FFA51F0005070700BFBFBF00FFEED4000E0A050000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF00000E090100FFE6C100BFBFBF0000000000FAFAFA00747474005757
      5700A1D1BE00DCDCDC00F3F3F300000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFBA5200FFBC5800CE9E
      5400768A8D00DEFBFE00DFFCFF00DFFCFF00BAC9C100F9B34700FFAF3700FFAA
      2A00FFA41C00FF9F1000FF9D0900000000000D111100FFC46B00FFCC8100FFD5
      9600A08ED1003333FF003333FF003333FF003333FF003333FF003333FF008573
      D400F1BA7700FFB44500FFA92700080B0B00BFBFBF00FFEBCE000E0A040000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF00000E080100FFE6C000BFBFBF000000000000000000DFDFE000549A
      BE0078CFE1009BFBFE00B4C2BA00EBEBEB00FBFBFB0000000000000000000000
      00000000000000000000000000000000000000000000FDB03C00D39C45007986
      7F00D7F4F800DFFCFF00DFFCFF006876FF00C1DAFF00C6DEDE00D5A55200FFA4
      1B00FFA01100FF9D0A00FF9B050000000000141B1B00FFC16400FFCC8000A08A
      CA003333FF003333FF00776FEB00C9B9D800ADA1DF004E4BF7003333FF003333
      FF00C9A19B00FFB84D00FFAA2A000A0E0E00B9B9B900FFE9C9006D6454000E09
      03000E0903000E0903000E0902000E0902000E0902000E0901000E0901000E09
      01000E0800006D624F00FFE6C000B9B9B9000000000000000000FBFBFB00D4D5
      D600509BC10091DBBE0098F28E0098DA9900D0D1D000F7F7F700000000000000
      00000000000000000000000000000000000000000000EF9F27007C704D00CCE9
      EE00DFFCFF00DFFCFF00DFFCFF00DFFCFF000000FF007786FF00DFFCFF00BFA6
      6E00FF9D0900FF9B0500FF9A0300000000001B242400FFBF5E00FFCB7E004E49
      F2003333FF009285DE00FFE4BB00FFE6C100FFE7C200FFE6C0003333FF003333
      FF00C9A29D00FFB95000FFAB2D000C10100091919100FFE7C400F3E1C400EBDB
      C400EBDBC400EBDBC400EBDBC300EBDBC300EBDBC200EBDBC200EBDAC100EBDA
      C000EBDAC000F3DFBF00FFE5BF0091919100000000000000000000000000F8F8
      F8003970A000BDCE8D00ADDD8D0096F48D008CFE8D00C1C5C100EFEFEF00FCFC
      FC000000000000000000000000000000000000000000F49B160068583200CDEA
      EF00C1DAFF007786FF008697FF00DFFCFF00DFFCFF00DFFCFF007786FF00DFFC
      FF00B6B49500FF9A0200FF99010000000000202B2B00FFBD5B00D6AD97003333
      FF003333FF00E4CABE00FFE1B400AD9DD6006962ED006962ED003333FF003333
      FF00C9A29D00FFB95000FFAA2C000D11110060606000FFD59500EAD8BD00BFFF
      BF00BFFFBF00BFFFBF00BFFFBF00BFFFBF00BFFFBF00BFFFBF00BFFFBF00BFFF
      BF00BFFFBF00EAD7BB00FFD39100606060000000000000000000000000000000
      0000DEDEDE00D3B88D00C3C78D00ACDF8D009CEE8D008CFE8D0088C5B900CED6
      D700F8F8F80000000000000000000000000000000000FE9D0A00C07E16003A44
      4000A5C3CB00DFFCFF007786FF00C1DAFF00DFFCFF00DFFCFF00DFFCFF00DFFC
      FF00DFFCFF00BCCABF00F999080000000000222E2E00FFBC5700C9A29F003333
      FF003333FF00FFDFB000FFDFAE00A08FD6003333FF003333FF003333FF003333
      FF00C9A09800FFB74C00FFA92A000C10100033333300FFBB5400D1A96D007FFF
      7F0089FF89008EFF8E008EFF8E008EFF8E008EFF8E008EFF8E008EFF8E0089FF
      89007FFF7F00D1A96D00FFBB5400333333000000000000000000000000000000
      0000FEFEFE00CECBCB00E1A98D00CAC08D00BBCF8D001AD6F2005EBAEE00BB9C
      EA00B8A2DE00D8D8D800F7F7F7000000000000000000FF9B0400FB990500CE83
      0E004B4228007F9CA900DFFCFF007786FF007786FF00DFFCFF00DFFCFF00CAE7
      EC00BDDAE000DFFCFF00B7AA7F0000000000202B2B00FFBA5100C9A09A003333
      FF003333FF00F1D2AF00FFDAA300FFDAA300FFD9A100FFD99F00FFD79B00FFD0
      8900FFC26800FFB44400FFA927000A0D0D0015151500FFA72400DA963300C38E
      3E00C5924500C6944900C6954B00C6954D00C6964E00C6964E00C6964E00C594
      4B00C3914500DA9B3C00FFAC2E00151515000000000000000000000000000000
      000000000000F4F4F400CDB7B600E0AB8D0063CBC90039C2EE00AF85E400B38E
      E700C6C8FE00C6C9FF00D5D5DE000000000000000000FF990000FF990100FF9A
      0200E08C0A00655024005C788600DFFCFF00DFFCFF00DFFCFF00DFFCFF00755C
      2B00353C3600D0EDF200AD8A4900000000001C252500FFB54500FFC369003333
      FF003333FF00AD98C900FFDCA600FFDBA600FFDAA200F1CCA300A089C600AD8F
      B400F1B76C00FFB44300FFA92900070A0A0005050500FF9E0C00D4871300B677
      1900B77A1D00B77B2100B77C2400B77E2600B77F2900B7802B00B7802C00B77F
      2B00B67D2600D48D2500FFA62000050505000000000000000000000000000000
      000000000000FEFEFE00EDEDED00F6948D0024D3ED009772DE00A779E000C6C9
      FF00C2C2FC00BFB9FA00BCB3F7000000000000000000FF9A0200FF9B0500FF9C
      0800FF9E0C00EA9413008964250040545C00C1DEE400DFFCFF00DFFCFF00E4A1
      3800725C2E00D4F1F400E9971A0000000000161D1D00FFB03A00FFBE5B00927A
      C3003333FF00413EF900AD99CD00FFDEAD00E4C6B500776BE0003333FF003333
      FF00E4AE7A00FFB64900FFAB2E000709090000000000FF9B0600B06C070000F0
      FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0
      FF0000F0FF00B0772100FFA92900000000000000000000000000000000000000
      00000000000000000000FEFEFE00CCCACA001AD6F200995CD900C0BDFB00BDB6
      F800B9ACF400B4A3F200B29DF0000000000000000000FF9B0600FF9D0A00FF9F
      1000FFA21700FFA51F00F5A42800B48230003B444000A5C3CB00DFFCFF00DFFC
      FF00DFFCFF00DFFCFF00FFA92900000000000F141400FFAB2E00FFB74B00F1BA
      77005C52E8003333FF003333FF003333FF003333FF003333FF003333FF00A085
      BD00FFC36900FFB95000FFAF39000406060000000000FF9D0A00B06E0C0000F0
      FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0
      FF0000F0FF00B07D3100FFB23F00000000000000000000000000000000000000
      0000000000000000000000000000F4F4F400A8C2C900914DD500B7AAF400B4A3
      F200B09AEE00AC91EB00AA89E9000000000000000000FF9D0A00FFA01100FFA4
      1C00FFA92700FFAD3200FFB13C00FDB34400D19B47004D4D3E007995A2007589
      8C007363400098784100FFB23F0000000000090C0C00FFA72300FFB13C00FFBD
      5A00FFC97700AD92B9007769DD00695FE600695FE6008575D700C9A8AE00FFCD
      8100FFC56E00FFBD5B00FFB649000304040000000000FF9F0F00D1861600B075
      1D00B0792700B07D3000B0803700B0823C00B0834000B0854300B0854400B085
      4300B0844200D19A4A00FFBA5300000000000000000000000000000000000000
      000000000000000000000000000000000000F1F1F100893ED000B098ED00AD92
      EC00A988E900A57FE600A882E2000000000000000000FF9F0F00FFA41B00FFAA
      2A00FFB03900FFB54500FFB95000FFBC5700FFBE5D00E2AE5C00A6875300C6A1
      6100FFBF5F00FFBD5A00FFBA53000000000004060600FFA41C00FFAE3300FFB8
      4E00FFC36800FFCB7C00FFD18C00FFD49300FFD59600FFD49400FFD18C00FFCD
      8100FFC87400FFC26600FFBC5900010202000000000069430900FFA82500FFAF
      3700FFB64800FFBB5400FFBF5E00FFC16400FFC36900FFC46C00FFC56D00FFC5
      6D00FFC36A00FFC26600694F2800000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ECECEC00A57FE500A278
      E2009E70E000AB85E100FCFCFC00000000000000000069430900FFA82500FFAF
      3700FFB64800FFBB5400FFBF5E00FFC16400FFC36900FFC46C00FCC36C00F9C1
      6C00FFC36A00FFC26600694F280000000000010202006C481000FFAC3000FFB6
      4900FFC06100FFC77300FFCD8100FFCF8700FFD18B00FFD08A00FFCF8600FFCC
      7F00FFC77500FFC46C006B522B00010101000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00EBEBEB00B99D
      DF00C3AAE600FEFEFE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000101010003040400070A
      0A000C10100010161600141B1B00161D1D00151C1C00131919000E1313000A0D
      0D00050707000304040001010100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ACACAC00C4C4C400D9D9
      D900EAEAEA00F7F7F700FDFDFD00FEFEFE00FDFDFD00FAFAFA00F0F0F000DFDF
      DF00CBCBCB00B5B5B5009C9C9C0000000000000000000A0A0A000C0C0C000D0D
      0D000F0F0F001010100010101000101010001010100010101000101010000F0F
      0F000D0D0D000C0C0C000A0A0A00000000000000000091919100BBBBBB00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BBBBBB0091919100000000000000000069512C00FFC56F00FFC6
      7100FFC77200FFC77200FFC67000FFC46C00FFC26700FFBF5F00FFBB5400FFB5
      4500FFAD3300FFA620006942070000000000A0A0A000D8D1C800756E64001410
      0900141009001410090014100900140F0800140F0800140F0700140F0700140E
      0500140E040075685600CDC0AC008D8D8D00151515007E6A4A00B090600000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000B07E34007E5D2A001515150091919100D9D3CA00FFF0DB00FFF1
      DB00FFF1DC00FFF1DC00FFF1DB00FFF0DA00FFF0D900FFEFD700FFEED400FFEC
      D000FFEACC00FFE9C700D9D0C1009191910000000000FFC06100FFC26600FFC3
      6900FFC36A00FFC36900FFC26700FFC16300FFBE5C00FFBA5300FFB64800FFB0
      3900FFA92700FFA31800FF9E0D0000000000A8A8A800FFF1DB00140F080000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000140D0200FFE2B6009494940033333300FFD49300B098730000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000B08B5400FFBD5A0033333300B9B9B900FFEFD700756C5E00140F
      0800140F0800140F0800140F0800140F0800140F0700140F0700140E0600140E
      0400140D030075675200FFE7C200B9B9B90000000000FFBA5200FFBC5800FFBD
      5B00FFBE5D00FFBE5C005D4828006E532900FFB84D00FFB44300FFAF3700FFAA
      2A00FFA41C00FF9F1000FF9D090000000000AAAAAA00FFF0D900140F070000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000140C0100FFE2B7009696960060606000FFE1B400D1C2AC00B0A4
      9400B0A59400B0A59400B0A49300B0A49200B0A49100B0A39000B0A28D00B0A2
      8B00B0A08900D1BB9C00FFD5950060606000BFBFBF00FFEED400140F070000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000140C0100FFE6C100BFBFBF0000000000FFB13C00FFB44300FFB5
      4700FFB64800FFB64800080705004C4841006E4E1D00FFAC2F00FFA82500FFA4
      1B00FFA01100FF9D0A00FF9B050000000000A6A6A600FFECD000756D6100140E
      0600140E0600140E0600140E0500140E0500140E0400140D0400140D0300140D
      0200140D010075685500FFE0B2009292920091919100FFEBCE00FFECD000FFEC
      D100FFEDD100FFEDD100FFECD000FFECCF00FFEBCD00FFEACB00FFE9C800FFE8
      C600FFE7C300FFE6C200FFE6C00091919100BFBFBF00FFEBCE00140E050000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000140C0100FFE6C000BFBFBF0000000000FFA82600FFAA2B00FFAC
      2F00FFAC3000FFAC300008070400F6F6F6004C473F005D401500FA9E1500FF9F
      0F00FF9D0900FF9B0500FF9A0300000000009C9C9C00FFE6C200F7EAD600F7F2
      E900FDFBF900FFFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFDFC00F9F5
      EE00F3E9D900F4DFC100FFDBA60089898900B9B9B900FFE9C900605546000E09
      03000E0903000E0903000E0903000E0902000E0902000E0901000E0901000E08
      01000E08010060534100FFE6C000B9B9B900BFBFBF00FFE9C90075685500140D
      0400140D0400140D0400140D0400140D0300140D0300140D0200140D0200140C
      0100140C010075664F00FFE6C000BFBFBF0000000000FFA11500FFA31800FFA3
      1A00FFA41B00FFA31A0008060400F6F6F600FFFFFF006E6B67004C351200FA99
      0700FF9B0400FF9A0200FF990100000000008D8D8D00FFDEAD00EADAC000D0FF
      D000E1FFE100EFFFEF00F7FFF700FAFFFA00F8FFF800F3FFF300E7FFE700D7FF
      D700C3FFC300E6D0AE00FFD595007C7C7C00BFBFBF00FFE7C4000E09010000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF00000E080000FFE5BF00BFBFBF00BFBFBF00FFE7C40075675200140D
      0200140D0200140D0200140D0200140D0200140D0100140C0100140C0100140C
      0100140C000075664F00FFE5BF00BFBFBF0000000000FF9D0A00FF9D0B00FF9E
      0C00FF9E0C00FF9E0C0008060400F6F6F600FFFFFF00FFFFFF006E6B67004C34
      0F00FF990000FF990100FF9901000000000079797900FFD49300E2C9A500B4FF
      B400C3FFC300CEFFCE00D6FFD600D9FFD900D8FFD800D2FFD200C7FFC700B9FF
      B900A9FFA900DEC29600FFCD81006B6B6B00BFBFBF00FFE6C2000E08010000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF00000E080000FFE5BF00BFBFBF00BFBFBF00FFE6C200140C010000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000140C0000FFE5BF00BFBFBF0000000000FF9B0400FF9B0400FF9B
      0400FF9A0300FF9A020008060400F6F6F600FFFFFF00FFFFFF00D4D4D4002A1F
      0F00FF9B0600FF9B0600FF9B05000000000064646400FFC97800E9C28700DEC1
      9600E2C8A200E5CEAB00E7D1B100E8D3B400E7D3B400E6D0AF00E3CBA600DFC4
      9B00DBBC8E00E7BD7F00FFC56E0058585800B9B9B900FFE6C000605341000E08
      00000E0800000E0800000E0800000E0800000E0800000E0800000E0800000E08
      00000E08000060534100FFE6C000B9B9B900BFBFBF00FFE6C000140C000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000140C0000FFE6C000BFBFBF0000000000FF990000FF990100FF9A
      0200FF9B0400FF9B060008060400F6F6F600FFFFFF00D4D4D40019130B00E991
      0F00FF9F0F00FF9F0E00FF9E0C000000000050505000FFBF5E00E4B36B00D5AF
      7700D8B58100DAB98900DCBD9000DCBE9300DCBF9200DBBC8F00D9B88800D5B3
      7F00D2AD7500E3B26900FFBE5C004646460091919100FFE5BF00D1BB9C00B09F
      8500B09F8500B09F8500B09F8500B09F8600B09F8700B09F8700B09F8700B09F
      8700B09F8700D1BDA000FFE7C20091919100BFBFBF00FFE5BF0075654F00140C
      0000140C0000140C0000140C0100140C0100140C0100140C0100140C0100140C
      0100140C010075665100FFE7C200BFBFBF0000000000FF9A0200FF9B0500FF9C
      0800FF9E0C00FF9F100008060400F6F6F6006E6B68002A201100E9991F00FFA6
      2100FFA51F00FFA41C00FFA21700000000003C3C3C00FFB64800C99A530059FF
      590061FF610067FF67006BFF6B006CFF6C006BFF6B0068FF680063FF63005CFF
      5C0054FF5400C79A5700FFB951003535350060606000FFD39200B09D820000F0
      FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0
      FF0000F0FF00B09F8600FFD79B0060606000BFBFBF00FFE6C00075664F00140C
      0100140C0100140C0100140D0200140D0200140D0200140D0300140D0300140D
      0300140D020075675300FFE8C500BFBFBF0000000000FF9B0600FF9D0A00FF9F
      1000FFA21700FFA51F00080704006E6B68004C381B00FAAC3600FFAF3800FFAF
      3800FFAE3500FFAC3000FFA92900000000002B2B2B00FFAF3800C28D3F0040FF
      400046FF46004AFF4A004DFF4D004EFF4E004EFF4E004BFF4B0047FF470042FF
      42003CFF3C00C0934F00FFB950002626260033333300FFBB5500B0894E0000F0
      FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0
      FF0000F0FF00B08F5D00FFC46D0033333300BFBFBF00FFE6C100140C010000F0
      FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0
      FF0000F0FF00140D0400FFE9C900BFBFBF0000000000FF9D0A00FFA01100FFA4
      1C00FFA92700FFAD32003B2E1A004C3A1F00FAB34900FFB94F00FFB95000FFB9
      4F00FFB74C00FFB54700FFB23F00000000001D1D1D00FFAA2B00D8963300BD89
      3B00BF8E4500BF924E00C0955500C0975A00C0995D00C0995F00BF985D00BE96
      5A00BD935500D7A35600FFBB56001919190015151500FFAB2D00D1933400B080
      3900B0854200B0874900B0894F00B08B5300B08C5600B08D5800B08D5800B08C
      5600B08A5200D1A05800FFBD5A0015151500BFBFBF00FFE6C200140D010000F0
      FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0FF0000F0
      FF0000F0FF00140E0600FFECCF00BFBFBF0000000000FF9F0F00FFA41B00FFAA
      2A00FFB03900FFB54500FFB95000FFBC5700FFBE5D00FFC06100FFC06200FFC0
      6100FFBF5F00FFBD5A00FFBA53000000000011111100FFA72300D5912C00B884
      3500B9884000BA8D4900BA905000BA925500BA935900BA945B00B9935A00B992
      5800B8905500D5A35A00FFBF5F000F0F0F0005050500FFA31800D18A2100B079
      2800B07E3300B0823B00B0844200B0864600B0874B00B0894D00B0894D00B088
      4D00B0874A00D19E5200FFBD5A0005050500B9B9B900FFE7C30075675300140D
      0300140E0400140E0500140F0600140F0700140F0700140F0800140F0800140F
      0800140F0700756B5C00FFEED400B9B9B9000000000069430900FFA82500FFAF
      3700FFB64800FFBB5400FFBF5E00FFC16400FFC36900FFC46C00FFC56D00FFC5
      6D00FFC36A00FFC26600694F280000000000090909006F4B1400B47B25000EFF
      0E000FFF0F0010FF100011FF110011FF110011FF110011FF110010FF10000EFF
      0E000DFF0D00B38B4E006E553000070707000000000069430900B0741A0000FF
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF0000B0864600694F28000000000091919100D9D0C100FFE9C800FFEB
      CD00FFEDD100FFEED400FFEFD700FFEFD800FFF0D900FFF0DA00FFF0DA00FFF0
      DA00FFF0DA00FFF0D900D9D3C900919191000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000004040400050505000505
      0500060606000606060007070700070707000707070006060600060606000606
      0600050505000404040003030300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000091919100BBBBBB00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BBBBBB009191910000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080018001000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800180010000000080018001800180010000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000080018001800180018001FFFF8001800100009FFF00000000
      000087FF00000000000081FF000000000000C07F000000000000C03F00000000
      0000E00F000000000000F007000000000000F001000000000000F80100000000
      0000F801000000000000FC01000000000000FE01000000000000FF0100000000
      0000FF81000000008001FF838001800180018001800180010000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800180018001800100000000000000000000000000000000
      000000000000}
  end
  object CoverLoadThread: TBMDThread
    Priority = tpLower
    OnExecute = CoverLoadThreadExecute
    Left = 608
    Top = 336
  end
  object TreeDropPopup: TPopupMenu
    OnPopup = TreeDropPopupPopup
    Left = 88
    object Set1: TMenuItem
      Caption = 'Set'
      OnClick = Set1Click
    end
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
      OnClick = Remove1Click
    end
    object N29: TMenuItem
      Caption = '-'
    end
    object Cancel1: TMenuItem
      Caption = 'Cancel'
      OnClick = Cancel1Click
    end
  end
  object timTreeSelectionChanged: TTimer
    Enabled = False
    Interval = 1
    OnTimer = timTreeSelectionChangedTimer
    Left = 16
    Top = 80
  end
  object imgLstCheckIcons: TImageList
    Left = 8
    Top = 8
    Bitmap = {
      494C010119001D00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000008000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00B8C4CA00B8C4
      CA00B8C4CA00B8C4CA00B8C4CA00B8C4CA00B8C4CA00B8C4CA00B8C4CA00B8C4
      CA00B8C4CA00B8C4CA00B8C4CA00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00C9D3D900DDE7
      EB00E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2
      F600E9F2F600E1EBEF00C9D3D900B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00E1EBEF00E9F2
      F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2
      F600E9F2F600E9F2F600E1EBEF00B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F600B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F600E9F2F6009A9A9A00E9F2F600E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F600B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F6009A9A9A009A9A9A009A9A9A00E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F600B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00E9F2F600E9F2
      F600E9F2F600E9F2F6009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A00E9F2
      F600E9F2F600E9F2F600E9F2F600B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00E9F2F600E9F2
      F600E9F2F6009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A00E9F2F600E9F2F600E9F2F600B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00E9F2F600E9F2
      F6009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A00E9F2F600E9F2F600B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F600B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2
      F600E9F2F600E9F2F600E9F2F600B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00DDE7EB00E9F2
      F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2
      F600E9F2F600E9F2F600DDE7EB00B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B8C4CA00C9D3D900DDE7
      EB00E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2F600E9F2
      F600E9F2F600E1EBEF00C9D3D900B8C4CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00B8C4CA00B8C4
      CA00B8C4CA00B8C4CA00B8C4CA00B8C4CA00B8C4CA00B8C4CA00B8C4CA00B8C4
      CA00B8C4CA00B8C4CA00B8C4CA00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E1D9ED005F8C7900236F
      4C00066237000662370006623700066237000662370006623700066237000662
      37000662370018694400588A7400EEF4FA0000000000ECD8DF005F8C7900236F
      4C00066237000662370006623700066237000662370006623700066237000662
      37000662370018694400588A7400F8F1F30000000000E1D9ED005F8C7900236F
      4C00066237000662370006623700066237000662370006623700066237000662
      37000662370018694400588A7400EEF4FA0000000000A8B7B900AAB7B900ABB8
      BA00A9B8BA00A8B7B900AAB7B900A9B6B800A8B7B900A9B8BB00AAB7B900ABB8
      BA00A8B7B900A8B7B9000000000000000000000000004E836C00447D630098B2
      C700B8D1E300B8D1E300B8D1E300B8D1E300B8D1E300B8D1E300B8D1E300B7D1
      E200B6D0E200A4B1C900427C610055887200000000004E836C00756475002572
      CF002572CF002572CF002572CF002572CF002572CF002572CF002572CF002572
      CF002572CF002572CF007262730055887200000000004E836C0047826600A6CB
      D800E2F3F600E4F4F800E4F4F800E4F4F800E4F4F800E4F4F800E4F4F800E4F5
      F800E5F5F800BEDAE400488469005588720000000000A7B6B800E2EFF100E3EF
      F100E1EEF000E1EEF000E1EDEF00E2EFF100E1EEF000E1EEF000E2EEF000E2EE
      F000E3F0F200A9B6B80000000000000000000000000018694400B3C8D700C9E1
      EC00C8E0EA00C8E0EB00C9E1EC00C9E1EC00C9E1EC00C9E1EC00C9E1EC00C8E0
      EB00C6DDEA00C1D8E600AAB9CD001869440000000000186944006399DD004F91
      E3004F91E3004E90E3004F91E3004F91E3004F91E3004F91E3004F91E3004F91
      E3004F91E3004F91E3006198DB00186944000000000018694400B0C4D400D3E9
      EE00D8ECF200D9EDF200D9EDF200D8ECF200D8ECF200D8ECF200D9EDF200D9ED
      F200DBEEF300DDEEF400B7D0DE001869440000000000AAB7B900E0EDEF00D0DB
      EB00E0ECEF00E0ECEE00E1EDEF00E0ECEE00DFECEE00E1EDEF00C3CCE800D0DA
      E900E2EEEE00AAB7B90000000000000000000000000006623700E1F3F600E0F3
      F600E0F3F600E0F3F600E0F3F600E0F3F600E0F3F600E0F3F600E0F3F600E0F3
      F600DEF1F600D6EBF200CCE4EE000662370000000000066237005896E3005896
      E300E0F2F500E0F2F500E0F2F500E0F2F500E0F2F500E0F2F500E0F2F500E0F2
      F500DEF0F5005896E3005695E300066237000000000006623700BED5E300C5DC
      E700C9E1EA00CAE2EA00CAE2EA00CAE2EA00CAE2EA00CAE2EA00CAE2EA00CAE2
      EA00CBE3EB00CEE4EC00CFE5ED000662370000000000A8B7B900E0EDEF00C4CD
      E900797BD900D0DAEB00E0ECEE00E1EDEF00DFECEE00A2A8E1007A7BD900E0EC
      ED00E1EDEF00ABB8BA0000000000000000000000000006623700E2F4F700E2F4
      F700E1F3F600E1F3F600E1F3F600E1F3F6009A9A9A00E1F3F600E1F3F600E1F3
      F600DFF2F600D8EDF200CFE4EE000662370000000000066237005C99E4005D9A
      E500E1F2F500E1F2F500E1F2F500E1F2F5009A9A9A00E1F2F500E1F2F500E1F2
      F500DFF1F5005C99E4005C99E400066237000000000006623700BDD4E200C4DB
      E600C9E1EA00CAE2EA00CAE2EA00CAE2EA009A9A9A00CAE2EA00CAE2EA00CAE2
      EA00CBE2EA00CCE4EC00CEE4EC000662370000000000A7B6B800E0EDEF00E0EC
      EE00A2A8E1006969D500D2DDEA00E2EEF0009A9FDF006969D500D0DAEB00E0ED
      EF00E4F0F200AAB7B90000000000000000000000000006623700E3F5F800E3F5
      F800E2F4F700E2F4F700E2F4F7009A9A9A009A9A9A009A9A9A00E2F4F700E2F4
      F700E1F3F600D9EEF300D0E5EE00066237000000000006623700639EE500639E
      E500E2F3F600E2F3F600E2F3F6009A9A9A009A9A9A009A9A9A00E2F3F600E2F3
      F600E1F2F500639EE500629DE500066237000000000006623700BDD3E300C5DB
      E700CAE1EA00CBE2EB00CBE2EB009A9A9A009A9A9A009A9A9A00CBE2EB00CBE2
      EB00CCE2EB00CEE3EC00CEE4ED000662370000000000A8B7B900E1EEF000E1ED
      EF00E0EDEF009A9FDF006A6AD5009093DD006A6AD500D3DEEB00E0ECEE00DFEC
      EE00E2EEF000ABB8BA0000000000000000000000000006623700E4F5F800E4F5
      F800E3F4F700E3F4F7009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A00E3F4
      F700E2F3F600DAEEF300D2E5EE000662370000000000066237006AA2E6006AA2
      E600E3F3F600E3F3F6009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A00E3F3
      F600E2F2F5006AA2E6006AA2E600066237000000000006623700BED3E300C6DB
      E700CBE1EA00CCE2EB009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A00CCE2
      EB00CFE2EB00D0E3EC00CFE4ED000662370000000000A9B6B800E1EFEE00E1ED
      EF00E0ECEE00E1ECEF007E80DA006868D500ADB4E300E1EDEF00E2EEEE00E0EC
      EE00E3EFF100A7B7B60000000000000000000000000006623700E9F9FA00E9F9
      FA00E8FAFB009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A00E7F9FB00E0F3F700D6EBF20006623700000000000662370092BBEC008BB8
      EB00E8F9FA009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A00E7F8FA008BB8EB0091BAEB00066237000000000006623700C1D7E400C8DE
      EA00CFE4ED009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A00D2E5EE00D3E6EE00D3E7EE000662370000000000AAB7B900E0EEED00E1ED
      EF00E0ECEE00A5ABE2006969D5009195DE006969D500CFD9EA00E0EBEF00E1ED
      EF00E1EDED00AAB7B90000000000000000000000000006623700EBF9FA00EBF9
      FA009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A00E1F3F700D7EBF20006623700000000000662370096BEED008BB8
      EB009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A008BB8EB0096BEED00066237000000000006623700C1D7E400C8DE
      EA009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A00D3E6EE00D3E7EE000662370000000000AAB7B900E1EEF000E0EC
      EE00AFB6E3006868D500CFDAEB00E1EDED00A4AAE2006868D500C4CDE900E0EC
      EE00E1EDED00ABB8BA0000000000000000000000000006623700EDFBFC00ECFB
      FC00ECFBFC00ECFBFC00ECFBFC00ECFBFC00ECFBFC00ECFBFC00ECFBFC00ECFB
      FC00ECFAFB00E4F4F900DBEDF4000662370000000000066237009CC4EE008BB8
      EB00EDFBFC00EDFBFC00EDFBFC00EDFBFC00EDFBFC00EDFBFC00EDFBFC00EDFB
      FC00ECFAFB008BB8EB009CC4EE00066237000000000006623700C3D8E500CAE0
      EA00D0E5EE00D3E6EE00D3E6EE00D3E6EE00D3E6EE00D3E6EE00D3E6EE00D3E6
      EE00D3E6EE00D4E7EE00D5E7EE000662370000000000AAB6BA00E0EDEF00C1CA
      EA006868D500C5CEE800E0EBEF00E0ECEE00E1EDEF00B0B7E4006868D500E1EE
      F000E1EEF000A8B8B70000000000000000000000000006623700F0FDFE00EFFD
      FE00EFFDFE00EFFDFE00EFFDFE00EFFDFE00EFFDFE00EFFDFE00EFFDFE00EFFD
      FE00EEFDFE00E8F7FB00E0F1F600066237000000000006623700A1C6EE008BB8
      EB00F0FDFE00F0FDFE00F0FDFE00F0FDFE00F0FDFE00F0FDFE00F0FDFE00F0FD
      FE00EFFDFE008BB8EB00A1C6EE00066237000000000006623700C3D9E500CAE0
      EA00D2E6EE00D4E9EE00D5E9EE00D5E9EE00D5E9EE00D5E9EE00D5E9EE00D5E9
      EE00D5E9EE00D5E9EE00D6E9EE000662370000000000ADB9BB00E2EEF000E1EC
      F100C7D1E900E0ECEE00E1EDEF00E1EDED00E0ECEE00E1EDEF00C0C9E600E1ED
      EF00E2EEF000AAB8B700000000000000000000000000236F4C00B4DDE400F5FF
      FF00F5FFFF00F5FFFF00F5FFFF00F5FFFF00F5FFFF00F5FFFF00F5FFFF00F5FF
      FF00F5FFFF00F4FFFF00B4DDE400236F4C0000000000236F4C0095C5FC008BB8
      EB0096BEED0096BEED0096BEED0096BEED0096BEED0096BEED0096BEED0096BE
      ED0096BEED008BB8EB0095C5FC00236F4C0000000000236F4C0095AFC400B9D0
      E300BFD4E400C2D8E600C3D9E700C3D9E700C3D9E700C3D9E700C3D9E700C3D9
      E700C2D8E600C4DAE7009EBDCE00236F4C0000000000AAB6B800E3EFEF00E1ED
      EF00E3EFEF00E2EEEE00E1EDEF00E2EEEE00E2EEF000E2EEEE00E1EDEF00E1ED
      EF00E3EFEF00AAB6BA000000000000000000000000005B8975004D8A6D00B4DE
      E500F6FFFF00F6FFFF00F6FFFF00F6FFFF00F6FFFF00F6FFFF00F6FFFF00F6FF
      FF00F6FFFF00C9EBEE004D8A6D005B8A7600000000005B8975007C8C890095C5
      FC0095C5FC0095C5FC0095C5FC0095C5FC0095C5FC0095C5FC0095C5FC0095C5
      FC0095C5FC0095C5FC007C8C89005B8A7600000000005B897500407A600091A7
      C000B2CCDE00B3CDDF00B4CDDF00B4CDDF00B4CDDF00B4CDDF00B4CDDF00B4CD
      DF00B4CDDF00A4B2C900437C62005B8A760000000000A8B7B900AAB8B700AAB7
      B900AAB7B900A8B7B900A9B8BA00A9B9B800AAB7B900ABB8BA00A8B7BA00A9B8
      BA00A9B6B800ABB7BB00000000000000000000000000D1C4DB005B897500236F
      4C00066237000662370006623700066237000662370006623700066237000662
      370006623700186944004F836D00D5C9DF0000000000DEC4C8005B897500236F
      4C00066237000662370006623700066237000662370006623700066237000662
      370006623700186944004F836D00E2C9CD0000000000D1C4DB005B897500236F
      4C00066237000662370006623700066237000662370006623700066237000662
      370006623700186944004F836D00D5C9DF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A8B7B900AAB7B900ABB7
      B700AAB7B900ABB8BA00A9B6B800AAB7B900A9B9B800A9B6B800AAB7B900A8B7
      B900A7B6B800AAB7B90000000000000000000000000056110000561100005513
      00005510000056110000520E01005710020054120000550F0200551000005712
      0000541200005611000000000000000000000000000057130000571201005913
      02005E1200005714000056120000571201005611000057130000581103005515
      00005A1502005812010000000000000000000000000056130000541304005712
      0100571201005A1200005813000057110000571200005A120100581300005616
      00005712000058140100000000000000000000000000AAB7B900E3EFEF00E3ED
      ED00E2EEEE00E2EEF000E3EFF100E1EDEF00E2F0EF00E3EFF100E3EFF100E1EE
      F000E2EFF100ABB8BA0000000000000000000000000056110000F4F9F700F8F7
      FB00F8F8F800F8F8F800FBF9F900F7F8F600F8F8F800F7F9F900F8F8F800EFF1
      F700F8F7F900561100000000000000000000000000005514000088C3FB0084C1
      F90082C2F80087C3F90087C3F90084C7F4008AC3FA0084C4F40088BFFC007FBE
      F50084C5F800581400000000000000000000000000005A120000C9D2D500C5D3
      D200C6D2D200C6D2D600C4D0D000C6D4D300C6D1D500C7D3D500C6D1D500C0CE
      D100C8D5D30056140200000000000000000000000000A8B7BA00E0EDEF00E1ED
      ED00E1EDED00E1EDEF00E3EFF100E3EFF100E1EEF000E0ECEE00E0ECEE00E3EF
      F100E2EFF100A9B6B80000000000000000000000000056110000F6F8F9009C9C
      EC00DEE1F400F8F8F800F9F7F700F9F8FA00F6F8F900F4F2F7007C7DE9009C9C
      EC00F9F9F900561100000000000000000000000000005914010081C3F6009C9C
      EC00DCE1F400F5F7F700F9F8FC00F9F6F800FAF9F500EEF3F7007D7DE9009D9C
      EC0085C4F6005712030000000000000000000000000057120100C5D1D5007A83
      C100B1B9CD00C2CCD300C2CDD100C4CDD100C1CFCE00BDC9CF006369BB007A82
      C000C7D2D60057120100000000000000000000000000A9B8BB00E3EFF100E1ED
      ED00E2EEEE00E4F0F200A1ADAF00E2EEF000E3EFF100E1EEF000E1EDEF00E0ED
      EF00E0EDEF00ABB8BA0000000000000000000000000056110000F6F8F9007D7E
      E8001312DB009C9CEE00FAF6F500F6F8F900F7F5F7004546E2001312DB00E1E1
      F600F9F8FA00561100000000000000000000000000005813020085C1F7007E7E
      E9001312DB009D9CEC00F7F8F600FCF7F900F0F5F7004646E1001212DB00E1E1
      F30082C2F9005B13010000000000000000000000000056110000C3D2D5006369
      BA000E0FA7007981BD00C3CECB00C5CDCC00BFCACF00373AB1000E0FA700B1BC
      CC00C6D1D5005A130000000000000000000000000000A9B8BA00E0EDEF00E2EE
      EE00E3EFEF00A3AFB100A5B1B300A4B0B200E3EFF100E1EEF000E2EEF000E0EC
      EE00E3EFF100AAB7B90000000000000000000000000056110000F6F8F800F2F3
      F6004546E2000101D900A8A9ED00EFF1F8003C3BE0000101D9009C9CEC00F8F9
      F700F9F7F700561100000000000000000000000000005310010082C4F500EEF0
      F5004746E1000101D900A5A8ED00F3F1F7003B3BE1000101D9009D9CEC00F6F8
      F80083C5F6005813000000000000000000000000000057120000C6D1D500BECB
      D100393AB0000101A400848AC100C0C7CB002E31AE000101A4007C80BF00C5CE
      D100C5D1D50058140100000000000000000000000000A8B7B900E2EFF100E1ED
      ED00A1ADAD00A3B0B200A3B0B200A3B0B200A3B1B000E3F0F200E2EEF000E2EE
      F000E2EEF000AAB7B90000000000000000000000000056110000F5F4F600F4F3
      F500F3F1F4003A3BE0000202D9002D2DDF000202D900A7A7EE00F7F6F800FAF8
      F800F6F9F700561100000000000000000000000000005A12000081C1F800F7F6
      F800F1F3F6003B3BE1000202D9002C2DDE000202D900A6A7EF00FCF7F800F7F9
      F90085C2FA005613000000000000000000000000000058120100C3D1D000C1CD
      CD00C0C9CE002E31AE000202A4002325AB000202A400828BBF00C3CCD000C3CE
      D200C6D2D40058130000000000000000000000000000ABB7BB00E2EEF000E5EF
      EF00A1ADAF00A3AFB100E5F1F300A3AFB100A3AFB100A2AFB100E3EFF100E2EE
      F000E1EEF000AAB7B90000000000000000000000000056110000F2F2F200EFF1
      F100F1F0F400E3E9F2001717DC000000D9005655E300F7F6F800F8F7F900F5F8
      F600F8F7F900561100000000000000000000000000005A12010084BDFA00ECF0
      F100EFF1F100E9E7F1001717DC000000D9005356E200FBF8FA00FCF7F600F2F9
      F40087C5FB005713000000000000000000000000000057130000BFCED100BFCC
      CE00C1CCCA00B9C3C9001213A8000000A4004547B300C1CDCF00C1CDCF00C4CE
      CE00CAD0D50057120000000000000000000000000000A8B7B900E1EEF000E2EE
      F000A1ADAF00E3EFF100E2EFF100E3EEF200A3AEB200A3AFB100A0ADAF00E1EE
      F000E3EFF100AAB7B90000000000000000000000000056110000E9EBEC00E6EB
      EA00E5EAEB004546DF000101D9002C2CDD000101D9009897E900F0F6F500F7F7
      F700FAF8F800561100000000000000000000000000005513010077BEF000EAE9
      EB00E9E7E9004445DE000101D9002C2CDD000101D9009398E800F3F6F400FAF6
      FB0086C1F9005714000000000000000000000000000058120100C0CCCE00C0C9
      CC00C0C8CA00383BAF000101A4002425AB000101A400797EBC00C4CBCE00C0CC
      D000C5D0D40059140100000000000000000000000000A8B7B900E1EFEE00E1ED
      ED00E2EEEE00E3EFEF00DFEDEC00E2EEF000E3EFF100A3AFB100A2AEB000E4F0
      F200E4EDF000ABB7B90000000000000000000000000056110000E3E6EA00E0E4
      E7005254DE000000D9009192E300E2E7EB004546DF000000D9007E7EE500F3F2
      F400F7F9F90056110000000000000000000000000000571200007CB5F300DFE1
      E4005352DD000000D9008F90E200E1E2E7004545DF000000D9007E7CE400F1F3
      F30083C2F5005712010000000000000000000000000057120000BDCBCA00BBC6
      C8004349B0000000A400747CBC00BCC5CB00383CAF000000A4006369B900C0CC
      CE00C4D2D10057130000000000000000000000000000A8B5B700E1EEF000E1ED
      EF00DFEBED00E1EDEF00E1EDEF00E0ECEE00E2EEF000E4F0F2009FACAE00E2EE
      EE00E1EDEF00ABB8BA0000000000000000000000000056110000D9E2E6006B6D
      DD000000D9007576DE00E2E8E300E6E8E800E2E5EB005655E0000000D900EAEF
      F200EEF1F500561100000000000000000000000000005B13010074B1F100696D
      D9000000D9007374DB00D9E1E000E2E4E400DEE3E3005555DD000000D900EAF0
      EF007DBDF7005812010000000000000000000000000056100300B7C9C8005B60
      B4000000A4006168B600BAC8C400BCC9C700BCC7C9004649B1000000A400BFCC
      CA00C2CED00057120000000000000000000000000000ADB9BD00E1EDEF00E3EF
      F100E2EEF000E1EDEF00E0ECEE00E0ECEE00E1EDEF00E2EEEE00E2F0EF00E1ED
      ED00E2EEEE00AAB8B70000000000000000000000000056110000DBDFE000C2CC
      DE007879DD00DDE0E400DEE1E500DFE3E400E1E6E400E3E5E8006D6FE000ECEC
      EC00ECF1F200561100000000000000000000000000005914010070ADEB00C2C5
      D7007376D900D9DBDC00DBDDDD00DADFDE00DFE2E000DBDEE4006C6EDE00EAE8
      E7007DB9F4005B14000000000000000000000000000059140000BBC7C700A8B3
      C500646BB600B9C5C900B8C7CA00BDC6CA00BCC8C800BBC6CA005860B700C0CC
      CE00BDCCCF0059130200000000000000000000000000A9B6B800E3EFEF00E2EE
      EE00E1EDED00E2EEEE00E2EEEE00E2EEEE00E0ECEC00E5EEF100E1EDEF00E1ED
      ED00E3EFEF00A9B6B80000000000000000000000000056110000D6E2E200DADE
      E300DCDFE300DDE2E500DDE3E200DFE5E400E0E6E500DEE7E400E5E8ED00E6E9
      ED00E8EEED0056110000000000000000000000000000581300006CB1F0006FAC
      EC006DAEEB0071B0EC0072B1ED0074B1EF0073B6EF0074B5EC0075B2F00076B5
      F10079B8F5005412000000000000000000000000000056120000BBC9C700B9C7
      CD00B8C5C700B8C7C900BBC7C900BAC7C900BCC8CA00BCC7CB00BCCAC900C1CA
      CE00C1CDCD0057130000000000000000000000000000ABB8BA00ABB8BA00AAB7
      B900ABB8BA00A8B5B700AAB7B900A9B6B800ACB9BB00A9B5B900ABB8BA00ABB8
      BA00AAB7B900AAB9BC0000000000000000000000000056110000561100005611
      0000561100005611000056110000561100005611000056110000561100005611
      000056110000561100000000000000000000000000005E110100571300005814
      01005A130000581300005B130100591200005B14000056150000581300005815
      0000561100005815000000000000000000000000000057120100581401005613
      0000591502005A12010057130000581300005813000059110000561100005710
      0200571300005513000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A8B7B900AAB7B900ABB8
      BA00A9B8BA00A8B7B900AAB7B900A9B6B800A8B7B900A9B8BB00AAB7B900ABB8
      BA00A8B7B900A8B7B90000000000000000000000000057120000551203005213
      00005612000055130000550F0000551300005412000053110000591100005412
      0000551001005613000000000000000000000000000055110400591400005714
      000059100200551100005A110300560F01005A13000055130100551100005812
      0100581401005911000000000000000000000000000058130000551300005812
      0100571400005510010058130000581201005513000059110000581500005612
      00005513000059140100000000000000000000000000A7B6B800E2EFF100E3EF
      F100E1EEF000E1EEF000E1EDEF00E2EFF100E1EEF000E1EEF000E2EEF000E2EE
      F000E3F0F200A9B6B80000000000000000000000000056110000FBF9F800FAF8
      F700F5F7F700F4FAF500F8F9F700FAF8F800F8F7F900F7F9FA00F7F6F800FAF8
      F700F9F7F600561102000000000000000000000000005812010085C4F60082C2
      F90084C3F50089C4F6008AC4F80087C6F80084C5F80088C4FA0085C0F80088C4
      FA0084C3F6005A14000000000000000000000000000057120100C5D5D400C6D2
      D800C5D2D000C7D2D600C7D3D500C4D0D400C8D2D200C0D2D100C5D1D300C8D3
      D700C7D3D50058120100000000000000000000000000AAB7B900E0EDEF00E1ED
      EF00E1EDEF00E0ECEE00E1EDEF00E0ECEE00DFECEE00E1EDEF00E0ECEE00E0EC
      EC00E2EEEE00AAB7B90000000000000000000000000054120000F5F7F700F8F8
      F800F8F8F800F5F8FC00FBF7FC00F8F7F900FAF8F700F6F8F800F8F9F500F6F8
      F800F3F8F600561100000000000000000000000000005813000086C5F800FAF9
      F500F5F7F700F4F9F800F4F9F700FBF7FC00F6F8F800F6FAF500F6F8F800F9F7
      F70084C4FA005713000000000000000000000000000058150000C7D2D600C3CD
      D400C5D1D300CAD0CF00C4D1D300CBD0D300C4CDD100C2CFD100CACDD500C2CE
      D200C8D5D7005A120000000000000000000000000000A8B7B900E0EDEF00E2EE
      F000E0ECEE00E0ECEE00E0ECEE00E1EDEF00DFECEE00E0ECEE00E1EDEF00E1ED
      ED00E1EDEF00ABB8BA00000000000000000000000000550F0200F5FBF600FAF6
      FB00F9F9F900F7F7F70002860000F8F7F900F4F9F700F7F9FA00F6F5F700FCF8
      F700FAF6FB00561200000000000000000000000000005814010087BFFA00F8F7
      F900FAF6FB00F6F8F80000870000F7F7F700F9F6F800F7FAF800F8F7F900F7F8
      F60081C3F8005813000000000000000000000000000057120300C4D2D100C8D0
      D000CBD2CF00C8D0D70000650300CDD0D800C6CFD300C6CCD100C1CECC00C2CF
      D700C5D3D20059140000000000000000000000000000A7B6B800E0EDEF00E0EC
      EE00E0ECEE00E0EDEF00DFEBED00E2EEF000DFECEE00E1EDEF00E0ECEE00E0ED
      EF00E4F0F200AAB7B900000000000000000000000000560F0100F5FAF800F8F8
      F800F9F7F60001890100008D020000870000F6F8F900FBF8F300F9F9F900FAF7
      F900F6F7FB00571100000000000000000000000000005911000082C2F800FCF7
      F800FBFAF600008700000187000003860000F8F9F700F5F7F700F5F7F800F7F9
      F90086C1F9005A1200000000000000000000000000005A130000C6D3D500C6D0
      D700CAD1D40002650100016A030002660000CCD1D400C4D1D300C3CCD000C3CF
      D100C4D2D00058120100000000000000000000000000A8B7B900E1EEF000E1ED
      EF00E0EDEF00DEEBED00E0ECEE00E0ECEE00E0ECEE00E0ECEE00E0ECEE00DFEC
      EE00E2EEF000ABB8BA0000000000000000000000000054110200F6F8F900FEF6
      F60003880200008B000000890000008C000004880000F7F8F600F9F8FA00FBF9
      F900F5F9F400571200000000000000000000000000005712010084C2F800F6FA
      F50000880100038A000000890000008D000000870000F9F7F700FBFBF500F9F6
      F80086C5F8005B14000000000000000000000000000057110000C3D0D800C8CE
      D3000067000000690200006A0000036B000001670200CBD0D900C8CED300C5CF
      CF00C6CFD80058130000000000000000000000000000A9B6B800E1EFEE00E1ED
      EF00E0ECEE00E1EDEF00E2EDF100E1EDEF00E0ECEE00E1EDEF00E2EEEE00E0EC
      EE00E3EFF100A7B7B60000000000000000000000000057120000F0F3F700F0F3
      F8000187000002870100FEF9F800008900000089000000890000F7F8F600F6F7
      FB00F7F9F900561000000000000000000000000000005712000081BCFA00F6F5
      F9000089000002880000F8F9F700018503000189010000890000F4F7FB00F6F9
      F70089C7F7005513000000000000000000000000000057120100C0CDD500CBD0
      D1000265010000670000D0D2DA00046700000069020002650100CCD3D600C4D1
      CF00C8D1D40057140000000000000000000000000000AAB7B900E0EEED00E1ED
      EF00E0ECEE00E1EDEF00DFEBED00E3EFEF00E0ECEE00E0ECEE00E0EBEF00E1ED
      EF00E1EDED00AAB7B90000000000000000000000000050130000E5EBF200EEED
      EF0003870000F1F0F400F6F0F500FAF3FA00018901000089000000880000F4F9
      F700FBF9F900561000000000000000000000000000005713000081BCF400EAED
      F10000850000F3EFF400F0F3F800F5F5F50004860300008C010002880000F7F7
      F70088C4F8005813000000000000000000000000000059140000C0CDCF00C1CD
      CD0000660100C3CDD400C8CDD000C5CBD600006700000168000002660000C9D0
      D300C5D0D4005A130000000000000000000000000000AAB7B900E1EEF000E0EC
      EE00DFEBED00DFEBED00E1EDEF00E1EDED00E0ECEE00DFECEE00DFEBEF00E0EC
      EE00E1EDED00ABB8BA000000000000000000000000005A120100E0E3E700E0E4
      E500E2E5E900E4E9E800E9E9E900EEECEC00F5EFF4000589000000890200FAF7
      F900F6F6F600561102000000000000000000000000005914010079B5F100E5E6
      E400E7E5E500E7E6E800E5EAE800EAEBEF00F5EFF40001860000008A0000F6F8
      F80085C0F8005B14000000000000000000000000000056110200BCC8CE00BECA
      CC00C3C6CE00BFCBCD00C0C9CC00C4CBCE00C9CBD5000066010000660100C3CE
      D200C4D1D30057130000000000000000000000000000AAB6BA00E0EDEF00E2ED
      F100E1EDEF00E0ECEE00E0EBEF00E0ECEE00E1EDEF00E0ECEE00DFEDEC00E1EE
      F000E1EEF000A8B8B70000000000000000000000000059110000D4DDE000D8DC
      DD00D7DCDD00DBE0DF00DAE2E100E0E5E400E3E6EA00E9EAEE0001850200ECF0
      F100F0F2F200571100000000000000000000000000005615000074B2F200D9DE
      DD00D8DDDE00D9DEDF00DCE1DF00E0E7E400E3E7E800ECEBEF0000850300EDEE
      F2007EBDF9005A13000000000000000000000000000054120000B8CBC800BDC6
      C900BDC6CA00BAC7C900BEC6C500BDC9C900BDC9CB00C8CDD00002660000BECD
      CF00C2CED20057120000000000000000000000000000ADB9BB00E2EEF000E2ED
      F100E1EDEF00E0ECEE00E1EDEF00E1EDED00E0ECEE00E1EDEF00E0ECEC00E1ED
      EF00E2EEF000AAB8B70000000000000000000000000059130200D3D8DB00CCDA
      D900D6D8D800D5DADD00D7DDDC00D7DDE200DBE0DE00E1E3E400E2E5EA00E4E9
      E700E7ECED00560E02000000000000000000000000005713000070AFEB00CFDA
      D800D5DAD900DCDCDC00DDDDDD00E0DDDF00DDE2E100E2E4E500E6E6E600EBEC
      EA0080B9F6005B13020000000000000000000000000059140100BCC8C800B9C7
      C600B9C6C800BAC7C900BBC5C500B8C4C800BCC8CC00C1C9C900BEC7D000C2CB
      CE00C3CCCF0054140200000000000000000000000000AAB6B800E3EFEF00E1ED
      EF00E3EFEF00E2EEEE00E1EDEF00E2EEEE00E2EEF000E2EEEE00E1EDEF00E1ED
      EF00E3EFEF00AAB6BA0000000000000000000000000054120000CED7DB00D1D6
      D900D1D6D700D2D7DA00D4D7DB00D1DADD00D8DFDC00D9DEDD00DCE2E100D6E4
      E300E0E6EB0054120000000000000000000000000000581300006EB0F1006EAB
      EB0070ADEB006DB3E80073B3ED0072B4EF0072B4EF0073B5F00076B3F30074B7
      F00075B8F7005914010000000000000000000000000057130000BCC9CB00BBC7
      CD00B7C6C800B8C6C500BAC7C900BCC9CB00BDC7C700BDC8CC00BDC6D000B7C9
      CA00C0CBD30058140100000000000000000000000000A8B7B900AAB8B700AAB7
      B900AAB7B900A8B7B900A9B8BA00A9B9B800AAB7B900ABB8BA00A8B7BA00A9B8
      BA00A9B6B800ABB7BB0000000000000000000000000054120000581302005311
      000055130100571300005813000051130100540F000057130000561200005311
      000057120000571201000000000000000000000000005F130100581300005A15
      02005A1400005813000058110300551300005A120100581300005B1400005114
      0000591401005712000000000000000000000000000058130200571300005814
      01005A1200005D12040058120100541500005A12000053130100581300005517
      0000581201005712000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000056110000561100005513
      00005510000056110000520E01005710020054120000550F0200551000005712
      0000541200005611000000000000000000000000000057130000571201005913
      02005E1200005714000056120000571201005611000057130000581103005515
      00005A1502005812010000000000000000000000000056130000541304005712
      0100571201005A1200005813000057110000571200005A120100581300005616
      0000571200005814010000000000000000000000000000000000000000000000
      0000D0D8D700BEC9C700B4C0BE00BEC9C700D0D8D700E6EAEA00000000000000
      0000000000000000000000000000000000000000000056110000F4F9F700F8F7
      FB00F8F8F800F8F8F800FBF9F900F7F8F600F8F8F800F7F9F900F8F8F800F5F7
      F800F8F7F900561100000000000000000000000000005514000088C3FB0084C1
      F90082C2F80087C3F90087C3F90084C7F4008AC3FA0084C4F40088BFFC0082C3
      F60084C5F800581400000000000000000000000000005A120000C9D2D500C5D3
      D200C6D2D200C6D2D600C4D0D000C6D4D300C6D1D500C7D3D500C6D1D500C5D3
      D200C8D5D3005614020000000000000000000000000000000000D5DCDB00CBD4
      D200E1E6E500F3F5F500FDFEFE00F3F5F500E1E6E500CBD4D200D5DCDB000000
      0000000000000000000000000000000000000000000056110000F6F8F900F8F8
      F800F6F9F700F8F8F800F9F7F700F9F8FA00F6F8F900FAF8F800F6F8F800F8F9
      F700F9F9F900561100000000000000000000000000005914010081C3F600F8F8
      F800F4F9F700F5F7F700F9F8FC00F9F6F800FAF9F500F4F9F800F8F7F900FAF8
      F80085C4F6005712030000000000000000000000000057120100C5D1D500C3D0
      D200C4CDD100C2CCD300C2CDD100C4CDD100C1CFCE00C2CED000C3D0D200C3CF
      D100C7D2D60057120100000000000000000000000000D5DCDB00DCE2E100FEFE
      FE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00DCE2E100D5DC
      DB00000000000000000000000000000000000000000056110000F6F8F900F8F9
      F700FAF7F900F9F8FA00FAF6F500F6F8F900FAF8F700F6F8F800FAF7F900F9F9
      F900F9F8FA00561100000000000000000000000000005813020085C1F700F9F9
      F900FCF7F800FAF8F700F7F8F600FCF7F900F3F8F700F8F9F700F8F8F800F9FA
      F60082C2F9005B13010000000000000000000000000056110000C3D2D500C3CF
      CF00C2CCCC00C1CECC00C3CECB00C5CDCC00C1CCD000C2CDD100C0CCD000C4D0
      D000C6D1D5005A1300000000000000000000E6EAEA00CBD4D200FEFEFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00CBD4
      D200E6EAEA000000000000000000000000000000000056110000F6F8F800F8F9
      F700F6F8F800FAF8F700F9FAF600F6F8F900FAF8F800F5F8F600F8F9F700F8F9
      F700F9F7F700561100000000000000000000000000005310010082C4F500F4F6
      F600FCF9F500F8F8F800F4F9F700FAF8F800F8F7F900F8F8F800FAF8F700F6F8
      F80083C5F6005813000000000000000000000000000057120000C6D1D500C3D0
      D200C9CECF00C7CCCD00C3CCCF00C5CDCC00C1CDCD00C4CCCC00C5CCCF00C5CE
      D100C5D1D500581401000000000000000000D0D8D700E1E6E500FFFFFF00FFFF
      FF00EEF1F100CFD7D600B7C3C100CFD7D600EEF1F100FFFFFF00FFFFFF00E1E6
      E500D0D8D7000000000000000000000000000000000056110000F5F4F600F4F3
      F500F6F4F400F1F5F600FBF6F700F8F8F800F8F7F900F8F8F800F7F6F800FAF8
      F800F6F9F700561100000000000000000000000000005A12000081C1F800F7F6
      F800F4F6F600F6F5F900F9F9F900F3F8F700FDF8FA00F6F8F900FCF7F800F7F9
      F90085C2FA005613000000000000000000000000000058120100C3D1D000C1CD
      CD00C2CBCE00C1CDCD00C2CCCC00C1CECC00C4CBCE00C1CECC00C3CCD000C3CE
      D200C6D2D400581300000000000000000000BEC9C700F3F5F500FFFFFF00FFFF
      FF00CFD7D600B2BFBD00B2BFBD00B2BFBD00CFD7D600FFFFFF00FFFFFF00F3F5
      F500BEC9C7000000000000000000000000000000000056110000F2F2F200EFF1
      F100F1F0F400EEF4F300F4F4F400F5F6F400F5F4F600F7F6F800F8F7F900F5F8
      F600F8F7F900561100000000000000000000000000005A12010084BDFA00ECF0
      F100EFF1F100F4F2F200F4F4F400F5F4F600EFF6F300FBF8FA00FCF7F600F2F9
      F40087C5FB005713000000000000000000000000000057130000BFCED100BFCC
      CE00C1CCCA00C2CDCB00C4CBCE00BFCDCB00C5CCCF00C1CDCF00C1CDCF00C4CE
      CE00CAD0D500571200000000000000000000B4C0BE00FDFEFE00FFFFFF00FFFF
      FF00B7C3C100B2BFBD00B2BFBD00B2BFBD00B7C3C100FFFFFF00FFFFFF00FDFE
      FE00B4C0BE000000000000000000000000000000000056110000E9EBEC00E6EB
      EA00E7ECEB00EBEEEC00EDEFF000EDEFF000F2F2F200F6F4F300F0F6F500F7F7
      F700FAF8F800561100000000000000000000000000005513010077BEF000EAE9
      EB00EBE9E900E7ECEB00E9EFEE00EFEEF000EDF1F200EEF5F200F3F6F400FAF6
      FB0086C1F9005714000000000000000000000000000058120100C0CCCE00C0C9
      CC00C2CACA00BDCAC800BECACA00C1CBCB00C3CACD00C4CCCB00C4CBCE00C0CC
      D000C5D0D400591401000000000000000000BEC9C700F3F5F500FFFFFF00FFFF
      FF00CFD7D600B2BFBD00B2BFBD00B2BFBD00CFD7D600FFFFFF00FFFFFF00F3F5
      F500BEC9C7000000000000000000000000000000000056110000E3E6EA00E2E6
      E700E1E5E600E5EAE900EAEBE900E7ECEB00EBEDED00EBF0EF00F1F2F000F3F2
      F400F7F9F90056110000000000000000000000000000571200007CB5F300E1E3
      E400E3E2E400DEE6E600E6E8E800E5E7E700E9EBEC00E9EDEE00F2EDEE00F1F3
      F30083C2F5005712010000000000000000000000000057120000BDCBCA00BCC8
      C800B9C7C600BCCAC900BCC8CA00C0C9CC00BFCCCA00BFCCCA00BECACC00C0CC
      CE00C4D2D100571300000000000000000000D0D8D700E1E6E500FFFFFF00FFFF
      FF00EEF1F100CFD7D600B7C3C100CFD7D600EEF1F100FFFFFF00FFFFFF00E1E6
      E500D0D8D7000000000000000000000000000000000056110000D9E2E600DDE1
      E200DDE3E200E1E3E300E2E8E300E6E8E800E4E7EB00ECE9EB00EAECEC00EAEF
      F200EEF1F500561100000000000000000000000000005B13010074B1F100D9E1
      DA00D8DEDD00DCDFDD00D9E1E000E2E4E400E0E5E300E9E9E300EBEAEC00EAF0
      EF007DBDF7005812010000000000000000000000000056100300B7C9C800BDC8
      C600BAC6C600BAC8C700BAC8C400BCC9C700BDC9C900BFC9C900BFC8CB00BFCC
      CA00C2CED00057120000000000000000000000000000CBD4D200FEFEFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00CBD4
      D200000000000000000000000000000000000000000056110000DBDFE000D6E1
      DF00DEE0E000DDE0E400DEE1E500DFE3E400E1E6E400E5E7E800E3E7E800ECEC
      EC00ECF1F200561100000000000000000000000000005914010070ADEB00D6D9
      D700D5DAD900D9DBDC00DBDDDD00DADFDE00DFE2E000DDE0E400E0E5E300EAE8
      E7007DB9F4005B14000000000000000000000000000059140000BBC7C700B9C6
      C800B9C5C500B9C5C900B8C7CA00BDC6CA00BCC8C800BCC8CA00B7C8CB00C0CC
      CE00BDCCCF0059130200000000000000000000000000D5DCDB00DCE2E100FEFE
      FE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00DCE2E100D5DC
      DB00000000000000000000000000000000000000000056110000D6E2E200DADE
      E300DCDFE300DDE2E500DDE3E200DFE5E400E0E6E500DEE7E400E5E8ED00E6E9
      ED00E8EEED0056110000000000000000000000000000581300006CB1F0006FAC
      EC006DAEEB0071B0EC0072B1ED0074B1EF0073B6EF0074B5EC0075B2F00076B5
      F10079B8F5005412000000000000000000000000000056120000BBC9C700B9C7
      CD00B8C5C700B8C7C900BBC7C900BAC7C900BCC8CA00BCC7CB00BCCAC900C1CA
      CE00C1CDCD005713000000000000000000000000000000000000D5DCDB00CBD4
      D200E1E6E500F3F5F500FDFEFE00F3F5F500E1E6E500CBD4D200D5DCDB000000
      0000000000000000000000000000000000000000000056110000561100005611
      0000561100005611000056110000561100005611000056110000561100005611
      000056110000561100000000000000000000000000005E110100571300005814
      01005A130000581300005B130100591200005B14000056150000581300005815
      0000561100005815000000000000000000000000000057120100581401005613
      0000591502005A12010057130000581300005813000059110000561100005710
      0200571300005513000000000000000000000000000000000000000000000000
      0000D0D8D700BEC9C700B4C0BE00BEC9C700D0D8D70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEE7DF00E9E0D600E7DDD300E9E0D600EEE7DF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEE7DF00E9E0D600E7DDD300E9E0D600EEE7DF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEE7DF00E9E0D600E7DDD300E9E0D600EEE7DF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E2D6
      C900DCCEBF00D9CABA00D8C9B800D9CABA00DCCEBF00E2D6C900000000000000
      000000000000000000000000000000000000000000000000000000000000E2D6
      C900DCCEBF00D9CABA00D8C9B800D9CABA00DCCEBF00E2D6C900000000000000
      000000000000000000000000000000000000000000000000000000000000E2D6
      C900DCCEBF00D9CABA00D8C9B800D9CABA00DCCEBF00E2D6C900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D5DDDE00C5D0D200BCC8CB00C5D0D200D5DDDE00E9EDEE00000000000000
      0000000000000000000000000000000000000000000000000000DFD2C400B999
      83009A6A4E0081442300712C0800814423009A6A4E00B9998300DFD2C4000000
      0000000000000000000000000000000000000000000000000000DFD2C400B999
      83009A6A4E0081442300712C0800814423009A6A4E00B9998300DFD2C4000000
      0000000000000000000000000000000000000000000000000000DFD2C400B999
      83009A6A4E0081442300712C0800814423009A6A4E00B9998300DFD2C4000000
      0000000000000000000000000000000000000000000000000000D9E0E200D0D9
      DB00E4E9EA00F4F6F700FEFEFE00F4F6F700E4E9EA00D0D9DB00D9E0E2000000
      00000000000000000000000000000000000000000000D5C3B300A2765B009664
      4800C0A28F00E4D7CF00F9F7F500E4D7CF00C0A28F0096644800A2765B00D5C3
      B3000000000000000000000000000000000000000000D5C3B300A2765B009664
      4800C0A28F00E4D7CF00F9F7F500E4D7CF00C0A28F0096644800A2765B00D5C3
      B3000000000000000000000000000000000000000000D5C3B300A2765B009664
      4800C0A28F00E4D7CF00F9F7F500E4D7CF00C0A28F0096644800A2765B00D5C3
      B3000000000000000000000000000000000000000000D9E0E200E0E5E700FEFE
      FE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00E0E5E700D9E0
      E20000000000000000000000000000000000E2D6C900A1745900B28D7600F8F5
      F200F7F3F000EDE6DF00E9E1D700EDE6DF00F7F3F000F8F5F200B28D7600A174
      5900E2D6C900000000000000000000000000E2D6C900A1745900B28D7600F8F5
      F200F7F3F000EDE6DF00E9E1D700EDE6DF00F7F3F000F8F5F200B28D7600A174
      5900E2D6C900000000000000000000000000E2D6C900A1745900B28D7600F8F5
      F200F7F3F000EDE6DF00E9E1D700EDE6DF00F7F3F000F8F5F200B28D7600A174
      5900E2D6C900000000000000000000000000E9EDEE00D0D9DB00FEFEFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00D0D9
      DB0000000000000000000000000000000000B9998300935F4100F1ECE500F7F3
      F000E3D8CC00D6C6B500D3C2AF00D6C6B500E3D8CC00F7F3F000F1ECE500935F
      4100B9998300000000000000000000000000B9998300935F4100F1ECE500F7F3
      F000E3D8CC00D6C6B500D3C2AF00D6C6B500E3D8CC00F7F3F000F1ECE500935F
      4100B9998300000000000000000000000000B9998300935F4100F1ECE500F7F3
      F000E3D8CC00D6C6B500D3C2AF00D6C6B500E3D8CC00F7F3F000F1ECE500935F
      4100B9998300000000000000000000000000D5DDDE00E4E9EA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4E9
      EA00D5DDDE0000000000000000000000000098684B00B5937D00FAF7F500EDE6
      DF00AABB910056A24B0018941C0056A24B00AABB9100EDE6DF00FAF7F500B593
      7D0098684B0000000000000000000000000098684B00B5937D00FAF7F500EDE6
      DF00AABB910056A24B0018941C0056A24B00AABB9100EDE6DF00FAF7F500B593
      7D0098684B0000000000000000000000000098684B00B5937D00FAF7F500EDE6
      DF00AABB910056A24B0018941C0056A24B00AABB9100EDE6DF00FAF7F500B593
      7D0098684B00000000000000000000000000C5D0D200F4F6F700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F6
      F700C5D0D2000000000000000000000000007F422000D2BDAD00FCFBFA00E9E1
      D70057A44D000D9213000D9213000D92130057A44D00E9E1D700FCFBFA00D2BD
      AD007F4220000000000000000000000000007F422000D2BDAD00FCFBFA00E9E1
      D70057A44D000D9213000D9213000D92130057A44D00E9E1D700FCFBFA00D2BD
      AD007F4220000000000000000000000000007F422000D2BDAD00FCFBFA00E9E1
      D70057A44D000D9213000D9213000D92130057A44D00E9E1D700FCFBFA00D2BD
      AD007F422000000000000000000000000000BCC8CB00FEFEFE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
      FE00BCC8CB00000000000000000000000000712C0800E0D3C500FAF7F500EDE6
      DF0019951D000D9213000D9213000D92130019951D00EDE6DF00FAF7F500E0D3
      C500712C0800000000000000000000000000712C0800E0D3C500FAF7F500EDE6
      DF0019951D000D9213000D9213000D92130019951D00EDE6DF00FAF7F500E0D3
      C500712C0800000000000000000000000000712C0800E0D3C500FAF7F500EDE6
      DF0019951D000D9213000D9213000D92130019951D00EDE6DF00FAF7F500E0D3
      C500712C0800000000000000000000000000C5D0D200F4F6F700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F6
      F700C5D0D20000000000000000000000000080432100CDB7A500F3EEE800F7F3
      F0005DAC58000D9213000D9213000D9213005DAC5800F7F3F000F3EEE800CDB7
      A5008043210000000000000000000000000080432100CDB7A500F3EEE800F7F3
      F0005DAC58000D9213000D9213000D9213005DAC5800F7F3F000F3EEE800CDB7
      A5008043210000000000000000000000000080432100CDB7A500F3EEE800F7F3
      F0005DAC58000D9213000D9213000D9213005DAC5800F7F3F000F3EEE800CDB7
      A50080432100000000000000000000000000D5DDDE00E4E9EA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4E9
      EA00D5DDDE000000000000000000000000009C6C5000B28E7600E9E0D600FAF7
      F500C4DEBF0060B15F001A971F0060B15F00C4DEBF00FAF7F500E9E0D600B28E
      76009C6C50000000000000000000000000009C6C5000B28E7600E9E0D600FAF7
      F500C4DEBF0060B15F001A971F0060B15F00C4DEBF00FAF7F500E9E0D600B28E
      76009C6C50000000000000000000000000009C6C5000B28E7600E9E0D600FAF7
      F500C4DEBF0060B15F001A971F0060B15F00C4DEBF00FAF7F500E9E0D600B28E
      76009C6C500000000000000000000000000000000000D0D9DB00FEFEFE00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00D0D9
      DB0000000000000000000000000000000000C4A99800935F4200DED0C200E9E0
      D600F3EEE800FAF7F500FCFBFA00FAF7F500F3EEE800E9E0D600DED0C200935F
      4200C4A99800000000000000000000000000C4A99800935F4200DED0C200E9E0
      D600F3EEE800FAF7F500FCFBFA00FAF7F500F3EEE800E9E0D600DED0C200935F
      4200C4A99800000000000000000000000000C4A99800935F4200DED0C200E9E0
      D600F3EEE800FAF7F500FCFBFA00FAF7F500F3EEE800E9E0D600DED0C200935F
      4200C4A9980000000000000000000000000000000000D9E0E200E0E5E700FEFE
      FE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00E0E5E700D9E0
      E2000000000000000000000000000000000000000000A77D6500AC856D00DBCC
      BD00DED1C300E2D6C900E4D9CD00E2D6C900DED1C300DBCCBD00AC856D00A77D
      65000000000000000000000000000000000000000000A77D6500AC856D00DBCC
      BD00DED1C300E2D6C900E4D9CD00E2D6C900DED1C300DBCCBD00AC856D00A77D
      65000000000000000000000000000000000000000000A77D6500AC856D00DBCC
      BD00DED1C300E2D6C900E4D9CD00E2D6C900DED1C300DBCCBD00AC856D00A77D
      6500000000000000000000000000000000000000000000000000D9E0E200D0D9
      DB00E4E9EA00F4F6F700FEFEFE00F4F6F700E4E9EA00D0D9DB00D9E0E2000000
      0000000000000000000000000000000000000000000000000000A87F67009461
      4300B28E7600C8B19D00D6C6B400C8B19D00B28E760094614300A87F67000000
      0000000000000000000000000000000000000000000000000000A87F67009461
      4300B28E7600C8B19D00D6C6B400C8B19D00B28E760094614300A87F67000000
      0000000000000000000000000000000000000000000000000000A87F67009461
      4300B28E7600C8B19D00D6C6B400C8B19D00B28E760094614300A87F67000000
      000000000000000000000000000000000000000000000000000000000000E9ED
      EE00D5DDDE00C5D0D200BCC8CB00C5D0D200D5DDDE00E9EDEE00000000000000
      000000000000000000000000000000000000000000000000000000000000CAB1
      A200A073590082462500712D080082462500A0735900CAB1A200000000000000
      000000000000000000000000000000000000000000000000000000000000CAB1
      A200A073590082462500712D080082462500A0735900CAB1A200000000000000
      000000000000000000000000000000000000000000000000000000000000CAB1
      A200A073590082462500712D080082462500A0735900CAB1A200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEE7DF00E9E0D600E7DDD300E9E0D600EEE7DF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEE7DF00E9E0D600E7DDD300E9E0D600EEE7DF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEE7DF00E9E0D600E7DDD300E9E0D600EEE7DF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E2D6
      C900DCCEBF00D9CABA00D8C9B800D9CABA00DCCEBF00E2D6C900000000000000
      000000000000000000000000000000000000000000000000000000000000E0D4
      C600D9C9B900D5C4B200D3C2AF00D5C4B200D9C9B900E0D4C600000000000000
      000000000000000000000000000000000000000000000000000000000000E2D6
      C900DCCEBF00D9CABA00D8C9B800D9CABA00DCCEBF00E2D6C900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DFD2C400B999
      83009A6A4E0081442300712C0800814423009A6A4E00B9998300DFD2C4000000
      0000000000000000000000000000000000000000000000000000DCCDBE00B593
      7B00976548007F411F00712C07007F411F0097654800B5937B00DCCDBE000000
      0000000000000000000000000000000000000000000000000000DFD2C400B999
      83009A6A4E0081442300712C0800814423009A6A4E00B9998300DFD2C4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5C3B300A2765B009664
      4800C0A28F00E4D7CF00F9F7F500E4D7CF00C0A28F0096644800A2765B00D5C3
      B3000000000000000000000000000000000000000000D2BEAD009E7054008167
      60007E93B00071A7DF0063ABF30071A7DF007E93B000816760009E705400D2BE
      AD000000000000000000000000000000000000000000D5C3B300A2765B00966B
      5200B4A19300C4C0BB00C8CBCB00C4C0BB00B4A19300966B5200A2765B00D5C3
      B300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E2D6C900A1745900B28D7600F9F8
      F500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F9F8F500B28D7600A174
      5900E2D6C900000000000000000000000000E0D4C6009E70540088878F007EB4
      EA00B3D2F000DFEBF700FAFAFB00DFEBF700B3D2F0007EB4EA0088878F009E70
      5400E0D4C600000000000000000000000000E2D6C900A1745900AD907D00CFD2
      D100CACECF00CACECF00CACECF00CACECF00CACECF00CFD2D100AD907D00A174
      5900E2D6C9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B9998300935F4100F1ECE500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F1ECE500935F
      4100B9998300000000000000000000000000B7967F0080665E007BB0E400DCE4
      EC00FEFEFD00FFFFFF00FFFFFF00FFFFFF00FEFEFD00DCE4EC007BB0E4008066
      5E00B7967F00000000000000000000000000B999830093664C00CACBC700CACE
      CF00CACECF00CACECF00CACECF00CACECF00CACECF00CACECF00CACBC7009366
      4C00B99983000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000098684B00B5937D00FAF7F500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAF7F500B593
      7D0098684B00000000000000000000000000976548007A8FAA00AAC4DF00FAF8
      F600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAF8F600AAC4DF007A8F
      AA009765480000000000000000000000000098684B00AC968600C7CACA00CACE
      CF00CACECF00CACECF00CACECF00CACECF00CACECF00CACECF00C7CACA00AC96
      860098684B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F422000D2BDAD00FCFBFA00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFBFA00D2BD
      AD007F4220000000000000000000000000007F411F006B9FD500CFD5DA00FDFC
      FB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFCFB00CFD5DA006B9F
      D5007F411F000000000000000000000000007F422000B9B0A700C8CCCC00CACE
      CF00CACECF00CACECF00CACECF00CACECF00CACECF00CACECF00C8CCCC00B9B0
      A7007F4220000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000712C0800E0D3C500FAF7F500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAF7F500E0D3
      C500712C0800000000000000000000000000712C07005EA4EA00E2D9D000FAF8
      F600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAF8F600E2D9D0005EA4
      EA00712C0700000000000000000000000000712C0800BBB9B200C7CACA00CACE
      CF00CACECF00CACECF00CACECF00CACECF00CACECF00CACECF00C7CACA00BBB9
      B200712C08000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080432100CDB7A500F3EEE800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3EEE800CDB7
      A50080432100000000000000000000000000804220006CA0D600C7C9CB00F3EE
      E900FEFEFD00FFFFFF00FFFFFF00FFFFFF00FEFEFD00F3EEE900C7C9CB006CA0
      D6008042200000000000000000000000000080432100B6ADA300C4C6C300CACE
      CF00CACECF00CACECF00CACECF00CACECF00CACECF00CACECF00C4C6C300B6AD
      A300804321000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C6C5000B28E7600E9E0D600FBFA
      F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFAF800E9E0D600B28E
      76009C6C50000000000000000000000000009B6B4F007B8FAB00A1B9D000E5DA
      CF00F3EEE900FAF8F600FDFCFB00FAF8F600F3EEE900E5DACF00A1B9D0007B8F
      AB009B6B4F000000000000000000000000009C6C5000AA928100BFBFBA00C8CC
      CB00CACECF00CACECF00CACECF00CACECF00CACECF00C8CCCB00BFBFBA00AA92
      81009C6C50000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C4A99800935F4200DED0C200E9E0
      D600F3EEE800FAF7F500FCFBFA00FAF7F500F3EEE800E9E0D600DED0C200935F
      4200C4A99800000000000000000000000000C4A997008269620078ABDE00C5C3
      C000DED1C300E5DACF00E8DED400E5DACF00DED1C300C5C3C00078ABDE008269
      6200C4A99700000000000000000000000000C4A9980093664D00BFBBB300BFBF
      BA00C4C6C300C7CACA00C8CCCC00C7CACA00C4C6C300BFBFBA00BFBBB3009366
      4D00C4A998000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A77D6500AC856D00DBCC
      BD00DED1C300E2D6C900E4D9CD00E2D6C900DED1C300DBCCBD00AC856D00A77D
      65000000000000000000000000000000000000000000A67D64008A88910078AB
      DE009FB6CC00BFBEBD00D1C2B200BFBEBD009FB6CC0078ABDE008A889100A67D
      64000000000000000000000000000000000000000000A77D6500A88A7600BDB9
      B000B9B7B100BBBAB400BCBBB600BBBAB400B9B7B100BDB9B000A88A7600A77D
      6500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A87F67009461
      4300B28E7600C8B19D00D6C6B400C8B19D00B28E760094614300A87F67000000
      0000000000000000000000000000000000000000000000000000A87F6700836A
      64007C90AD006CA0D6005DA4E9006CA0D6007C90AD00836A6400A87F67000000
      0000000000000000000000000000000000000000000000000000A87F67009468
      4E00AA928100B3A99E00B6B2AA00B3A99E00AA92810094684E00A87F67000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CAB1
      A200A073590082462500712D080082462500A0735900CAB1A200000000000000
      000000000000000000000000000000000000000000000000000000000000CAB1
      A200A073590082462500712D080082462500A0735900CAB1A200000000000000
      000000000000000000000000000000000000000000000000000000000000CAB1
      A200A073590082462500712D080082462500A0735900CAB1A200000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000800000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFF0000000000008000000000000000
      8000000000000000800000000000000080000000000000008000000000000000
      8000000000000000800000000000000080000000000000008000000000000000
      8000000000000000800000000000000080000000000000008000000000000000
      8000000000000000FFFF000000000000FFFFFFFFFFFFFFFFFFFF800080008000
      8003800080008000800380008000800080038000800080008003800080008000
      8003800080008000800380008000800080038000800080008003800080008000
      8003800080008000800380008000800080038000800080008003800080008000
      8003800080008000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003800380038003800380038003800380038003800380038003
      8003800380038003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF800380038003F03F800380038003C01F800380038003800F800380038003
      0007800380038003000780038003800300078003800380030007800380038003
      00078003800380030007800380038003800F800380038003800F800380038003
      C01F800380038003F07FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF07FF07FF07F
      FFFFE03FE03FE03FF03FC01FC01FC01FC01F800F800F800F800F000700070007
      000F000700070007000700070007000700070007000700070007000700070007
      00070007000700070007000700070007800F000700070007800F800F800F800F
      C01FC01FC01FC01FE03FE03FE03FE03FFFFFFFFFFFFFFFFFFFFFF07FF07FF07F
      FFFFE03FE03FE03FFFFFC01FC01FC01FFFFF800F800F800FFFFF000700070007
      FFFF000700070007FFFF000700070007FFFF000700070007FFFF000700070007
      FFFF000700070007FFFF000700070007FFFF000700070007FFFF800F800F800F
      FFFFC01FC01FC01FFFFFE03FE03FE03F00000000000000000000000000000000
      000000000000}
  end
end
