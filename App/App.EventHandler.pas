unit App.EventHandler;
{ *************************************************************************** }
interface
{ *************************************************************************** }
type
  TEventHandler = class
    private
    public
      procedure HandleEvents;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
uses
  SDL2;
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
procedure TEventHandler.HandleEvents;
var
  LRunning : boolean;
  LEvent   : PSDL_Event;
begin
  LRunning := true;
  while LRunning do
  begin
    while SDL_PollEvent(@LEvent) > 0 do
       case LEvent.type_ of
         SDL_QUITEV : LRunning := False;
       end;
  end;
end;
{ *************************************************************************** }
end.
