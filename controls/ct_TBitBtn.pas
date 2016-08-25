unit ct_TBitBtn;

interface

uses
  VCL.Graphics,
  ShellApi,
  VCL.Buttons,

  ZendTypes,
  HZendTypes,
  ZendApi,
  AZendApi;

procedure ct_gui_controls_TBitBtn_Create(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

procedure ct_gui_controls_TBitBtn_LoadPicture(ht: Integer; return_value: pzval;
  return_value_ptr: ppzval; this_ptr: pzval; return_value_used: Integer;
  TSRMLS_DC: pointer); cdecl;

implementation

  procedure ct_gui_controls_TBitBtn_Create;
    var
      Text: ppzval;
      Button: TBitBtn;
  begin
    Button := TBitBtn.Create(nil);

    if ZvalArgsGet(ht, @Text) = SUCCESS then
      Button.Caption := AZendApi.Z_STRVAL(Text);

    ZVAL_LONG(return_value, Integer(Button));
  end;

  procedure ct_gui_controls_TBitBtn_LoadPicture;
	    var
        ID: ppzval;
	      FileName: ppzval;
        Obj: TObject;

        ico: TIcon;
        bmp: TBitmap;
  begin
		if ZvalArgsGet(ht, @ID, @FileName) = SUCCESS then
		begin
      ico := TIcon.Create;
      ico.Handle := ExtractIcon(HInstance, PWideChar(WideString(AZendApi.Z_STRVAL(FileName))), 0);
      bmp := TBitmap.Create;
      bmp.PixelFormat := pf32bit;
      bmp.Width := ico.Width;
      bmp.Height := ico.Height;
      bmp.Canvas.Draw(0, 0, ico);
      TBitBtn(AZendApi.Z_INTVAL(ID)).Glyph.Assign(bmp);
    end;
  end;
  
end.
