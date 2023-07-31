unit uUtils;

interface

uses uTools;

Type
  tApacheAddLog = procedure (Log: string; LogType: tLogType = ltDefault) of object;


procedure RunInBrowser(url: String; apachePort: Integer; browserApp: String; AddLog: tApacheAddLog);

implementation

uses uMain, SysUtils, uApache, gnugettext, Windows;


procedure RunInBrowser(url: String; ApachePort: Integer; BrowserApp: String; AddLog: tApacheAddLog);
var
  App, Param: string;
Begin
  if ApachePort = 80 then
    Param := 'http://127.0.0.1' + url
  else
    Param := 'http://127.0.0.1:' + IntToStr(apachePort) + url;

  if BrowserApp <> '' then
  begin
    App := BrowserApp;
    ExecuteFile(App, Param, '', SW_SHOW);
    AddLog(Format(_('Executing "%s" "%s"'), [App, Param]), ltDebug);
  end
  else
  begin
    ExecuteFile(Param, '', '', SW_SHOW);
    AddLog(Format(_('Executing "%s"'), [Param]), ltDebug);
  end;
End;

end.
