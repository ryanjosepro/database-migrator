unit DataFlex;

interface

uses
  System.SysUtils, System.Classes, System.Types, Vcl.Forms,
  Arrays, MyUtils;

type

  TDataFlex = class
  private
    StrList: TStringList;
    Separator: string;
    Rows: integer;
    Cols: integer;

  public
    constructor Create(StrList: TStringList; Separator: string);

    function GetRows: integer;
    function GetCols: integer;

    function ToMatrix: TStringMatrix;
  end;

implementation

//Cria o objeto e define os atributos
constructor TDataFlex.Create(StrList: TStringList; Separator: string);
begin
  self.StrList := StrList;
  self.Separator := Separator;
  self.Rows := StrList.Count;
  self.Cols := Length(TUtils.Cut(StrList[0], self.Separator));
end;

//Retorna a quantidade de linhas
function TDataFlex.GetRows: integer;
begin
  Result := self.Rows;
end;

//Retorna a quantidade de colunas
function TDataFlex.GetCols: integer;
begin
  Result := self.Cols;
end;

//Retorna uma matrix com os dados
function TDataFlex.ToMatrix: TStringMatrix;
var
  Cont: integer;
begin
  SetLength(Result, self.Rows, self.Cols);
  for Cont := 0 to Rows - 1 do
  begin
    Result[Cont] := TUtils.Cut(StrList[Cont], self.Separator);
  end;
end;

end.
