unit сt_TMessage;

interface

uses
  VCL.Dialogs,
  hzendtypes,
  WPDFunction,
  ZENDTypes;

procedure сt_gui_controls_messages_tmessage_show(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

  procedure сt_gui_controls_messages_tmessage_show;
  var
    Text: ppzval;
  begin
    if (ZvalArgsGet(ht, @Text) = SUCCESS) then
    begin
      ShowMessage(Text^.value.str.val);
    end;
  end;

end.
