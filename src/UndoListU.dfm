object undoListForm: TundoListForm
  Left = 373
  Top = 162
  Width = 769
  Height = 558
  Caption = 'Select file operations to undo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 761
    Height = 13
    Align = alTop
    Caption = ' Select the items you want to undo'
  end
  object tree: TVirtualStringTree
    Left = 0
    Top = 13
    Width = 761
    Height = 454
    Align = alClient
    Colors.TreeLineButtonColor = clBlack
    Header.AutoSizeIndex = -1
    Header.DefaultHeight = 17
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoColumnResize, hoDblClickResize, hoVisible]
    HintAnimation = hatNone
    TabOrder = 0
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect]
    OnCompareNodes = treeCompareNodes
    OnFreeNode = treeFreeNode
    OnGetText = treeGetText
    Columns = <
      item
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
        Position = 0
        Width = 75
        WideText = 'Operation'
      end
      item
        Position = 1
        Width = 100
        WideText = 'Time'
      end
      item
        Position = 2
        Width = 340
        WideText = 'Moved from'
      end
      item
        Position = 3
        Width = 340
        WideText = 'To'
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 467
    Width = 761
    Height = 64
    Align = alBottom
    TabOrder = 1
    object pLabel: TLabel
      Left = 1
      Top = 34
      Width = 759
      Height = 13
      Align = alBottom
    end
    object pBar: TProgressBar
      Left = 1
      Top = 47
      Width = 759
      Height = 16
      Align = alBottom
      Min = 0
      Max = 100
      TabOrder = 1
    end
    object DelDirsCB: TCheckBox
      Left = 176
      Top = 4
      Width = 249
      Height = 17
      Caption = 'Delete empty directories'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object goBtn: TButton
      Left = 0
      Top = 0
      Width = 91
      Height = 25
      Caption = 'Undo selected'
      TabOrder = 0
      OnClick = goBtnClick
    end
    object closeBtn: TButton
      Left = 90
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 2
      OnClick = closeBtnClick
    end
  end
end
