unit RttiProcedures;

interface

uses
  VCL.Forms,
  System.SysUtils,
  TypInfo,
  Rtti,
  DelphiFunctions,

  AZendApi,
  ZendApi,
  PHPApi,

  HZendTypes,
  ZendTypes;

procedure ct_GetPropValue(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure ct_SetPropValue(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure ct_ExistsProp(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

  procedure ct_GetPropValue;
    var
      IntObj: ppzval;
      PropName: ppzval;
      Value: String;
  begin
    if ZvalArgsGet(ht, @IntObj, @PropName) = SUCCESS then
    begin
      Value := TypInfo.GetPropValue(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName));
	  case DelphiFunctions.is_numeric(Value) of
		true:
			ZVAL_LONG(return_value, StrToInt(Value));
		false:
			ZVAL_STRINGW(return_value, PWideChar(WideString(Value)), false);
	  end;
    end;
  end;

  procedure ct_SetPropValue;
    var
      IntObj, PropName, Value: ppzval;
  begin
    if ZvalArgsGet(ht, @IntObj, @PropName, @Value) = SUCCESS then
	begin
		case Value^._type of
			IS_LONG:
				TypInfo.SetPropValue(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName), Value^.value.lval);
			IS_STRING: 
				TypInfo.SetPropValue(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName), String(Value^.value.str.val));
			IS_BOOL:
				TypInfo.SetPropValue(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName), zend_bool(Value^.value.lval));
		end;
	end;
  end;

  procedure ct_ExistsProp;
	var
      IntObj: ppzval;
	  PropName: ppzval;
  begin
  
    if ZvalArgsGet(ht, @IntObj, @PropName) = SUCCESS then
    	begin

		if IsPublishedProp(TObject(AZendApi.Z_INTVAL(IntObj)), AZendApi.Z_STRVAL(PropName)) = true then
		    ZVAL_TRUE(return_value)
		else
        ZVAL_FALSE(return_value);
    end;

  end;
  
end.
