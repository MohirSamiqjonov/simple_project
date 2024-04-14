create or replace package Cla_Api is
  ---------------------------------------------------------------------------------------------------- 
  Procedure Patient_Medical_History_Save(r_Row Cla_Patient_Medical_Histories%rowtype);
  ----------------------------------------------------------------------------------------------------
  Procedure Patient_Medical_History_Delete
  (
    i_Company_Id                 number,
    i_Patient_Medical_History_Id number
  );
  ----------------------------------------------------------------------------------------------------
  Procedure Visit_Save(r_Row Cla_Visits%rowtype); 
  ----------------------------------------------------------------------------------------------------
  Procedure Visit_Delete
  (
    i_Company_Id number,
    i_Visit_Id   number
  );
  ----------------------------------------------------------------------------------------------------
  Procedure Disease_Save(r_Row Cla_Diseases%rowtype);
  ----------------------------------------------------------------------------------------------------
  Procedure Disease_Delete
  (
    i_Company_Id number,
    i_Disease_Id number,
    i_Visit_Id   number
  );
  ----------------------------------------------------------------------------------------------------
  Procedure Drug_Save(r_Row Cla_Drugs%rowtype);
  ----------------------------------------------------------------------------------------------------
  Procedure Drug_Delete
  (
    i_Company_Id number,
    i_Drug_Id    number,
    i_Visit_Id   number
  );
  ---------------------------------------------------------------------------------------------------- 
  Procedure Update_Drug
  (
    i_Company_Id          number,
    i_Drug_Id             number,
    i_Visit_Id            number,
    i_Sold_Count_Medicine number
  );
end Cla_Api;
/
create or replace package body Cla_Api is
  ----------------------------------------------------------------------------------------------------
  Procedure Patient_Medical_History_Save(r_Row Cla_Patient_Medical_Histories%rowtype) is
  begin
    z_Cla_Patient_Medical_Histories.Save_Row(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Patient_Medical_History_Delete
  (
    i_Company_Id                 number,
    i_Patient_Medical_History_Id number
  ) is
  begin
    z_Cla_Patient_Medical_Histories.Delete_One(i_Company_Id                 => i_Company_Id,
                                               i_Patient_Medical_History_Id => i_Patient_Medical_History_Id);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Visit_Save(r_Row Cla_Visits%rowtype) is
  begin
    z_Cla_Visits.Save_Row(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Visit_Delete
  (
    i_Company_Id number,
    i_Visit_Id   number
  ) is
  begin
    z_Cla_Visits.Delete_One(i_Company_Id => i_Company_Id, i_Visit_Id => i_Visit_Id);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Disease_Save(r_Row Cla_Diseases%rowtype) is
  begin
    z_Cla_Diseases.Save_Row(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Disease_Delete
  (
    i_Company_Id number,
    i_Disease_Id number,
    i_Visit_Id   number
  ) is
  begin
    z_Cla_Diseases.Delete_One(i_Company_Id => i_Company_Id,
                              i_Disease_Id => i_Disease_Id,
                              i_Visit_Id   => i_Visit_Id);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Drug_Save(r_Row Cla_Drugs%rowtype) is
  begin
    z_Cla_Drugs.Save_Row(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Drug_Delete
  (
    i_Company_Id number,
    i_Drug_Id    number,
    i_Visit_Id   number
  ) is
  begin
    z_Cla_Drugs.Delete_One(i_Company_Id => i_Company_Id,
                           i_Drug_Id    => i_Drug_Id,
                           i_Visit_Id   => i_Visit_Id);
  end;

  ---------------------------------------------------------------------------------------------------- 
  Procedure Update_Drug
  (
    i_Company_Id          number,
    i_Drug_Id             number,
    i_Visit_Id            number,
    i_Sold_Count_Medicine number
  ) is
  begin
    z_Cla_Drugs.Update_One(i_Company_Id          => i_Company_Id,
                           i_Drug_Id             => i_Drug_Id,
                           i_Visit_Id            => i_Visit_Id,
                           i_Sold_Count_Medicine => Option_Number(i_Sold_Count_Medicine));
  end;

end Cla_Api;
/
