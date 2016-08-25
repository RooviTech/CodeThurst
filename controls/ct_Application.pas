unit ct_Application;

interface

uses ZendApi, ZendTypes, HZendTypes, AZendApi, Rtti, VCL.Forms;

procedure ct_gui_Application_Initialize();
procedure ct_gui_Application_Run();

procedure ct_gui_Application_SetterHandler(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;
  
procedure ct_gui_Application_GetterHandler(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

  procedure ct_gui_Application_Initialize;
  begin
    Application.Initialize;
  end;

  procedure ct_gui_Application_Run;
  begin
    Application.Run;
  end;
  
  procedure ct_gui_Application_SetterHandler;
	var
		PropName: ppzval;
		PropValue: ppzval;
		RttiProperty: TRttiProperty;
  begin
    if ZvalArgsGet(ht, @PropName, @PropValue) = SUCCESS then
	begin
		RttiProperty := TRttiContext
		.Create
		.GetType(TApplication)
		.GetProperty(PropName^.value.str.val);
		case PropValue^._type of
			IS_STRING:
				RttiProperty.SetValue(Application, PropValue^.value.str.val);
			IS_LONG:
				RttiProperty.SetValue(Application, PropValue^.value.lval);
			IS_BOOL:
				RttiProperty.SetValue(Application, zend_bool(PropValue^.value.lval));
		end;
	end;
  end;
  
  procedure ct_gui_Application_GetterHandler;
	var
		PropName: ppzval;
		PropValue: ppzval;
		RttiProperty: TRttiProperty;
  begin
    if ZvalArgsGet(ht, @PropName) = SUCCESS then
	begin
		RttiProperty := TRttiContext
		.Create
		.GetType(TApplication)
		.GetProperty(PropName^.value.str.val);
		ZVAL_STRINGW(return_value, PWideChar(RttiProperty.GetValue(Application).ToString), false);
	end;
  end;

end.
