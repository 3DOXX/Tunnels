unit Game.Graphics;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  Interfaces.Console,
  Graphics.Shader,
  App.Resources,
  Neslib.FastMath;
{ *************************************************************************** }
type
  TGraphics = class
    private
      FConsole : IConsole;
      FMatProj : TMatrix4;
      FShader  : TShader;
      procedure Init;
    public
      constructor Create(const _Console : IConsole);
      procedure AssignFunctions;

      function CreateShader(const _VertexShader   : string;
                            const _FragmentShader : string) : TShader;

      property ProjectionMatrix : TMatrix4 read FMatProj;
      property TestShader       : TShader  read FShader write FShader;
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
  Result := TShader.Create(FConsole,
                           TShaderResource.Create('test',_VertexShader),
                           TShaderResource.Create('test',_FragmentShader));
end;
{ *************************************************************************** }
procedure TGraphics.AssignFunctions;
begin
  glCreateProgram           := SDL_GL_GetProcAddress('glCreateProgram');
  glCreateShader            := SDL_GL_GetProcAddress('glCreateShader');
  glShaderSource            := SDL_GL_GetProcAddress('glShaderSource');
  glCompileShader           := SDL_GL_GetProcAddress('glCompileShader');
  glGetShaderiv             := SDL_GL_GetProcAddress('glGetShaderiv');
  glAttachShader            := SDL_GL_GetProcAddress('glAttachShader');
  glDeleteShader            := SDL_GL_GetProcAddress('glDeleteShader');
  glUseProgram              := SDL_GL_GetProcAddress('glUseProgram');
  glLinkProgram             := SDL_GL_GetProcAddress('glLinkProgram');
  glGetShaderInfoLog        := SDL_GL_GetProcAddress('glGetShaderInfoLog');
  glGenVertexArrays         := SDL_GL_GetProcAddress('glGenVertexArrays');
  glGenBuffers              := SDL_GL_GetProcAddress('glGenBuffers');
  glBindBuffer              := SDL_GL_GetProcAddress('glBindBuffer');
  glBufferData              := SDL_GL_GetProcAddress('glBufferData');
  glVertexAttribPointer     := SDL_GL_GetProcAddress('glVertexAttribPointer');
  glBindVertexArray         := SDL_GL_GetProcAddress('glBindVertexArray');
  glEnableVertexAttribArray := SDL_GL_GetProcAddress('glEnableVertexAttribArray');
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
const
  FOV = 1000;
  AR  = 4/3;
  CLIPPING_NEAR = 1;
  CLIPPING_FAR  = 1000;
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

  // Create Projection Matrix
  FMatProj.InitPerspectiveFovLH(FOV, AR, CLIPPING_NEAR, CLIPPING_FAR);
end;
{ *************************************************************************** }
end.
