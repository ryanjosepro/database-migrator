unit ViewDatas;

interface

uses
  System.SysUtils, System.Classes, System.Types, Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.Buttons, Vcl.ExtCtrls,
  ViewFields, Arrays, Configs, DataFlex;

type
  TWindowDatas = class(TForm)
    LblFileName: TLabel;
    GridDatas: TStringGrid;
    LblTotRows: TLabel;
    LblTotCols: TLabel;
    BtnFields: TSpeedButton;
    Images: TImageList;
    Actions: TActionList;
    ActConfigFields: TAction;
    BtnSelect: TSpeedButton;
    ActSelect: TAction;
    PanelSearch: TPanel;
    TxtRowsLimit: TEdit;
    LblRowsLimit: TLabel;
    ActOpenFile: TAction;
    BtnOpenFile: TSpeedButton;
    OpenFile: TFileOpenDialog;
    BtnAlter: TSpeedButton;
    ActAlter: TAction;
    ActAddCell: TAction;
    ActAddRow: TAction;
    ActAddCol: TAction;
    ActDelCell: TAction;
    ActDelRow: TAction;
    ActDelCol: TAction;
    BtnActCell: TSpeedButton;
    BtnDelCell: TSpeedButton;
    BtnAddRow: TSpeedButton;
    BtnDelRow: TSpeedButton;
    BtnAddCol: TSpeedButton;
    BtnDelCol: TSpeedButton;
    BtnCancel: TSpeedButton;
    ActCancel: TAction;
    BtnSave: TSpeedButton;
    ActSave: TAction;
    ActSaveAs: TAction;
    BtnSaveAs: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActOpenFileExecute(Sender: TObject);
    procedure ActConfigFieldsExecute(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure TxtRowsLimitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    procedure FillGrid;
    procedure CleanGrid;
    procedure GridToData;
  end;

var
  WindowDatas: TWindowDatas;

implementation

{$R *.dfm}

procedure TWindowDatas.FormActivate(Sender: TObject);
begin
  if TConfigs.GetConfig('TEMP', 'FilePath').Trim <> '' then
  begin
    LblFileName.Caption := 'Arquivo Dataflex: ' + TConfigs.GetConfig('TEMP', 'FilePath');
    ActOpenFile.ImageIndex := 2;
    BtnOpenFile.Action := ActOpenFile;
  end;
end;

procedure TWindowDatas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WindowFields.Close;
end;

procedure TWindowDatas.ActOpenFileExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin
    TConfigs.SetConfig('TEMP', 'FilePath', OpenFile.FileName);
    ActOpenFile.ImageIndex := 2;
    BtnOpenFile.Action := ActOpenFile;
    LblFileName.Caption := 'Arquivo Dataflex: ' + TConfigs.GetConfig('TEMP', 'FilePath');
    CleanGrid;
  end;
end;

procedure TWindowDatas.ActConfigFieldsExecute(Sender: TObject);
begin
  WindowFields.Show;
end;

procedure TWindowDatas.ActSelectExecute(Sender: TObject);
begin
  if TConfigs.GetConfig('TEMP', 'FilePath') = '' then
  begin
    ShowMessage('Selecione um arquivo!');
  end
  else
  begin
    FillGrid;
  end;
end;

procedure TWindowDatas.TxtRowsLimitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key.ToString = '13' then
  begin
    ActSelectExecute(BtnSelect);
  end;
end;

procedure TWindowDatas.CleanGrid;
begin
  GridDatas.RowCount := 2;
  GridDatas.ColCount := 2;
  GridDatas.Rows[0].Clear;
  GridDatas.Cols[0].Clear;
  GridDatas.Cols[1].Clear;
end;

//TO COMMENT
procedure TWindowDatas.FillGrid;
var
  Rows: TStringList;
  DataFlex: TDataFlex;
  Datas: TStringMatrix;
  ContRow, ContCol, TotRows: integer;
begin
  if Trim(TxtRowsLimit.Text) = '' then
  begin
    TotRows := 0;
  end
  else
  begin
    TotRows := StrToInt(TxtRowsLimit.Text);
  end;

  Rows := TStringList.Create;
  Rows.LoadFromFile(TConfigs.GetConfig('TEMP', 'FilePath'));
  DataFlex := TDataFlex.Create(Rows);
  SetLength(Datas, DataFlex.GetRows, DataFlex.GetCols);
  Datas := DataFlex.ToMatrix;

  if (TotRows > DataFlex.GetRows) or (TotRows = 0) then
  begin
    TotRows := DataFlex.GetRows;
    TxtRowsLimit.Text := DataFlex.GetRows.ToString;
  end;

  GridDatas.RowCount := TotRows + 1;
  GridDatas.ColCount := DataFlex.GetCols + 1;
  LblTotRows.Caption := 'Dados: ' + DataFlex.GetRows.ToString;
  LblTotCols.Caption := 'Campos: ' + DataFlex.GetCols.ToString;

  for ContRow := 1 to TotRows do
  begin
    GridDatas.Cells[0, ContRow] := 'Dado ' + ContRow.ToString;
  end;

  for ContCol := 1 to DataFlex.GetCols do
  begin
    GridDatas.Cells[ContCol, 0] := 'Campo ' + ContCol.ToString;
  end;

  for ContRow := 1 to TotRows do
  begin
    for ContCol := 1 to DataFlex.GetCols do
    begin
      GridDatas.Cells[ContCol, ContRow] := Datas[ContRow - 1, ContCol - 1];
    end;
  end;
end;

procedure TWindowDatas.GridToData;
begin

end;

end.
