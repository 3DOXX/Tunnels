unit Graphics.Shader;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  Interfaces.Console,
  dglOpenGl;
{ *************************************************************************** }
type
  TShader = class
    private
      FConsole : IConsole;
      FHandle  : GlHandle;
      procedure Compile(const _Source : AnsiString;
                        const _Type   : GLenum);
    public
      constructor CreateFromFile(const _Console        : IConsole;
                                 const _VertexShader   : string;
                                 const _FragmentShader : string);
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
procedure TShader.Compile(const _Source : AnsiString;
                          const _Type   : GLenum);
var
  LShader  : GlHandle;
  LResult  : GlInt;
  LInfoLog : AnsiString;
begin
  LShader := glCreateShader(_Type);
  glShaderSource(LShader, 1, @_Source, nil);

  FConsole.LogMessage('Compiling shader...', False);
  glCompileShader(LShader);
  glGetShaderiv(LShader, GL_COMPILE_STATUS, @LResult);

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
constructor TShader.CreateFromFile(const _Console        : IConsole;
                                   const _VertexShader   : string;
                                   const _FragmentShader : string);
begin
  FConsole := _Console;
  FHandle  := glCreateProgram;

  Compile(AnsiString(TFile.ReadAllText(_VertexShader, TEncoding.ANSI)), GL_VERTEX_SHADER);
  Compile(AnsiString(TFile.ReadAllText(_FragmentShader, TEncoding.ANSI)), GL_FRAGMENT_SHADER);

  glLinkProgram(FHandle);
end;
{ *************************************************************************** }
end.
