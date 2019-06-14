unit ConnectionFactory;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, MyUtils;

type
  TConnFactory = class(TDataModule)
    Conn: TFDConnection;
    Trans: TFDTransaction;
    QuerySQL: TFDQuery;
    QueryTable: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);

  public
    class procedure SetParams(UserName, Password, Database: string);

  end;

var
  ConnFactory: TConnFactory;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TConnFactory.DataModuleCreate(Sender: TObject);
begin
  Conn.Params.UserName := TConfigs.GetConfig('DB', 'UserName');
  Conn.Params.Password := TConfigs.GetConfig('DB', 'Password');
  Conn.Params.Database := TConfigs.GetConfig('DB', 'Database');
end;

class procedure TConnFactory.SetParams(UserName, Password, Database: string);
begin
  ConnFactory.Conn.Params.UserName := UserName;
  ConnFactory.Conn.Params.Password := Password;
  ConnFactory.Conn.Params.Database := Database;
end;

end.
