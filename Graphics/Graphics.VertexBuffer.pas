unit Graphics.VertexBuffer;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  dglOpenGl;
{ *************************************************************************** }
type
  TVertexData = array[0..8] of Single;
{ *************************************************************************** }
  TVertexBuffer = class
    private
      FID : GlUint;
    public
      constructor Create;
      destructor  Destroy; override;

      procedure Activate;
      procedure AssignData(const _Data : TVertexData);
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
procedure TVertexBuffer.Activate;
begin
  glBindBuffer(GL_ARRAY_BUFFER, FID);
end;
{ *************************************************************************** }
constructor TVertexBuffer.Create;
begin
  glGenBuffers(1, @FID);
end;
{ *************************************************************************** }
destructor TVertexBuffer.Destroy;
begin
  glDeleteBuffers(1, @FID);
  inherited;
end;
{ *************************************************************************** }
procedure TVertexBuffer.AssignData(const _Data : TVertexData);
begin
  Activate;
  glBufferData(GL_ARRAY_BUFFER, sizeof(_Data), @_Data, GL_STATIC_DRAW);
end;
{ *************************************************************************** }
end.
