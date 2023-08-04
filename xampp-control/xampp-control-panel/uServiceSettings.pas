unit uServiceSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTools, GnuGettext, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls;

type
  TfServiceSettings = class(TForm)
    lMain: TLabel;
    bSave: TBitBtn;
    bCancel: TBitBtn;
    pcSettings: TPageControl;
    pApache: TTabSheet;
    pMySQL: TTabSheet;
    gApache: TGroupBox;
    lApacheName: TLabel;
    lApacheMain: TLabel;
    lApacheSSL: TLabel;
    tApacheName: TEdit;
    tApacheMain: TEdit;
    tApacheSSL: TEdit;
    gMySQL: TGroupBox;
    lMySQLMain: TLabel;
    lMySQLName: TLabel;
    tMySQLMain: TEdit;
    tMySQLName: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
  private
    function ValidateName(Name: string): Boolean;
    function ValidatePort(Port: string): Boolean;
  public
    { Public declarations }
  end;

var
  fServiceSettings: TfServiceSettings;

implementation

{$R *.dfm}

function TfServiceSettings.ValidateName(Name: string): Boolean;
begin
  if (Trim(Name) <> '') and (Pos(' ', Name) = 0) and (Pos('"', Name) = 0) then
    Result := True
  else
    Result := False;
end;

function TfServiceSettings.ValidatePort(Port: string): Boolean;
var
  i: integer;
begin
  if (TryStrToInt(Port, i) = True) and (Trim(Port) <> '') then
    Result := True
  else
    Result := False;
end;

procedure TfServiceSettings.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfServiceSettings.bSaveClick(Sender: TObject);
var
  error: boolean;
begin
  error := False;
  if ValidateName(tApacheName.Text) then
    Config.ServiceNames.Apache := tApacheName.Text
  else
  begin
    ShowMessage('Apache Name: "' + tApacheName.Text + '" is not a valid name.');
    error := True;
  end;
  if ValidatePort(tApacheMain.Text) then
    Config.ServicePorts.Apache := StrToInt(tApacheMain.Text)
  else
  begin
    ShowMessage('Apache Main: "' + tApacheMain.Text + '" is not a valid number.');
    error := True;
  end;
  if ValidatePort(tApacheSSL.Text) then
    Config.ServicePorts.ApacheSSL := StrToInt(tApacheSSL.Text)
  else
  begin
    ShowMessage('Apache SSL: "' + tApacheSSL.Text + '" is not a valid number.');
    error := True;
  end;

  if ValidateName(tMySQLName.Text) then
    Config.ServiceNames.MySQL := tMySQLName.Text
  else
  begin
    ShowMessage('MySQL Name: "' + tMySQLName.Text + '" is not a valid name.');
    error := True;
  end;
  if ValidatePort(tMySQLMain.Text) then
    Config.ServicePorts.MySQL := StrToInt(tMySQLMain.Text)
  else
  begin
    ShowMessage('MySQL: "' + tMySQLMain.Text + '" is not a valid number.');
    error := True;
  end;

  if error = False then
  begin
    SaveSettings;
    Close;
  end;
end;

procedure TfServiceSettings.FormCreate(Sender: TObject);
begin
  TranslateComponent(Self);
end;

procedure TfServiceSettings.FormShow(Sender: TObject);
begin
  tApacheName.Text := Config.ServiceNames.Apache;
  tApacheMain.Text := IntToStr(Config.ServicePorts.Apache);
  tApacheSSL.Text := IntToStr(Config.ServicePorts.ApacheSSL);

  tMySQLName.Text := Config.ServiceNames.MySQL;
  tMySQLMain.Text := IntToStr(Config.ServicePorts.MySQL);
end;

end.
