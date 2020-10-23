unit Interfaces.App;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  Interfaces.Console,
  Interfaces.Window;
{ *************************************************************************** }
type
  IApp = interface
    function GetWindow : IWindow;
    property Window    : IWindow read GetWindow;

    function GetConsole : IConsole;
    property Console    : IConsole read GetConsole;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
end.
