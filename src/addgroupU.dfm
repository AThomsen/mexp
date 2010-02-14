object addgroup: Taddgroup
  Left = 348
  Top = 148
  BorderStyle = bsDialog
  Caption = 'Group not found'
  ClientHeight = 212
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 297
    Height = 89
    Alignment = taCenter
    AutoSize = False
    Caption = 'title'
    Layout = tlCenter
    WordWrap = True
  end
  object Label2: TLabel
    Left = 8
    Top = 104
    Width = 297
    Height = 25
    AutoSize = False
    Caption = 
      'You can add the defined group to your own groups, or use an exis' +
      'ting group by selecting the group in the list.'
    WordWrap = True
  end
  object Button1: TButton
    Left = 8
    Top = 144
    Width = 145
    Height = 25
    Caption = 'Add group to database'
    Default = True
    ModalResult = 6
    TabOrder = 0
  end
  object Button2: TButton
    Left = 320
    Top = 176
    Width = 145
    Height = 25
    Cancel = True
    Caption = 'Always ignore this group'
    ModalResult = 2
    TabOrder = 1
  end
  object Button3: TButton
    Left = 320
    Top = 144
    Width = 145
    Height = 25
    Caption = 'Use selected group instead'
    TabOrder = 2
    OnClick = Button3Click
  end
  object ListBox1: TListBox
    Left = 320
    Top = 8
    Width = 145
    Height = 129
    ItemHeight = 13
    TabOrder = 3
  end
  object Button4: TButton
    Left = 168
    Top = 144
    Width = 145
    Height = 25
    Caption = 'Remove group from tag'
    ModalResult = 7
    TabOrder = 4
  end
  object Button5: TButton
    Left = 8
    Top = 176
    Width = 305
    Height = 25
    Caption = 'Remove group from tag on all files'
    ModalResult = 9
    TabOrder = 5
  end
end
