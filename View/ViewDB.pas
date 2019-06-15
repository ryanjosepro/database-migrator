unit ViewDB;

interface

uses
  System.SysUtils, System.Classes, System.Types, Winapi.Windows, Winapi.Messages, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList,
  Configs, DAO;

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
  TConfigs.SetConfig('DB', 'UserName', TxtUserName.Text);
  TConfigs.SetConfig('DB', 'Password', TxtPassword.Text);
  TConfigs.SetConfig('DB', 'Database', TxtDatabase.Text);
  TConfigs.SetConfig('DB', 'Table', TxtTable.Text);

  TDAO.SetParams(TxtUserName.Text, TxtPassword.Text, TxtDatabase.Text);

  DidChange := false;
  Close;
end;

procedure TWindowDB.ActTestConnExecute(Sender: TObject);
var
  CurrUserName, CurrPassword, CurrDatabase: string;
begin
  TDAO.GetParams(CurrUserName, CurrPassword, CurrDatabase);

  TDAO.SetParams(TxtUserName.Text, TxtPassword.Text, TxtDatabase.Text);
  try
    try
      TDAO.TestConn;
      ShowMessage('Conex�o Ok!');
    except on E: Exception do
      ShowMessage('Erro de conex�o: ' + E.ToString);
    end;
  finally
    TDAO.SetParams(CurrUserName, CurrPassword, CurrDatabase);
  end;
end;

procedure TWindowDB.EditsChange(Sender: TObject);
begin
  DidChange := true;
end;

procedure TWindowDB.FormActivate(Sender: TObject);
begin
  TxtUserName.Text := TConfigs.GetConfig('DB', 'UserName');
  TxtPassword.Text := TConfigs.GetConfig('DB', 'Password');
  TxtDatabase.Text := TConfigs.GetConfig('DB', 'Database');
  TxtTable.Text := TConfigs.GetConfig('DB', 'Table');
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
