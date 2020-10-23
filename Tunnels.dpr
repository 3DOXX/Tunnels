program Tunnels;
{ *************************************************************************** }
{$APPTYPE GUI}
{$R *.res}
{ *************************************************************************** }
uses
  SDL2,
  System.SysUtils,
  App.Activity in 'App\App.Activity.pas',
  App in 'App\App.pas',
  App.Console in 'App\App.Console.pas',
  App.EventHandler in 'App\App.EventHandler.pas',
  App.Window in 'App\App.Window.pas';

{ *************************************************************************** }
var
  FApp : TApp;
{ *************************************************************************** }
begin
  try
    FApp := TApp.Create;
    FApp.EventHandler.HandleEvents;
    FreeAndNil(FApp);
  except
    on E : Exception do
      SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR,
                               PAnsiChar(AnsiString(E.ClassName)),
                               PAnsiChar(AnsiString(E.Message)),
                               nil);
  end;
end.
