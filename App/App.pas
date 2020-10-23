unit App;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  App.Console,
  App.EventHandler,
  App.Activity,
  App.Window,
  Interfaces.App,
  Interfaces.Console,
  Interfaces.Window;
{ *************************************************************************** }
type
  TApp = class(TInterfacedObject, IApp)
    private
      FConsole      : TConsole;
      FEventHandler : TEventHandler;
      FActivity     : TActivity;
      FWindow       : TWindow;
      function InitSDL : boolean;
      procedure SetActivity(const _Activity : TActivity);
    protected
      function GetConsole : IConsole;
      function GetWindow  : IWindow;
    public
      constructor Create;
      destructor  Destroy; override;

      property EventHandler : TEventHandler read FEventHandler;
      property Activity     : TActivity     read FActivity write SetActivity;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
uses
  SysUtils,
  SDL2;
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
constructor TApp.Create;
begin
  inherited;
  FConsole  := TConsole.Create;
  if InitSDL then
  begin
    FEventHandler := TEventHandler.Create;
    FWindow       := TWindow.Create;
  end
  else
    raise Exception.Create(string(SDL_GetError));
end;
{ *************************************************************************** }
destructor TApp.Destroy;
begin
  FreeAndNil(FWindow);
  FreeAndNil(FEventHandler);
  FreeAndNil(FConsole);
  SDL_Quit;
  inherited;
end;
{ *************************************************************************** }
{ PROTECTED                                                                   }
{ *************************************************************************** }
function TApp.GetConsole : IConsole;
begin
  Result := FConsole;
end;
{ *************************************************************************** }
function TApp.GetWindow : IWindow;
begin
  Result := FWindow;
end;
{ *************************************************************************** }
{ PRIVATE                                                                     }
{ *************************************************************************** }
function TApp.InitSDL : boolean;
begin
  FConsole.LogMessage('Initializing SDL2...', False);
  Result := (SDL_Init(SDL_INIT_VIDEO) = 0);
  if Result then
    FConsole.LogSuccess
  else
    FConsole.LogError(string(SDL_GetError));
end;
{ *************************************************************************** }
procedure TApp.SetActivity(const _Activity : TActivity);
begin
  FEventHandler.OnUpdateEvent := nil;
  FActivity := _Activity;
  if _Activity <> nil then
  begin
    FActivity.OnLoad;
    FEventHandler.OnUpdateEvent := FActivity.OnUpdate;
  end;
end;
{ *************************************************************************** }
end.
