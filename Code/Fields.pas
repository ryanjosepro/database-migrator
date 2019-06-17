unit Fields;

interface

uses
  System.SysUtils, System.Classes, System.Types;

type
  TFields = class
  public
    class function ExtractOrder(StrList: TStringList): TStringList;
    class function ExtractDefaults(StrList: TStringList): TStringList;
  end;

implementation

{ TFields }

class function TFields.ExtractOrder(StrList: TStringList): TStringList;
var
  Cont: integer;
begin
  Result := TStringList.Create;
  for Cont := 0 to StrList.Count - 1 do
  begin
    if StrList[Cont] <> '{$DEFAULTS$}' then
    begin
      Result.Add(StrList[Cont]);
    end
    else
    begin
      Break;
    end;
  end;
end;

class function TFields.ExtractDefaults(StrList: TStringList): TStringList;
var
  Cont: integer;
begin
  Result := TStringList.Create;
  Cont := 0;
  while StrList[Cont] <> '{$DEFAULTS$}' do
  begin
    Inc(Cont);
  end;

  for Cont := Cont + 1 to StrList.Count - 1 do
  begin
    Result.Add(StrList[Cont]);
  end;
end;

end.
