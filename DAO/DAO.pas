unit DAO;

interface

uses
  System.SysUtils, System.Variants, System.Classes, FireDAC.Comp.Client, ConnectionFactory, ViewDB, MyUtils,
  Vcl.Dialogs;

type
  TStringArray = array of string;

  TDAO = class
  public
    class function QueryTable: TFDQuery;
    class function QuerySQL: TFDQuery;

    class function Table: string;

    class function GetFieldsNames: TStringArray;

    class function Count: integer;

  end;

implementation

{ TDAO }

class function TDAO.QueryTable: TFDQuery;
begin
  Result := ConnFactory.QueryTable;
end;

class function TDAO.Table: string;
begin
  Result := TConfigs.GetTable;
end;

class function TDAO.QuerySQL: TFDQuery;
begin
  Result := ConnFactory.QuerySQL;
end;

class function TDAO.GetFieldsNames: TStringArray;
var
  Cont: integer;
begin
  QueryTable.Close;
  QueryTable.ParamByName('TABLE_NAME').AsString := Table;
  QueryTable.Open;
  if QueryTable.RowsAffected <> 0 then
  begin
    SetLength(Result, QueryTable.RowsAffected);
    QueryTable.First;
    for Cont := 0 to QueryTable.RowsAffected do
    begin
      Result[Cont] := QueryTable.FieldByName('FIELD_NAME').AsString;
      QueryTable.Next;
    end;
  end
  else
  begin
    SetLength(Result, 1);
    Result[0] := '';
  end;
end;

class function TDAO.Count: integer;
begin
  QueryTable.Close;
  QueryTable.ParamByName('TABLE_NAME').AsString := Table;
  QueryTable.Open;
  Result := QueryTable.RowsAffected;
end;

end.
