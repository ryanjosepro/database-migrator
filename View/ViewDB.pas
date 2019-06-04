unit ViewDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, ConnectionFactory, MyUtils;

type
  TWindowDB = class(TForm)
    ImageTitle: TImage;
    LblUserName: TLabel;
    TxtUserName: TEdit;
    LblPassword: TLabel;
    TxtPassword: TEdit;
    LblDatabase: TLabel;
    TxtDatabase: TEdit;
    LblTable: TLabel;
    TxtTable: TEdit;
    BtnSave: TSpeedButton;
    BtnTestConn: TSpeedButton;
    OpenFile: TFileOpenDialog;
    Actions: TActionList;
    Images: TImageList;
    ActDBFile: TAction;
    BtnDBFile: TSpeedButton;
    ActSave: TAction;
    ActTestConn: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditsChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActDBFileExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActTestConnExecute(Sender: TObject);
  end;

var
  WindowDB: TWindowDB;
  DidChange: boolean;

implementation

{$R *.dfm}

procedure TWindowDB.ActDBFileExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin
    TxtDatabase.Text := OpenFile.FileName;
  end;
end;

procedure TWindowDB.ActSaveExecute(Sender: TObject);
begin
  TConfigs.SetUserName(TxtUserName.Text);
  TConfigs.SetPassWord(TxtPassword.Text);
  TConfigs.SetDatabase(TxtDatabase.Text);
  TConfigs.SetTable(TxtTable.Text);
  DidChange := false;
  Close;
end;

procedure TWindowDB.ActTestConnExecute(Sender: TObject);
begin
  ConnFactory.Conn.Params.UserName := TxtUserName.Text;
  ConnFactory.Conn.Params.Password := TxtPassword.Text;
  ConnFactory.Conn.Params.Database := TxtDatabase.Text;
  try
    ConnFactory.Conn.Connected := true;
    ShowMessage('Conex�o Ok!');
  except on E: Exception do
    ShowMessage('Erro de conex�o: ' + E.ToString);
  end;
end;

procedure TWindowDB.EditsChange(Sender: TObject);
begin
  DidChange := true;
end;

procedure TWindowDB.FormActivate(Sender: TObject);
begin
  TxtUserName.Text := TConfigs.GetUserName;
  TxtPassword.Text := TConfigs.GetPassword;
  TxtDatabase.Text := TConfigs.GetDatabase;
  TxtTable.Text := TConfigs.GetTable;
  DidChange := false;
end;

procedure TWindowDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DidChange then
  begin
    case MessageDlg('Deseja salvar as configura��es?', mtInformation, mbYesNoCancel,  2) of
      6: ActSaveExecute(BtnSave);
      2: Action := TCloseAction.caNone;
    end;
  end
  else
  begin
    DidChange := false;
  end;
end;

end.
