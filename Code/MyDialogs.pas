unit MyDialogs;

interface

uses
  System.SysUtils, System.Classes, System.Types, Vcl.Dialogs, Vcl.Forms,
  Vcl.StdCtrls;

type
  TDialogs = class
  public
    class function YesNo(Msg: string; BtnDefault: TMsgDlgBtn = mbNo): integer;
    class function YesNoCancel(Msg: string; BtnDefault: TMsgDlgBtn = mbCancel): integer;
    class function CustomDialog(const Msg: string; DlgType: TmsgDlgType; Buttons: TMsgDlgButtons; ButtonsCaption: array of string; dlgcaption: string): Integer;
  end;

implementation

{ TMyDialogs }

class function TDialogs.YesNo(Msg: string; BtnDefault: TMsgDlgBtn): integer;
begin
  Result := MessageDlg(Msg, mtWarning, mbYesNo, 0, BtnDefault);
end;

class function TDialogs.YesNoCancel(Msg: string; BtnDefault: TMsgDlgBtn): integer;
begin
  Result := MessageDlg(Msg, mtConfirmation, mbYesNoCancel, 0, BtnDefault);
end;

class function TDialogs.CustomDialog(const Msg: string; DlgType: TmsgDlgType; Buttons: TMsgDlgButtons; ButtonsCaption: array of string; dlgcaption: string): Integer;
var
  aMsgdlg: TForm;
  I: Integer;
  Dlgbutton: Tbutton;
  Captionindex: Integer;
begin
  aMsgdlg := createMessageDialog(Msg, DlgType, Buttons);
  aMsgdlg.Caption := dlgcaption;
  aMsgdlg.BiDiMode := bdRightToLeft;
  Captionindex := 0;
  for I := 0 to aMsgdlg.componentcount - 1 Do
  begin
    if (aMsgdlg.components[I] is Tbutton) then
    Begin
      Dlgbutton := Tbutton(aMsgdlg.components[I]);
      if Captionindex <= High(ButtonsCaption) then
        Dlgbutton.Caption := ButtonsCaption[Captionindex];
      inc(Captionindex);
    end;
  end;
  Result := aMsgdlg.Showmodal;
end;

end.
