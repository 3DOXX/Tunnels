unit App.Window;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  SDL2;
{ *************************************************************************** }
type
  TWindow = class
    private
      FHandle : PSDL_Window;
    public
      constructor Create;
      destructor  Destroy; override;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
constructor TWindow.Create;
begin
  FHandle := SDL_CreateWindow('tunnels',
                              SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
                              800, 600,
                              SDL_WINDOW_OPENGL);
end;
{ *************************************************************************** }
destructor TWindow.Destroy;
begin
  SDL_DestroyWindow(FHandle);
  inherited;
end;
{ *************************************************************************** }
end.
