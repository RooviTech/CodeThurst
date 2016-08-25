unit AZendApi;

interface

uses
  ZendTypes;

function Z_STRVAL(value: ppzval): String;
function Z_INTVAL(value: ppzval): Integer;
function Z_BOOLVAL(value: ppzval): Boolean;
function Z_VAL(value: ppzval): String;

implementation

  function Z_STRVAL;
  begin
    Result := value^.value.str.val;
  end;

  function Z_INTVAL;
  begin
    Result := value^.value.lval;
  end;

  function Z_BOOLVAL;
  begin
    Result := zend_bool(value^.value.lval);
  end;

  function Z_VAL;
  begin
    case value^._type of
      IS_STRING:
        Result := String(value^.value.str.val);
      IS_LONG:
        Result := String(value^.value.lval);
      IS_BOOL:
        Result := String(value^.value.lval);
    end;
  end;

end.
