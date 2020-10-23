unit App.Activity;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  Interfaces.App;
{ *************************************************************************** }
type
  TActivity = class
    protected
      FApp : IApp;
    public
      constructor Create(const _App : IApp);

      procedure OnLoad; virtual;
      procedure OnUpdate; virtual;
      procedure OnFinish; virtual;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
constructor TActivity.Create(const _App : IApp);
begin
  FApp := _App;
end;
{ *************************************************************************** }
procedure TActivity.OnFinish;
begin
end;
{ *************************************************************************** }
procedure TActivity.OnLoad;
begin
end;
{ *************************************************************************** }
procedure TActivity.OnUpdate;
begin
end;
{ *************************************************************************** }
end.
