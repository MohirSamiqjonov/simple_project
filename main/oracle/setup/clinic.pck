create or replace package Clinic is
  ----------------------------------------------------------------------------------------------------
  Function Version return varchar2 deterministic;
  ----------------------------------------------------------------------------------------------------
  Function Project_Code return varchar2 deterministic;
end Clinic;
/
create or replace package body Clinic is
  ----------------------------------------------------------------------------------------------------
  Function Version return varchar2 deterministic is
  begin
    return '1.0.0';
  end;

  ----------------------------------------------------------------------------------------------------
  Function Project_Code return varchar2 deterministic is
  begin
    return 'clinic';
  end;

end Clinic;
/
