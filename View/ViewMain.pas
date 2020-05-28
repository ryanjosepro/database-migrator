unit ViewMain;
interface

uses
  System.SysUtils, System.Classes, System.Types, Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.ExtDlgs, Vcl.ComCtrls,
  ViewDB, ViewDatas, ViewConfigs, Arrays, MyDialogs, Config, MyUtils, DataFlex, DAO;

type
  TWindowMain = class(TForm)
    TxtLog: TMemo;
    BtnMigrate: TSpeedButton;
    BtnDatabase: TSpeedButton;
    OpenFile: TFileOpenDialog;
    BtnDatas: TSpeedButton;
    BtnStop: TSpeedButton;
    BtnConfigs: TSpeedButton;
    ProgressBar: TProgressBar;
    Images: TImageList;
    Actions: TActionList;
    ActOpenFile: TAction;
    ActConfigDB: TAction;
    ActConfigFields: TAction;
    ActDatas: TAction;
    ActConfigs: TAction;
    ActMigrate: TAction;
    ActStop: TAction;
    BtnPause: TSpeedButton;
    ActPause: TAction;
    ActContinue: TAction;
    ActEsc: TAction;
    procedure ActOpenFileExecute(Sender: TObject);
    procedure ActConfigDBExecute(Sender: TObject);
    procedure ActConfigFieldsExecute(Sender: TObject);
    procedure ActDatasExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActConfigsExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActMigrateExecute(Sender: TObject);
    procedure ActStopExecute(Sender: TObject);
    procedure ActPauseExecute(Sender: TObject);
    procedure ActContinueExecute(Sender: TObject);
    procedure ActOpenFileHint(var HintStr: string; var CanShow: Boolean);
    procedure ActEscExecute(Sender: TObject);
  private
    procedure Log(Msg: string);
    procedure NormalMode;
    procedure MigrationMode;
    procedure PausedMode;
  end;

  TMigration = class(TThread)
  protected
    procedure Execute; override;
    procedure Log(Msg: string);
  public
    constructor Create;
  end;


var
  WindowMain: TWindowMain;
  MigrationEnabled: boolean = false;
  MigrationPaused: boolean = false;

implementation

{$R *.dfm}

procedure TWindowMain.FormActivate(Sender: TObject);
begin
  TConfig.SetConfig('TEMP', 'FilePath', '');
  WindowState := TUtils.Iif(TConfig.GetConfig('SYSTEM', 'WindowState') = '2', wsMaximized, wsNormal);
end;

procedure TWindowMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Answer: integer;
begin
  if MigrationEnabled then
  begin
    Answer := TDialogs.YesNo('Deseja cancelar a migração?');

    if Answer = mrYes then
    begin
      MigrationEnabled := false;
      TConfig.SetConfig('TEMP', 'FilePath', '');
      TConfig.SetConfig('SYSTEM', 'WindowState', TUtils.Iif(WindowMain.WindowState = wsMaximized, '2', '0'));
    end
    else if Answer = mrNo then
    begin
      Action := caNone;
    end;
  end
  else
  begin
    TConfig.SetConfig('TEMP', 'FilePath', '');
    TConfig.SetConfig('SYSTEM', 'WindowState', TUtils.Iif(WindowMain.WindowState = wsMaximized, '2', '0'));
  end;
end;

procedure TWindowMain.ActEscExecute(Sender: TObject);
begin
  if MigrationEnabled then
  begin
    ActStop.Execute;
  end
  else
  begin
    Close;
  end;
end;

procedure TWindowMain.ActOpenFileExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin
    TConfig.SetConfig('TEMP', 'FilePath', OpenFile.FileName);
    ActOpenFile.ImageIndex := 5;
    BtnOpenFile.Action := ActOpenFile;
  end;
end;

procedure TWindowMain.ActOpenFileHint(var HintStr: string; var CanShow: Boolean);
begin
  HintStr := TUtils.IfEmpty(TConfig.GetConfig('TEMP', 'FilePath'), 'Arquivo Dataflex');
end;

procedure TWindowMain.ActConfigDBExecute(Sender: TObject);
begin
  WindowDB.ShowModal;
end;

procedure TWindowMain.ActConfigFieldsExecute(Sender: TObject);
begin
  WindowFields.ShowModal;
end;

procedure TWindowMain.ActDatasExecute(Sender: TObject);
begin
  WindowDatas.ShowModal;
  if TConfig.GetConfig('TEMP', 'FilePath').Trim <> '' then
  begin
    ActOpenFile.ImageIndex := 5;
    BtnOpenFile.Action := ActOpenFile;
  end;
end;

procedure TWindowMain.ActConfigsExecute(Sender: TObject);
begin
  WindowConfigs.ShowModal;
end;

procedure TWindowMain.ActMigrateExecute(Sender: TObject);
var
  Ok: boolean;
begin
  //Verificações antes da liberação da Thread
  Ok := true;
  if TDAO.Count <= 0 then
  begin
    Ok := false;
    ShowMessage('Selecione uma tabela válida!');
    WindowFields.ShowModal;
  end
  else if WindowFields.IsClean then
  begin
    Ok := false;
    ShowMessage('Configure os campos!');
    WindowFields.ShowModal;
  end
  else if TConfig.GetConfig('TEMP', 'FilePath') = '' then
  begin
    Ok := false;
    ShowMessage('Selecione um arquivo!');
    if OpenFile.Execute then
    begin
      Ok := true;
      TConfig.SetConfig('TEMP', 'FilePath', OpenFile.FileName);
      ActOpenFile.ImageIndex := 5;
      BtnOpenFile.Action := ActOpenFile;
    end;
  end;

  //Se tudo Ok a Thread é liberada
  if Ok then
  begin
    TxtLog.Clear;
    MigrationMode;
    TMigration.Create;
  end;
end;

procedure TWindowMain.ActPauseExecute(Sender: TObject);
begin
  PausedMode;
end;

procedure TWindowMain.ActContinueExecute(Sender: TObject);
begin
  MigrationMode;
end;

procedure TWindowMain.ActStopExecute(Sender: TObject);
begin
  PausedMode;
  if TDialogs.YesNo('Deseja cancelar a migração?') = mrYes then
  begin
    NormalMode;
  end
  else
  begin
    MigrationMode;
  end;
end;

procedure TWindowMain.Log(Msg: string);
begin
  TxtLog.Lines.Add(Msg);
end;

procedure TWindowMain.NormalMode;
begin
  ActMigrate.Enabled := true;
  ActPause.Enabled := false;
  ActContinue.Enabled := false;
  ActStop.Enabled := false;
  ActConfigs.Enabled := true;
  ActOpenFile.Enabled := true;
  ActConfigDB.Enabled := true;
  ActConfigFields.Enabled := true;
  ActDatas.Enabled := true;
  MigrationEnabled := false;
  MigrationPaused := false;
end;

procedure TWindowMain.MigrationMode;
begin
  ActMigrate.Enabled := false;
  ActPause.Enabled := true;
  ActContinue.Enabled := false;
  ActStop.Enabled := true;
  ActConfigs.Enabled := false;
  ActOpenFile.Enabled := false;
  ActConfigDB.Enabled := false;
  ActConfigFields.Enabled := false;
  ActDatas.Enabled := false;
  MigrationEnabled := true;
  MigrationPaused := false;
  BtnPause.Action := ActPause;
end;

procedure TWindowMain.PausedMode;
begin
  ActMigrate.Enabled := false;
  ActPause.Enabled := false;
  ActContinue.Enabled := true;
  ActStop.Enabled := true;
  ActConfigs.Enabled := false;
  ActOpenFile.Enabled := false;
  ActConfigDB.Enabled := false;
  ActConfigFields.Enabled := false;
  ActDatas.Enabled := false;
  MigrationEnabled := true;
  MigrationPaused := true;
  BtnPause.Action := ActContinue;
end;

{ TMyThread }

constructor TMigration.Create;
begin
  inherited Create(false);
end;

procedure TMigration.Execute;
var
  Rows: TStringList;
  DataFlex: TDataFlex;
  Datas: TStringMatrix;
  Order: TIntegerArray;
  Defaults, FieldsValues: TStringArray;
  ContRow, CommitStep: integer;
  LogActions, LogDatas, Commit, LimitStarts, LimitEnds, TableAction, ErrorHdlg, ContOrders: integer;
  Error: string;
  OutStr: string;
begin
  //Chama do método sobreposto na classe mãe
  inherited;
  try
    //Passa o arquivo Dataflex para uma StringList
    Rows := TStringList.Create;
    Rows.LoadFromFile(TConfig.GetConfig('TEMP', 'FilePath'));

    //Passa a StringList para a classe de tratamento
    DataFlex := TDataFlex.Create(Rows, ';');
    SetLength(Datas, DataFlex.GetRowCount, DataFlex.GetColCount);

    //A classe de tratamento retorna uma matriz
    Datas := DataFlex.ToMatrix;

    //Busca as configurações
    TConfig.GetGeneral(LogActions, LogDatas, Commit, LimitStarts, LimitEnds, TableAction, ErrorHdlg);

    Commit := TUtils.IifLess(Commit = -1, DataFlex.GetRowCount, Commit);

    LimitEnds := TUtils.Iif(LimitEnds = -1, DataFlex.GetRowCount, LimitEnds);

    LimitStarts := TUtils.Iif(LimitStarts = -1, 1, LimitStarts);

    CommitStep := Commit;

    //Aplica a configuração de tabela firebird
    if TableAction = 1 then
    begin
      TDAO.Truncate;
    end;

    //Ajusta a barra de carregamento
    WindowMain.ProgressBar.Position := 0;
    WindowMain.ProgressBar.Max := LimitEnds;

    Error := '';

    ContRow := LimitStarts - 1;

    //Passa por cada linha Dataflex
    while ContRow <= LimitEnds - 1 do
    begin
      try
        //Verifica se a migração foi pausada
        while MigrationPaused do
        begin
          Sleep(500);
        end;

        //Verifica se a migração foi parada
        if MigrationEnabled then
        begin
          Order := WindowFields.GetOrder;

          Defaults := WindowFields.GetDefaults;

          //Manda os dados para classe DAO para inserir
          TDAO.Insert(Datas[ContRow], Order, Defaults);

          //Manda os dados para o log
          if LogDatas = 1 then
          begin

            SetLength(FieldsValues, Length(order));

            for ContOrders := 0 to Length(Order) - 1 do
            begin
              FieldsValues[ContOrders] := Datas[ContRow][Order[ContOrders]];
            end;

            Log('DADO ' + (ContRow + 1).ToString + ' INSERIDO -> ' + TUtils.ArrayToStr(Datas[ContRow], ' - ', ';'));
          end;

          //Atualiza a barra de carregamento
          WindowMain.ProgressBar.StepIt;

          //Verifica o passo de commit
          if (ContRow + 1 = CommitStep) or (ContRow + 1 >= LimitEnds) then
          begin
            TDAO.Commit;
            if LogActions = 1 then
            begin
              Log('DADOS COMITADOS!');
            end;
            CommitStep := CommitStep + Commit;
          end;
        end
        else
        begin
          //Quando a migração é interrompida
          TDAO.Rollback;
          break;
        end;
      Except on E: Exception do
        Error := E.ToString;
      end;

      //Verifica se houve algum erro
      if Error <> '' then
      begin
        //Parar migração
        if ErrorHdlg = 0 then
        begin
          if LogActions = 1 then
          begin
            Log('ERRO NO DADO ' + (ContRow + 1).ToString + ' -> ' + Error);
          end;
          WindowMain.ActStop.Execute;
        end
        else
        //Ignorar dado
        if ErrorHdlg = 1 then
        begin
          if LogActions = 1 then
          begin
            Log('ERRO NO DADO ' + (ContRow + 1).ToString + ' -> ' + Error);
            Log('DADO IGNORADO!');
          end;
        end
        //Tratar Dado
        else
        ShowMessage('ERRO NO DADO ' + (ContRow + 1).ToString + ' -> ' + Error);
        if ErrorHdlg = 2 then
        begin
          Synchronize(
          procedure
          begin
            WindowDatas.ShowModal(ContRow + 1);
          end
          );
          if TDialogs.YesNo('Deseja reinserir o dado ' + (ContRow + 1).ToString + '?', mbYes) = mrYes then
          begin
            Rows := TStringList.Create;
            Rows.LoadFromFile(TConfig.GetConfig('TEMP', 'FilePath'));
            DataFlex := TDataFlex.Create(Rows, ';');
            Datas := DataFlex.ToMatrix;
            ContRow := ContRow - 1;
          end
          else
          begin
            Log('ERRO NO DADO ' + (ContRow + 1).ToString + ' -> ' + Error);
            Log('DADO IGNORADO!');
          end;
        end;

        Error := '';
      end;
      Inc(ContRow, 1);
    end;
    if LogActions = 1 then
    begin
      Log('MIGRAÇÃO FINALIZADA!');
    end;
  finally
    WindowMain.NormalMode;
    FreeAndNil(Rows);
    FreeAndNil(DataFlex);
  end;
end;

procedure TMigration.Log(Msg: string);
begin
  WindowMain.Log(Msg);
end;

end.
