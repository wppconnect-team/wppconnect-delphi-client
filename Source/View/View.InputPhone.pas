unit View.InputPhone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;

type
  TFInputPhone = class(TForm)
    EditAdressPhone: TMaskEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInputPhone: TFInputPhone;

implementation

{$R *.dfm}

procedure TFInputPhone.Button1Click(Sender: TObject);
begin
  ModalResult := mrOk;
//  if EditAdressPhone.Text.Trim.Length <= '12' then
//  begin
//    Application.MessageBox('Number is invalidad.', 'Warning', MB_OK);
//    ModalResult := mrCancel;
//  end;
end;

end.
