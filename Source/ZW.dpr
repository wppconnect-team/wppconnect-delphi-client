program ZW;

uses
  Vcl.Forms,
  View.Main in 'View\View.Main.pas' {MainView},
  ZW.Controller.ZW in 'Controller\ZW.Controller.ZW.pas',
  ZW.Utils.LibUtils in 'Utils\ZW.Utils.LibUtils.pas',
  ZW.Utils.Emoction in 'Utils\ZW.Utils.Emoction.pas',
  ZW.Model in 'Model\ZW.Model.pas',
  View.InputPhone in 'View\View.InputPhone.pas' {FInputPhone};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
