create or replace package Clr_Api is
  ----------------------------------------------------------------------------------------------------
  Procedure Disease_Save(r_Row Clr_Diseases%rowtype);
  ----------------------------------------------------------------------------------------------------
  Procedure Disease_Delete
  (
    i_Company_Id number,
    i_Disease_Id number
  );
  ----------------------------------------------------------------------------------------------------
  Procedure Clinic_Save(r_Row Clr_Clinics%rowtype);
  ----------------------------------------------------------------------------------------------------
  Procedure Clinic_Delete
  (
    i_Company_Id number,
    i_Clinic_Id  number
  );
  ----------------------------------------------------------------------------------------------------
  Procedure Drug_Save(r_Row Clr_Drugs%rowtype);
  ----------------------------------------------------------------------------------------------------
  Procedure Drug_Delete
  (
    i_Company_Id number,
    i_Drug_Id    number
  );
end Clr_Api;
/
create or replace package body Clr_Api is
  ----------------------------------------------------------------------------------------------------
  Procedure Disease_Save(r_Row Clr_Diseases%rowtype) is
  begin
    z_Clr_Diseases.Save_Row(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Disease_Delete
  (
    i_Company_Id number,
    i_Disease_Id number
  ) is
  begin
    z_Clr_Diseases.Delete_One(i_Company_Id => i_Company_Id, i_Disease_Id => i_Disease_Id);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Clinic_Save(r_Row Clr_Clinics%rowtype) is
  begin
    z_Clr_Clinics.Save_Row(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Clinic_Delete
  (
    i_Company_Id number,
    i_Clinic_Id  number
  ) is
  begin
    z_Clr_Clinics.Delete_One(i_Company_Id => i_Company_Id, i_Clinic_Id => i_Clinic_Id);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Drug_Save(r_Row Clr_Drugs%rowtype) is
  begin
    z_Clr_Drugs.Save_Row(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Drug_Delete
  (
    i_Company_Id number,
    i_Drug_Id    number
  ) is
  begin
    z_Clr_Drugs.Delete_One(i_Company_Id => i_Company_Id, i_Drug_Id => i_Drug_Id);
  end;

end Clr_Api;
/
