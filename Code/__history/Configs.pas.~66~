unit Configs;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, Vcl.Forms, IniFiles,
  MyUtils;

type

  TConfigs = class
  strict private
    class function Source: string;
  public
    class function GetConfig(const Section, Name: string): string;
    class procedure SetConfig(const Section, Name, Value: string);

    class procedure GetGeneral(var Commit, Limit, TruncFB: integer);
    class procedure SetGeneral(Commit, Limit, TruncFB: integer);

    class procedure GetDB(var UserName, Password, Database: string);
    class procedure SetDB(UserName, Password, Database: string);
  end;

implementation

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

{ TGeneral }

class procedure TConfigs.GetGeneral(var Commit, Limit, TruncFB: integer);
begin
  Commit := TUtils.IfEmpty(TConfigs.GetConfig('GENERAL', 'Commit'), '-1').ToInteger;
  Limit := TUtils.IfEmpty(TConfigs.GetConfig('GENERAL', 'Limit'), '-1').ToInteger;
  TruncFB := TUtils.IfEmpty(TConfigs.GetConfig('GENERAL', 'TruncFB'), '0').ToInteger;
end;

class procedure TConfigs.SetGeneral(Commit, Limit, TruncFB: integer);
begin
  TConfigs.SetConfig('GENERAL', 'Commit', Commit.ToString);
  TConfigs.SetConfig('GENERAL', 'Limit', Limit.ToString);
  TConfigs.SetConfig('GENERAL', 'TruncFB', TruncFB.ToString);
end;

{ TDB }

class procedure TConfigs.GetDB(var UserName, Password, Database: string);
begin
  UserName := TConfigs.GetConfig('DB', 'UserName');
  Password := TConfigs.GetConfig('DB', 'Password');
  Database := TConfigs.GetConfig('DB', 'Database');
end;

class procedure TConfigs.SetDB(UserName, Password, Database: string);
begin
  TConfigs.SetConfig('DB', 'UserName', UserName);
  TConfigs.SetConfig('DB', 'Password', Password);
  TConfigs.SetConfig('DB', 'Database', Database);
end;

end.
