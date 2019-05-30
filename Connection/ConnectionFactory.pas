unit ConnectionFactory;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TConnFactory = class(TDataModule)
    Conn: TFDConnection;
    Trans: TFDTransaction;
    QuerySQL: TFDQuery;
    QueryTable: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  end;

var
  ConnFactory: TConnFactory;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TConnFactory.DataModuleCreate(Sender: TObject);
begin
  if FileExists(ExtractFilePath(Application.ExeName) + '..\..\DB\NSC.FDB') then
  begin
    Conn.Params.Database := ExtractFilePath(Application.ExeName) + '..\..\DB\NSC.FDB';
  end
  else
  begin
    Conn.Params.Database := ExtractFilePath(Application.ExeName) + 'DB\NSC.FDB';
  end;
end;

end.
