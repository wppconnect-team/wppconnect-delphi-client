unit ZW.Controller.ZW;

interface

uses
  Vcl.Dialogs,
  Vcl.Forms,
  REST.Client,
  REST.Types,
  System.Classes,
  System.Generics.Collections,
  System.Json,
  System.StrUtils,
  System.SysUtils,

  Bcl.Json,

  ZW.Model,

  ZW.Utils.LibUtils,
  ZW.Utils.Emoction;

type
  TStatusSession = (tssNone, tssClosed, tssInitializing, tssQrCode, tssConnected, tssUnknown);
  TBatteryLevel = (tblNone, tblSucess);

  TOnStatusSession = procedure(AStatusSession: TStatusSession) of object;
  TOnQrCode = procedure(AQrCodeBase64: string) of object;
  TOnUnreadMessage = procedure(AUnreadMessage: TList<TResponseModel>) of object;
  TOnError = procedure(AError: string) of object;
  TOnAfterDownload = procedure(AFileName : string) of object;
  TOnRequest = procedure(ARestRequest: TRestRequest) of object;

  TZWStatusSessionThread = class(TThread)
  private
    FOwner: TObject;
    FLastStatusSession: TStatusSession;
    FLastQrCode: string;
    FUnreadMessages: TList<TResponseModel>;
    FLastError: string;

    procedure StatusSession;
    procedure QrCode;
    procedure UnreadMessages;
    procedure Error;

    procedure Terminate(ASender: TObject);
  public
    constructor Create(ACreateSuspended: Boolean; AOwner: TObject);
  protected
    procedure Execute; override;
  end;

  TServerSettings = class
  private
    FSecretKey: string;
    FPort: Integer;
    FTimeOut: Integer;
    FHostName: string;
    FSession: string;
    procedure SetHostName(const Value: string);
    procedure SetPort(const Value: Integer);
    procedure SetSecretKey(const Value: string);
    procedure SetSession(const Value: string);
    procedure SetTimeOut(const Value: Integer);
  public
    constructor create;
  published
    property HostName : string read FHostName write SetHostName;
    property Port : Integer read FPort write SetPort;
    property SecretKey : string read FSecretKey write SetSecretKey;
    property Session : string read FSession write SetSession;
    property TimeOut : Integer read FTimeOut write SetTimeOut;
  end;

  TDownloadSettings = class
  private
    FPath: string;
    FTimeOut: Integer;
    FAutoDownload: Boolean;
    procedure SetPath(const Value: string);
    procedure SetTimeOut(const Value: Integer);
    procedure SetAutoDownload(const Value: Boolean);
  public
    constructor Create;

  published
    property Path : string read FPath write SetPath;
    property TimeOut : Integer read FTimeOut write SetTimeOut;
    property AutoDownload : Boolean read FAutoDownload write SetAutoDownload;
  end;

  TSendSettings = class
  private
    FWait: Integer;
    FDeleteAfterSend: Boolean;
    FControl: Boolean;
    FTimeOut: Integer;
    procedure SetControl(const Value: Boolean);
    procedure SetDeleteAfterSend(const Value: Boolean);
    procedure SetWait(const Value: Integer);
    procedure SetTimeOut(const Value: Integer);
  public
    constructor Create;

  published
    property Control : Boolean read FControl write SetControl;
    property Wait : Integer read FWait write SetWait;
    property DeleteAfterSend : Boolean read FDeleteAfterSend write SetDeleteAfterSend;
    property TimeOut : Integer read FTimeOut write SetTimeOut;
  end;

  TSendMessageSettings = class(TSendSettings)
  end;

  TSendFileSettings = class(TSendSettings)
  end;

  TSendLocationSettings = class(TSendSettings)
  end;

  TSendContactVCardSettings = class(TSendSettings)
  end;

  TSendLinkPreviewSettings = class(TSendSettings)
  end;

  TPhoneSettings = class
  private
    FDDD: string;
    FProcessPhone: Boolean;
    FDDI: string;
    procedure SetDDD(const Value: string);
    procedure SetDDI(const Value: string);
    procedure SetProcessPhone(const Value: Boolean);
  public
    constructor Create;

  published
    property ProcessPhone : Boolean read FProcessPhone write SetProcessPhone;
    property DDI : string read FDDI write SetDDI;
    property DDD : string read FDDD write SetDDD;
  end;

  TSettings = class
  private
    FDownload: TDownloadSettings;
    FSendContactVCard: TSendContactVCardSettings;
    FSendLinkPreview: TSendLinkPreviewSettings;
    FSendMessage: TSendMessageSettings;
    FSendLocation: TSendLocationSettings;
    FSendFile: TSendFileSettings;
    FPhone: TPhoneSettings;
    FServer: TServerSettings;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Server : TServerSettings read FServer;
    property Download : TDownloadSettings read FDownload;
    property SendMessage : TSendMessageSettings read FSendMessage;
    property SendFile : TSendFileSettings read FSendFile;
    property SendLocation : TSendLocationSettings read FSendLocation;
    property SendContactVCard : TSendContactVCardSettings read FSendContactVCard;
    property SendLinkPreview : TSendLinkPreviewSettings read FSendLinkPreview;
    property Phone : TPhoneSettings read FPhone;
  end;

  TZWController = class(TComponent)
  private
    FToken: String;
    FQrCode: String;

    FActive: Boolean;
    FBusy: Boolean;
    FStatusSession: TStatusSession;
    FUnreadMessage: Boolean;

    FOnStatusSession: TOnStatusSession;
    FOnQrCode: TOnQrCode;
    FOnUnreadMessage: TOnUnreadMessage;
    FOnError: TOnError;
    FOnRequest: TOnRequest;
    FSettings: TSettings;
    FOnAfterDownload: TOnAfterDownload;
    FEmotions: TEmoctions;

    procedure SetActive(const Value: Boolean);
    procedure SetBusy(const Value: Boolean);
    procedure SetStatusSession(AStatusSession: string);
    procedure SetUnreadMessage(const Value: Boolean);

    procedure SetOnStatusSession(const Value: TOnStatusSession);
    procedure SetOnQrCode(const Value: TOnQrCode);
    procedure SetOnUnreadMessage(const Value: TOnUnreadMessage);
    procedure SetOnError(const Value: TOnError);
    procedure SetOnRequest(const Value: TOnRequest);

    function NewRequest(ARestResource: string; AMethod: TRESTRequestMethod; ATimeOut: Integer = 5000): TRestRequest;
    procedure SendRequest(ARestRequest: TRestRequest; ARestParams: TRESTRequestParameterList = nil);
    function ArchiveFiles(ABase64: String; AMimeType: String) : string;
    function UniqueIDFile : string;
    function ProcessPhone(APhone: String): string;
    function BaseUrl : string;

    function GenerateToken: String;
    procedure SetOnAfterDownload(const Value: TOnAfterDownload);

    property QrCode: String read FQrCode;

    property Status: TStatusSession read FStatusSession;
  public
    constructor Create(AOwner : TComponent);
    destructor Destroy; override;

    // Sessão
    procedure StartSession;
    function StatusSession: TStatusSession;
    function CheckConnectionSession: Boolean;
    function CloseSession: Boolean;
    function LogOutSession: Boolean;

    // Dispositivo
    function GetBatteryLevel: TBatteryLevel;
    function GetPhoneNumber: string;
    function CheckNumberStatus(APhone: String): TNumberStatusModel;

    // Mensagem
    function SendMessage(APhone: String; AMessage: String; AIsGroup: Boolean = False): Boolean;
    function SendFile(APhone: String; AFilePath: string; AFileName: String = ''; AIsGroup: Boolean = False): Boolean;
    function SendLocation(APhone: String; ALatitude: Extended; ALongitude: Extended; ATitle: String): Boolean;
    function SendContactVCard(APhone: String; AContactsId: String; AName: String; AIsGroup: Boolean): Boolean;
    function SendLinkPreview(APhone: String; AUrl: String; ACaption: String): Boolean;
    function DownloadFile(AMessageId : string): string;

    function ChangeUsername(AName: string): Boolean;

    // Chat
    function ArquiveChat(APhone: String; AIsGroup: Boolean = False): Boolean;
    // Limpa todas as mensagem do chat e mantem o chat na lista de chats
    function ClearChat(APhone: String; AIsGroup: Boolean = False): Boolean;
    // Limpa todas as mensagem do chat e apaga o chat na lista de chats
    function DeleteChat(APhone: String; AIsGroup: Boolean = False): Boolean;
    function DeleteMessage(APhone: String; AMessageId: String): Boolean;
    function GetChatById(APhone: String; AIsGroup: Boolean = False): TList<TResponseModel>;
    function SendSeen(APhone: String; AIsGroup: Boolean = False): Boolean;
    function UnreadMessages: TList<TResponseModel>;

    property Busy: Boolean read FBusy write FBusy;
    Property Emotions : TEmoctions read FEmotions;
  published
    property Active: Boolean read FActive write SetActive;
    property UnreadMessage: Boolean read FUnreadMessage write SetUnreadMessage;
    property Settings : TSettings read FSettings;

    property OnStatusSession: TOnStatusSession read FOnStatusSession write SetOnStatusSession;
    property OnQrCode: TOnQrCode read FOnQrCode write SetOnQrCode;
    property OnUnreadMessage: TOnUnreadMessage read FOnUnreadMessage write SetOnUnreadMessage;
    property OnError: TOnError read FOnError write SetOnError;
    property OnAfterDownload : TOnAfterDownload read FOnAfterDownload write SetOnAfterDownload;
    property OnRequest: TOnRequest read FOnRequest write SetOnRequest;
  end;

implementation

{ TZWStatusSessionThread }

constructor TZWStatusSessionThread.Create(ACreateSuspended: Boolean; AOwner: TObject);
begin
  Inherited Create(ACreateSuspended);

  FOwner := AOwner;
  FreeOnTerminate := True;
  OnTerminate := Terminate;

  FLastStatusSession := tssUnknown;
  FLastQrCode := '';
end;

procedure TZWStatusSessionThread.Execute;
var
  FStatusSession: TStatusSession;
begin
  inherited;
  while not Application.Terminated and TZWController(FOwner).Active do
  begin
    try
      TZWController(FOwner).Busy := True;

      FStatusSession := TZWController(FOwner).StatusSession;
      if (FStatusSession <> FLastStatusSession) then
      begin
        FLastStatusSession := FStatusSession;
        if Assigned(TZWController(FOwner).OnStatusSession) then
          Synchronize(StatusSession);
      end;

      if not(FStatusSession in [tssInitializing, tssConnected]) then
      begin
        TZWController(FOwner).StartSession;
        if (TZWController(FOwner).QrCode.Trim <> '') and (TZWController(FOwner).QrCode.Trim <> FLastQrCode.Trim) then
        begin
          FLastQrCode := TZWController(FOwner).QrCode;
          if Assigned(TZWController(FOwner).OnQrCode) then
            Synchronize(QrCode);
        end;
      end;

      if (FLastStatusSession = tssConnected) and TZWController(FOwner).UnreadMessage and TZWController(FOwner).Active then
      begin
        FUnreadMessages := TZWController(FOwner).UnreadMessages;
        Synchronize(UnreadMessages);
      end;

      if TZWController(FOwner).Active then
      begin
        Sleep(1000);
      end;
    except
      On E: Exception do
      begin
        FLastError := E.Message;
        if Assigned(TZWController(FOwner).OnError) then
          Synchronize(Error);
      end;
    end;
  end;
end;

procedure TZWStatusSessionThread.Terminate(ASender: TObject);
begin
  TZWController(FOwner).Busy := False;
end;

procedure TZWStatusSessionThread.StatusSession;
begin
  TZWController(FOwner).OnStatusSession(FLastStatusSession);
end;

procedure TZWStatusSessionThread.QrCode;
begin
  TZWController(FOwner).OnQrCode(FLastQrCode);
end;

procedure TZWStatusSessionThread.UnreadMessages;
var
  I: Integer;
begin
  if Assigned(FUnreadMessages) then
  begin
    try
      if FUnreadMessages.Count > 0 then
      begin
        if Assigned(TZWController(FOwner).OnUnreadMessage) then
          TZWController(FOwner).OnUnreadMessage(FUnreadMessages);
      end;
    finally
      for I := FUnreadMessages.Count - 1 downto 0 do
      begin
        FUnreadMessages[I].Free;
        FUnreadMessages.Delete(I);
      end;
      FUnreadMessages.Free;
    end;
  end;
end;

procedure TZWStatusSessionThread.Error;
begin
  TZWController(FOwner).OnError(FLastError);
end;

{ TZWController }

constructor TZWController.Create(AOwner : TComponent);
begin
  Inherited Create(AOwner);
  FSettings := TSettings.Create;

  FToken := '';
  FQrCode := '';

  FActive := False;
  FBusy := False;
end;

destructor TZWController.Destroy;
begin
  if FActive then
    FActive := False;

  while FBusy do
  begin
    Sleep(100);
    Application.ProcessMessages;
  end;

  FSettings.Free;
  inherited;
end;

procedure TZWController.SetActive(const Value: Boolean);
var
  FThead: TZWStatusSessionThread;
begin
  if Value = FActive then
    Exit;

  FActive := Value;
  if FActive then
  begin
    FThead := TZWStatusSessionThread.Create(False, Self);
  end;
end;

procedure TZWController.SetBusy(const Value: Boolean);
begin
  FBusy := Value;
end;

procedure TZWController.SetStatusSession(AStatusSession: string);
begin
  case AnsiIndexStr(AStatusSession, ['CLOSED', 'INITIALIZING', 'QRCODE', 'CONNECTED']) of
    0:
      FStatusSession := tssClosed;
    1:
      FStatusSession := tssInitializing;
    2:
      FStatusSession := tssQrCode;
    3:
      FStatusSession := tssConnected;
  else
    raise Exception.Create(AStatusSession);
  end;
end;

procedure TZWController.SetUnreadMessage(const Value: Boolean);
begin
  FUnreadMessage := Value;
end;

procedure TZWController.SetOnStatusSession(const Value: TOnStatusSession);
begin
  FOnStatusSession := Value;
end;

procedure TZWController.SetOnQrCode(const Value: TOnQrCode);
begin
  FOnQrCode := Value;
end;

procedure TZWController.SetOnUnreadMessage(const Value: TOnUnreadMessage);
begin
  FOnUnreadMessage := Value;
end;

procedure TZWController.SetOnAfterDownload(const Value: TOnAfterDownload);
begin
  FOnAfterDownload := Value;
end;

procedure TZWController.SetOnError(const Value: TOnError);
begin
  FOnError := Value;
end;

procedure TZWController.SetOnRequest(const Value: TOnRequest);
begin
  FOnRequest := Value;
end;

function TZWController.NewRequest(ARestResource: string; AMethod: TRESTRequestMethod; ATimeOut: Integer): TRestRequest;
var
  RestClient: TRESTClient;
  RestRequest: TRestRequest;
begin
  Result := nil;

  RestRequest := TRestRequest.Create(nil);
  RestClient := TRESTClient.Create(RestRequest);
  try
    RestRequest.Client := RestClient;
    RestClient.Accept := 'application/json';
    RestClient.ContentType := 'application/json';

    RestClient.Baseurl := BaseUrl;
    RestRequest.Resource := ARestResource;
    RestRequest.Method := AMethod;
    RestRequest.Timeout := ATimeOut;

    Result := RestRequest;
  except
  end;
end;

function TZWController.ProcessPhone(APhone: String): string;
begin
  Result := APhone.Trim;
  if not Settings.Phone.ProcessPhone then
    Exit;

  if Result.Length in [8, 9] then
    Result := Concat(Settings.Phone.DDI, Settings.Phone.DDD, Result);

  if Result.Length = 13 then
  begin
    if (StrToInt(Copy(Result, 1, 2)) >= 30) then
      Delete(Result, 5, 1);
  end;
end;

procedure TZWController.SendRequest(ARestRequest: TRestRequest; ARestParams: TRESTRequestParameterList = nil);
var
  I: Integer;
begin
  ARestRequest.Params.Clear;
  if (Assigned(ARestParams)) and (ARestParams.Count > 0) then
  begin
    for I := 0 to ARestParams.Count - 1 do
      ARestRequest.Params.AddItem(ARestParams[I].Name, ARestParams[I].Value, ARestParams[I].Kind, ARestParams[I].Options, ARestParams.Items[I].ContentType);
  end;

  try
    ARestRequest.Execute;
    //if Assigned(FOnRequest) then
      //FOnRequest(ARestRequest);
  except
    on E: Exception do
      raise Exception.Create(Concat('A requisição falhou. Detalhe:', sLineBreak, 'Endpoint.: ', ARestRequest.Client.Baseurl, ARestRequest.Resource, sLineBreak, 'Erro: ',
        E.Message));
  end;
end;

function TZWController.GenerateToken;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
begin
  Request := NewRequest('/{session}/{secretkey}/generate-token', rmPOST);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddItem('secretkey', Settings.Server.SecretKey, pkURLSEGMENT);

    Request.Accept := 'text/html, application/xhtml+xml, */*';
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            FToken := Request.Response.JSONValue.GetValue<String>('token').Replace('"', '', [rfReplaceAll]);
          end;
      else
        raise Exception.Create('Não foi possível obter o token. Detalhe: ' + Request.Response.Content);
      end;
    except
      raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

procedure TZWController.StartSession;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  StatusSession: string;
begin
  if FToken = '' then
    GenerateToken;

  Request := NewRequest('/{session}/start-session', rmPOST, Settings.Server.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddItem('webhook', 'null', pkREQUESTBODY);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            if Request.Response.JSONValue.FindValue('qrcode') <> nil then
              FQrCode := Request.Response.JSONValue.GetValue<String>('qrcode').Replace('"', '', [rfReplaceAll]).Trim;
            if Request.Response.JSONValue.GetValue<String>('status').Replace('"', '', [rfReplaceAll]) <> '' then
              SetStatusSession(Request.Response.JSONValue.GetValue<String>('status').Replace('"', '', [rfReplaceAll]));
          end;
      else
        raise Exception.Create('Não foi possível iniciar a sessão. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.StatusSession: TStatusSession;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
begin
  Result := tssNone;
  if FToken = '' then
    GenerateToken;

  Request := NewRequest('/{session}/status-session', rmGET, Settings.Server.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            if Request.Response.JSONValue.GetValue<String>('status').Replace('"', '', [rfReplaceAll]) <> '' then
              SetStatusSession(Request.Response.JSONValue.GetValue<String>('status').Replace('"', '', [rfReplaceAll]));
            Result := FStatusSession;
          end;
      else
        raise Exception.Create('Sistema desconectado. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.CheckConnectionSession: Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  StatusSession: String;
begin
  Result := False;
  if FToken = '' then
    GenerateToken;

  Request := NewRequest('/{session}/check-connection-session', rmGET, Settings.Server.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            if Request.Response.JSONValue.GetValue<Boolean>('status') then
              Result := Request.Response.JSONValue.GetValue<Boolean>('status');
          end
      else
        raise Exception.Create('Não foi possível checar a sessão. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.LogOutSession: Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
begin
  Result := False;

  if FToken = '' then
    GenerateToken;

  Request := NewRequest('/{session}/logout-session', rmPOST, Settings.Server.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          Result := True;
      else
        raise Exception.Create('Não foi possível encerrar a sessão. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.CloseSession: Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
begin
  Result := False;

  if FToken = '' then
    GenerateToken;

  Request := NewRequest('/{session}/close-session', rmPOST, Settings.Server.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          Result := True;
      else
        raise Exception.Create('Não foi possível fechar a sessão. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.GetBatteryLevel: TBatteryLevel;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
begin
  Result := tblNone;

  if FToken = '' then
    GenerateToken;

  Request := NewRequest('/{session}/get-battery-level', rmGET, Settings.Server.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            if Request.Response.JSONValue.GetValue<String>('status').Replace('"', '', [rfReplaceAll]) = 'sucess' then
              Result := tblSucess;
          end;
      else
        raise Exception.Create('Não foi possível obter o status da bateria. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.GetPhoneNumber: string;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  StatusSession: String;
begin
  Result := '';

  Request := NewRequest('/{session}/get-phone-number', rmGET, Settings.Server.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            Result := Request.Response.JSONValue.GetValue<String>('phoneNumber').Replace('"', '', [rfReplaceAll]);
          end;
      else
        raise Exception.Create('Não foi possivel obter o número do telefone. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.CheckNumberStatus(APhone: String): TNumberStatusModel;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
begin
  Result := nil;
  APhone := ProcessPhone(APhone);

  if FToken = '' then
    GenerateToken;

  Request := NewRequest('/{session}/check-number-status/{phone}', rmGET, Settings.Server.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddItem('phone', APhone, pkURLSEGMENT);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            Result := TJson.Deserialize<TNumberStatusModel>(Request.Response.JSONValue.ToJSON);
          end;
      else
        raise Exception.Create('Não foi possível obter o status do número. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.SendMessage(APhone: String; AMessage: String; AIsGroup: Boolean = False): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  Message_: TTextMessageModel;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  Request := NewRequest('/{session}/send-message', rmPOST, Settings.SendMessage.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  Message_ := TTextMessageModel.Create;
  try

    Message_.Phone := APhone;
    Message_.Message_ := AMessage;
    Message_.IsGroup := AIsGroup;

    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddBody(TJson.Serialize(Message_), ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201: begin
          Result := True;
          if Settings.SendMessage.DeleteAfterSend then begin
            try
              DeleteChat(APhone, AIsGroup);
            except
            end;
          end;
          if Settings.SendMessage.Control then
            Sleep(Settings.SendMessage.Wait);
        end
      else
        raise Exception.Create(Format('Não foi possível enviar a mensagem. Detalhe: [%d] %s', [Request.Response.StatusCode, Request.Response.Content]));
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Message_);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.SendFile(APhone: String; AFilePath: string; AFileName: String = ''; AIsGroup: Boolean = False): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  Message_: TFileMessageModel;
  Ext: string;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  Request := NewRequest('/{session}/send-file-base64', rmPOST, Settings.SendFile.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  Message_ := TFileMessageModel.Create;
  try
    case AnsiIndexStr(LowerCase(ExtractFileExt(AFilePath)), ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.mp3', '.mp4', '.avi', '.pdf', '.doc', '.docx', '.txt', '.csv', '.xls',
      '.xlsx', '.sql']) of
      0:
        Ext := 'data:image/jpg;base64,';
      1:
        Ext := 'data:image/jpeg;base64,';
      2:
        Ext := 'data:image/png;base64,';
      3:
        Ext := 'data:image/gif;base64,';
      4:
        Ext := 'data:image/bmp;base64,';
      5:
        Ext := 'data:audio/mp3;base64,';
      6:
        Ext := 'data:audio/mp4;base64,';
      7:
        Ext := 'data:video/avi;base64,';
      8:
        Ext := 'data:application/pdf;base64,';
      9:
        Ext := 'data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,';
      10:
        Ext := 'data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,';
      11:
        Ext := 'data:text/plain;base64,';
      12:
        Ext := 'data:application/vnd.ms-excel;base64,';
      13:
        Ext := 'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,';
      14:
        Ext := 'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,';
      15:
        Ext := 'data:application/x-sql;base64,'
    else
      raise Exception.Create('Formato de arquivo não suportado.');
    end;

    Message_.Phone := APhone;
    Message_.Base64 := Ext + FileToBase64(AFilePath);
    Message_.FilePath := AFilePath;
    Message_.FileName := AFileName;
    Message_.IsGroup := AIsGroup;

    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddBody(TJson.Serialize(Message_), ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201: begin
          Result := True;
          if Settings.SendFile.DeleteAfterSend then begin
            try
              DeleteChat(APhone, AIsGroup);
            except
            end;
          end;
          if Settings.SendFile.Control then
            Sleep(Settings.SendFile.Wait);
        end
      else
        raise Exception.Create(Format('Não foi possível enviar a mensagem. Detalhe: [%d] %s', [Request.Response.StatusCode, Request.Response.Content]));
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Message_);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.SendLocation(APhone: String; ALatitude: Extended; ALongitude: Extended; ATitle: String): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  Message_: TLocationMessageModel;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  Request := NewRequest('/{session}/send-location', rmPOST, Settings.SendLocation.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  Message_ := TLocationMessageModel.Create;
  try
    Message_.Phone := APhone;
    Message_.Latitude := ALatitude;
    Message_.Longitude := ALongitude;
    Message_.Title := ATitle;

    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddBody(TJson.Serialize(Message_), ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201: begin
          Result := True;
          if Settings.SendLocation.DeleteAfterSend then begin
            try
              DeleteChat(APhone, false);
            except
            end;
          end;
          if Settings.SendLocation.Control then
            Sleep(Settings.SendLocation.Wait);
        end
      else
        raise Exception.Create(Format('Não foi possível enviar a localização. Detalhe: [%d] %s', [Request.Response.StatusCode, Request.Response.Content]));
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Message_);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.SendContactVCard(APhone: String; AContactsId: String; AName: String; AIsGroup: Boolean): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  Message_: TContactVCardMessageModel;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  Request := NewRequest('/{session}/contact-vcard', rmPOST, Settings.SendContactVCard.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  Message_ := TContactVCardMessageModel.Create;
  try
    Message_.Phone := APhone;
    Message_.ContactsId := AContactsId;
    Message_.Name := AName;
    Message_.IsGroup := AIsGroup;

    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddBody(TJson.Serialize(Message_), ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201: begin
          Result := True;
          if Settings.SendContactVCard.DeleteAfterSend then begin
            try
              DeleteChat(APhone, AIsGroup);
            except
            end;
          end;
          if Settings.SendContactVCard.Control then
            Sleep(Settings.SendContactVCard.Wait);
        end
      else
        raise Exception.Create(Format('Não foi possível enviar o contato. Detalhe: [%d] %s', [Request.Response.StatusCode, Request.Response.Content]));
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Message_);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.SendLinkPreview(APhone: String; AUrl: String; ACaption: String): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  Message_: TLinkPreviweMessageModel;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  Request := NewRequest('/{session}/send-link-preview', rmPOST, Settings.SendLinkPreview.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  Message_ := TLinkPreviweMessageModel.Create;
  try
    Message_.Phone := APhone;
    Message_.Url := AUrl;
    Message_.Caption := ACaption;

    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddBody(TJson.Serialize(Message_), ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201: begin
          Result := True;
          if Settings.SendLinkPreview.DeleteAfterSend then begin
            try
              DeleteChat(APhone, false);
            except
            end;
          end;
          if Settings.SendLinkPreview.Control then
            Sleep(Settings.SendLinkPreview.Wait);
        end
      else
        raise Exception.Create(Format('Não foi possível enviar o link. Detalhe: [%d] %s', [Request.Response.StatusCode, Request.Response.Content]));
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Message_);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.GetChatById(APhone: String; AIsGroup: Boolean = False): TList<TResponseModel>;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  StatusSession: String;
begin
  Result := nil;

  Request := NewRequest('/{session}/chat-by-id/{phone}', rmGET);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddItem('phone', APhone, pkURLSEGMENT, [poDoNotEncode]);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            Result := TJson.Deserialize < TList < TResponseModel >> (Request.Response.JSONValue.GetValue<TJSONValue>('response').ToJSON);
          end;
      else
        raise Exception.Create('Não foi possível obter o chat. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.UniqueIDFile: string;
var
  FGuid : TGUID;
begin
  CreateGUID(FGuid);
  Result := GUIDToString(FGuid);
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '{', '', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '', [rfReplaceAll]);
end;

function TZWController.UnreadMessages: TList<TResponseModel>;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  StatusSession: String;
begin
  Result := nil;

  Request := NewRequest('/{session}/unread-messages', rmGET);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            Result := TJson.Deserialize < TList < TResponseModel >> (Request.Response.JSONValue.GetValue<TJSONValue>('response').ToJSON);
          end;
      else
        raise Exception.Create('Não foi possível encerrar a sessão. Detalhe: ' + Request.Response.Content);
      end;
    except
      on E: Exception do
        raise;
    end;
  finally
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.DeleteChat(APhone: String; AIsGroup: Boolean = False): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  JsonObject: TJSONObject;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  JsonObject := TJSONObject.Create;
  JsonObject.AddPair('phone', APhone);
  JsonObject.AddPair('isGroup', TJSONBool.Create(AIsGroup));

  Request := NewRequest('/{session}/delete-chat', rmPOST);
  Params := TRESTRequestParameterList.Create(nil);
  try
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddBody(JsonObject.ToJSON, ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          Result := True;
      else
        raise Exception.Create('Não foi possível deletar o chat. Detalhe: ' + Request.Response.Content);
      end;
    except
      raise;
    end;
  finally
    FreeAndNil(JsonObject);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.DownloadFile(AMessageId : string): string;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  JsonBody: TJSONObject;
begin
  Result := '';

  Request := NewRequest('/{session}/download-media', rmPOST, Settings.Download.TimeOut);
  Params := TRESTRequestParameterList.Create(nil);
  JsonBody := TJSONObject.Create(nil);
  try
    JsonBody.AddPair('messageId', AMessageId);

    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddBody(JsonBody.ToJSON, ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          begin
            Result := ArchiveFiles(Request.Response.JSONValue.GetValue<string>('base64').Replace('"', '', [rfReplaceAll]), Request.Response.JSONValue.GetValue<string>('mimetype')
              .Replace('"', '', [rfReplaceAll]));
          end
      else
        raise Exception.Create('Não foi possível baixar o arquivo. Detalhe: ' + Request.Response.Content);
      end;
    except
      raise;
    end;
  finally
    FreeAndNil(JsonBody);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.ClearChat(APhone: String; AIsGroup: Boolean = False): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  JsonBody: TJSONObject;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  Request := NewRequest('/{session}/clear-chat', rmPOST);
  Params := TRESTRequestParameterList.Create(nil);
  JsonBody := TJSONObject.Create;
  try
    JsonBody.AddPair('phone', APhone);
    JsonBody.AddPair('isGroup', TJSONBool.Create(AIsGroup));

    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddBody(JsonBody.ToJSON, ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          Result := True;
      else
        raise Exception.Create('Não foi possível limpar o chat. Detalhe: ' + Request.Response.Content);
      end;
    except
      raise;
    end;
  finally
    FreeAndNil(JsonBody);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.ArchiveFiles(ABase64: String; AMimeType: String) : string;
var
  File_: TBytesStream;
  FileName: String;
  Ext: String;
begin
  Result := '';
  Ext := Concat('.', Copy(AMimeType, Pos('/', AMimeType) + 1, AMimeType.Length));
  if Pos(';', Ext) > 0 then
    Delete(Ext, Pos(';', Ext), length(Ext) - Pos(';', Ext)+1);
  FileName := Concat(IncludeTrailingPathDelimiter(Settings.Download.Path), UniqueIDFile, Ext);
  FileName := StringReplace(FileName, '.ogg', '.wav', [rfReplaceAll]);
  try
    try
      File_ := Base64ToFile(ABase64);

      if not DirectoryExists(ExtractFilePath(FileName)) then
        ForceDirectories(ExtractFilePath(FileName));

      File_.SaveToFile(FileName);
      Result := FileName;
    except
      raise;
    end;
  finally
    if Assigned(File_) then
      FreeAndNil(File_);
  end;
end;

function TZWController.ArquiveChat(APhone: String; AIsGroup: Boolean): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  JsonObject: TJSONObject;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  Request := NewRequest('/{session}/arquive-chat', rmPOST);
  Params := TRESTRequestParameterList.Create(nil);
  JsonObject := TJSONObject.Create;
  try
    JsonObject.AddPair('phone', APhone);
    JsonObject.AddPair('isGroup', TJSONBool.Create(AIsGroup));

    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddBody(JsonObject.ToJSON, ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          Result := True;
      else
        raise Exception.Create('Não foi possível deletar o chat. Detalhe: ' + Request.Response.Content);
      end;
    except
      raise;
    end;
  finally
    FreeAndNil(JsonObject);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.BaseUrl: string;
begin
  Result := Concat('http://', Settings.Server.Hostname, ':', Settings.Server.Port.ToString, '/api');
end;

function TZWController.ChangeUsername(AName: string): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  JsonBody: TJSONObject;
begin
  Result := False;

  Request := NewRequest('/{session}/change-username', rmPOST);
  Params := TRESTRequestParameterList.Create(nil);
  JsonBody := TJSONObject.Create;
  try
    JsonBody.AddPair('name', AName);

    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddBody(JsonBody.ToJSON, ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          Result := True;
      else
        raise Exception.Create('Não foi possível alterar o Profile Name. Detalhe: ' + Request.Response.Content);
      end;
    except
      raise;
    end;
  finally
    FreeAndNil(JsonBody);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.DeleteMessage(APhone: String; AMessageId: String): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  JsonBody: TJSONObject;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  Request := NewRequest('/{session}/delete-message', rmPOST);
  Params := TRESTRequestParameterList.Create(nil);
  JsonBody := TJSONObject.Create;
  try
    JsonBody.AddPair('phone', APhone);
    JsonBody.AddPair('messageId', AMessageId);

    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddBody(JsonBody.ToJSON, ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          Result := True;
      else
        raise Exception.Create('Não foi possível deletar a message. Detalhe: ' + Request.Response.Content);
      end;
    except
      raise;
    end;
  finally
    FreeAndNil(JsonBody);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;

function TZWController.SendSeen(APhone: String; AIsGroup: Boolean = False): Boolean;
var
  Request: TRestRequest;
  Params: TRESTRequestParameterList;
  JsonBody: TJSONObject;
begin
  Result := False;
  APhone := ProcessPhone(APhone);

  Request := NewRequest('/{session}/send-seen', rmPOST);
  Params := TRESTRequestParameterList.Create(nil);
  JsonBody := TJSONObject.Create;
  try
    JsonBody.AddPair('phone', APhone);

    Params.AddItem('session', Settings.Server.Session, pkURLSEGMENT);
    Params.AddItem('Authorization', Concat('Bearer ', FToken), pkHTTPHEADER, [poDoNotEncode]);
    Params.AddBody(JsonBody.ToJSON, ctAPPLICATION_JSON);
    try
      SendRequest(Request, Params);
      case Request.Response.StatusCode of
        200, 201:
          Result := True;
      else
        raise Exception.Create('Não foi possível marcar o chat como lido. Detalhe: ' + Request.Response.Content);
      end;
    except
      raise;
    end;
  finally
    FreeAndNil(JsonBody);
    FreeAndNil(Params);
    FreeAndNil(Request);
  end;
end;


{ TDownloadSettings }

constructor TDownloadSettings.Create;
begin
  FPath := Concat(ExtractFilePath(ParamStr(0)), 'ZW\Downloads\');
  FTimeOut := 30000;
  FAutoDownload := false;
end;

procedure TDownloadSettings.SetAutoDownload(const Value: Boolean);
begin
  FAutoDownload := Value;
end;

procedure TDownloadSettings.SetPath(const Value: string);
begin
  FPath := Value;
end;

procedure TDownloadSettings.SetTimeOut(const Value: Integer);
begin
  FTimeOut := Value;
end;

{ TSettings }

constructor TSettings.Create;
begin
  FServer := TServerSettings.create;
  FDownload := TDownloadSettings.Create;
  FSendMessage := TSendMessageSettings.Create;
  FSendFile := TSendFileSettings.Create;
  FSendContactVCard := TSendContactVCardSettings.Create;
  FSendLocation := TSendLocationSettings.Create;
  FSendLinkPreview := TSendLinkPreviewSettings.Create;
  FPhone := TPhoneSettings.Create;
end;

destructor TSettings.Destroy;
begin
  FServer.Free;
  FDownload.Free;
  FSendMessage.Free;
  FSendFile.Free;
  FSendLocation.Free;
  FSendContactVCard.Free;
  FSendLinkPreview.Free;
  FPhone.Free;
  inherited;
end;

{ TSendSettings }

constructor TSendSettings.Create;
begin
  FControl := false;
  FWait := 1000;
  FDeleteAfterSend := false;
  FTimeOut := 15000;
end;

procedure TSendSettings.SetControl(const Value: Boolean);
begin
  FControl := Value;
end;

procedure TSendSettings.SetDeleteAfterSend(const Value: Boolean);
begin
  FDeleteAfterSend := Value;
end;

procedure TSendSettings.SetTimeOut(const Value: Integer);
begin
  FTimeOut := Value;
end;

procedure TSendSettings.SetWait(const Value: Integer);
begin
  FWait := Value;
end;

{ TPhoneSettings }

constructor TPhoneSettings.Create;
begin
  FProcessPhone := false;
  FDDI := '55';
  FDDD := '';
end;

procedure TPhoneSettings.SetDDD(const Value: string);
begin
  FDDD := Value;
end;

procedure TPhoneSettings.SetDDI(const Value: string);
begin
  FDDI := Value;
end;

procedure TPhoneSettings.SetProcessPhone(const Value: Boolean);
begin
  FProcessPhone := Value;
end;

{ TServerSettings }

constructor TServerSettings.create;
begin
  FTimeOut := 5000;
end;

procedure TServerSettings.SetHostName(const Value: string);
begin
  FHostName := Value;
end;

procedure TServerSettings.SetPort(const Value: Integer);
begin
  FPort := Value;
end;

procedure TServerSettings.SetSecretKey(const Value: string);
begin
  FSecretKey := Value;
end;

procedure TServerSettings.SetSession(const Value: string);
begin
  FSession := Value;
end;

procedure TServerSettings.SetTimeOut(const Value: Integer);
begin
  FTimeOut := Value;
end;

end.
