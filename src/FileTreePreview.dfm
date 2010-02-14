object FilePreviewForm: TFilePreviewForm
  Left = 370
  Top = 114
  Width = 552
  Height = 566
  Caption = 'Preview'
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
  object tree: TVirtualStringTree
    Left = 0
    Top = 24
    Width = 544
    Height = 481
    Align = alClient
    Colors.TreeLineButtonColor = clBlack
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
    HintAnimation = hatNone
    StateImages = MainForm.TreeImgs
    TabOrder = 0
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    OnCompareNodes = treeCompareNodes
    OnFreeNode = treeFreeNode
    OnGetText = treeGetText
    OnGetImageIndex = treeGetImageIndex
    Columns = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 505
    Width = 544
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 208
      Top = 4
      Width = 249
      Height = 33
      AutoSize = False
      Caption = 
        'This will be your disk structure after the files have been moved' +
        '. Proceed?'
      WordWrap = True
    end
    object Button1: TButton
      Left = 8
      Top = 4
      Width = 81
      Height = 24
      Caption = 'Proceed'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 104
      Top = 4
      Width = 81
      Height = 24
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object ExpandCollapsePanel: TPanel
    Left = 0
    Top = 0
    Width = 544
    Height = 24
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 2
    OnResize = ExpandCollapsePanelResize
    object ExpandAll: TButton
      Left = 0
      Top = 0
      Width = 78
      Height = 24
      Caption = 'Expand all'
      TabOrder = 0
      OnClick = ExpandAllClick
    end
    object CollapseAll: TButton
      Left = 408
      Top = 0
      Width = 70
      Height = 24
      Caption = 'Collapse all'
      TabOrder = 1
      OnClick = CollapseAllClick
    end
  end
end
