object renameForm: TrenameForm
  Left = 349
  Top = 155
  AutoSize = True
  BorderStyle = bsDialog
  BorderWidth = 8
  Caption = 'File already exists'
  ClientHeight = 225
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object topLabel: TLabel
    Left = 0
    Top = 0
    Width = 491
    Height = 24
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Error moving the file'
    Layout = tlCenter
    WordWrap = True
  end
  object file1Label: TLabel
    Left = 0
    Top = 24
    Width = 491
    Height = 14
    Align = alTop
    Alignment = taCenter
    Caption = 'file1Label'
    Layout = tlCenter
    OnDblClick = file1LabelDblClick
  end
  object toLabel: TLabel
    Left = 0
    Top = 38
    Width = 491
    Height = 30
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'To'
    Layout = tlCenter
  end
  object file2Label: TLabel
    Left = 0
    Top = 68
    Width = 491
    Height = 14
    Align = alTop
    Alignment = taCenter
    Caption = 'file2Label'
    Layout = tlCenter
    OnDblClick = file2LabelDblClick
  end
  object ButLabel: TLabel
    Left = 0
    Top = 82
    Width = 491
    Height = 28
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'The target filename already exists!'
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 8
    Top = 136
    Width = 97
    Height = 14
    Caption = 'Rename to filename:'
  end
  object Label1: TLabel
    Left = 0
    Top = 110
    Width = 491
    Height = 12
    Align = alTop
    Alignment = taCenter
    Caption = '(doubleclick a file to play it)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
  end
  object newNameEdit: TEdit
    Left = 16
    Top = 152
    Width = 449
    Height = 22
    TabOrder = 0
    OnChange = newNameEditChange
  end
  object OvrBtn: TButton
    Left = 112
    Top = 200
    Width = 97
    Height = 25
    Caption = '&Overwrite target'
    ModalResult = 3
    TabOrder = 1
  end
  object delBtn: TButton
    Left = 0
    Top = 200
    Width = 97
    Height = 25
    Caption = '&Delete source'
    ModalResult = 1
    TabOrder = 2
  end
  object renameBut: TButton
    Left = 232
    Top = 200
    Width = 75
    Height = 25
    Caption = '&Rename'
    Enabled = False
    ModalResult = 4
    TabOrder = 3
  end
  object cancelBtn: TButton
    Left = 416
    Top = 200
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
