create or replace package Clr_Next is
  ----------------------------------------------------------------------------------------------------
  Function Disease_Id return number;
  ----------------------------------------------------------------------------------------------------
  Function Clinic_Id return number;
  ----------------------------------------------------------------------------------------------------
  Function Drug_Id return number;
end Clr_Next;
/
create or replace package body Clr_Next is
  ----------------------------------------------------------------------------------------------------
  Function Disease_Id return number is
  begin
    return Clr_Diseases_Sq.Nextval;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Clinic_Id return number is
  begin
    return Clr_Clinics_Sq.Nextval;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Drug_Id return number is
  begin
    return Clr_Drugs_Sq.Nextval;
  end;

end Clr_Next;
/
