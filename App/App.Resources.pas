unit App.Resources;
{ *************************************************************************** }
interface
{ *************************************************************************** }
type
  ESourceType = ( SOURCE_TYPE_FILE, SOURCE_TYPE_RES );
{ *************************************************************************** }
  TResource = class
    private
      FName   : string;
      FSource : ESourceType;
    protected
      FFile   : string;
    public
      constructor Create(const _Name : string; const _Source : ESourceType);

      property Name     : string      read FName;
      property Source   : ESourceType read FSource;
      property Filename : string      read FFile;
  end;
{ *************************************************************************** }
  TShaderResource = class(TResource)
    private
    public
      constructor Create(const _Name : string; const _File : string);

      function GetData : AnsiString;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
uses
  IOUtils,
  SysUtils;
{ *************************************************************************** }
{ TShaderResource                                                             }
{ *************************************************************************** }
constructor TShaderResource.Create(const _Name : string; const _File : string);
begin
  inherited Create(_Name, SOURCE_TYPE_FILE);
  FFile := _File;
end;
{ *************************************************************************** }
function TShaderResource.GetData : AnsiString;
begin
  if FSource = SOURCE_TYPE_FILE then
    Result := AnsiString(TFile.ReadAllText(FFile, TEncoding.ANSI));
end;
{ *************************************************************************** }
{ TResource                                                                   }
{ *************************************************************************** }
constructor TResource.Create(const _Name : string; const _Source : ESourceType);
begin
  FName   := _Name;
  FSource := _Source;
end;
{ *************************************************************************** }
end.
