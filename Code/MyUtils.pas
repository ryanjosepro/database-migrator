unit MyUtils;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants;

type

  TUtils = class
  public
    class function Iff(cond: boolean; v1, v2: variant): variant;

  end;

implementation

class function TUtils.Iff(Cond: boolean; V1, V2: variant): variant;
begin
  if Cond then
  begin
    Result := V1;
  end
  else
  begin
    Result := V2;
  end;
end;

end.
