unit DelphiFunctions;

interface

function is_numeric(const st:string): boolean;

implementation

  function is_numeric;
  var
    i: Integer;
  begin
    Result :=True;
    for i := 1 to Length(st) do
      if not (st[i] in ['0'..'9']) then Result :=False;
  end;

end.
