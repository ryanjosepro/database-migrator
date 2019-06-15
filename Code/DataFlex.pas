unit DataFlex;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.StrUtils, Vcl.Forms,
  Arrays;

type

  TDataFlex = class
  strict private
    //Atributos
    StrList: TStringList;
    Rows: integer;
    Cols: integer;

public
  //Constutor
  constructor Create(StrList: TStringList);

  //De String -> Array, separa os campos
  function Cut(Str: string): TStringDynArray;

  //Gets
  function GetRows: integer;
  function GetCols: integer;

  //Transforma a stringlist em uma matriz
  function ToMatrix: TStringMatrix;

end;

implementation

constructor TDataFlex.Create(StrList: TStringList);
begin
  self.StrList := StrList;
  self.Rows := StrList.Count;
  self.Cols := Length(Cut(StrList[0]));
end;

function TDataFlex.Cut(Str: string): TStringDynArray;
var
  StrSize: integer;
begin
  StrSize := Length(SplitString(Str, ';'));
  SetLength(Result, StrSize);
  Result := SplitString(Str, ';');
end;

function TDataFlex.GetRows: integer;
begin
  Result := self.Rows;
end;

function TDataFlex.GetCols: integer;
begin
  Result := self.Cols;
end;

function TDataFlex.ToMatrix: TStringMatrix;
var
  Cont: integer;
begin
  SetLength(Result, GetRows, GetCols);
  for Cont := 0 to GetRows - 1 do
  begin
    Result[Cont] := Cut(self.StrList[Cont]);
  end;
end;

end.
