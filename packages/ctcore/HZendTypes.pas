unit hzendtypes;

interface

uses Winapi.Windows, ZENDTypes;

var
  get_zend_version: function(): PAnsiChar; cdecl;
  get_php_version: function(): PAnsiChar; cdecl;
  zend_alter_ini_entry: function(name: PAnsiChar; name_length: uint;
    new_value: PAnsiChar; new_value_length: uint; modify_type: Integer;
    stage: Integer): Integer; cdecl;
  ts_resource_ex: function(id: Integer; p: pointer): pointer; cdecl;
  php_request_startup: function(TSRMLS_D: pointer): Integer; cdecl;
  php_request_shutdown: procedure(dummy: pointer); cdecl;
  php_execute_script: function(primary_file: pointer; TSRMLS_D: pointer)
    : Integer; cdecl;
  sapi_globals_id: pointer;
  core_globals_id: pointer;
  tsrm_startup: function(expected_threads: Integer; expected_resources: Integer;
    debug_level: Integer; debug_filename: PAnsiChar): Integer; cdecl;

  sapi_startup: procedure(module: pointer); cdecl;
  php_module_startup: function(sf: pointer; additional_modules: pointer;
    num_additional_modules: uint): Integer; cdecl;
  zend_error: procedure(ErrType: Integer; ErrText: PAnsiChar); cdecl;
  _zend_bailout: procedure(filename: PAnsiChar; lineno: uint); cdecl;
  ZvalArgsGet: function(param_count: Integer; Args: ppzval): Integer;
cdecl varargs;

implementation

end.
