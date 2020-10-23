unit Game;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  App.Activity,
  Game.Graphics,
  Game.Renderer;
{ *************************************************************************** }
type
  TGame = class(TActivity)
    private
      FGraphics : TGraphics;
      FRenderer : TRenderer;
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
  FRenderer := TRenderer.Create(FApp.Window);
end;
{ *************************************************************************** }
procedure TGame.OnUpdate;
begin
  FRenderer.Clear;
  FRenderer.SwapBuffers;
end;
{ *************************************************************************** }
end.
