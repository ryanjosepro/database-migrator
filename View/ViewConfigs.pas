unit ViewConfigs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Buttons, System.Actions, Vcl.ActnList,
  MyUtils, Configs;

type
  TWindowConfigs = class(TForm)
    TxtLimit: TEdit;
    PageConfigs: TPageControl;
    TabMigration: TTabSheet;
    TabFirebird: TTabSheet;
    CheckTruncFB: TCheckBox;
    BtnDiscard: TSpeedButton;
    BtnSave: TSpeedButton;
    Actions: TActionList;
    ActSave: TAction;
    ActDiscard: TAction;
    TxtCommit: TEdit;
    GroupCommit: TRadioGroup;
    GroupLimit: TRadioGroup;
    procedure ActDiscardExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure GroupCommitClick(Sender: TObject);
    procedure GroupLimitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckTruncFBClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    procedure LoadConfigs;
  end;

var
  WindowConfigs: TWindowConfigs;
  DidChange: boolean;

implementation

{$R *.dfm}

procedure TWindowConfigs.ActSaveExecute(Sender: TObject);
begin
  TConfigs.SetConfig('GENERAL', 'Commit', TUtils.Iff(GroupCommit.ItemIndex = 0, '-1', TUtils.IfClean(TxtCommit.Text, '-1')));
  TConfigs.SetConfig('GENERAL', 'Limit', TUtils.Iff(GroupLimit.ItemIndex = 0, '-1', TUtils.IfClean(TxtLimit.Text, '-1')));
  TConfigs.SetConfig('GENERAL', 'TruncFB', TUtils.Iff(CheckTruncFB.Checked, '1', '0'));

  DidChange := false;

  Close;
end;

procedure TWindowConfigs.CheckTruncFBClick(Sender: TObject);
begin
  DidChange := true;
end;

procedure TWindowConfigs.FormActivate(Sender: TObject);
begin
  LoadConfigs;
  DidChange := false;
end;

procedure TWindowConfigs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DidChange then
  begin
    case MessageDlg('Deseja salvar as configurações?', mtConfirmation, mbYesNoCancel, 0, mbCancel) of
    mrYes:
      ActSaveExecute(BtnSave);
    mrCancel:
      Action := TCloseAction.caNone;
    end;
  end
  else
  begin
    DidChange := false;
  end;
end;

procedure TWindowConfigs.LoadConfigs;
var
  Commit, Limit, TruncFB: integer;
begin
  Commit := TUtils.IfClean(TConfigs.GetConfig('GENERAL', 'Commit'), '-1').ToInteger;
  Limit := TUtils.IfClean(TConfigs.GetConfig('GENERAL', 'Limit'), '-1').ToInteger;
  TruncFB := TUtils.IfClean(TConfigs.GetConfig('GENERAL', 'TruncFB'), '0').ToInteger;

  if Commit = -1 then
  begin
    GroupCommit.ItemIndex := 0;
  end
  else
  begin
    GroupCommit.ItemIndex := 1;
    TxtCommit.Text := Commit.ToString;
  end;

  if Limit = -1 then
  begin
    GroupLimit.ItemIndex := 0;
  end
  else
  begin
    GroupLimit.ItemIndex := 1;
    TxtLimit.Text := Limit.ToString;
  end;

  CheckTruncFB.Checked := TruncFB = 1;

  PageConfigs.TabIndex := 0;
end;

procedure TWindowConfigs.ActDiscardExecute(Sender: TObject);
begin
  DidChange := false;
  Close;
end;

procedure TWindowConfigs.GroupCommitClick(Sender: TObject);
begin
  DidChange := true;
  if GroupCommit.ItemIndex = 0 then
  begin
    TxtCommit.Enabled := false;
  end
  else
  begin
    TxtCommit.Enabled := true;
    TxtCommit.SetFocus;
  end;
end;

procedure TWindowConfigs.GroupLimitClick(Sender: TObject);
begin
  DidChange := true;
  if GroupLimit.ItemIndex = 0 then
  begin
    TxtLimit.Enabled := false;
  end
  else
  begin
    TxtLimit.Enabled := true;
    TxtLimit.SetFocus;
  end;
end;

end.
