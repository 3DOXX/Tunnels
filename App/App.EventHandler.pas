unit App.EventHandler;
{ *************************************************************************** }
interface
{ *************************************************************************** }
type
  TActivityEvent = procedure of object;
{ *************************************************************************** }
  TEventHandler = class
    private
      FOnUpdate : TActivityEvent;
    public
      constructor Create;

      procedure HandleEvents;

      property OnUpdateEvent : TActivityEvent read FOnUpdate write FOnUpdate;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
uses
  SDL2;
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
constructor TEventHandler.Create;
begin
  FOnUpdate := nil;
end;
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

    if Assigned(FOnUpdate) then
      FOnUpdate;
  end;
end;
{ *************************************************************************** }
end.
