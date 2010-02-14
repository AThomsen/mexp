object groupsform: Tgroupsform
  Left = 698
  Top = 124
  BorderStyle = bsDialog
  Caption = 'MEXP Groups'
  ClientHeight = 382
  ClientWidth = 194
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 8
    Top = 296
    Width = 177
    Height = 39
    Caption = 
      'Select which groups each mp3 file should be attached to by editi' +
      'ng the ID3 tag of the mp3'
    WordWrap = True
  end
  object Button1: TButton
    Left = 56
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 0
  end
  object GroupTree: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 177
    Height = 241
    ClipboardFormats.Strings = (
      'Plain text'
      'Unicode text'
      'Virtual Tree Data')
    Colors.BorderColor = clWindowText
    Colors.HotColor = clBlack
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
    HintAnimation = hatNone
    TabOrder = 1
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnChange = GroupTreeChange
    OnDragOver = GroupTreeDragOver
    OnDragDrop = GroupTreeDragDrop
    OnEditing = GroupTreeEditing
    OnGetText = GroupTreeGetText
    OnNewText = GroupTreeNewText
    Columns = <>
  end
  object Button2: TButton
    Left = 16
    Top = 256
    Width = 65
    Height = 25
    Caption = 'Add'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 112
    Top = 256
    Width = 65
    Height = 25
    Caption = 'Delete'
    Enabled = False
    TabOrder = 3
    OnClick = Button3Click
  end
end
