object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 639
  ClientWidth = 1027
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 72
    Top = 26
    Width = 69
    Height = 23
    Caption = 'File name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tw Cen MT Condensed'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 81
    Top = 66
    Width = 58
    Height = 23
    Caption = 'Register'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tw Cen MT Condensed'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 153
    Top = 146
    Width = 26
    Height = 23
    Caption = 'Key'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tw Cen MT Condensed'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 497
    Top = 146
    Width = 30
    Height = 23
    Caption = 'Text'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tw Cen MT Condensed'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 793
    Top = 146
    Width = 145
    Height = 23
    Caption = 'Cipher/Decipher text'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tw Cen MT Condensed'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 169
    Top = 29
    Width = 496
    Height = 24
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 671
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Open file'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo2: TMemo
    Left = 169
    Top = 69
    Width = 496
    Height = 24
    Lines.Strings = (
      'Memo2')
    TabOrder = 2
    OnKeyPress = Memo2KeyPress
  end
  object Memo3: TMemo
    Left = 16
    Top = 175
    Width = 329
    Height = 418
    Lines.Strings = (
      'Memo3')
    TabOrder = 3
  end
  object Memo4: TMemo
    Left = 351
    Top = 175
    Width = 330
    Height = 418
    Lines.Strings = (
      'Memo4')
    TabOrder = 4
  end
  object Memo5: TMemo
    Left = 687
    Top = 175
    Width = 330
    Height = 418
    Lines.Strings = (
      'Memo5')
    TabOrder = 5
  end
  object Button2: TButton
    Left = 433
    Top = 606
    Width = 75
    Height = 25
    Caption = 'Encrypt'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tw Cen MT Condensed'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 534
    Top = 606
    Width = 75
    Height = 25
    Caption = 'Decrypt'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tw Cen MT Condensed'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button4: TButton
    Left = 768
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Save file'
    TabOrder = 8
    OnClick = Button4Click
  end
  object OpenDialog1: TOpenDialog
    Left = 688
    Top = 72
  end
  object SaveDialog1: TSaveDialog
    Left = 784
    Top = 72
  end
end
