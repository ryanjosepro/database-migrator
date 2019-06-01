unit ViewFields;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons, DAO, Data.DB, Vcl.DBGrids,
  MyUtils, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList;

type
  TWindowFields = class(TForm)
    Title1: TLabel;
    GridFields: TStringGrid;
    LblCamposFB: TLabel;
    LblNCampos: TLabel;
    Title2: TLabel;
    LblTotFields: TLabel;
    Actions: TActionList;
    Images: TImageList;
    BtnExport: TSpeedButton;
    ActExport: TAction;
    BtnImport: TSpeedButton;
    ActImport: TAction;
    SaveFile: TFileSaveDialog;
    OpenFile: TFileOpenDialog;
    ActOrdFields: TAction;
    SpeedButton1: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure ActExportExecute(Sender: TObject);
    procedure ActImportExecute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  end;

var
  WindowFields: TWindowFields;

implementation

{$R *.dfm}

procedure TWindowFields.ActExportExecute(Sender: TObject);
var
  Arq: TextFile;
  Cont: integer;
begin
  AssignFile(Arq, 'Temp\fields.txt');
  Rewrite(Arq);
  for Cont := 0 to GridFields.RowCount - 1 do
  begin
    Writeln(Arq, GridFields.Cells[1, Cont]);
  end;
  CloseFile(Arq);
end;

procedure TWindowFields.ActImportExecute(Sender: TObject);
begin
  //
end;

procedure TWindowFields.FormActivate(Sender: TObject);
var
  Cont: integer;
  Campos: TStringArray;
begin
  try
    GridFields.ColWidths[1] := 88;
    if TDAO.Count <> 0 then
    begin
      LblCamposFB.Caption := 'Campos Firebird - ' + TDAO.Table;
      SetLength(Campos, TDAO.Count);
      Campos := TDAO.GetFieldsNames;
      GridFields.RowCount := High(Campos);
      for Cont := 0 to High(Campos) do
      begin
        GridFields.Cells[0, Cont] := (Campos[Cont]);
      end;
    end
    else
    begin
      ShowMessage('Selecione uma tabela!');
    end;
  finally
    LblTotFields.Caption := 'Total Campos Firebird: ' + TDAO.Count.ToString;
  end;
end;

procedure TWindowFields.SpeedButton1Click(Sender: TObject);
var
  Cont: integer;
begin
  for Cont := 0 to GridFields.RowCount - 1 do
  begin
    GridFields.Cells[1, Cont] := IntToStr(Cont + 1);
  end;
end;

end.
