unit ViewMain;

interface

uses
  System.SysUtils, System.Classes, System.Types, Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.ExtDlgs,
  ViewDB, ViewFields, ViewDados, ViewConfigs, Arrays, Configs, MyUtils, DataFlex, DAO;

type
  TWindowMain = class(TForm)
    LblTitle1: TLabel;
    LblTitle2: TLabel;
    LblTitle3: TLabel;
    TxtLog: TMemo;
    BtnStart: TSpeedButton;
    BtnOpenFile: TSpeedButton;
    Images: TImageList;
    Actions: TActionList;
    ActOpenFile: TAction;
    BtnDatabase: TSpeedButton;
    ActConfigDB: TAction;
    BtnFields: TSpeedButton;
    ActConfigFields: TAction;
    OpenFile: TFileOpenDialog;
    BtnDatas: TSpeedButton;
    ActDados: TAction;
    BtnStop: TSpeedButton;
    BtnConfigs: TSpeedButton;
    ActConfigs: TAction;
    procedure ActOpenFileExecute(Sender: TObject);
    procedure ActConfigDBExecute(Sender: TObject);
    procedure ActConfigFieldsExecute(Sender: TObject);
    procedure ActDadosExecute(Sender: TObject);
    procedure Log(Msg: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnStopClick(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure ActConfigsExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  end;

  TMyThread = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;


var
  WindowMain: TWindowMain;
  MigrationEnabled: boolean = false;

implementation

{
PROGRAMATION RULES

-To keep code always clean and organized;
-To create variables, objects and components always in english;
-To comment everything that you can;
-Forms Order -> ViewMain - ViewConfigs - ViewDB - ViewFields - ViewDados;
-Units Order -> Arrays - MyUtils - Configs - DataFlex - Fields - DAO - ConnectionFactory;
-Default Uses -> System.SysUtils, System.Classes, System.Types;

PROGRAMATION RULES
}

{$R *.dfm}

procedure TWindowMain.ActOpenFileExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin
    ActOpenFile.Hint := OpenFile.FileName;
    TConfigs.SetConfig('TEMP', 'FilePath', OpenFile.FileName);
  end;
end;

procedure TWindowMain.ActConfigDBExecute(Sender: TObject);
begin
  WindowDB.ShowModal;
end;

procedure TWindowMain.ActConfigFieldsExecute(Sender: TObject);
begin
  WindowFields.ShowModal;
end;

procedure TWindowMain.ActConfigsExecute(Sender: TObject);
begin
  WindowConfigs.ShowModal;
end;

procedure TWindowMain.ActDadosExecute(Sender: TObject);
begin
  WindowDados.ShowModal;
end;

procedure TWindowMain.BtnStartClick(Sender: TObject);
begin
  if TConfigs.GetConfig('TEMP', 'FilePath') = '' then
  begin
    if OpenFile.Execute then
    begin
      TMyThread.Create;
    end;
  end
  else
  begin
    TMyThread.Create;
  end;
end;

procedure TWindowMain.BtnStopClick(Sender: TObject);
begin
  MigrationEnabled := false;
end;

procedure TWindowMain.Log(Msg: string);
begin
  TxtLog.Lines.Add(Msg);
end;

procedure TWindowMain.FormActivate(Sender: TObject);
begin
  TConfigs.SetConfig('TEMP', 'FilePath', '');
end;

procedure TWindowMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TConfigs.SetConfig('TEMP', 'FilePath', '');
end;

{ TMyThread }

constructor TMyThread.Create;
begin
  inherited Create(false);
end;

//TO COMMENT
procedure TMyThread.Execute;
var
  Rows: TStringList;
  DataFlex: TDataFlex;
  Datas: TStringMatrix;
  ContRow, ContCol, TotRows: integer;
  OutStr: string;
begin
  WindowMain.BtnStart.Enabled := false;
  inherited;
  MigrationEnabled := true;
  Rows := TStringList.Create;
  Rows.LoadFromFile(TConfigs.GetConfig('TEMP', 'FilePath'));
  DataFlex := TDataFlex.Create(Rows);
  SetLength(Datas, DataFlex.GetRows, DataFlex.GetCols);
  Datas := DataFlex.ToMatrix;
  try
    try
      WindowMain.TxtLog.Clear;
      if WindowConfigs.RadioBtnAllRows.Checked then
      begin
        TotRows := DataFlex.GetRows;
      end
      else if WindowConfigs.RadioBtnLimitRows.Checked then
      begin
        if StrToInt(WindowConfigs.TxtLimitRows.Text) > DataFlex.GetRows then
        begin
          TotRows := DataFlex.GetRows;
        end
        else
        begin
          TotRows := StrToInt(WindowConfigs.TxtLimitRows.Text);
        end;
      end;

      for ContRow := 0 to TotRows - 1 do
      begin
        if MigrationEnabled then
        begin
          TDAO.Insert(Datas[ContRow], WindowFields.GetOrder, WindowFields.GetDefauts);
          OutStr := '';
          for ContCol := 0 to DataFlex.GetCols - 1 do
          begin
            OutStr := OutStr + Datas[ContRow][ContCol] + ' - ';
          end;
          WindowMain.Log('Inserted -> ' + OutStr);
        end
        else
        begin
          WindowMain.Log('STOPED!');
          break;
        end;
      end;
    except on E: Exception do
      ShowMessage(E.ToString);
    end;
  finally
    WindowMain.BtnStart.Enabled := true;
    FreeAndNil(Rows);
    FreeAndNil(DataFlex);
  end;
end;

end.
