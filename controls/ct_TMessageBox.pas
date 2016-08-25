unit ct_TMessageBox;

interface

uses
  System.SysUtils,
  WinApi.Windows,
  VCL.Forms,
  VCL.Dialogs,
  hzendtypes,
  WPDFunction,
  ZENDTypes,
  ZENDApi;

procedure ct_gui_controls_messages_tmessagebox_show(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

  procedure ct_gui_controls_messages_tmessagebox_show;
  var
    Caption: ppzval;
    Text: ppzval;
    Inf: ppzval;
  begin
    if (ZvalArgsGet(ht, @Caption, @Text, @Inf) = SUCCESS) then
    begin
      ZVAL_LONG(return_value, MessageBoxA(Application.Handle, PAnsiChar(Text^.value.str.val), PAnsiChar(Caption^.value.str.val), Inf^.value.lval));
    end;
  end;

end.
