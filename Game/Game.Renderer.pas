unit Game.Renderer;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  SDL2,
  dglOpenGl,
  Interfaces.Window;
{ *************************************************************************** }
type
  TRenderer = class
    private
      FWindow  : IWindow;
      FContext : TSDL_GlContext;
    public
      constructor Create(const _Window : IWindow);
      destructor  Destroy; override;

      procedure Clear;
      procedure SwapBuffers;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
procedure TRenderer.Clear;
begin
  glClear(GL_COLOR_BUFFER_BIT);
end;
{ *************************************************************************** }
procedure TRenderer.SwapBuffers;
begin
  SDL_GL_SwapWindow(FWindow.Handle);
end;
{ *************************************************************************** }
constructor TRenderer.Create(const _Window : IWindow);
begin
  FWindow  := _Window;
  FContext := SDL_GL_CreateContext(FWindow.Handle);

  glClearColor(0.1, 0.2, 0.3, 1);
end;
{ *************************************************************************** }
destructor TRenderer.Destroy;
begin
  SDL_GL_DeleteContext(FContext);
  inherited;
end;
{ *************************************************************************** }
end.
