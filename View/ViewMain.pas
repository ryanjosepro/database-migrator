unit ViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList, System.ImageList,
  Vcl.ImgList, Vcl.ExtDlgs, ViewDB, ViewFields, ViewDados, DAO, MyUtils;

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
    procedure ActOpenFileExecute(Sender: TObject);
    procedure ActConfigDBExecute(Sender: TObject);
    procedure ActConfigFieldsExecute(Sender: TObject);
    procedure ActDadosExecute(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure Log(Msg: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  WindowMain: TWindowMain;

implementation

{$R *.dfm}

procedure TWindowMain.ActOpenFileExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin
    ActOpenFile.Hint := OpenFile.FileName;
    TConfigs.SetFilePath(OpenFile.FileName);
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

procedure TWindowMain.ActDadosExecute(Sender: TObject);
begin
  WindowDados.ShowModal;
end;

procedure TWindowMain.BtnStartClick(Sender: TObject);
var
  Rows: TStringList;
  DataFlex: TDataFlex;
  Datas: TStringMatrix;
  ContRow, ContCol: integer;
  OutStr: string;
begin
  //Se o arquivo n�o foi selecionado;
  if OpenFile.FileName = '' then
  begin
    OpenFile.Execute;
  end;
  //Cria uma lista de strings;
  Rows := TStringList.Create;
  //Pega as linhas do arquivo;
  Rows.LoadFromFile(OpenFile.FileName);
  //Manda as linhas pra classe de tratamento;
  DataFlex := TDataFlex.Create(Rows);
  //Define o tamanho da matriz;
  SetLength(Datas, DataFlex.GetRows, DataFlex.GetCols);
  //Atribui a matriz para uma vari�vel;
  Datas := DataFlex.ToMatrix;
  //Try para libera��o de objetos;
  try
    //Try para tratamento de erros;
    try
      //Limpa o log de sa�da;
      TxtLog.Clear;
      //Percorre cada linha da matriz;
      for ContRow := 0 to DataFlex.GetRows do
      begin
        //Envia uma linha com dados para o DAO;
        TDAO.Insert(Datas[ContRow], WindowFields.GetOrder);
        //Limpa a vari�vel de sa�da;
        OutStr := '';
        //Percorre cada dado da linha da matriz;
        for ContCol := 0 to DataFlex.GetCols - 1 do
        begin
          //Atribui � vari�vel de sa�da os dados da linha;
          OutStr := OutStr + Datas[ContRow][ContCol] + ' - ';
        end;
        //Envia � vari�vel de sa�da para o log;
        Log('Inserted ' + OutStr);
      end;
    except on E: Exception do
      ShowMessage(E.ToString);
    end;
  finally
    FreeAndNil(Rows);
    FreeAndNil(DataFlex);
  end;
end;

procedure TWindowMain.Log(Msg: string);
begin
  TxtLog.Lines.Add(Msg);
end;

procedure TWindowMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TConfigs.SetFilePath('');
end;

end.
