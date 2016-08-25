unit EngineController;

interface

uses
  VCL.Dialogs,
  CtFunction,
  RttiProcedures,
  GUIWorks,

  ZENDTypes,
  ZendApi,
  hzendtypes,

  // GUI
  ct_Application,
  ct_TForm,
  ct_TBitBtn,
  ct_TSpeedButton;

procedure DefineAllFunctions(Engine: TCtEngine);

implementation

  procedure DefineAllFunctions;
  begin
  {$IFNDEF VANILLA_ENGINE}
    {$IFDEF ADD_GUI}
      Engine.DefineFunction('ct_GetPropValue', @ct_GetPropValue);
      Engine.DefineFunction('ct_SetPropValue', @ct_SetPropValue);
      Engine.DefineFunction('ct_ExistsProp', @ct_ExistsProp);
	  
      Engine.DefineFunction('ct_gui_parent', @ct_gui_parent);
      Engine.DefineFunction('ct_gui_destroy', @ct_gui_destroy);

      Engine.DefineFunction('ct_gui_Application_Initialize', @ct_gui_Application_Initialize);
      Engine.DefineFunction('ct_gui_Application_Run', @ct_gui_Application_Run);
      Engine.DefineFunction('ct_gui_Application_SetterHandler', @ct_gui_Application_SetterHandler);
      Engine.DefineFunction('ct_gui_Application_GetterHandler', @ct_gui_Application_GetterHandler);

      Engine.DefineFunction('ct_gui_controls_TForm_Create', @ct_gui_controls_TForm_Create);
      Engine.DefineFunction('ct_gui_controls_TForm_Show', @ct_gui_controls_TForm_Show);
	  
      Engine.DefineFunction('ct_gui_controls_TBitBtn_Create', @ct_gui_controls_TBitBtn_Create);
      Engine.DefineFunction('ct_gui_controls_TBitBtn_LoadPicture', @ct_gui_controls_TBitBtn_LoadPicture);
	  
      Engine.DefineFunction('ct_gui_controls_TSpeedButton_Create', @ct_gui_controls_TSpeedButton_Create);
      Engine.DefineFunction('ct_gui_controls_TSpeedButton_LoadPicture', @ct_gui_controls_TSpeedButton_LoadPicture);
    {$ENDIF}
  {$ENDIF}
end;

end.
