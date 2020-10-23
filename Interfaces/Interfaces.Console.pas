unit Interfaces.Console;
{ *************************************************************************** }
interface
{ *************************************************************************** }
type
  IConsole = interface
    procedure LogMessage(const _Text : string; const _Linebreak : boolean = True);
    procedure LogError  (const _Text : string);
    procedure LogWarning(const _Text : string);
    procedure LogSuccess(const _Text : string = '');
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
end.
