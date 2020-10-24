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
  App.Window in 'App\App.Window.pas',
  Game in 'Game\Game.pas',
  Game.Graphics in 'Game\Game.Graphics.pas',
  Interfaces.Console in 'Interfaces\Interfaces.Console.pas',
  Interfaces.Window in 'Interfaces\Interfaces.Window.pas',
  Interfaces.App in 'Interfaces\Interfaces.App.pas',
  App.Utils in 'App\App.Utils.pas',
  Game.Renderer in 'Game\Game.Renderer.pas',
  Graphics.Shader in 'Graphics\Graphics.Shader.pas',
  App.Resources in 'App\App.Resources.pas',
  Graphics.Drawable in 'Graphics\Graphics.Drawable.pas',
  Graphics.VertexBuffer in 'Graphics\Graphics.VertexBuffer.pas',
  Graphics.VertexArray in 'Graphics\Graphics.VertexArray.pas';

{ *************************************************************************** }
var
  FApp  : TApp;
  FGame : TGame;
{ *************************************************************************** }
begin
  try
    FApp  := TApp.Create;
    FGame := TGame.Create(FApp);
    FApp.Activity := FGame;
    FApp.EventHandler.HandleEvents;
    TryFreeAndNil(FGame);
    TryFreeAndNil(FApp);
  except
    on E : Exception do
      SDL_ShowSimpleMessageBox(SDL_MESSAGEBOX_ERROR,
                               PAnsiChar(AnsiString(E.ClassName)),
                               PAnsiChar(AnsiString(E.Message)),
                               nil);
  end;
end.
