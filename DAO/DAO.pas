unit DAO;

interface

uses
  System.SysUtils, System.Variants, System.Classes, FireDAC.Comp.Client, ViewDB, ConnectionFactory;

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
  Result := WindowDB.TxtTable.Text;
end;

class function TDAO.QuerySQL: TFDQuery;
begin
  Result := ConnFactory.QuerySQL;
end;

class function TDAO.Count: integer;
begin
  QueryTable.Close;
  QueryTable.ParamByName('TABLE_NAME').AsString := Table;
  QueryTable.Open;
  Result := QueryTable.RowsAffected;
end;

class function TDAO.GetFieldsNames: TStringArray;
var
  Cont: integer;
begin
  QueryTable.Close;
  QueryTable.ParamByName('TABLE_NAME').AsString := Table;
  QueryTable.Open;
  SetLength(Result, QueryTable.RowsAffected);
  QueryTable.First;
  Cont := 0;
  while Cont <> QueryTable.RowsAffected - 1 do
  begin
    Result[Cont] := QueryTable.FieldByName('FIELD_NAME').AsString;
    QueryTable.Next;
    Inc(Cont, 1);
  end;
end;


end.
