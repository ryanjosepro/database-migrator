program ProjectMigrator;

uses
  Vcl.Forms,
  ViewMain in 'View\ViewMain.pas' {WindowMain},
  MyUtils in 'Code\MyUtils.pas',
  ConnectionFactory in 'Connection\ConnectionFactory.pas' {ConnFactory: TDataModule},
  ViewDB in 'View\ViewDB.pas' {WindowDB},
  ViewFields in 'View\ViewFields.pas' {WindowFields},
  DAO in 'DAO\DAO.pas',
  ViewConfigs in 'View\ViewConfigs.pas' {WindowConfigs},
  Configs in 'Code\Configs.pas',
  DataFlex in 'Code\DataFlex.pas',
  Arrays in 'Code\Arrays.pas',
  ViewDatas in 'View\ViewDatas.pas' {WindowDatas},
  MyDialogs in 'Code\MyDialogs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Migration';
  Application.CreateForm(TWindowMain, WindowMain);
  Application.CreateForm(TConnFactory, ConnFactory);
  Application.CreateForm(TWindowDB, WindowDB);
  Application.CreateForm(TWindowFields, WindowFields);
  Application.CreateForm(TWindowConfigs, WindowConfigs);
  Application.CreateForm(TWindowDatas, WindowDatas);
  Application.Run;
end.
