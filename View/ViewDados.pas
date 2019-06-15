unit ViewDados;

interface

uses
  System.SysUtils, System.Classes, System.Types, Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.Buttons, Vcl.ExtCtrls,
  ViewFields, Arrays, Configs, DataFlex;

type
  TWindowDados = class(TForm)
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
    procedure ActConfigFieldsExecute(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure ActOpenFileExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TxtRowsLimitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure FillGrid;
  end;

var
  WindowDados: TWindowDados;

implementation

{$R *.dfm}

procedure TWindowDados.ActConfigFieldsExecute(Sender: TObject);
begin
  WindowFields.ShowModal;
end;

procedure TWindowDados.ActOpenFileExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin
    LblFileName.Caption := OpenFile.FileName;
    TConfigs.SetConfig('TEMP', 'FilePath', OpenFile.FileName);
  end;
end;

procedure TWindowDados.ActSelectExecute(Sender: TObject);
begin
  FillGrid;
end;

//TO COMMENT
procedure TWindowDados.FillGrid;
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
  LblTotRows.Caption := 'Linhas: ' + DataFlex.GetRows.ToString;
  LblTotCols.Caption := 'Colunas: ' + DataFlex.GetCols.ToString;

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

procedure TWindowDados.FormActivate(Sender: TObject);
begin
  LblFileName.Caption := 'Arquivo Dataflex: ' + TConfigs.GetConfig('TEMP', 'FilePath');
end;

procedure TWindowDados.TxtRowsLimitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key.ToString = '13' then
  begin
    ActSelectExecute(BtnSelect);
  end;
end;

end.
