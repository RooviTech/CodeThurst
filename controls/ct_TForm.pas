unit ct_TForm;

interface

uses
  VCL.Forms,
  VCL.Controls,

  // Ct
  HZendTypes,
  ZendTypes,
  ZendApi,
  AZendApi;

procedure ct_gui_controls_TForm_Create(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure ct_gui_controls_TForm_Show(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

  procedure ct_gui_controls_TForm_Create;
    var
      Caption: ppzval;
      Form: TForm;
  begin
    Form := TForm.Create(Application);

    Application.CreateForm(TForm, Form);

    if ZvalArgsGet(ht, @Caption) = SUCCESS then
      Form.Caption := Z_STRVAL(Caption);
	  
    ZVAL_LONG(return_value, Integer(Form));
  end;

  procedure ct_gui_controls_TForm_Show;
    var ID: ppzval;
  begin
    if ZvalArgsGet(ht, @ID) = SUCCESS then
      TForm(Z_INTVAL(ID)).Show();
  end;

end.
