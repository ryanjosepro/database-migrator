unit MyUtils;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.StrUtils, System.Types, Vcl.Forms, IniFiles;

type
  TIntegerArray = array of integer;
  TStringArray = array of string;
  TStringMatrix = array of TStringDynArray;

  //Manipular dataflex
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

  //Campos Firebird
  TFields = class
  public

  end;

  //Configurações gerais
  TConfigs = class
  strict private
    class function Source: string;

  public
    class function GetConfig(const Section, Name: string): string;
    class procedure SetConfig(const Section, Name, Value: string);

  end;

  //Utilitários e ferramentas
  TUtils = class
  public
    class function Iff(cond: boolean; v1, v2: variant): variant;

  end;

implementation

{ TDataFlex }

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

{ TConfigs }

class function TConfigs.Source: string;
begin
  Result := ExtractFilePath(Application.ExeName) + 'Config\Config.ini';
end;

class function TConfigs.GetConfig(const Section, Name: string): string;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Result := Arq.ReadString(Section, Name, '');
  finally
    FreeAndNil(Arq);
  end;
end;

class procedure TConfigs.SetConfig(const Section, Name, Value: string);
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Arq.WriteString(Section, Name, Value);
  finally
    FreeAndNil(Arq);
  end;
end;

{ TUtils }

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
