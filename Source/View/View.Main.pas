unit View.Main;

interface

uses
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  REST.Client,
  System.Classes,
  System.Generics.Collections,
  System.Json,
  System.SysUtils,
  System.Variants,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.DBGrids,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Grids,
  Vcl.Imaging.pngimage,
  Vcl.Mask,
  Vcl.StdCtrls,
  Winapi.Messages,
  Winapi.Windows,
  //
  Bcl.Json,

  JvButton,
  JvCtrls,
  JvExStdCtrls,
  //
  ZW.Controller.ZW,
  ZW.Model,
  ZW.Utils.LibUtils,
  View.InputPhone;

type
  TLevelUserChat = (luWelcome, luInputName, luInputOption, luTalking);

  TChatClientMessage = class
  private
    FId: string;
    FTimestamp: TDateTime;
    FMessage: string;

    procedure SetId(const Value: string);
    procedure SetMessage(const Value: string);
    procedure SetTimestamp(const Value: TDateTime);
  public
    property Id: string read FId write SetId;
    property Timestamp: TDateTime read FTimestamp write SetTimestamp;
    property Message_: string read FMessage write SetMessage;
  end;

  TChatClient = class
  private
    FName: string;
    FPhone: string;
    FLevel: TLevelUserChat;
    FMessages: TList<TChatClientMessage>;

    procedure SetName(const Value: string);
    procedure SetPhone(const Value: string);
    procedure SetLevel(const Value: TLevelUserChat);
  public
    constructor Create;
    destructor Destroy; override;

    procedure NewMessage(AMessage: TMessageModel);
    function MessageExists(AId: string): Boolean;

    property Name: string read FName write SetName;
    property Phone: string read FPhone write SetPhone;
    property Level: TLevelUserChat read FLevel write SetLevel;

    property Messages: TList<TChatClientMessage> read FMessages;
  end;

  TChatBot = class
  private
    FClients: TList<TChatClient>;
    FOwner: TZWController;

    procedure GetOptions(AUser: TChatClient);
    function SendFile(AClient: TChatClient; AFileName: string): Boolean;
  public
    constructor Create(AOwner: TZWController);
    destructor Destroy; override;

    function AddClient(APhone: string): TChatClient;
    function FindClient(APhone: string): TChatClient;
    procedure CloseChat(AClient: TChatClient);

    property Clients: TList<TChatClient> read FClients;
  end;

  TStatusConexao = (tsConnected);

  TMainView = class(TForm)
    GroupBox3: TGroupBox;
    Image1: TImage;
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MaskEditMyNumber: TMaskEdit;
    EditHostname: TEdit;
    EditPort: TEdit;
    EditSecret: TEdit;
    Panel1: TPanel;
    GroupBox4: TGroupBox;
    RichEditMyChat: TRichEdit;
    GroupBox5: TGroupBox;
    RichEditMessage: TRichEdit;
    TabSheetLogs: TTabSheet;
    PanelLogs: TPanel;
    RichEditLogs: TRichEdit;
    GroupBox2: TGroupBox;
    BotaoStartStopSession: TButton;
    BotaoLogOutSession: TButton;
    BotaoCloseSession: TButton;
    GroupBox7: TGroupBox;
    BotaoSendTextMessage: TButton;
    BotaoSendLocation: TButton;
    BotaoSendVCard: TButton;
    BotaoSendLinkPreview: TButton;
    BotaoSendFileMessage: TButton;
    GroupBox8: TGroupBox;
    BotaoBatteryStatus: TButton;
    BotaoStatusNumber: TButton;
    GroupBox6: TGroupBox;
    BotaoDownloadFile: TButton;
    BotaoClearChat: TButton;
    BotaoGetChatById: TButton;
    ComboBoxProcessUnreadMessages: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BotaoSendFileMessageClick(Sender: TObject);
    procedure BotaoSendTextMessageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BotaoStartStopSessionClick(Sender: TObject);
    procedure BotaoCloseSessionClick(Sender: TObject);
    procedure BotaoSendLocationClick(Sender: TObject);
    procedure BotaoSendVCardClick(Sender: TObject);
    procedure BotaoBatteryStatusClick(Sender: TObject);
    procedure BotaoStatusNumberClick(Sender: TObject);
    procedure BotaoGetChatByIdClick(Sender: TObject);
    procedure BotaoClearChatClick(Sender: TObject);
    procedure BotaoDownloadFileClick(Sender: TObject);
    procedure BotaoLogOutSessionClick(Sender: TObject);
  private
    FZW: TZWController;
    FChatBot: TChatBot;

    procedure LoadSettings;
    procedure OnStatusSession(AStatusSession: TStatusSession);
    procedure OnQrCode(AQrCodeBase64: string);
    procedure OnError(AError: string);
    procedure OnUnreadMessage(AUnreadMessage: TList<TResponseModel>);
    procedure OnRequest(ARestRequest: TRestRequest);
  public
  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

uses
  System.DateUtils;

{$REGION 'TChatClientMessage'}
procedure TChatClientMessage.SetId(const Value: string);
begin
  FId := Value;
end;

procedure TChatClientMessage.SetMessage(const Value: string);
begin
  FMessage := Value;
end;

procedure TChatClientMessage.SetTimestamp(const Value: TDateTime);
begin
  FTimestamp := Value;
end;
{$ENDREGION 'TChatClientMessage'}

{$REGION 'TChatClient'}
constructor TChatClient.Create;
begin
  FMessages := TList<TChatClientMessage>.Create;
end;

destructor TChatClient.Destroy;
var
  I: Integer;
begin
  for I := FMessages.Count - 1 downto 0 do
  begin
    FMessages[I].Free;
    FMessages.Delete(I);
  end;
  FreeAndNil(FMessages);

  Inherited;
end;

procedure TChatClient.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TChatClient.SetPhone(const Value: string);
begin
  FPhone := Value;
end;

procedure TChatClient.SetLevel(const Value: TLevelUserChat);
begin
  FLevel := Value;
end;

function TChatClient.MessageExists(AId: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FMessages.Count - 1 do
  begin
    Result := FMessages[I].Id = AId;
    if Result then
      Break;
  end;
end;

procedure TChatClient.NewMessage(AMessage: TMessageModel);
var
  Message_: TChatClientMessage;
begin
  Message_ := TChatClientMessage.Create;
  Message_.Id := AMessage.Id;
  Message_.Timestamp := UnixToDateTime(StrToInt(AMessage.Timestamp.ToString), False);
  Message_.Message_ := AMessage.Body;
  FMessages.Add(Message_);
end;
{$ENDREGION 'TChatClient'}

{$REGION 'TChatBot'}
constructor TChatBot.Create(AOwner: TZWController);
begin
  FClients := TList<TChatClient>.Create;
  FOwner := AOwner;
end;

destructor TChatBot.Destroy;
var
  I: Integer;
begin
  for I := FClients.Count - 1 downto 0 do
  begin
    FClients[I].Free;
    FClients.Delete(I);
  end;
  FreeAndNil(FClients);

  Inherited;
end;

procedure TChatBot.GetOptions(AUser: TChatClient);
var
  FOptions: string;
begin
  if AUser.Level <> luInputOption then
    Exit;
  FOptions := 'Olá, *' + AUser.Name + '* Digite o número da opção desejada:' + #13#10 + '*1* - Suporte ' + #13#10 + '*2* - Boleto ' + #13#10 + '*3* - Proposta ' + #13#10 +
    '*4* - Contato ' + #13#10 + '*5* - Endereço ' + #13#10 + '*X* - Sair ';
  FOwner.SendMessage(AUser.Phone, FOptions);
end;

function TChatBot.SendFile(AClient: TChatClient; AFileName: string): Boolean;
begin
  AFileName := ExtractFilePath(Application.ExeName) + AFileName;
  Result := FileExists(AFileName);
  if Result then
  begin
    try
      FOwner.SendFile(AClient.Phone, AFileName, ExtractFileName(AFileName));
    except
      Result := False;
    end;
  end;
end;

function TChatBot.AddClient(APhone: string): TChatClient;
begin
  Result := TChatClient.Create;
  Result.Phone := APhone;
  Result.Level := luWelcome;
  FClients.Add(Result);
end;

function TChatBot.FindClient(APhone: string): TChatClient;
var
  I: Integer;
begin
  Result := nil;
  for I := FClients.Count - 1 downto 0 do
  begin
    if FClients[I].Phone = APhone then
    begin
      Result := FClients[I];
      Break;
    end;
  end;
end;

procedure TChatBot.CloseChat(AClient: TChatClient);
var
  I: Integer;
begin
  FOwner.SendMessage(AClient.Phone, 'Agrademos pelo contato, ' + #13#10 + 'Atendimento encerrado!');
  FOwner.DeleteChat(AClient.Phone);

  for I := FClients.Count - 1 downto 0 do
  begin
    if FClients[I] = AClient then
    begin
      FClients[I].Free;
      FClients.Delete(I);
      FClients.TrimExcess;
      Break;
    end;
  end;
end;
{$ENDREGION 'TChatBot'}

{$REGION 'TMainView'}
procedure TMainView.FormCreate(Sender: TObject);
begin
  FZW := TZWController.Create(Self);
  FZW.OnStatusSession := OnStatusSession;
  FZW.OnQrCode := OnQrCode;
  FZW.OnUnreadMessage := OnUnreadMessage;
  FZW.OnError := OnError;
  FZW.UnreadMessage := True;
  FZW.OnRequest := OnRequest;

  FChatBot := TChatBot.Create(FZW);
end;

procedure TMainView.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FChatBot);
  FreeAndNil(FZW);
end;

procedure TMainView.FormShow(Sender: TObject);
begin
  RichEditMessage.SetFocus;
end;

procedure TMainView.LoadSettings;
begin
  //Configurações do servidor
  FZW.Settings.Server.HostName := EditHostname.Text;
  FZW.Settings.Server.Port := StrToInt(EditPort.Text);
  FZW.Settings.Server.Session := MaskEditMyNumber.Text;
  FZW.Settings.Server.SecretKey := EditSecret.Text;
end;

procedure TMainView.OnStatusSession(AStatusSession: TStatusSession);
begin
  case AStatusSession of
    tssNone:
      StatusBar1.Panels[0].Text := '';
    tssClosed:
      StatusBar1.Panels[0].Text := 'Desconectado';
    tssInitializing:
      StatusBar1.Panels[0].Text := 'Inicializando';
    tssQrCode:
      StatusBar1.Panels[0].Text := 'Aguardando QRCode';
    tssConnected:
      begin
        StatusBar1.Panels[0].Text := 'Conectado';
        Image1.Picture := nil;
      end;
  end;
end;

procedure TMainView.OnQrCode(AQrCodeBase64: string);
begin
  Base64ToQrCode(AQrCodeBase64, Image1);
end;

procedure TMainView.OnError(AError: string);
begin
  RichEditLogs.Lines.Add(AError);
  RichEditLogs.Lines.Add(StringOfChar('-', 20));
end;

procedure TMainView.OnRequest(ARestRequest: TRestRequest);
begin
  RichEditLogs.Lines.Add(ARestRequest.Response.ToString);
  RichEditLogs.Lines.Add(StringOfChar('-', 20));
end;

procedure TMainView.OnUnreadMessage(AUnreadMessage: TList<TResponseModel>);
var
  Client: TChatClient;
  Message_: TMessageModel;
  Option: Integer;
  I, X: Integer;
begin
  for I := 0 to AUnreadMessage.Count - 1 do
  begin
    for X := 0 to AUnreadMessage[I].Messages.Count - 1 do
    begin
      Message_ := AUnreadMessage[I].Messages[X];
      Client := FChatBot.FindClient(Message_.ChatId.User);
      if not Assigned(Client) then
      begin
        Client := FChatBot.AddClient(Message_.ChatId.User);
        FZW.SendMessage(Client.Phone, 'Olá, sou *ZW*, com quem estou falando?');
      end;

      if (not Client.MessageExists(Message_.Id)) and (MinutesBetween(UnixToDateTime(Message_.Timestamp, False), Now()) < 5) then
      begin
        Client.NewMessage(Message_);
        case Client.Level of
          luWelcome:
            Client.Level := luInputName;
          luInputName:
            begin
              if Length(Message_.Body.Trim) < 2 then
                FZW.SendMessage(Client.Phone, 'Preciso que me informe o seu nome:')
              else
              begin
                Client.Name := Message_.Body.Trim;
                Client.Level := luInputOption;
                FChatBot.GetOptions(Client);
              end;
            end;
          luInputOption:
            begin
              Option := StrToIntDef(Message_.Body.Trim, -1);
              case Option of
                1:
                  begin
                    FZW.SendMessage(Client.Phone, 'Aguarde, você é próximo a ser atendido!');
                    FZW.SendMessage(Client.Phone, 'Olá sou *Fulano*, como posso lhe ajudar?');
                    Client.Level := luTalking;
                  end;
                2:
                  begin
                    if not FChatBot.SendFile(Client, Format('Boleto-%s.pdf', [Client.Phone])) then
                      FZW.SendMessage(Client.Phone, 'Não existe(m) fatura(s) em aberto.');
                    FChatBot.CloseChat(Client);
                  end;
                3:
                  begin
                    if not FChatBot.SendFile(Client, 'Proposta.pdf') then
                      FZW.SendMessage(Client.Phone, 'Proposta indiponível no momento.');
                    FChatBot.CloseChat(Client);
                  end;
                4:
                  begin
                    FZW.SendMessage(Client.Phone, 'Certo, momento que já lhe envio nossos contatos.');
                    FZW.SendContactVCard(Client.Phone, '5538997289136@c.us', 'SPEEDY SISTEMAS', False);
                    FChatBot.CloseChat(Client);
                  end;
                5:
                  begin
                    FZW.SendMessage(Client.Phone, 'Estou lhe enviando a localização de nossa empresa, momento...');
                    FZW.SendLocation(Client.Phone, -16.705869452292156, -43.84391795924117, 'SPEEDY');
                    FChatBot.CloseChat(Client);
                  end
              else
                begin
                  if Message_.Body.Trim.ToUpper = 'X' then
                  begin
                    FChatBot.CloseChat(Client);
                  end
                  else
                  begin
                    FChatBot.GetOptions(Client);
                  end;
                end;
              end;
            end;
          luTalking:
            begin
              if Message_.Body.Trim.ToUpper = 'X' then
              begin
                FChatBot.CloseChat(Client)
              end
              else
              begin
                RichEditMyChat.Lines.Add(Format('%s as %s:', [Client.Name, FormatDateTime('hh:ss', Time)]));
                RichEditMyChat.Lines.Add(Message_.Body);
              end;
            end;
        end;
        if Message_.IsMedia then
          TThread.Queue(TThread.Current,
            procedure
            begin
              FZW.DownloadFile(Message_.Id);
            end);
      end;
      FZW.SendSeen(Client.Phone);
    end;
  end;
end;

procedure TMainView.BotaoStartStopSessionClick(Sender: TObject);
begin
  if BotaoStartStopSession.Caption = 'Iniciar' then
  begin
    LoadSettings;
    FZW.UnreadMessage := (ComboBoxProcessUnreadMessages.ItemIndex = 0);
    BotaoStartStopSession.Caption := 'Parar';
    FZW.Active := True;
  end
  else
  begin
    FZW.Active := False;
    Image1.Picture := nil;
    StatusBar1.Panels[0].Text := 'Servidor Parado';
    BotaoStartStopSession.Caption := 'Iniciar';
  end;
end;

procedure TMainView.BotaoCloseSessionClick(Sender: TObject);
begin
  FZW.CloseSession;
end;

procedure TMainView.BotaoLogOutSessionClick(Sender: TObject);
begin
  LoadSettings;
  FZW.LogOutSession;
end;

procedure TMainView.BotaoSendTextMessageClick(Sender: TObject);
var
  Phone: string;
begin
  FInputPhone.ShowModal;
  if FInputPhone.ModalResult = mrOk then
  begin
    Phone := FInputPhone.EditAdressPhone.Text;
    FZW.SendMessage(Phone, RichEditMessage.Text)
  end;
end;

procedure TMainView.BotaoSendFileMessageClick(Sender: TObject);
var
  Phone: string;
begin
  FInputPhone.ShowModal;
  if FInputPhone.ModalResult = mrOk then
  begin
    Phone := FInputPhone.EditAdressPhone.Text;
    if OpenDialog1.Execute then
    begin
      FZW.SendFile(Phone, OpenDialog1.FileName);
    end;
  end;
end;

procedure TMainView.BotaoSendVCardClick(Sender: TObject);
var
  Phone: string;
begin
  FInputPhone.ShowModal;
  if FInputPhone.ModalResult = mrOk then
  begin
    Phone := FInputPhone.EditAdressPhone.Text;
    if OpenDialog1.Execute then
    begin
      FZW.SendContactVCard(Phone, '5538999760687@c.us', 'Diego Melo', False);
    end;
  end;
end;

procedure TMainView.BotaoSendLocationClick(Sender: TObject);
var
  Phone: string;
begin
  FInputPhone.ShowModal;
  if FInputPhone.ModalResult = mrOk then
  begin
    Phone := FInputPhone.EditAdressPhone.Text;
    if OpenDialog1.Execute then
    begin
      FZW.SendLocation(Phone, -16.705869452292156, -43.84391795924117, 'SPEEDY');
    end;
  end;
end;

procedure TMainView.BotaoBatteryStatusClick(Sender: TObject);
var
  BatteryLevel: TBatteryLevel;
begin
  BatteryLevel := FZW.GetBatteryLevel;
  case BatteryLevel of
    tblSucess:
      ShowMessage('Charged Battery');
  end;
end;

procedure TMainView.BotaoGetChatByIdClick(Sender: TObject);
var
  Phone: string;
begin
  FInputPhone.ShowModal;
  if FInputPhone.ModalResult = mrOk then
  begin
    Phone := FInputPhone.EditAdressPhone.Text;
    if OpenDialog1.Execute then
    begin
      RichEditMyChat.Text := FZW.GetChatById(Phone).ToString;
    end;
  end;
end;

procedure TMainView.BotaoStatusNumberClick(Sender: TObject);
var
  Phone: string;
begin
  FInputPhone.ShowModal;
  if FInputPhone.ModalResult = mrOk then
  begin
    Phone := FInputPhone.EditAdressPhone.Text;
    if OpenDialog1.Execute then
    begin
      RichEditMyChat.Text := TJson.Serialize(FZW.CheckNumberStatus(Phone));
    end;
  end;
end;

procedure TMainView.BotaoClearChatClick(Sender: TObject);
var
  Phone: string;
begin
  FInputPhone.ShowModal;
  if FInputPhone.ModalResult = mrOk then
  begin
    Phone := FInputPhone.EditAdressPhone.Text;
    FZW.ClearChat(Phone);
  end;
end;

procedure TMainView.BotaoDownloadFileClick(Sender: TObject);
begin
  try
    // FZW.DownloadMedia(nil);
  finally
  end;
end;
{$ENDREGION 'TMainView'}

end.
