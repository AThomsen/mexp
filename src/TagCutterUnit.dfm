object TagCutter: TTagCutter
  Left = 573
  Top = 90
  BorderStyle = bsSingle
  Caption = 'TagCutter'
  ClientHeight = 541
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 144
    Width = 441
    Height = 113
    Caption = 'Command '
    TabOrder = 0
    object FromCountPanel: TPanel
      Left = 235
      Top = 15
      Width = 204
      Height = 96
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lblFrom: TLabel
        Left = 18
        Top = 20
        Width = 23
        Height = 13
        Alignment = taRightJustify
        Caption = 'From'
      end
      object lblCount: TLabel
        Left = 13
        Top = 52
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Count'
      end
      object FromEdit: TEdit
        Left = 48
        Top = 16
        Width = 41
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = FromEditChange
      end
      object CountEdit: TEdit
        Left = 48
        Top = 48
        Width = 41
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = CountEditChange
      end
    end
    object CutByPanel: TPanel
      Left = 235
      Top = 15
      Width = 204
      Height = 96
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object Label7: TLabel
        Left = 8
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Cut'
      end
      object Label8: TLabel
        Left = 112
        Top = 16
        Width = 74
        Height = 13
        AutoSize = False
        Caption = 'characters'
      end
      object CutByEdit: TEdit
        Left = 48
        Top = 12
        Width = 57
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 0
        Text = '0'
        OnChange = CutByEditChange
      end
    end
    object InsertPanel: TPanel
      Left = 235
      Top = 15
      Width = 204
      Height = 96
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 4
      object Label9: TLabel
        Left = 16
        Top = 8
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'Insert text:'
      end
      object InsertTextEdit: TEdit
        Left = 72
        Top = 4
        Width = 121
        Height = 21
        TabOrder = 0
        OnChange = InsertTextEditChange
      end
      object InsertRadio1: TRadioButton
        Left = 16
        Top = 40
        Width = 145
        Height = 17
        Caption = 'Insert before'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = InsertRadio1Click
      end
      object InsertRadio2: TRadioButton
        Left = 16
        Top = 56
        Width = 145
        Height = 17
        Caption = 'Append'
        TabOrder = 2
        OnClick = InsertRadio2Click
      end
      object InsertRadio3: TRadioButton
        Left = 16
        Top = 72
        Width = 129
        Height = 17
        Caption = 'Insert at position:'
        TabOrder = 3
        OnClick = InsertRadio3Click
      end
      object InsertAtPosEdit: TEdit
        Left = 136
        Top = 70
        Width = 49
        Height = 21
        TabOrder = 4
        OnChange = InsertAtPosEditChange
      end
    end
    object ReplacePanel: TPanel
      Left = 235
      Top = 15
      Width = 204
      Height = 96
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Label3: TLabel
        Left = 16
        Top = 9
        Width = 40
        Height = 13
        Alignment = taRightJustify
        Caption = 'Replace'
      end
      object Label4: TLabel
        Left = 32
        Top = 41
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'With'
      end
      object replaceFindEdit: TEdit
        Left = 64
        Top = 5
        Width = 121
        Height = 21
        TabOrder = 0
        OnChange = replaceFindEditChange
      end
      object ReplaceWithEdit: TEdit
        Left = 64
        Top = 37
        Width = 121
        Height = 21
        TabOrder = 1
        OnChange = ReplaceWithEditChange
      end
      object chkReplaceCS: TCheckBox
        Left = 64
        Top = 61
        Width = 97
        Height = 17
        Caption = 'Case-sensitive'
        TabOrder = 2
        OnClick = chkReplaceCSClick
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 15
      Width = 233
      Height = 96
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 3
      object Label1: TLabel
        Left = 18
        Top = 44
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Command'
      end
      object Label2: TLabel
        Left = 43
        Top = 8
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'Field'
      end
      object commandCB: TComboBox
        Left = 72
        Top = 40
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = commandCBChange
      end
      object FieldCB: TComboBox
        Left = 72
        Top = 4
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = FieldCBChange
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 264
    Width = 441
    Height = 177
    Caption = 'Preview '
    TabOrder = 1
    object PreviewTree: TVirtualStringTree
      Left = 8
      Top = 15
      Width = 425
      Height = 154
      Colors.TreeLineButtonColor = clBlack
      Header.AutoSizeIndex = -1
      Header.DefaultHeight = 17
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'MS Sans Serif'
      Header.Font.Style = []
      Header.Options = [hoColumnResize, hoDrag, hoVisible]
      HintAnimation = hatNone
      TabOrder = 0
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect]
      OnGetText = PreviewTreeGetText
      Columns = <
        item
          Position = 0
          Width = 200
          WideText = 'Old value'
        end
        item
          Position = 1
          Width = 200
          WideText = 'New value'
        end>
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 441
    Height = 129
    Caption = 'Commands '
    TabOrder = 2
    object Panel1: TPanel
      Left = 2
      Top = 102
      Width = 437
      Height = 25
      Align = alBottom
      TabOrder = 0
      object AddCommandBtn: TButton
        Left = 0
        Top = 0
        Width = 113
        Height = 25
        Caption = 'Add'
        TabOrder = 0
        OnClick = AddCommandBtnClick
      end
      object Button1: TButton
        Left = 112
        Top = 0
        Width = 105
        Height = 25
        Caption = 'Delete'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
    object CommandTree: TVirtualStringTree
      Left = 2
      Top = 15
      Width = 437
      Height = 87
      Align = alClient
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
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toFullRowSelect]
      OnChange = CommandTreeChange
      OnGetText = CommandTreeGetText
      Columns = <>
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 448
    Width = 441
    Height = 41
    Caption = 'Options '
    TabOrder = 3
    object updateTags: TCheckBox
      Left = 56
      Top = 16
      Width = 129
      Height = 17
      Caption = 'Update tags'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object Button3: TButton
      Left = 184
      Top = 10
      Width = 105
      Height = 25
      Caption = 'Specify Tags...'
      TabOrder = 1
      OnClick = Button3Click
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 496
    Width = 441
    Height = 41
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 4
    object StartBtn: TButton
      Left = 0
      Top = 0
      Width = 105
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = StartBtnClick
    end
    object pbar: TProgressBar
      Left = 2
      Top = 25
      Width = 437
      Height = 14
      Align = alBottom
      TabOrder = 1
    end
    object Button2: TButton
      Left = 104
      Top = 0
      Width = 105
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
  end
end
