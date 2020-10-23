unit App.Console;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  Windows ;
{ *************************************************************************** }
type
  ETextColor = ( TEXT_COLOR_WHITE  = FOREGROUND_RED or FOREGROUND_GREEN or FOREGROUND_BLUE ,
                 TEXT_COLOR_RED    = FOREGROUND_RED ,
                 TEXT_COLOR_YELLOW = FOREGROUND_RED or FOREGROUND_GREEN ,
                 TEXT_COLOR_GREEN  = FOREGROUND_GREEN ) ;
{ *************************************************************************** }
  TConsole = class
    private
      procedure Output(const _Text      : string;
                       const _Linebreak : Boolean;
                       const _Color     : ETextColor);
    public
      destructor Destroy; override;

      procedure LogMessage(const _Text : string; const _Linebreak : boolean = True);
      procedure LogError  (const _Text : string);
      procedure LogWarning(const _Text : string);
      procedure LogSuccess(const _Text : string = '');

      procedure ShowConsole;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
destructor TConsole.Destroy;
begin
  if GetStdHandle(STD_OUTPUT_HANDLE) > 0 then
    FreeConsole;
  inherited;
end;
{ *************************************************************************** }
procedure TConsole.ShowConsole;
begin
  if GetStdHandle(STD_OUTPUT_HANDLE) = 0 then
    AllocConsole;
end;
{ *************************************************************************** }
procedure TConsole.LogMessage(const _Text : string; const _Linebreak : boolean);
begin
  Output(_Text, _Linebreak, TEXT_COLOR_WHITE);
end;
{ *************************************************************************** }
procedure TConsole.LogError(const _Text : string);
begin
  Output('ERROR: ', False, TEXT_COLOR_RED);
  Output(_Text, True, TEXT_COLOR_WHITE);
end;
{ *************************************************************************** }
procedure TConsole.LogWarning(const _Text : string);
begin
  Output('WARNING: ', False, TEXT_COLOR_YELLOW);
  Output(_Text, True, TEXT_COLOR_WHITE);
end;
{ *************************************************************************** }
procedure TConsole.LogSuccess(const _Text : string);
begin
  if _Text <> '' then
  begin
    Output('OK ', False, TEXT_COLOR_GREEN);
    Output('(' + _Text + ')', True, TEXT_COLOR_WHITE);
  end
  else
    Output('OK', True, TEXT_COLOR_GREEN);
end;
{ *************************************************************************** }
{ PRIVATE                                                                     }
{ *************************************************************************** }
procedure TConsole.Output(const _Text      : string;
                          const _Linebreak : Boolean;
                          const _Color     : ETextColor);
var
  LHandle : THandle;
begin
  LHandle := GetStdHandle(STD_OUTPUT_HANDLE);
  if LHandle > 0 then
  begin
    SetConsoleTextAttribute(LHandle, Word(_Color));
    if _Linebreak then
      WriteLn(_Text)
    else
      Write(_Text);
    SetConsoleTextAttribute(LHandle, Word(TEXT_COLOR_WHITE));
  end;
end;
{ *************************************************************************** }
end.
