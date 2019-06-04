unit ViewDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.Buttons, DAO, MyUtils;

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
    procedure FormActivate(Sender: TObject);
    procedure ActConfigFieldsExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WindowDados: TWindowDados;

implementation

{$R *.dfm}

uses ViewFields;

procedure TWindowDados.ActConfigFieldsExecute(Sender: TObject);
begin
  WindowFields.ShowModal;
end;

procedure TWindowDados.FormActivate(Sender: TObject);
var
  Rows: TStringList;
  DataFlex: TDataFlex;
  Datas: TStringMatrix;
  ContRow, ContCol: integer;
begin
  LblFileName.Caption := 'Arquivo Dataflex: ' + TConfigs.GetFilePath;

  Rows := TStringList.Create;
  Rows.LoadFromFile(TConfigs.GetFilePath);
  DataFlex := TDataFlex.Create(Rows);
  SetLength(Datas, DataFlex.GetRows, DataFlex.GetCols);
  Datas := DataFlex.ToMatrix;

  GridDatas.RowCount := DataFlex.GetRows + 1;
  GridDatas.ColCount := DataFlex.GetCols + 1;
  LblTotRows.Caption := 'Linhas: ' + DataFlex.GetRows.ToString;
  LblTotCols.Caption := 'Colunas: ' + DataFlex.GetCols.ToString;

  for ContRow := 1 to DataFlex.GetRows do
  begin
    GridDatas.Cells[0, ContRow] := 'Dado ' + ContRow.ToString;
  end;

  for ContCol := 1 to DataFlex.GetCols do
  begin
    GridDatas.Cells[ContCol, 0] := 'Campo ' + ContCol.ToString;
  end;

  for ContRow := 1 to DataFlex.GetRows do
  begin
    for ContCol := 1 to DataFlex.GetCols do
    begin
      GridDatas.Cells[ContCol, ContRow] := Datas[ContRow - 1, ContCol - 1];
    end;
  end;
end;

end.
