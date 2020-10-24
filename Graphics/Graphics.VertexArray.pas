unit Graphics.VertexArray;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  dglOpenGl,
  Graphics.VertexBuffer;
{ *************************************************************************** }
type
  TVertexArray = class
    private
      FID         : GlUint;
      FAttributes : Integer;
    public
      constructor Create;
      destructor  Destroy; override;

      procedure Activate;
      procedure AssignBuffer(const _Buffer : TVertexBuffer;
                             const _Size   : GlInt = 3;
                             const _Type   : GlEnum  = GL_FLOAT);
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
procedure TVertexArray.Activate;
begin
  glBindVertexArray(FID);
end;
{ *************************************************************************** }
procedure TVertexArray.AssignBuffer(const _Buffer : TVertexBuffer;
                                    const _Size   : GlInt;
                                    const _Type   : GlEnum);
begin
  Activate;
  _Buffer.Activate;
  glVertexAttribPointer(FAttributes, _Size, _Type, GL_FALSE, 0, nil);
  glEnableVertexAttribArray(FAttributes);
  inc(FAttributes);
end;
{ *************************************************************************** }
constructor TVertexArray.Create;
begin
  glGenVertexArrays(1, @FID);
end;
{ *************************************************************************** }
destructor TVertexArray.Destroy;
begin
  glDeleteVertexArrays(1, @FID);
  inherited;
end;
{ *************************************************************************** }
end.
