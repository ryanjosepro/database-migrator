program ProjectMigrator;

uses
  Vcl.Forms,
  ViewMain in 'View\ViewMain.pas' {WindowMain},
  Connection in 'Modal\Connection.pas' {DataModuleConn: TDataModule},
  ViewDB in 'View\ViewDB.pas' {WindowDB},
  ViewConfigs in 'View\ViewConfigs.pas' {WindowConfigs},
  Config in 'Code\Config.pas',
  ViewDatas in 'View\ViewDatas.pas' {WindowDatas},
  MyDialogs in 'Code\MyDialogs.pas',
  MyUtils in 'Code\MyUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Migration';
  Application.CreateForm(TWindowMain, WindowMain);
  Application.CreateForm(TDataModuleConn, DataModuleConn);
  Application.CreateForm(TWindowDB, WindowDB);
  Application.CreateForm(TWindowConfigs, WindowConfigs);
  Application.CreateForm(TWindowDatas, WindowDatas);
  Application.Run;
end.
