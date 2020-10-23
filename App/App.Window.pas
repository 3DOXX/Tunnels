unit App.Window;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  SDL2,
  Interfaces.Window;
{ *************************************************************************** }
type
  TWindow = class(TInterfacedObject, IWindow)
    private
      FHandle : PSDL_Window;
    protected
      function GetHandle : PSDL_Window;
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
  inherited;
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
{ PROTECTED                                                                   }
{ *************************************************************************** }
function TWindow.GetHandle : PSDL_Window;
begin
  Result := FHandle;
end;
{ *************************************************************************** }
end.
