object AskUsePlaylistForm: TAskUsePlaylistForm
  Left = 350
  Top = 213
  BorderStyle = bsDialog
  Caption = 'Use playlists extract track information'
  ClientHeight = 370
  ClientWidth = 532
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 532
    Height = 19
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    object Label1: TLabel
      Left = 3
      Top = 3
      Width = 196
      Height = 13
      Caption = 'These playlist were found while scanning.'
    end
  end
  object list: TCheckListBox
    Left = 0
    Top = 19
    Width = 532
    Height = 277
    Align = alClient
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 296
    Width = 532
    Height = 74
    Align = alBottom
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 2
    object Label2: TLabel
      Left = 3
      Top = 3
      Width = 526
      Height = 39
      Align = alTop
      Caption = 
        'If the playlist represents an album of songs in the correct orde' +
        'r, MEXP can use this order to determine the track number on each' +
        ' file in the playlist.'#13#10'Please select the lists that represents ' +
        'an album'
      WordWrap = True
    end
    object Button2: TButton
      Left = 0
      Top = 50
      Width = 75
      Height = 25
      Caption = 'All'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 74
      Top = 50
      Width = 75
      Height = 25
      Caption = 'None'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button1: TButton
      Left = 148
      Top = 50
      Width = 385
      Height = 25
      Caption = 'Continue'
      ModalResult = 1
      TabOrder = 0
    end
  end
end
