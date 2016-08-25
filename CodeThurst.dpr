program CodeThurst;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  VCL.Forms,
  VersionInfo,
  CtFunction,
  PHPLoader,
  ZendTypes,
  ZendApi,
  RttiProcedures in 'RttiProcedures.pas',
  ct_TForm in 'controls\ct_TForm.pas',
  EngineController in 'EngineController.pas',
  AZendApi in 'packages\ctcore\AZendApi.pas',
  ct_Application in 'controls\ct_Application.pas',
  ct_TBitBtn in 'controls\ct_TBitBtn.pas',
  DelphiFunctions in 'DelphiFunctions.pas';

// Zend error handler
procedure zend_error_cb2(AType: Integer; const AFname: PAnsiChar;
  const ALineNo: UINT; const AFormat: PAnsiChar; Args: va_list)cdecl;
var
  LText: string;
  LBuffer: array [0 .. 4096] of AnsiChar;
begin
  case AType of
    E_ERROR:
      LText := 'Fatal Error:';
    E_WARNING:
      LText := 'Warning:';
    E_CORE_ERROR:
      LText := 'Core Error:';
    E_CORE_WARNING:
      LText := 'Core Warning:';
    E_COMPILE_ERROR:
      LText := 'Compile Error:';
    E_COMPILE_WARNING:
      LText := 'Compile Warning:';
    E_USER_ERROR:
      LText := 'User Error:';
    E_USER_WARNING:
      LText := 'User Warning:';
    E_RECOVERABLE_ERROR:
      LText := 'Recoverable Error:';
    E_PARSE:
      LText := 'Parse Error:';
    E_NOTICE:
      LText := 'Notice:';
    E_USER_NOTICE:
      LText := 'User Notice:';
    E_STRICT:
      LText := 'Strict Error:';
    E_CORE:
      LText := 'Core Error:';
  else
    LText := 'Unknown Error(' + inttostr(AType) + '):';
  end;

  wvsprintfA(LBuffer, AFormat, Args);

  LText := LText + ' ' + String(LBuffer) + ', on line: ' + inttostr(ALineNo) + ', in file ' + String(AFname);

  WriteLn(LText);
  _zend_bailout(AFname, ALineNo);
end;

var
  Engine: TCtEngine;
  php: TpsvCustomPHP;
  CoreRequire: AnsiString;
  tmp: pointer;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    SetConsoleTitle(PWideChar('CodeThurst '+VersionInfo.Year+'.'+VersionInfo.Version+' - '+VersionInfo.Prefix));

    if ParamCount <> 1 then
    begin
      WriteLn(Format('Usage: %s <filename.php>', [ParamStr(0)]));
      Halt(1);
    end;

    Application.ShowMainForm := false;

    Engine := TCtEngine.Create(nil);
    Engine.PHPINIPath := 'core/php.ini';

    EngineController.DefineAllFunctions(Engine);

    Engine.StartupEngine;

    php := TEngineCt();

    tmp := GetProcAddress(PHP5dll, 'zend_error_cb');

    asm
      mov edx, dword ptr [tmp]
      mov dword ptr [edx], offset zend_error_cb2
    end;

    if FileExists(ParamStr(1)) then
    begin
      if FileExists('core/launch.php') then CoreRequire := 'require("core/launch.php");';

      Write(php.RunCode('<?php '+CoreRequire+' require("'+AnsiString(ParamStr(1))+'");'));
    end
    else
      WriteLn('File "'+ParamStr(1)+'" not found.');

    php.ShutdownRequest;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
