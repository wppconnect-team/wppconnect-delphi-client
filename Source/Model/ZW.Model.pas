unit ZW.Model;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.SysUtils,

  Bcl.Json.Attributes;

type
  TTextMessageModel = class
  type
  private
    [JsonPropertyAttribute('phone')]
    FPhone: String;
    [JsonPropertyAttribute('message')]
    FMessage_: String;
    [JsonPropertyAttribute('isGroup')]
    FIsGroup: Boolean;

    procedure SetIsGroup(const Value: Boolean);
    procedure SetMessage_(const Value: String);
    procedure SetPhone(const Value: String);
  public
    property Phone: String read FPhone write SetPhone;
    property Message_: String read FMessage_ write SetMessage_;
    property IsGroup: Boolean read FIsGroup write SetIsGroup;
  end;

  TFileMessageModel = class
  type
  private
    [JsonPropertyAttribute('phone')]
    FPhone: String;
    [JsonPropertyAttribute('base64')]
    FBase64: String;
    [JsonPropertyAttribute('path')]
    FFilePath: String;
    [JsonPropertyAttribute('filename')]
    FFileName: String;

    [JsonPropertyAttribute('isGroup')]
    FIsGroup: Boolean;

    procedure SetIsGroup(const Value: Boolean);
    procedure SetBase64(const Value: String);
    procedure SetPhone(const Value: String);
    procedure SetFileName(const Value: String);
    procedure SetFilePath(const Value: String);
  public
    property Phone: String read FPhone write SetPhone;
    property Base64: String read FBase64 write SetBase64;
    property FilePath: String read FFilePath write SetFilePath;
    property FileName: String read FFileName write SetFileName;
    property IsGroup: Boolean read FIsGroup write SetIsGroup;
  end;

  TLocationMessageModel = class
  type
  private
    [JsonPropertyAttribute('phone')]
    FPhone: String;
    [JsonPropertyAttribute('lat')]
    FLatitude: Extended;
    [JsonPropertyAttribute('lng')]
    FLongitude: Extended;
    [JsonPropertyAttribute('title')]
    FTitle: String;

    procedure SetPhone(const Value: String);
    procedure SetLatitude(const Value: Extended);
    procedure SetLongitude(const Value: Extended);
    procedure SetTitle(const Value: String);
  public
    property Phone: String read FPhone write SetPhone;
    property Latitude: Extended read FLatitude write SetLatitude;
    property Longitude: Extended read FLongitude write SetLongitude;
    property Title: String read FTitle write SetTitle;
  end;

  TContactVCardMessageModel = class
  type
  private
    [JsonPropertyAttribute('phone')]
    FPhone: String;
    [JsonPropertyAttribute('contactsId')]
    FContactsId: String;
    [JsonPropertyAttribute('name')]
    FName: String;
    [JsonPropertyAttribute('isGroup')]
    FIsGroup: Boolean;

    procedure SetContactsId(const Value: String);
    procedure SetIsGroup(const Value: Boolean);
    procedure SetName(const Value: String);
    procedure SetPhone(const Value: String);
  public
    property Phone: String read FPhone write SetPhone;
    property ContactsId: String read FContactsId write SetContactsId;
    property Name: String read FName write SetName;
    property IsGroup: Boolean read FIsGroup write SetIsGroup;
  end;

  TLinkPreviweMessageModel = class
  type
  private
    [JsonPropertyAttribute('phone')]
    FPhone: String;
    [JsonPropertyAttribute('url')]
    FUrl: String;
    [JsonPropertyAttribute('caption')]
    FCaption: String;

    procedure SetPhone(const Value: String);
    procedure SetUrl(const Value: String);
    procedure SetCaption(const Value: String);
  public
    property Phone: String read FPhone write SetPhone;
    property Url: String read FUrl write SetUrl;
    property Caption: String read FCaption write SetCaption;
  end;

  TIdModel = class
  private
    [JsonPropertyAttribute('server')]
    FServer: String;
    [JsonPropertyAttribute('user')]
    FUser: String;
    [JsonPropertyAttribute('_serialized')]
    FSerialized: String;

    procedure SetServer(const Value: String);
    procedure SetUser(const Value: String);
    procedure SetSerialized(const Value: String);
  public
    property Server: String read FServer write SetServer;
    property User: String read FUser write SetUser;
    property Serialized: String read FSerialized write SetSerialized;
  end;

  TLastReceivedKeyModel = class
  private
    [JsonPropertyAttribute('fromMe')]
    FFromMe: Boolean;
    [JsonPropertyAttribute('remote')]
    FRemote: TIdModel;
    [JsonPropertyAttribute('id')]
    FId: String;
    [JsonPropertyAttribute('_serialized')]
    FSerialized: String;

    procedure SetFromMe(const Value: Boolean);
    procedure SetId(const Value: String);
    procedure SetSerialized(const Value: String);
    procedure SetRemote(const Value: TIdModel);
  public
    destructor destroy; override;
    property FromMe: Boolean read FFromMe write SetFromMe;
    property Id: String read FId write SetId;
    property Serialized: String read FSerialized write SetSerialized;
    property Remote: TIdModel read FRemote write SetRemote;
  end;

  TProfilePicThumbObjModel = class
  private
    [JsonPropertyAttribute('eurl')]
    FEurl: String;
    [JsonPropertyAttribute('id')]
    FId: TIdModel;
    [JsonPropertyAttribute('img')]
    FImg: String;
    [JsonPropertyAttribute('imgFull')]
    FImgFull: String;
    [JsonPropertyAttribute('raw')]
    FRaw: String;
    [JsonPropertyAttribute('tag')]
    FTag: String;

    procedure SetEurl(const Value: String);
    procedure SetId(const Value: TIdModel);
    procedure SetImg(const Value: String);
    procedure SetImgFull(const Value: String);
    procedure SetRaw(const Value: String);
    procedure SetTag(const Value: String);
  public
    destructor destroy; override;
    property Eurl: String read FEurl write SetEurl;
    property Id: TIdModel read FId write SetId;
    property Img: String read FImg write SetImg;
    property ImgFull: String read FImgFull write SetImgFull;
    property Raw: String read FRaw write SetRaw;
    property Tag: String read FTag write SetTag;
  end;

  TContactModel = class
  private
    [JsonPropertyAttribute('id')]
    FId: TIdModel;
    [JsonPropertyAttribute('name')]
    FName: String;
    [JsonPropertyAttribute('shortname')]
    FShortName: String;
    [JsonPropertyAttribute('pushname')]
    FPushname: String;
    [JsonPropertyAttribute('type')]
    FType_: String;
    [JsonPropertyAttribute('isBusiness')]
    FIsBusiness: Boolean;
    [JsonPropertyAttribute('isEnterprise')]
    FIsEnterprise: Boolean;
    [JsonPropertyAttribute('formattedName')]
    FFormattedName: String;
    [JsonPropertyAttribute('isMe')]
    FIsMe: Boolean;
    [JsonPropertyAttribute('isMyContact')]
    FIsMyContact: Boolean;
    [JsonPropertyAttribute('isPSA')]
    FIsPSA: Boolean;
    [JsonPropertyAttribute('isUser')]
    FIsUser: Boolean;
    [JsonPropertyAttribute('isWAContact')]
    FIsWAContact: Boolean;
    [JsonPropertyAttribute('profilePicThumbObj')]
    FProfilePicThumbObjModel: TProfilePicThumbObjModel;
    [JsonPropertyAttribute('msgs')]
    FMsgs: String;

    //[JsonPropertyAttribute('statusMute')]
    FStatusMute: Boolean;
    //[JsonPropertyAttribute('labels')]
    FLabels: array of String;

    procedure SetId(const Value: TIdModel);
    procedure SetPushname(const Value: String);
    procedure SetType_(const Value: String);
    procedure SetIsBusiness(const Value: Boolean);
    procedure SetIsEnterprise(const Value: Boolean);
    procedure SetStatusMute(const Value: Boolean);
    procedure SetLabels(const Value: array of String);
    procedure SetFormattedName(const Value: String);
    procedure SetIsMe(const Value: Boolean);
    procedure SetIsMyContact(const Value: Boolean);
    procedure SetIsPSA(const Value: Boolean);
    procedure SetIsUser(const Value: Boolean);
    procedure SetIsWAContact(const Value: Boolean);
    procedure SetProfilePicThumbObjModel(const Value: TProfilePicThumbObjModel);
    procedure SetMsgs(const Value: String);
    procedure SetName(const Value: String);
    procedure SetShortName(const Value: String);
  public
    destructor destroy; override;
    property Id: TIdModel read FId write SetId;
    property Name: String read FName write SetName;
    property ShortName: String read FShortName write SetShortName;
    property Pushname: String read FPushname write FPushname;
    property Type_: String read FType_ write SetType_;
    property IsBusiness: Boolean read FIsBusiness write SetIsBusiness;
    property IsEnterprise: Boolean read FIsEnterprise write SetIsEnterprise;
    property FormattedName: String read FFormattedName write SetFormattedName;
    property IsMe: Boolean read FIsMe write SetIsMe;
    property IsMyContact: Boolean read FIsMyContact write SetIsMyContact;
    property IsPSA: Boolean read FIsPSA write SetIsPSA;
    property IsUser: Boolean read FIsUser write SetIsUser;
    property IsWAContact: Boolean read FIsWAContact write SetIsWAContact;
    property ProfilePicThumbObjModel: TProfilePicThumbObjModel read FProfilePicThumbObjModel write SetProfilePicThumbObjModel;
    property Msgs: String read FMsgs write SetMsgs;


    property StatusMute: Boolean read FStatusMute write SetStatusMute;
    //property Labels: array of String read FLabels write SetLabels;
  end;

  TSenderModel = class
  private
    [JsonPropertyAttribute('id')]
    FId: TIdModel;
    [JsonPropertyAttribute('pushname')]
    FPushname: String;
    [JsonPropertyAttribute('type')]
    FType_: String;
    [JsonPropertyAttribute('isBusiness')]
    FIsBusiness: Boolean;
    [JsonPropertyAttribute('isEnterprise')]
    FIsEnterprise: Boolean;
    [JsonPropertyAttribute('statusMute')]
    FStatusMute: Boolean;
    [JsonPropertyAttribute('labels')]
    FLabels: array of String;
    [JsonPropertyAttribute('formattedName')]
    FFormattedName: String;
    [JsonPropertyAttribute('isMe')]
    FIsMe: Boolean;
    [JsonPropertyAttribute('isMyContact')]
    FIsMyContact: Boolean;
    [JsonPropertyAttribute('isPSA')]
    FIsPSA: Boolean;
    [JsonPropertyAttribute('isUser')]
    FIsUser: Boolean;
    [JsonPropertyAttribute('isWAContact')]
    FIsWAContact: Boolean;
    [JsonPropertyAttribute('profilePicThumbObj')]
    FProfilePicThumbObjModel: TProfilePicThumbObjModel;
    [JsonPropertyAttribute('msgs')]
    FMsgs: String;

    procedure SetId(const Value: TIdModel);
    procedure SetPushname(const Value: String);
    procedure SetType_(const Value: String);
    procedure SetIsBusiness(const Value: Boolean);
    procedure SetIsEnterprise(const Value: Boolean);
    procedure SetStatusMute(const Value: Boolean);
    procedure SetLabels(const Value: array of String);
    procedure SetFormattedName(const Value: String);
    procedure SetIsMe(const Value: Boolean);
    procedure SetIsMyContact(const Value: Boolean);
    procedure SetIsPSA(const Value: Boolean);
    procedure SetIsUser(const Value: Boolean);
    procedure SetIsWAContact(const Value: Boolean);
    procedure SetProfilePicThumbObjModel(const Value: TProfilePicThumbObjModel);
    procedure SetMsgs(const Value: String);
  public
    destructor destroy; override;
    property Id: TIdModel read FId write SetId;
    property Pushname: String read FPushname write SetPushname;
    property Type_: String read FType_ write SetType_;
    property IsBusiness: Boolean read FIsBusiness write SetIsBusiness;
    property IsEnterprise: Boolean read FIsEnterprise write SetIsEnterprise;
    property StatusMute: Boolean read FStatusMute write SetStatusMute;
    //property Labels: array of String read FLabels write SetLabels;
    property FormattedName: String read FFormattedName write SetFormattedName;
    property IsMe: Boolean read FIsMe write SetIsMe;
    property IsMyContact: Boolean read FIsMyContact write SetIsMyContact;
    property IsPSA: Boolean read FIsPSA write SetIsPSA;
    property IsUser: Boolean read FIsUser write SetIsUser;
    property IsWAContact: Boolean read FIsWAContact write SetIsWAContact;
    property ProfilePicThumbObjModel: TProfilePicThumbObjModel read FProfilePicThumbObjModel write SetProfilePicThumbObjModel;
    property Msgs: String read FMsgs write SetMsgs;
  end;

  TMediaPreviewModel = class
  private
    [JsonPropertyAttribute('_retainCount')]
    FRetainCount: Integer;
    [JsonPropertyAttribute('_inAutoReleasePool')]
    FInAutoReleasePool: Boolean;
    [JsonPropertyAttribute('released')]
    FReleased: BOolean;
    [JsonPropertyAttribute('_b64')]
    FB64: String;
    [JsonPropertyAttribute('_mimetype')]
    FMimeType: String;

    procedure SetRetainCount(const Value: Integer);
    procedure SetInAutoReleasePool(const Value: Boolean);
    procedure SetReleased(const Value: BOolean);
    procedure SetB64(const Value: String);
    procedure SetMimeType(const Value: String);
  public
    property RetainCount: Integer read FRetainCount write SetRetainCount;
    property InAutoReleasePool: Boolean read FInAutoReleasePool write SetInAutoReleasePool;
    property Released: BOolean read FReleased write SetReleased;
    property B64: String read FB64 write SetB64;
    property MimeType: String read FMimeType write SetMimeType;
  end;

  TMediaDataModel = class
  private
    [JsonPropertyAttribute('type')]
    Ftype_: string;
    [JsonPropertyAttribute('mediaStage')]
    FmediaStage: String;
    [JsonPropertyAttribute('size')]
    FSize: Integer;
    [JsonPropertyAttribute('fileHash')]
    FFileHash: String;
    [JsonPropertyAttribute('mimetype')]
    FMimeType: String;
    [JsonPropertyAttribute('mediaBlob')]
    FmediaBlob: String;
    [JsonPropertyAttribute('fullHeight')]
    FFullHeight: Integer;
    [JsonPropertyAttribute('fullWidth')]
    FFullWidth: Integer;
    [JsonPropertyAttribute('aspectRatio')]
    FAspectRatio: Double;
    [JsonPropertyAttribute('animationDuration')]
    FAnimationDuration: Integer;
    [JsonPropertyAttribute('animationAsNewMsg')]
    FAnimatedAsNewMsg: Boolean;
    [JsonPropertyAttribute('isViewOnce')]
    FIsViewOnce: Boolean;
    [JsonPropertyAttribute('duration')]
    FDuration: string;
    [JsonPropertyAttribute('preview')]
    FPreview: TMediaPreviewModel;
    [JsonPropertyAttribute('_swStreamingSupported')]
    FSwStreamingSupported: Boolean;
    [JsonPropertyAttribute('_listeningToSwSupport')]
    FListeningToSwSupport: Boolean;
    [JsonPropertyAttribute('isVcarOverMmsDocument')]
    FIsVcarOverMmsDocument: Boolean;

    procedure SetAnimatedAsNewMsg(const Value: Boolean);
    procedure SetAnimationDuration(const Value: Integer);
    procedure SetAspectRatio(const Value: Double);
    procedure SetDuration(const Value: string);
    procedure SetFileHash(const Value: String);
    procedure SetFullHeight(const Value: Integer);
    procedure SetFullWidth(const Value: Integer);
    procedure SetIsVcarOverMmsDocument(const Value: Boolean);
    procedure SetIsViewOnce(const Value: Boolean);
    procedure SetListeningToSwSupport(const Value: Boolean);
    procedure SetmediaBlob(const Value: String);
    procedure SetmediaStage(const Value: String);
    procedure SetMimeType(const Value: String);
    procedure SetPreview(const Value: TMediaPreviewModel);
    procedure SetSize(const Value: Integer);
    procedure SetSwStreamingSupported(const Value: Boolean);
    procedure Settype_(const Value: string);
  public
    destructor Destroy; override;

    property type_: string read Ftype_ write Settype_;
    property mediaStage: String read FmediaStage write SetmediaStage;
    property Size: Integer read FSize write SetSize;
    property FileHash: String read FFileHash write SetFileHash;
    property MimeType: String read FMimeType write SetMimeType;
    property mediaBlob: String read FmediaBlob write SetmediaBlob;
    property FullHeight: Integer read FFullHeight write SetFullHeight;
    property FullWidth: Integer read FFullWidth write SetFullWidth;
    property AspectRatio: Double read FAspectRatio write SetAspectRatio;
    property AnimationDuration: Integer read FAnimationDuration write SetAnimationDuration;
    property AnimatedAsNewMsg: Boolean read FAnimatedAsNewMsg write SetAnimatedAsNewMsg;
    property IsViewOnce: Boolean read FIsViewOnce write SetIsViewOnce;
    property Preview: TMediaPreviewModel read FPreview write SetPreview;
    property Duration: string read FDuration write SetDuration;
    property SwStreamingSupported: Boolean read FSwStreamingSupported write SetSwStreamingSupported;
    property ListeningToSwSupport: Boolean read FListeningToSwSupport write SetListeningToSwSupport;
    property IsVcarOverMmsDocument: Boolean read FIsVcarOverMmsDocument write SetIsVcarOverMmsDocument;
  end;

  TMessageModel = class
  private
    [JsonPropertyAttribute('id')]
    FId: String;
    [JsonPropertyAttribute('body')]
    FBody: String;
    [JsonPropertyAttribute('type')]
    FType_: String;
    [JsonPropertyAttribute('t')]
    FT: Integer;
    [JsonPropertyAttribute('notifyName')]
    FNotifyName: String;
    [JsonPropertyAttribute('from')]
    FFrom: String;
    [JsonPropertyAttribute('to')]
    FTo_: String;
    [JsonPropertyAttribute('self')]
    FSelf: String;
    [JsonPropertyAttribute('ack')]
    FAck: Integer;
    [JsonPropertyAttribute('isNewMsg')]
    FIsNewMsg: Boolean;
    [JsonPropertyAttribute('star')]
    FStar: Boolean;
    [JsonPropertyAttribute('recvFresh')]
    FrecvFresh: Boolean;
    [JsonPropertyAttribute('isFromTemplate')]
    FIsFromTemplate: Boolean;
    [JsonPropertyAttribute('broadcast')]
    FBroadcast: Boolean;
    [JsonPropertyAttribute('mentionedJidList')]
    [JsonIgnoreAttribute]
    //FMentionedJidList: array[] of String;
    [JsonPropertyAttribute('isVcardOverMmsDocument')]
    FIsVcardOverMmsDocument: Boolean;
    [JsonPropertyAttribute('isForwarded')]
    FIsForwarded: Boolean;
    [JsonPropertyAttribute('ephemeralOutOfSync')]
    FEphemeralOutOfSync: Boolean;
    [JsonPropertyAttribute('productHeaderImageRejected')]
    FProductHeaderImageRejected: Boolean;
    [JsonPropertyAttribute('isDynamicReplyButtonsMsg')]
    FIsDynamicReplyButtonsMsg: Boolean;
    [JsonPropertyAttribute('isMdHistoryMsg')]
    FIsMdHistoryMsg: Boolean;
    [JsonPropertyAttribute('chatId')]
    FChatId: TIdModel;
    [JsonPropertyAttribute('fromMe')]
    FFromMe: Boolean;
    [JsonPropertyAttribute('sender')]
    FSender: TContactModel;
    [JsonPropertyAttribute('timestamp')]
    FTimestamp: Integer;
    [JsonPropertyAttribute('content')]
    FContent: String;
    [JsonPropertyAttribute('isGroupMsg')]
    FIsGroupMsg: Boolean;
    [JsonPropertyAttribute('isMedia')]
    FIsMedia: Boolean;
    [JsonPropertyAttribute('isNotification')]
    FIsNotification: Boolean;
    [JsonPropertyAttribute('isPSA')]
    FIsPSA: Boolean;
    [JsonPropertyAttribute('mediaData')]
    FMediaData: TMediaDataModel;

    // não existem?
    //[JsonPropertyAttribute('labels')]
    FLabels: array of String;
    //[JsonPropertyAttribute('author')]
    FAuthor: String;
    //[JsonPropertyAttribute('invis')]
    FInvis: Boolean;
    FScanLengths: array of Integer;

    procedure SetId(const Value: String);
    procedure SetBody(const Value: String);
    procedure SetType_(const Value: String);
    procedure SetT(const Value: Integer);
    procedure SetNotifyName(const Value: String);
    procedure SetFrom(const Value: String);
    procedure SetTo_(const Value: String);
    procedure SetAuthor(const Value: String);
    procedure SetSelf(const Value: String);
    procedure SetAck(const Value: Integer);
    procedure SetInvis(const Value: Boolean);
    procedure SetStar(const Value: Boolean);
    procedure SetIsFromTemplate(const Value: Boolean);
    procedure SetBroadcast(const Value: Boolean);
    procedure SetMentionedJidList(const Value: array of String);
    procedure SetIsVcardOverMmsDocument(const Value: Boolean);
    procedure SetIsForwarded(const Value: Boolean);
    procedure SetLabels(const Value: array of String);
    procedure SetEphemeralOutOfSync(const Value: Boolean);
    procedure SetProductHeaderImageRejected(const Value: Boolean);
    procedure SetIsDynamicReplyButtonsMsg(const Value: Boolean);
    procedure SetIsMdHistoryMsg(const Value: Boolean);
    procedure SetChatId(const Value: TIdModel);
    procedure SetFromMe(const Value: Boolean);
    procedure SetSender(const Value: TContactModel);
    procedure SetTimestamp(const Value: Integer);
    procedure SetContent(const Value: String);
    procedure SetIsGroupMsg(const Value: Boolean);
    procedure SetIsMedia(const Value: Boolean);
    procedure SetIsNotification(const Value: Boolean);
    procedure SetIsPSA(const Value: Boolean);
    procedure SetMediaData(const Value: TMediaDataModel);
    procedure SetIsNewMsg(const Value: Boolean);
    procedure SetrecvFresh(const Value: Boolean);
    procedure SetScanLengths(const Value: array of Integer);
  public
    destructor Destroy; override;

    property Id: String read FId write SetId;
    property Body: String read FBody write SetBody;
    property Type_: String read FType_ write SetType_;
    property T: Integer read FT write SetT;
    property NotifyName: String read FNotifyName write SetNotifyName;
    property From: String read FFrom write SetFrom;
    property To_: String read FTo_ write SetTo_;
    property Self: String read FSelf write SetSelf;
    property Ack: Integer read FAck write SetAck;
    property IsNewMsg: Boolean read FIsNewMsg write SetIsNewMsg;
    property Star: Boolean read FStar write SetStar;
    property recvFresh: Boolean read FrecvFresh write SetrecvFresh;
    //property ScanLengths: array of Integer read FScanLengths write SetScanLengths;
    property IsFromTemplate: Boolean read FIsFromTemplate write SetIsFromTemplate;
    property Broadcast: Boolean read FBroadcast write SetBroadcast;
    //property MentionedJidList: array[] of String read FMentionedJidList write SetMentionedJidList;
    property IsVcardOverMmsDocument: Boolean read FIsVcardOverMmsDocument write SetIsVcardOverMmsDocument;
    property IsForwarded: Boolean read FIsForwarded write SetIsForwarded;
    property EphemeralOutOfSync: Boolean read FEphemeralOutOfSync write SetEphemeralOutOfSync;
    property ProductHeaderImageRejected: Boolean read FProductHeaderImageRejected write SetProductHeaderImageRejected;
    property IsDynamicReplyButtonsMsg: Boolean read FIsDynamicReplyButtonsMsg write SetIsDynamicReplyButtonsMsg;
    property IsMdHistoryMsg: Boolean read FIsMdHistoryMsg write SetIsMdHistoryMsg;
    property ChatId: TIdModel read FChatId write SetChatId;
    property FromMe: Boolean read FFromMe write SetFromMe;
    property Sender: TContactModel read FSender write SetSender;
    property Timestamp: Integer read FTimestamp write SetTimestamp;
    property Content: String read FContent write SetContent;
    property IsGroupMsg: Boolean read FIsGroupMsg write SetIsGroupMsg;
    property IsMedia: Boolean read FIsMedia write SetIsMedia;
    property IsNotification: Boolean read FIsNotification write SetIsNotification;
    property IsPSA: Boolean read FIsPSA write SetIsPSA;
    property MediaData: TMediaDataModel read FMediaData write SetMediaData;

    //property Labels: array of String read FLabels write SetLabels;
    property Author: String read FAuthor write SetAuthor;
    property Invis: Boolean read FInvis write SetInvis;
  end;

  TResponseModel = class
  private
    [JsonPropertyAttribute('id')]
    FId: TIdModel;
    [JsonPropertyAttribute('lastReceivedKey')]
    FLastReceivedKey: TLastReceivedKeyModel;
    [JsonPropertyAttribute('t')]
    FT: Integer;
    [JsonPropertyAttribute('unreadCount')]
    FUnreadCount: Integer;
    [JsonPropertyAttribute('muteExpiration')]
    FMuteExpiration: Integer;
    [JsonPropertyAttribute('notSpam')]
    FNotSpam: Boolean;
    [JsonPropertyAttribute('ephemeralDuration')]
    FEphemeralDuration: Integer;
    [JsonPropertyAttribute('endOfHistoryTransferType')]
    FEndOfHistoryTransferType: Integer;
    [JsonPropertyAttribute('msgs')]
    FMsgs: String;
    [JsonPropertyAttribute('kind')]
    FKind: String;
    [JsonPropertyAttribute('isBroadcast')]
    FIsBroadcast: Boolean;
    [JsonPropertyAttribute('isGroup')]
    FIsGroup: Boolean;
    [JsonPropertyAttribute('isUser')]
    FIsUser: Boolean;
    [JsonPropertyAttribute('contact')]
    FContact: TContactModel;
    [JsonPropertyAttribute('messages')]
    FMessages: TList<TMessageModel>;

    //[JsonPropertyAttribute('pendingMsgs')]
    FPendingMsgs: Boolean;
    //[JsonPropertyAttribute('archive')]
    FArchive: Boolean;
    //[JsonPropertyAttribute('isReadOnly')]
    FIsReadOnly: Boolean;
    //[JsonPropertyAttribute('isAnnounceGrpRestrict')]
    FIsAnnounceGrpRestrict: Boolean;
    //[JsonPropertyAttribute('modifyTag')]
    FModifyTag: Integer;
    //[JsonPropertyAttribute('name')]
    FName: String;
    //[JsonPropertyAttribute('pin')]
    FPin: Integer;

    procedure SetPendingMsgs(const Value: Boolean);
    procedure SetId(const Value: TIdModel);
    procedure SetLastReceivedKey(const Value: TLastReceivedKeyModel);
    procedure SetName(const Value: String);
    procedure SetMsgs(const Value: String);
    procedure SetNotSpam(const Value: Boolean);
    procedure SetUnreadCount(const Value: Integer);
    procedure SetModifyTag(const Value: Integer);
    procedure SetMuteExpiration(const Value: Integer);
    procedure SetKind(const Value: String);
    procedure SetIsReadOnly(const Value: Boolean);
    procedure SetIsUser(const Value: Boolean);
    procedure SetArchive(const Value: Boolean);
    procedure SetIsGroup(const Value: Boolean);
    procedure SetIsAnnounceGrpRestrict(const Value: Boolean);
    procedure SetIsBroadcast(const Value: Boolean);
    procedure SetContact(const Value: TContactModel);
    procedure SetT(const Value: Integer);
    procedure SetPin(const Value: Integer);
    procedure SetMessages(const Value: TList<TMessageModel>);
    procedure SetEphemeralDuration(const Value: Integer);
    procedure SetEndOfHistoryTransferType(const Value: Integer);
  public
    destructor Destroy; override;

    property Id: TIdModel read FId write SetId;
    property PendingMsgs: Boolean read FPendingMsgs write SetPendingMsgs;
    property LastReceivedKey: TLastReceivedKeyModel read FLastReceivedKey write SetLastReceivedKey;
    property T: Integer read FT write SetT;
    property UnreadCount: Integer read FUnreadCount write SetUnreadCount;
    property MuteExpiration: Integer read FMuteExpiration write SetMuteExpiration;
    property NotSpam: Boolean read FNotSpam write SetNotSpam;
    property EphemeralDuration: Integer read FEphemeralDuration write SetEphemeralDuration;
    property EndOfHistoryTransferType: Integer read FEndOfHistoryTransferType write SetEndOfHistoryTransferType;
    property Archive: Boolean read FArchive write SetArchive;
    property IsReadOnly: Boolean read FIsReadOnly write SetIsReadOnly;
    property IsAnnounceGrpRestrict: Boolean read FIsAnnounceGrpRestrict write SetIsAnnounceGrpRestrict;
    property ModifyTag: Integer read FModifyTag write SetModifyTag;
    property Name: String read FName write SetName;
    property Pin: Integer read FPin write SetPin;
    property Msgs: String read FMsgs write SetMsgs;
    property Kind: String read FKind write SetKind;
    property IsBroadcast: Boolean read FIsBroadcast write SetIsBroadcast;
    property IsGroup: Boolean read FIsGroup write SetIsGroup;
    property IsUser: Boolean read FIsUser write SetIsUser;
    property Contact: TContactModel read FContact write SetContact;
    property Messages: TList<TMessageModel> read FMessages write SetMessages;
  end;

  TNumberStatusModel = class
  private
    [JsonPropertyAttribute('id')]
    FId: TIdModel;
    [JsonPropertyAttribute('isBusiness')]
    FIsBusiness: Boolean;
    [JsonPropertyAttribute('canReceiveMessage')]
    FCanReceiveMessage: Boolean;
    [JsonPropertyAttribute('numberExists')]
    FNumberExists: Boolean;

    procedure SetId(const Value: TIdModel);
    procedure SetIsBusiness(const Value: Boolean);
    procedure SetCanReceiveMessage(const Value: Boolean);
    procedure SetNumberExists(const Value: Boolean);
  public
    destructor destroy; override;
    property Id: TIdModel read FId write SetId;
    property IsBusiness: Boolean read FIsBusiness write SetIsBusiness;
    property CanReceiveMessage: Boolean read FCanReceiveMessage write SetCanReceiveMessage;
    property NumberExists: Boolean read FNumberExists write SetNumberExists;
  end;

implementation

{ TFileMessageModel }

procedure TFileMessageModel.SetPhone(const Value: String);
begin
  FPhone := Value;
end;

procedure TFileMessageModel.SetBase64(const Value: String);
begin
  FBase64 := Value;
end;

procedure TFileMessageModel.SetFilePath(const Value: String);
begin
  FFilePath := Value;
end;

procedure TFileMessageModel.SetFileName(const Value: String);
begin
  FFileName := Value;
end;

procedure TFileMessageModel.SetIsGroup(const Value: Boolean);
begin
  FIsGroup := Value;
end;

{ TTextMessageModel }

procedure TTextMessageModel.SetPhone(const Value: String);
begin
  FPhone := Value;
end;

procedure TTextMessageModel.SetMessage_(const Value: String);
begin
  FMessage_ := Value;
end;

procedure TTextMessageModel.SetIsGroup(const Value: Boolean);
begin
  FIsGroup := Value;
end;

{ TId }

procedure TIdModel.SetSerialized(const Value: String);
begin
  FSerialized := Value;
end;

procedure TIdModel.SetServer(const Value: String);
begin
  FServer := Value;
end;

procedure TIdModel.SetUser(const Value: String);
begin
  FUser := Value;
end;

{ TResponseModel }

destructor TResponseModel.Destroy;
var
  I : Integer;
begin
  if Assigned(FLastReceivedKey) then
    FreeAndNil(FLastReceivedKey);
  if Assigned(FId) then
    FreeAndNil(FId);
  if Assigned(FContact) then
    FreeAndNil(FContact);
  if Assigned(FMessages) then begin
    for I := FMessages.Count -1 downto 0 do begin
      FMessages[I].Free;
      FMessages.Delete(I);
    end;
    FreeAndNil(FMessages);
  end;
  inherited;
end;

procedure TResponseModel.SetArchive(const Value: Boolean);
begin
  FArchive := Value;
end;

procedure TResponseModel.SetContact(const Value: TContactModel);
begin
  FContact := Value;
end;

procedure TResponseModel.SetEndOfHistoryTransferType(const Value: Integer);
begin
  FEndOfHistoryTransferType := Value;
end;

procedure TResponseModel.SetEphemeralDuration(const Value: Integer);
begin
  FEphemeralDuration := Value;
end;

procedure TResponseModel.SetId(const Value: TIdModel);
begin
  FId := Value;
end;

procedure TResponseModel.SetIsAnnounceGrpRestrict(const Value: Boolean);
begin
  FIsAnnounceGrpRestrict := Value;
end;

procedure TResponseModel.SetIsBroadcast(const Value: Boolean);
begin
  FIsBroadcast := Value;
end;

procedure TResponseModel.SetIsGroup(const Value: Boolean);
begin
  FIsGroup := Value;
end;

procedure TResponseModel.SetIsReadOnly(const Value: Boolean);
begin
  FIsReadOnly := Value;
end;

procedure TResponseModel.SetIsUser(const Value: Boolean);
begin
  FIsUser := Value;
end;

procedure TResponseModel.SetKind(const Value: String);
begin
  FKind := Value;
end;

procedure TResponseModel.SetLastReceivedKey(const Value: TLastReceivedKeyModel);
begin
  FLastReceivedKey := Value;
end;

procedure TResponseModel.SetMessages(const Value: TList<TMessageModel>);
begin
  FMessages := Value;
end;

procedure TResponseModel.SetModifyTag(const Value: Integer);
begin
  FModifyTag := Value;
end;

procedure TResponseModel.SetMsgs(const Value: String);
begin
  FMsgs := Value;
end;

procedure TResponseModel.SetMuteExpiration(const Value: Integer);
begin
  FMuteExpiration := Value;
end;

procedure TResponseModel.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TResponseModel.SetNotSpam(const Value: Boolean);
begin
  FNotSpam := Value;
end;

procedure TResponseModel.SetPendingMsgs(const Value: Boolean);
begin
  FPendingMsgs := Value;
end;

procedure TResponseModel.SetPin(const Value: Integer);
begin
  FPin := Value;
end;

procedure TResponseModel.SetT(const Value: Integer);
begin
  FT := Value;
end;

procedure TResponseModel.SetUnreadCount(const Value: Integer);
begin
  FUnreadCount := Value;
end;

{ TContactModel }

destructor TContactModel.destroy;
begin
  if Assigned(FId) then
    FreeAndNil(FId);
  if Assigned(FProfilePicThumbObjModel) then
    FreeAndNil(FProfilePicThumbObjModel);
  inherited;
end;

procedure TContactModel.SetFormattedName(const Value: String);
begin
  FFormattedName := Value;
end;

procedure TContactModel.SetId(const Value: TIdModel);
begin
  FId := Value;
end;

procedure TContactModel.SetIsBusiness(const Value: Boolean);
begin
  FIsBusiness := Value;
end;

procedure TContactModel.SetIsEnterprise(const Value: Boolean);
begin
  FIsEnterprise := Value;
end;

procedure TContactModel.SetIsMe(const Value: Boolean);
begin
  FIsMe := Value;
end;

procedure TContactModel.SetIsMyContact(const Value: Boolean);
begin
  FIsMyContact := Value;
end;

procedure TContactModel.SetIsPSA(const Value: Boolean);
begin
  FIsPSA := Value;
end;

procedure TContactModel.SetIsUser(const Value: Boolean);
begin
  FIsUser := Value;
end;

procedure TContactModel.SetIsWAContact(const Value: Boolean);
begin
  FIsWAContact := Value;
end;

procedure TContactModel.SetLabels(const Value: array of String);
begin
  //FLabels := Value;
end;

procedure TContactModel.SetMsgs(const Value: String);
begin
  FMsgs := Value;
end;

procedure TContactModel.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TContactModel.SetPushname(const Value: String);
begin
  FPushname := Value;
end;

procedure TContactModel.SetProfilePicThumbObjModel(const Value: TProfilePicThumbObjModel);
begin
  FProfilePicThumbObjModel := Value;
end;

procedure TContactModel.SetShortName(const Value: String);
begin
  FShortName := Value;
end;

procedure TContactModel.SetStatusMute(const Value: Boolean);
begin
  FStatusMute := Value;
end;

procedure TContactModel.SetType_(const Value: String);
begin
  FType_ := Value;
end;

{ TProfilePicThumbObjModel }

destructor TProfilePicThumbObjModel.destroy;
begin
  if Assigned(FId) then
    FreeAndNil(FId);
  inherited;
end;

procedure TProfilePicThumbObjModel.SetEurl(const Value: String);
begin
  FEurl := Value;
end;

procedure TProfilePicThumbObjModel.SetId(const Value: TIdModel);
begin
  FId := Value;
end;

procedure TProfilePicThumbObjModel.SetImg(const Value: String);
begin
  FImg := Value;
end;

procedure TProfilePicThumbObjModel.SetImgFull(const Value: String);
begin
  FImgFull := Value;
end;

procedure TProfilePicThumbObjModel.SetRaw(const Value: String);
begin
  FRaw := Value;
end;

procedure TProfilePicThumbObjModel.SetTag(const Value: String);
begin
  FTag := Value;
end;

{ TLastReceivedKeyModel }

destructor TLastReceivedKeyModel.destroy;
begin
  if Assigned(FRemote) then
    FreeAndNil(FRemote);
  inherited;
end;

procedure TLastReceivedKeyModel.SetFromMe(const Value: Boolean);
begin
  FFromMe := Value;
end;

procedure TLastReceivedKeyModel.SetId(const Value: String);
begin
  FId := Value;
end;

procedure TLastReceivedKeyModel.SetRemote(const Value: TIdModel);
begin
  FRemote := Value;
end;

procedure TLastReceivedKeyModel.SetSerialized(const Value: String);
begin
  FSerialized := Value;
end;

{ TMessageModel }

destructor TMessageModel.destroy;
begin
  if Assigned(FSender) then
    FreeAndNil(FSender);
  if Assigned(FChatId) then
    FreeAndNil(FChatId);
  if Assigned(FMediaData) then
    FreeAndNil(FMediaData);

  inherited;
end;

procedure TMessageModel.SetAck(const Value: Integer);
begin
  FAck := Value;
end;

procedure TMessageModel.SetAuthor(const Value: String);
begin
  FAuthor := Value;
end;

procedure TMessageModel.SetBody(const Value: String);
begin
  FBody := Value;
end;

procedure TMessageModel.SetBroadcast(const Value: Boolean);
begin
  FBroadcast := Value;
end;

procedure TMessageModel.SetChatId(const Value: TIdModel);
begin
  FChatId := Value;
end;

procedure TMessageModel.SetContent(const Value: String);
begin
  FContent := Value;
end;

procedure TMessageModel.SetEphemeralOutOfSync(const Value: Boolean);
begin
  FEphemeralOutOfSync := Value;
end;

procedure TMessageModel.SetFrom(const Value: String);
begin
  FFrom := Value;
end;

procedure TMessageModel.SetFromMe(const Value: Boolean);
begin
  FFromMe := Value;
end;

procedure TMessageModel.SetId(const Value: String);
begin
  FId := Value;
end;

procedure TMessageModel.SetInvis(const Value: Boolean);
begin
  FInvis := Value;
end;

procedure TMessageModel.SetIsDynamicReplyButtonsMsg(const Value: Boolean);
begin
  FIsDynamicReplyButtonsMsg := Value;
end;

procedure TMessageModel.SetIsForwarded(const Value: Boolean);
begin
  FIsForwarded := Value;
end;

procedure TMessageModel.SetIsFromTemplate(const Value: Boolean);
begin
  FIsFromTemplate := Value;
end;

procedure TMessageModel.SetIsGroupMsg(const Value: Boolean);
begin
  FIsGroupMsg := Value;
end;

procedure TMessageModel.SetIsMdHistoryMsg(const Value: Boolean);
begin
  FIsMdHistoryMsg := Value;
end;

procedure TMessageModel.SetIsMedia(const Value: Boolean);
begin
  FIsMedia := Value;
end;

procedure TMessageModel.SetIsNewMsg(const Value: Boolean);
begin
  FIsNewMsg := Value;
end;

procedure TMessageModel.SetIsNotification(const Value: Boolean);
begin
  FIsNotification := Value;
end;

procedure TMessageModel.SetIsPSA(const Value: Boolean);
begin
  FIsPSA := Value;
end;

procedure TMessageModel.SetIsVcardOverMmsDocument(const Value: Boolean);
begin
  FIsVcardOverMmsDocument := Value;
end;

procedure TMessageModel.SetLabels(const Value: array of String);
begin
  //FLabels := Value;
end;

procedure TMessageModel.SetMediaData(const Value: TMediaDataModel);
begin
  FMediaData := Value;
end;

procedure TMessageModel.SetMentionedJidList(const Value: array of String);
begin
  //FMentionedJidList := Value;
end;

procedure TMessageModel.SetNotifyName(const Value: String);
begin
  FNotifyName := Value;
end;

procedure TMessageModel.SetProductHeaderImageRejected(const Value: Boolean);
begin
  FProductHeaderImageRejected := Value;
end;

procedure TMessageModel.SetrecvFresh(const Value: Boolean);
begin
  FrecvFresh := Value;
end;

procedure TMessageModel.SetScanLengths(const Value: array of Integer);
begin
  //FScanLengths := Value;
end;

procedure TMessageModel.SetSelf(const Value: String);
begin
  FSelf := Value;
end;

procedure TMessageModel.SetSender(const Value: TContactModel);
begin
  FSender := Value;
end;

procedure TMessageModel.SetStar(const Value: Boolean);
begin
  FStar := Value;
end;

procedure TMessageModel.SetT(const Value: Integer);
begin
  FT := Value;
end;

procedure TMessageModel.SetTimestamp(const Value: Integer);
begin
  FTimestamp := Value;
end;

procedure TMessageModel.SetTo_(const Value: String);
begin
  FTo_ := Value;
end;

procedure TMessageModel.SetType_(const Value: String);
begin
  FType_ := Value;
end;

{ TSenderModel }

destructor TSenderModel.destroy;
begin
  if Assigned(FId) then
    FreeAndNil(FId);
  if Assigned(FProfilePicThumbObjModel) then
    FreeAndNil(FProfilePicThumbObjModel);
  inherited;
end;

procedure TSenderModel.SetFormattedName(const Value: String);
begin
  FFormattedName := Value;
end;

procedure TSenderModel.SetId(const Value: TIdModel);
begin
  FId := Value;
end;

procedure TSenderModel.SetIsBusiness(const Value: Boolean);
begin
  FIsBusiness := Value;
end;

procedure TSenderModel.SetIsEnterprise(const Value: Boolean);
begin
  FIsEnterprise := Value;
end;

procedure TSenderModel.SetIsMe(const Value: Boolean);
begin
  FIsMe := Value;
end;

procedure TSenderModel.SetIsMyContact(const Value: Boolean);
begin
  FIsMyContact := Value;
end;

procedure TSenderModel.SetIsPSA(const Value: Boolean);
begin
  FIsPSA := Value;
end;

procedure TSenderModel.SetIsUser(const Value: Boolean);
begin
  FIsUser := Value;
end;

procedure TSenderModel.SetIsWAContact(const Value: Boolean);
begin
  FIsWAContact := Value;
end;

procedure TSenderModel.SetLabels(const Value: array of String);
begin
  //FLabels := Value;
end;

procedure TSenderModel.SetMsgs(const Value: String);
begin
  FMsgs := Value;
end;

procedure TSenderModel.SetProfilePicThumbObjModel(const Value: TProfilePicThumbObjModel);
begin
  FProfilePicThumbObjModel := Value;
end;

procedure TSenderModel.SetPushname(const Value: String);
begin
  FPushname := Value;
end;

procedure TSenderModel.SetStatusMute(const Value: Boolean);
begin
  FStatusMute := Value;
end;

procedure TSenderModel.SetType_(const Value: String);
begin
  FType_ := Value;
end;

{ TMediaDataModel }

destructor TMediaDataModel.Destroy;
begin
  if Assigned(FPreview) then
    FreeAndNil(FPreview);

  inherited;
end;

procedure TMediaDataModel.SetAnimatedAsNewMsg(const Value: Boolean);
begin
  FAnimatedAsNewMsg := Value;
end;

procedure TMediaDataModel.SetAnimationDuration(const Value: Integer);
begin
  FAnimationDuration := Value;
end;

procedure TMediaDataModel.SetAspectRatio(const Value: Double);
begin
  FAspectRatio := Value;
end;

procedure TMediaDataModel.SetDuration(const Value: string);
begin
  FDuration := Value;
end;

procedure TMediaDataModel.SetFileHash(const Value: String);
begin
  FFileHash := Value;
end;

procedure TMediaDataModel.SetFullHeight(const Value: Integer);
begin
  FFullHeight := Value;
end;

procedure TMediaDataModel.SetFullWidth(const Value: Integer);
begin
  FFullWidth := Value;
end;

procedure TMediaDataModel.SetIsVcarOverMmsDocument(const Value: Boolean);
begin
  FIsVcarOverMmsDocument := Value;
end;

procedure TMediaDataModel.SetIsViewOnce(const Value: Boolean);
begin
  FIsViewOnce := Value;
end;

procedure TMediaDataModel.SetListeningToSwSupport(const Value: Boolean);
begin
  FListeningToSwSupport := Value;
end;

procedure TMediaDataModel.SetmediaBlob(const Value: String);
begin
  FmediaBlob := Value;
end;

procedure TMediaDataModel.SetmediaStage(const Value: String);
begin
  FmediaStage := Value;
end;

procedure TMediaDataModel.SetMimeType(const Value: String);
begin
  FMimeType := Value;
end;

procedure TMediaDataModel.SetPreview(const Value: TMediaPreviewModel);
begin
  FPreview := Value;
end;

procedure TMediaDataModel.SetSize(const Value: Integer);
begin
  FSize := Value;
end;

procedure TMediaDataModel.SetSwStreamingSupported(const Value: Boolean);
begin
  FSwStreamingSupported := Value;
end;

procedure TMediaDataModel.Settype_(const Value: string);
begin
  Ftype_ := Value;
end;

{ TMediaPreviewModel }

procedure TMediaPreviewModel.SetB64(const Value: String);
begin
  FB64 := Value;
end;

procedure TMediaPreviewModel.SetInAutoReleasePool(const Value: Boolean);
begin
  FInAutoReleasePool := Value;
end;

procedure TMediaPreviewModel.SetMimeType(const Value: String);
begin
  FMimeType := Value;
end;

procedure TMediaPreviewModel.SetReleased(const Value: BOolean);
begin
  FReleased := Value;
end;

procedure TMediaPreviewModel.SetRetainCount(const Value: Integer);
begin
  FRetainCount := Value;
end;

{ TLocationMessage }

procedure TLocationMessageModel.SetPhone(const Value: String);
begin
  FPhone := Value;
end;

procedure TLocationMessageModel.SetLatitude(const Value: Extended);
begin
  FLatitude := Value;
end;

procedure TLocationMessageModel.SetLongitude(const Value: Extended);
begin
  FLongitude := Value;
end;

procedure TLocationMessageModel.SetTitle(const Value: String);
begin
  FTitle := Value;
end;

{ TContactVCardMessage }

procedure TContactVCardMessageModel.SetPhone(const Value: String);
begin
  FPhone := Value;
end;

procedure TContactVCardMessageModel.SetContactsId(const Value: String);
begin
  FContactsId := Value;
end;

procedure TContactVCardMessageModel.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TContactVCardMessageModel.SetIsGroup(const Value: Boolean);
begin
  FIsGroup := Value;
end;

{ TLinkPreviweMessage }

procedure TLinkPreviweMessageModel.SetPhone(const Value: String);
begin
  FPhone := Value;
end;

procedure TLinkPreviweMessageModel.SetUrl(const Value: String);
begin
  FUrl := Value;
end;

procedure TLinkPreviweMessageModel.SetCaption(const Value: String);
begin
  FCaption := Value;
end;

{ TNumberStatusModel }

procedure TNumberStatusModel.SetId(const Value: TIdModel);
begin
  FId := Value;
end;

procedure TNumberStatusModel.SetIsBusiness(const Value: Boolean);
begin
  FIsBusiness := Value;
end;

destructor TNumberStatusModel.destroy;
begin
  if Assigned(FId) then
    FreeAndNil(FId);
  inherited;
end;

procedure TNumberStatusModel.SetCanReceiveMessage(const Value: Boolean);
begin
  FCanReceiveMessage := Value;
end;

procedure TNumberStatusModel.SetNumberExists(const Value: Boolean);
begin
  FNumberExists := Value;
end;

end.
