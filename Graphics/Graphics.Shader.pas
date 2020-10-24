unit Graphics.Shader;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  Interfaces.Console,
  dglOpenGl,
  App.Resources;
{ *************************************************************************** }
type
  TShader = class
    private
      FConsole : IConsole;
      FHandle  : GlHandle;
      procedure Compile(const _Source : TShaderResource;
                        const _Type   : GLenum);
    public
      constructor Create(const _Console        : IConsole;
                         const _VertexShader   : TShaderResource;
                         const _FragmentShader : TShaderResource);
      procedure Activate;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
uses
  IOUtils,
  SysUtils;
{ *************************************************************************** }
{ PRIVATE                                                                     }
{ *************************************************************************** }
procedure TShader.Compile(const _Source : TShaderResource;
                          const _Type   : GLenum);
var
  LShader  : GlHandle;
  LResult  : GlInt;
  LInfoLog : AnsiString;
  LSource  : AnsiString;
begin
  // Get Source Data
  LShader := glCreateShader(_Type);
  LSource := _Source.GetData;
  glShaderSource(LShader, 1, @LSource, nil);
  // Output to Console
  FConsole.LogMessage('Compiling ', False);
  case _Type of
    GL_VERTEX_SHADER   : FConsole.LogMessage('Vertex-Shader', False);
    GL_FRAGMENT_SHADER : FConsole.LogMessage('Fragment-Shader', False);
  end;
  case _Source.Source of
    SOURCE_TYPE_FILE : FConsole.LogMessage(' "' + _Source.Filename + '"', False);
  end;
  FConsole.LogMessage('...', False);
  // Compile
  glCompileShader(LShader);
  glGetShaderiv(LShader, GL_COMPILE_STATUS, @LResult);
  // Evaluate Compilation
  if LResult = 1 then
  begin
    glAttachShader(FHandle, LShader);
    FConsole.LogSuccess;
  end
  else
  begin
    glGetShaderiv(LShader, GL_INFO_LOG_LENGTH, @LResult);
    SetLength(LInfoLog, LResult);
    glGetShaderInfoLog(LShader, LResult, @LResult, @LInfoLog[1]);
    FConsole.LogError(string(LInfoLog));
  end;
  // Cleanup
  glDeleteShader(LShader);
end;
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
procedure TShader.Activate;
begin
  glUseProgram(FHandle);
end;
{ *************************************************************************** }
constructor TShader.Create(const _Console        : IConsole;
                           const _VertexShader   : TShaderResource;
                           const _FragmentShader : TShaderResource);
begin
  FConsole := _Console;
  FHandle  := glCreateProgram;

  Compile(_VertexShader, GL_VERTEX_SHADER);
  Compile(_FragmentShader, GL_FRAGMENT_SHADER);

  glLinkProgram(FHandle);
end;
{ *************************************************************************** }
end.
