unit MyDialogs;

interface

uses
  System.SysUtils, System.Classes, System.Types, Vcl.Dialogs;

type
  TDialogs = class
  public
    class function YesNo(Msg: string; BtnDefault: TMsgDlgBtn = mbNo): integer;
    class function YesNoCancel(Msg: string; BtnDefault: TMsgDlgBtn = mbCancel): integer;
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

end.
