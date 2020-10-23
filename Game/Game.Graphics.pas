unit Game.Graphics;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  Interfaces.Console,
  Interfaces.Window;
{ *************************************************************************** }
type
  TGraphics = class
    private
      FConsole : IConsole;
      procedure Init;
    public
      constructor Create(const _Console : IConsole);
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
uses
  dglOpenGl,
  SysUtils;
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
constructor TGraphics.Create(const _Console : IConsole);
begin
  FConsole := _Console;
  Init;
end;
{ *************************************************************************** }
{ PRIVATE                                                                     }
{ *************************************************************************** }
procedure TGraphics.Init;
begin
  FConsole.LogMessage('Initializing OpenGL...', False);
  if InitOpenGL then
  begin
    ReadExtensions;
    FConsole.LogSuccess;
  end
  else
  begin
    FConsole.LogError('Failed to load OpenGL-driver');
    raise Exception.Create('Failed to load OpenGL-driver');
  end;
end;
{ *************************************************************************** }
end.
