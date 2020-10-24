unit Graphics.Drawable;
{ *************************************************************************** }
interface
{ *************************************************************************** }
uses
  Neslib.FastMath;
{ *************************************************************************** }
type
  TDrawable = class
    private
      FMatModel : TMatrix4;
      FPosition : TVector3;
      procedure RebuildModelMatrix;
    protected
      FMatTrans : TMatrix4;
      FMatRot   : TMatrix4;
      FMatScale : TMatrix4;
    public
      constructor Create;

      procedure SetPosition(const _X : Single;
                            const _Y : Single;
                            const _Z : Single);
      procedure Move(const _X : Single;
                     const _Y : Single;
                     const _Z : Single);

      property ModelMatrix : TMatrix4 read FMatModel;
      property Position    : TVector3 read FPosition write FPosition;
  end;
{ *************************************************************************** }
implementation
{ *************************************************************************** }
{ PUBLIC                                                                      }
{ *************************************************************************** }
procedure TDrawable.Move(const _X, _Y, _Z : Single);
begin
  SetPosition(FPosition.X+_X, FPosition.Y+_Y, FPosition.Z+_Z);
end;
{ *************************************************************************** }
procedure TDrawable.SetPosition(const _X, _Y, _Z : Single);
begin
  FPosition.Init(_X,_Y,_Z);
  FMatTrans.InitTranslation(FPosition);
  RebuildModelMatrix;
end;
{ *************************************************************************** }
constructor TDrawable.Create;
begin
  FPosition.Init(0);

  FMatTrans.InitTranslation(0,0,0);
  FMatRot.InitRotationYawPitchRoll(0,0,0);
  FMatScale.InitScaling(1);

  RebuildModelMatrix;
end;
{ *************************************************************************** }
{ PRIVATE                                                                     }
{ *************************************************************************** }
procedure TDrawable.RebuildModelMatrix;
begin
  FMatModel := FMatTrans * FMatRot * FMatScale;
end;
{ *************************************************************************** }
end.
