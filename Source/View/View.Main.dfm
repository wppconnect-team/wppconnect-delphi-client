object MainView: TMainView
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'ZW '
  ClientHeight = 586
  ClientWidth = 1066
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
  OnShow = FormShow
  DesignSize = (
    1066
    586)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox3: TGroupBox
    Left = 856
    Top = 8
    Width = 202
    Height = 227
    Anchors = [akTop, akRight]
    Caption = '  QR Code   '
    TabOrder = 2
    object Image1: TImage
      AlignWithMargins = True
      Left = 7
      Top = 20
      Width = 188
      Height = 195
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 10
      Align = alClient
      Proportional = True
      Stretch = True
      ExplicitLeft = 0
      ExplicitTop = 18
      ExplicitWidth = 201
      ExplicitHeight = 202
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 567
    Width = 1066
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 129
    Width = 608
    Height = 435
    ActivePage = TabSheet1
    TabOrder = 4
    object TabSheet1: TTabSheet
      Caption = 'Chat Functions'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 600
        Height = 407
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object GroupBox4: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 592
          Height = 206
          Align = alTop
          Caption = '  Chat   '
          TabOrder = 0
          object RichEditMyChat: TRichEdit
            AlignWithMargins = True
            Left = 7
            Top = 20
            Width = 578
            Height = 174
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 10
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Zoom = 100
          end
        end
        object GroupBox5: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 216
          Width = 592
          Height = 187
          Align = alClient
          Caption = '  Mensagem   '
          TabOrder = 1
          object RichEditMessage: TRichEdit
            AlignWithMargins = True
            Left = 7
            Top = 20
            Width = 578
            Height = 155
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 10
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Zoom = 100
          end
        end
      end
    end
    object TabSheetLogs: TTabSheet
      Caption = 'Errors'
      ImageIndex = 1
      object PanelLogs: TPanel
        Left = 0
        Top = 0
        Width = 600
        Height = 407
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object RichEditLogs: TRichEdit
          Left = 1
          Top = 1
          Width = 598
          Height = 405
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 10
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Zoom = 100
        end
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 608
    Height = 115
    Caption = '  Configura'#231#245'es   '
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 20
      Width = 97
      Height = 13
      Caption = 'My Number Session:'
    end
    object Label3: TLabel
      Left = 142
      Top = 20
      Width = 52
      Height = 13
      Caption = 'Hostname:'
    end
    object Label4: TLabel
      Left = 297
      Top = 20
      Width = 24
      Height = 13
      Caption = 'Port:'
    end
    object Label5: TLabel
      Left = 349
      Top = 20
      Width = 51
      Height = 13
      Caption = 'My secret:'
    end
    object Label1: TLabel
      Left = 8
      Top = 63
      Width = 129
      Height = 13
      Caption = 'Process Unread Messages:'
    end
    object MaskEditMyNumber: TMaskEdit
      Left = 8
      Top = 36
      Width = 126
      Height = 21
      EditMask = '99 (99) 9 9999-9999;0;_'
      MaxLength = 19
      TabOrder = 0
      Text = '5538998760341'
    end
    object EditHostname: TEdit
      Left = 142
      Top = 36
      Width = 149
      Height = 21
      TabOrder = 1
      Text = 'wpp.speedysistemas.com.br'
    end
    object EditPort: TEdit
      Left = 297
      Top = 36
      Width = 46
      Height = 21
      NumbersOnly = True
      TabOrder = 2
      Text = '17111'
    end
    object EditSecret: TEdit
      Left = 349
      Top = 39
      Width = 250
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
      Text = 'gN3FivW}C4{M;!]:kPpryXm!Pf1o3o'
    end
    object ComboBoxProcessUnreadMessages: TComboBox
      Left = 8
      Top = 79
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 4
      Text = 'No'
      Items.Strings = (
        'Yes'
        'No')
    end
  end
  object GroupBox2: TGroupBox
    Left = 622
    Top = 8
    Width = 228
    Height = 100
    Caption = '  Session   '
    TabOrder = 1
    object BotaoStartStopSession: TButton
      Left = 2
      Top = 15
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Iniciar'
      TabOrder = 0
      OnClick = BotaoStartStopSessionClick
    end
    object BotaoLogOutSession: TButton
      Left = 2
      Top = 40
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'LogOut Session'
      TabOrder = 1
      OnClick = BotaoLogOutSessionClick
    end
    object BotaoCloseSession: TButton
      Left = 2
      Top = 65
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Close Session'
      TabOrder = 2
      OnClick = BotaoLogOutSessionClick
    end
  end
  object GroupBox7: TGroupBox
    Left = 622
    Top = 114
    Width = 228
    Height = 146
    Caption = '  Message   '
    TabOrder = 3
    object BotaoSendTextMessage: TButton
      Left = 2
      Top = 15
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Send Message'
      TabOrder = 0
      OnClick = BotaoSendTextMessageClick
    end
    object BotaoSendLocation: TButton
      Left = 2
      Top = 90
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Send Location'
      TabOrder = 3
      OnClick = BotaoSendLocationClick
    end
    object BotaoSendVCard: TButton
      Left = 2
      Top = 65
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Send VCard'
      TabOrder = 2
      OnClick = BotaoSendVCardClick
    end
    object BotaoSendLinkPreview: TButton
      Left = 2
      Top = 115
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Send Link Preview'
      TabOrder = 4
      OnClick = BotaoSendVCardClick
    end
    object BotaoSendFileMessage: TButton
      Left = 2
      Top = 40
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Send Message With File (mp3, jpg, pdf, ect.)'
      TabOrder = 1
      WordWrap = True
      OnClick = BotaoSendFileMessageClick
    end
  end
  object GroupBox8: TGroupBox
    Left = 622
    Top = 266
    Width = 228
    Height = 74
    Caption = '  Device   '
    TabOrder = 5
    object BotaoBatteryStatus: TButton
      Left = 2
      Top = 15
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Status Battery'
      TabOrder = 0
      OnClick = BotaoBatteryStatusClick
    end
    object BotaoStatusNumber: TButton
      Left = 2
      Top = 40
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Status Number'
      TabOrder = 1
      OnClick = BotaoStatusNumberClick
    end
  end
  object GroupBox6: TGroupBox
    Left = 622
    Top = 346
    Width = 228
    Height = 97
    Caption = '  Chat   '
    TabOrder = 6
    object BotaoDownloadFile: TButton
      Left = 2
      Top = 15
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Download File'
      TabOrder = 0
      OnClick = BotaoDownloadFileClick
    end
    object BotaoClearChat: TButton
      Left = 2
      Top = 40
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Clear Chat'
      TabOrder = 1
      OnClick = BotaoClearChatClick
    end
    object BotaoGetChatById: TButton
      Left = 2
      Top = 65
      Width = 224
      Height = 25
      Align = alTop
      Caption = 'Get Chat By Id'
      TabOrder = 2
      OnClick = BotaoGetChatByIdClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 487
    Top = 228
  end
end
