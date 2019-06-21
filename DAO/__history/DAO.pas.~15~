unit DAO;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, FireDAC.Comp.Client,
  Arrays, Configs, ConnectionFactory;

type

  TDAO = class
  private
    class procedure Select;

  public
    class function QueryTable: TFDQuery;
    class function QuerySQL: TFDQuery;

    class procedure GetParams(var UserName, Password, Database: string);
    class procedure SetParams(UserName, Password, Database: string);

    class procedure TestConn;

    class function Table: string;

    class procedure Insert(Datas: TStringDynArray; Order: TIntegerArray; Defaults: TStringArray);

    class function GetFieldsNames: TStringArray;
    class function GetFieldsTypes: TStringArray;
    class function GetFieldsTypesNumber: TIntegerArray;
    class function GetFieldsNotNulls: TIntegerArray;

    class function Count: integer;

    class procedure Truncate;

  end;

implementation

{ TDAO }

class function TDAO.QueryTable: TFDQuery;
begin
  Result := ConnFactory.QueryTable;
end;

class function TDAO.QuerySQL: TFDQuery;
begin
  Result := ConnFactory.QuerySQL;
end;

class procedure TDAO.GetParams(var UserName, Password, Database: string);
begin
  UserName := ConnFactory.Conn.Params.UserName;
  Password := ConnFactory.Conn.Params.Password;
  Database := ConnFactory.Conn.Params.Database;
end;

class procedure TDAO.SetParams(UserName, Password, Database: string);
begin
  ConnFactory.Conn.Params.UserName := UserName;
  ConnFactory.Conn.Params.Password := Password;
  ConnFactory.Conn.Params.Database := Database;
end;

class procedure TDAO.TestConn;
begin
  ConnFactory.Conn.Connected := true;
end;

class function TDAO.Table: string;
begin
  Result := TConfigs.GetConfig('DB', 'Table');
end;

//TO COMMENT
class procedure TDAO.Insert(Datas: TStringDynArray; Order: TIntegerArray; Defaults: TStringArray);
var
  Cont: Integer;
  Tipos: TIntegerArray;
  Fields: TStringArray;
begin
  SetLength(Tipos, Count);
  Tipos := GetFieldsTypesNumber;
  SetLength(Fields, Count);
  Fields := GetFieldsNames;
  QuerySQL.SQL.Clear;
  QuerySQL.Open('select * from ' + Table);
  QuerySQL.Insert;
  for Cont := 0 to Count - 1 do
  begin
    if (Order[Cont] <> -1) and (Trim(Datas[Order[Cont] - 1]) <> '') then
    begin
      case Tipos[Cont] of
      7, 8:
        QuerySQL.FieldByName(Fields[Cont]).AsInteger := Datas[Order[Cont] - 1].ToInteger;
      12:
        QuerySQL.FieldByName(Fields[Cont]).AsDateTime := StrToDate(Datas[Order[Cont] - 1]);
      14:
        QuerySQL.FieldByName(Fields[Cont]).AsWideString := Datas[Order[Cont] - 1];
      16:
        QuerySQL.FieldByName(Fields[Cont]).AsFloat := Datas[Order[Cont] - 1].ToDouble;
      35:
        QuerySQL.FieldByName(Fields[Cont]).AsDateTime := StrToDateTime(Datas[Order[Cont] - 1]);
      37:
        QuerySQL.FieldByName(Fields[Cont]).AsString := Datas[Order[Cont] - 1];
      end;
    end
    else if Defaults[Cont] <> '' then
    begin
      case Tipos[Cont] of
      7, 8:
        QuerySQL.FieldByName(Fields[Cont]).AsInteger := Defaults[Cont].ToInteger;
      12:
        QuerySQL.FieldByName(Fields[Cont]).AsDateTime := StrToDate(Defaults[Cont]);
      14:
        QuerySQL.FieldByName(Fields[Cont]).AsWideString := Defaults[Cont];
      16:
        QuerySQL.FieldByName(Fields[Cont]).AsFloat := Defaults[Cont].ToDouble;
      35:
        QuerySQL.FieldByName(Fields[Cont]).AsDateTime := StrToDateTime(Defaults[Cont]);
      37:
        QuerySQL.FieldByName(Fields[Cont]).AsString := Defaults[Cont];
      end;
    end;
  end;
  QuerySQL.Post;
end;

//TO COMMENT
class function TDAO.GetFieldsNames: TStringArray;
var
  Cont: integer;
begin
  Select;
  if Count <> 0 then
  begin
    SetLength(Result, Count);
    QueryTable.First;
    for Cont := 0 to Count - 1 do
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

//TO COMMENT
class function TDAO.GetFieldsTypes: TStringArray;
var
  Cont: integer;
begin
  Select;
  if Count <> 0 then
  begin
    SetLength(Result, Count);
    QueryTable.First;
    for Cont := 0 to Count - 1 do
    begin
      Result[Cont] := QueryTable.FieldByName('FIELD_TYPE').AsString;
      QueryTable.Next;
    end;
  end
  else
  begin
    SetLength(Result, 1);
    Result[0] := '';
  end;
end;

//TO COMMENT
class function TDAO.GetFieldsTypesNumber: TIntegerArray;
var
  Cont: integer;
begin
  Select;
  if Count <> 0 then
  begin
    SetLength(Result, Count);
    QueryTable.First;
    for Cont := 0 to Count - 1 do
    begin
      Result[Cont] := QueryTable.FieldByName('FIELD_NUMBER').AsInteger;
      QueryTable.Next;
    end;
  end
  else
  begin
    SetLength(Result, 1);
    Result[0] := 0;
  end;
end;

//TO COMMENT
class function TDAO.GetFieldsNotNulls: TIntegerArray;
var
  Cont: integer;
begin
  Select;
  if Count <> 0 then
  begin
    SetLength(Result, Count);
    QueryTable.First;
    for Cont := 0 to Count - 1 do
    begin
      Result[Cont] := QueryTable.FieldByName('FIELD_NULL').AsInteger;
      QueryTable.Next;
    end;
  end
  else
  begin
    SetLength(Result, 1);
    Result[0] := 0;
  end;
end;

class procedure TDAO.Select;
begin
  QueryTable.Close;
  QueryTable.ParamByName('TABLE_NAME').AsString := Table;
  QueryTable.Open;
end;

class function TDAO.Count: integer;
begin
  Select;
  Result := QueryTable.RowsAffected;
end;

class procedure TDAO.Truncate;
begin
  QuerySQL.SQL.Clear;
  QuerySQL.SQL.Add('delete from ' + Table +' where id > 0');
  QuerySQL.ExecSQL;
  QuerySQL.SQL.Clear;
end;

end.
