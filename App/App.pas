unit App;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  App.Console;
{ *************************************************************************** }
type
  TApp = class
    private
      FConsole : TConsole;
      function InitSDL : boolean;
    public
      constructor Create;
      destructor  Destroy; override;
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
  FConsole := TConsole.Create;
  if InitSDL then
  begin
    // ...
  end
  else
    raise Exception.Create(string(SDL_GetError));
end;
{ *************************************************************************** }
destructor TApp.Destroy;
begin
  FreeAndNil(FConsole);
  SDL_Quit;
  inherited;
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
end.
