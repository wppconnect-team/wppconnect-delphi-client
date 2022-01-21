object FInputPhone: TFInputPhone
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Adress Phone'
  ClientHeight = 80
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 80
    Height = 13
    Caption = 'Adresser Phone:'
  end
  object EditAdressPhone: TMaskEdit
    Left = 8
    Top = 24
    Width = 199
    Height = 21
    EditMask = '99 (99) 9 9999-9999;0;_'
    MaxLength = 19
    TabOrder = 0
    Text = '55'
  end
  object Button1: TButton
    Left = 136
    Top = 51
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 55
    Top = 51
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
  end
end
