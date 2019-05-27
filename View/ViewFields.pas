unit ViewFields;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons, DAO,
  Data.DB, Vcl.DBGrids;

type
  TWindowFields = class(TForm)
    Title1: TLabel;
    GridFirebird: TStringGrid;
    LblCampos: TLabel;
    LblNCampos: TLabel;
    Title2: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WindowFields: TWindowFields;

implementation

{$R *.dfm}

procedure TWindowFields.FormActivate(Sender: TObject);
var
  Cont: integer;
  Campos: TStringArray;
begin
  GridFirebird.ColWidths[1] := 88;
  SetLength(Campos, TDAO.Count);
  Campos := TDAO.GetFieldsNames;
  GridFirebird.RowCount := High(Campos);
  for Cont := 0 to High(Campos) do
  begin
    GridFirebird.Cells[0, Cont] := (Campos[Cont]);
  end;
end;

end.
