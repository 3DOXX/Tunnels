unit Game.Renderer;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  SDL2,
  dglOpenGl,
  Interfaces.Window,
  Game.Graphics,
  Graphics.Drawable,
  Graphics.VertexArray,
  Graphics.VertexBuffer;
{ *************************************************************************** }
type
  TRenderer = class
    private
      FWindow   : IWindow;
      FContext  : TSDL_GlContext;
      FGraphics : TGraphics;
      FVAO : TVertexArray;
      FVBO : TVertexBuffer;
    public
      constructor Create(const _Window : IWindow; const _Graphics : TGraphics);
      destructor  Destroy; override;

      procedure Clear;
      procedure SwapBuffers;

      procedure Render(const _Drawable : TDrawable);
      procedure Prepare;
  end;
{ *************************************************************************** }
implementation

const
  vertices : TVertexData = ( 0.5, -0.5, 0.0,
                            -0.5, -0.5, 0.0,
                             0.0,  0.5, 0.0 );
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
procedure TRenderer.Render(const _Drawable : TDrawable);
begin
  FVAO.Activate;
  glDrawArrays(GL_TRIANGLES, 0, 3);
end;
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
constructor TRenderer.Create(const _Window : IWindow; const _Graphics : TGraphics);
begin
  FWindow   := _Window;
  FGraphics := _Graphics;
  FContext  := SDL_GL_CreateContext(FWindow.Handle);

  glClearColor(0.1, 0.2, 0.3, 1);

end;
{ *************************************************************************** }
destructor TRenderer.Destroy;
begin
  SDL_GL_DeleteContext(FContext);
  inherited;
end;

procedure TRenderer.Prepare;
begin
  FVAO := TVertexArray.Create;
  FVBO := TVertexBuffer.Create;
  FVBO.AssignData(vertices);

  FVAO.AssignBuffer(FVBO);
end;

{ *************************************************************************** }
end.
