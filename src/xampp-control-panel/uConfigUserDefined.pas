unit uConfigUserDefined;

interface

uses
  GnuGettext, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, Buttons, uTools, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfConfigUserDefined = class(TForm)
    lblDescription1: TLabel;
    bSave: TBitBtn;
    bAbort: TBitBtn;
    lblDescription2: TLabel;
    pcUserDefConf: TPageControl;
    pApache: TTabSheet;
    pMySQL: TTabSheet;
    mConfigApache: TMemo;
    mLogsApache: TMemo;
    mConfigMySQL: TMemo;
    mLogsMySQL: TMemo;
    pnlApache: TPanel;
    lblApacheConf: TLabel;
    lblApacheLogs: TLabel;
    pnlMySQL: TPanel;
    lblMySQLConf: TLabel;
    lblMySQLLogs: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bAbortClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure Memo2Config;
    procedure Config2Memo;
  public
    { Public-Deklarationen }
  end;

var
  fConfigUserDefined: TfConfigUserDefined;

implementation

{$R *.dfm}
{ TfConfigUserDefined }

procedure TfConfigUserDefined.bAbortClick(Sender: TObject);
begin
  Close;
end;

procedure TfConfigUserDefined.bSaveClick(Sender: TObject);
begin
  Memo2Config;
  SaveSettings;
end;

procedure TfConfigUserDefined.Memo2Config;
begin
  Config.UserConfig.Apache.Text := mConfigApache.Text;
  Config.UserConfig.MySQL.Text := mConfigMySQL.Text;

  Config.UserLogs.Apache.Text := mLogsApache.Text;
  Config.UserLogs.MySQL.Text := mLogsMySQL.Text;
end;

procedure TfConfigUserDefined.Config2Memo;
begin
  mConfigApache.Text := Config.UserConfig.Apache.Text;
  mConfigMySQL.Text := Config.UserConfig.MySQL.Text;

  mLogsApache.Text := Config.UserLogs.Apache.Text;
  mLogsMySQL.Text := Config.UserLogs.MySQL.Text;
end;

procedure TfConfigUserDefined.FormCreate(Sender: TObject);
begin
  TranslateComponent(self);
end;

procedure TfConfigUserDefined.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
    exit;
  end;
end;

procedure TfConfigUserDefined.FormShow(Sender: TObject);
begin
  Config2Memo;
end;

end.
