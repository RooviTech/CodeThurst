unit GUIWorks;

interface

uses
  TypInfo,
  
  VCL.Forms,
  VCL.Controls,
  
  ZendTypes,
  HZendTypes,

  ZendApi,
  PHPApi,

  RttiProcedures
;

procedure ct_gui_parent(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;
  
procedure ct_gui_destroy(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

  procedure ct_gui_parent;
    var
      Obj: ppzval;
      Owner: ppzval;
  begin
	ZvalArgsGet(ht, @Obj, @Owner);
	if Owner^._type = IS_NULL then
		ZVAL_LONG(return_value, Integer(TControl(Obj^.value.lval).Parent))
	else
		TControl(Obj^.value.lval).Parent := TWinControl(Owner^.value.lval)
  end;
  
  procedure ct_gui_destroy;
	var Obj: ppzval;
  begin
	if ZvalArgsGet(ht, @Obj) = SUCCESS then
		TControl(Obj^.value.lval).Free;
  end;

end.
