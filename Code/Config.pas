unit Config;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, Vcl.Forms, IniFiles,
  MyUtils;

type

  TConfig = class
  strict private
    class function Source: string;
    class procedure CreateFile(Path: string);
  public
    class function GetConfig(const Section, Name: string; Default: string = ''): string;
    class procedure SetConfig(const Section, Name: string; Value: string = '');

    class procedure GetGeneral(var LogActions, LogDatas, Commit, LimitStarts, LimitEnds, TableAction, ErrorHdlg: integer);
    class procedure SetGeneral(LogActions, LogDatas, Commit, LimitStarts, LimitEnds, TableAction, ErrorHdlg: integer);

    class procedure GetDB(var UserName, Password, Database: string);
    class procedure SetDB(UserName, Password, Database: string);
  end;

implementation

{ TConfigs }

//Caminho das configurações
class function TConfig.Source: string;
var
  Path: string;
begin
  Path := ExtractFilePath(Application.ExeName) + 'Config.ini';

  if FileExists(Path) then
  begin
    Result := Path;
  end
  else
  begin
    CreateFile(Path);
  end;
end;

//Cria o arquivo Config.ini
class procedure TConfig.CreateFile(Path: string);
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Path);
  try
    Arq.WriteString('SYSTEM', 'WindowState', '0');
    Arq.WriteString('GENERAL', 'LogActions', '1');
    Arq.WriteString('GENERAL', 'LogDatas', '1');
    Arq.WriteString('GENERAL', 'Commit', '-1');
    Arq.WriteString('GENERAL', 'LimitStarts', '-1');
    Arq.WriteString('GENREAL', 'LimitEnds', '-1');
    Arq.WriteString('GENERAL', 'TableAction', '0');
    Arq.WriteString('GENERAL', 'ErrorHdlg', '0');
    Arq.WriteString('DB', 'UserName', 'SYSDBA');
    Arq.WriteString('DB', 'Password', 'masterkey');
    Arq.WriteString('DB', 'Database', '');
    Arq.WriteString('DB', 'Table', '');
    Arq.WriteString('TEMP', 'FilePath', '');
  finally
    FreeAndNil(Arq);
  end;
end;

//Busca uma configuração específica
class function TConfig.GetConfig(const Section, Name: string; Default: string = ''): string;
var
  Arq: TIniFile;
begin
  Arq := TIniFile.Create(Source);
  try
    Result := Arq.ReadString(Section, Name, Default);
  finally
    FreeAndNil(Arq);
  end;
end;

//Define uma configuração específica
class procedure TConfig.SetConfig(const Section, Name: string; Value: string = '');
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

//Configurações da seção GENERAL
class procedure TConfig.GetGeneral(var LogActions, LogDatas, Commit, LimitStarts, LimitEnds, TableAction, ErrorHdlg: integer);
begin
  LogActions := GetConfig('GENERAL', 'LogActions', '0').ToInteger;
  LogDatas := GetConfig('GENERAL', 'LogDatas', '0').ToInteger;
  Commit := GetConfig('GENERAL', 'Commit', '-1').ToInteger;
  LimitStarts := GetConfig('GENERAL', 'LimitStarts', '-1').ToInteger;
  LimitEnds := GetConfig('GENERAL', 'LimitEnds', '-1').ToInteger;
  TableAction := GetConfig('GENERAL', 'TruncFB', '0').ToInteger;
  ErrorHdlg := GetConfig('GENERAL', 'ErrorHdlg', '2').ToInteger;
end;

class procedure TConfig.SetGeneral(LogActions, LogDatas, Commit, LimitStarts, LimitEnds, TableAction, ErrorHdlg: integer);
begin
  SetConfig('GENERAL', 'LogActions', LogActions.ToString);
  SetConfig('GENERAL', 'LogDatas', LogDatas.ToString);
  SetConfig('GENERAL', 'Commit', Commit.ToString);
  SetConfig('GENERAL', 'LimitStarts', LimitStarts.ToString);
  SetConfig('GENERAL', 'LimitEnds', LimitEnds.ToString);
  SetConfig('GENERAL', 'TruncFB', TableAction.ToString);
  SetConfig('GENERAL', 'ErrorHdlg', ErrorHdlg.ToString);
end;

//Configurãções da seção DB
class procedure TConfig.GetDB(var UserName, Password, Database: string);
begin
  UserName := GetConfig('DB', 'UserName');
  Password := GetConfig('DB', 'Password');
  Database := GetConfig('DB', 'Database');
end;

class procedure TConfig.SetDB(UserName, Password, Database: string);
begin
  SetConfig('DB', 'UserName', UserName);
  SetConfig('DB', 'Password', Password);
  SetConfig('DB', 'Database', Database);
end;

end.
