unit App.Utils;
{ *************************************************************************** }
interface
{ *************************************************************************** }
procedure TryFreeAndNil(_Object : TObject);
{ *************************************************************************** }
implementation
{ *************************************************************************** }
uses
  SysUtils;
{ *************************************************************************** }
procedure TryFreeAndNil(_Object : TObject);
begin
  if _Object is TInterfacedObject then
  begin
    if (_Object as TInterfacedObject).RefCount > 0 then
      FreeAndNil(_Object);
  end
  else
    FreeAndNil(_Object);
end;
{ *************************************************************************** }
end.
