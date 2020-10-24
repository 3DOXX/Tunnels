unit Game;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  App.Activity,
  Game.Graphics,
  Game.Renderer,
  Graphics.Drawable;
{ *************************************************************************** }
type
  TGame = class(TActivity)
    private
      FGraphics : TGraphics;
      FRenderer : TRenderer;
      FDrawable : TDrawable;
    public
      procedure OnLoad; override;
      procedure OnUpdate; override;
      procedure OnFinish; override;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
uses
  SysUtils;
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
procedure TGame.OnFinish;
begin
  FreeAndNil(FRenderer);
  FreeAndNil(FGraphics);
end;
{ *************************************************************************** }
procedure TGame.OnLoad;
begin
  FGraphics := TGraphics.Create(FApp.Console);

  FRenderer := TRenderer.Create(FApp.Window, FGraphics);

  FGraphics.AssignFunctions;

  FRenderer.Prepare;


  FGraphics.TestShader := FGraphics.CreateShader('g:\test.vrt', 'g:\test.frg');
  FDrawable := TDrawable.Create;

  FGraphics.TestShader.Activate;
end;
{ *************************************************************************** }
procedure TGame.OnUpdate;
begin
  FRenderer.Clear;
  FRenderer.Render(FDrawable);
  FRenderer.SwapBuffers;
end;
{ *************************************************************************** }
end.
