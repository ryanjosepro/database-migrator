program ProjectMigration;

uses
  Vcl.Forms,
  ViewMain in 'View\ViewMain.pas' {WindowMain},
  MyUtils in 'Code\MyUtils.pas',
  ConnectionFactory in 'Connection\ConnectionFactory.pas' {ConnFactory: TDataModule},
  ViewDB in 'View\ViewDB.pas' {WindowDB},
  ViewFields in 'View\ViewFields.pas' {WindowFields},
  DAO in 'DAO\DAO.pas',
  ViewDados in 'View\ViewDados.pas' {WindowDados};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Migration';
  Application.CreateForm(TWindowMain, WindowMain);
  Application.CreateForm(TConnFactory, ConnFactory);
  Application.CreateForm(TWindowDB, WindowDB);
  Application.CreateForm(TWindowFields, WindowFields);
  Application.CreateForm(TWindowDados, WindowDados);
  Application.Run;
end.
