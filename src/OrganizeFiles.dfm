object OrgFiles: TOrgFiles
  Left = 415
  Top = 172
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Organize Files Wizard'
  ClientHeight = 558
  ClientWidth = 671
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object loadinglabel: TLabel
    Left = 0
    Top = 527
    Width = 671
    Height = 15
    Align = alBottom
    AutoSize = False
  end
  object pbar: TProgressBar
    Left = 0
    Top = 542
    Width = 671
    Height = 16
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 500
    Width = 671
    Height = 27
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Go!'
      TabOrder = 0
      OnClick = Button1Click
    end
    object CloseBtn: TButton
      Left = 74
      Top = 0
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Close'
      ModalResult = 2
      TabOrder = 1
      OnClick = CloseBtnClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 671
    Height = 500
    Align = alClient
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 168
      Width = 40
      Height = 13
      Caption = 'Pattern:'
    end
    object Label2: TLabel
      Left = 192
      Top = 154
      Width = 268
      Height = 13
      Caption = 'F2 to edit values. Drag and drop drives to change order'
    end
    object Label3: TLabel
      Left = 520
      Top = 240
      Width = 137
      Height = 73
      AutoSize = False
      Caption = 
        'If all songs in a directory has the same artist, also move all o' +
        'ther files in that directory'
      WordWrap = True
      OnMouseDown = Label3MouseDown
    end
    object deldirsbox: TCheckBox
      Left = 496
      Top = 152
      Width = 169
      Height = 17
      Caption = 'Delete empty directories'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object SU: TCheckBox
      Left = 496
      Top = 176
      Width = 169
      Height = 17
      Caption = 'save undo file'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object DriveOpt: TRadioGroup
      Left = 32
      Top = 256
      Width = 449
      Height = 89
      Caption = 'Drive options '
      ItemIndex = 1
      Items.Strings = (
        'Keep files in their current directory'
        'Keep files on their current drive'
        
          'All tracks with the same artist should be placed on the same dri' +
          've'
        'Start from 0..9, A, B, C from drive 1')
      TabOrder = 2
      OnClick = DriveOptClick
    end
    object driveTree: TVirtualStringTree
      Left = 24
      Top = 8
      Width = 617
      Height = 137
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
      Header.Options = [hoColumnResize, hoDrag, hoVisible]
      HintAnimation = hatNone
      StateImages = MainForm.TreeImgs
      TabOrder = 3
      TreeOptions.MiscOptions = [toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toExtendedFocus]
      OnChecked = driveTreeChecked
      OnDragAllowed = driveTreeDragAllowed
      OnDragOver = driveTreeDragOver
      OnDragDrop = driveTreeDragDrop
      OnEditing = driveTreeEditing
      OnFreeNode = driveTreeFreeNode
      OnGetText = driveTreeGetText
      OnGetImageIndex = driveTreeGetImageIndex
      OnMouseDown = driveTreeMouseDown
      OnNewText = driveTreeNewText
      Columns = <
        item
          Options = [coAllowClick, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
          Position = 0
          Width = 36
          WideText = 'Use'
        end
        item
          Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
          Position = 1
          Width = 134
          WideText = 'Drive'
        end
        item
          Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
          Position = 2
          Width = 160
          WideText = 'Root directory'
        end
        item
          Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
          Position = 3
          Width = 94
          WideText = 'Free Space (mb)'
        end
        item
          Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
          Position = 4
          Width = 174
          WideText = 'Leave free space after move (mb)'
        end>
    end
    object UseCompilationPattern: TCheckBox
      Left = 16
      Top = 216
      Width = 265
      Height = 17
      Caption = 'Use special pattern for "Compilation" files:'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = UseCompilationPatternClick
    end
    object ScrollBox1: TScrollBox
      Left = 32
      Top = 352
      Width = 625
      Height = 145
      TabOrder = 5
      object patternHelp: TLabel
        Left = 8
        Top = 8
        Width = 38
        Height = 13
        Caption = 'helpTXT'
      end
    end
    object ShowPreview: TCheckBox
      Left = 496
      Top = 200
      Width = 169
      Height = 17
      Caption = 'Show preview'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object MoveOtherFiles: TCheckBox
      Left = 496
      Top = 224
      Width = 169
      Height = 17
      Caption = 'Move other files'
      TabOrder = 7
    end
    object patternEdit: TComboBox
      Left = 32
      Top = 184
      Width = 441
      Height = 21
      ItemHeight = 13
      TabOrder = 8
      Text = '%artist%\%album%\%track0%. %title%'
    end
    object compilationPatternEdit: TComboBox
      Left = 32
      Top = 232
      Width = 441
      Height = 21
      ItemHeight = 13
      TabOrder = 9
      Text = '%album%\%track0%. %artist% - %title%'
    end
  end
  object saveD: TSaveDialog
    DefaultExt = 'undo'
    FileName = 'Organize Files Wizard Undo'
    Filter = 'undo files|*.undo'
    Title = 'Save to a new file or select an existing file to append it'
    Left = 608
    Top = 456
  end
  object FF: TJvSearchFiles
    DirOption = doExcludeSubDirs
    FileParams.FileMasks.Strings = (
      '*.*')
    Left = 608
    Top = 384
  end
end
