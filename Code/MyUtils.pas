unit MyUtils;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.StrUtils, System.Types, Vcl.Forms, IniFiles;

type
  TIntegerArray = array of integer;
  TStringArray = array of string;
  TStringMatrix = array of TStringDynArray;

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

    function GetRows: integer;
    function GetCols: integer;

    //Transforma a stringlist em uma matriz
    function ToMatrix: TStringMatrix;

  end;

  TConfigs = class
  strict private
    class function Source: string;

  public
    //DB
    class function GetUserName: string;
    class function GetPassword: string;
    class function GetDatabase: string;
    class function GetTable: string;
    class procedure SetUserName(const Value: string);
    class procedure SetPassWord(const Value: string);
    class procedure SetDatabase(const Value: string);
    class procedure SetTable(const Value: string);

    //TEMP
    class function GetFilePath: string;
    class procedure SetFilePath(Value: string);

  end;

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

class function TConfigs.GetUserName: string;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Result := Arq.ReadString('DB', 'UserName', 'SYSDBA');
  finally
    FreeAndNil(Arq);
  end;
end;

class function TConfigs.GetPassword: string;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Result := Arq.ReadString('DB', 'Password', 'masterkey');
  finally
    FreeAndNil(Arq);
  end;
end;

class function TConfigs.GetDatabase: string;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Result := Arq.ReadString('DB', 'Database', ExtractFilePath(Application.ExeName) + 'DB\NSC.FDB');
  finally
    FreeAndNil(Arq);
  end;
end;

class function TConfigs.GetTable: string;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Result := Arq.ReadString('DB', 'Table', 'CLIENTES');
  finally
    FreeAndNil(Arq);
  end;
end;

class procedure TConfigs.SetUserName(const Value: string);
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Arq.WriteString('DB', 'UserName', Value);
  finally
    FreeAndNil(Arq);
  end;
end;

class procedure TConfigs.SetPassWord(const Value: string);
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Arq.WriteString('DB', 'Password', Value);
  finally
    FreeAndNil(Arq);
  end;
end;

class procedure TConfigs.SetDatabase(const Value: string);
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Arq.WriteString('DB', 'Database', Value);
  finally
    FreeAndNil(Arq);
  end;
end;

class procedure TConfigs.SetTable(const Value: string);
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Arq.WriteString('DB', 'Table', Value);
  finally
    FreeAndNil(Arq);
  end;
end;

class function TConfigs.GetFilePath: string;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Result := Arq.ReadString('TEMP', 'FilePath', '');
  finally
    FreeAndNil(Arq);
  end;
end;

class procedure TConfigs.SetFilePath(Value: string);
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Arq.WriteString('TEMP', 'FilePath', Value);
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
