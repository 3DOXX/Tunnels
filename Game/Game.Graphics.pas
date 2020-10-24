unit Game.Graphics;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  Interfaces.Console,
  Graphics.Shader;
{ *************************************************************************** }
type
  TGraphics = class
    private
      FConsole : IConsole;
      procedure Init;
    public
      constructor Create(const _Console : IConsole);
      procedure AssignFunctions;

      function CreateShader(const _VertexShader   : string;
                            const _FragmentShader : string) : TShader;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
uses
  dglOpenGl,
  SysUtils,
  SDL2;
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
function TGraphics.CreateShader(const _VertexShader   : string;
                                const _FragmentShader : string) : TShader;
begin
  Result := TShader.CreateFromFile(FConsole, _VertexShader, _FragmentShader);
end;
{ *************************************************************************** }
procedure TGraphics.AssignFunctions;
begin
  glCreateProgram    := SDL_GL_GetProcAddress('glCreateProgram');
  glCreateShader     := SDL_GL_GetProcAddress('glCreateShader');
  glShaderSource     := SDL_GL_GetProcAddress('glShaderSource');
  glCompileShader    := SDL_GL_GetProcAddress('glCompileShader');
  glGetShaderiv      := SDL_GL_GetProcAddress('glGetShaderiv');
  glAttachShader     := SDL_GL_GetProcAddress('glAttachShader');
  glDeleteShader     := SDL_GL_GetProcAddress('glDeleteShader');
  glUseProgram       := SDL_GL_GetProcAddress('glUseProgram');
  glLinkProgram      := SDL_GL_GetProcAddress('glLinkProgram');
  glGetShaderInfoLog := SDL_GL_GetProcAddress('glGetShaderInfoLog');
end;
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
