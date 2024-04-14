create or replace package Ui_Clinic4 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/disease
  ---------------------------------------------------------------------------------------------------- 
  Function Add_Model return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap;
  ---------------------------------------------------------------------------------------------------- 
  Procedure Add(p Hashmap);
  ----------------------------------------------------------------------------------------------------
  Procedure Edit(p Hashmap);
end Ui_Clinic4;
/
create or replace package body Ui_Clinic4 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/disease
  ---------------------------------------------------------------------------------------------------- 
  Function Add_Model return Hashmap is
  begin
    return Fazo.Zip_Map('state', 'A');
  end;

  ---------------------------------------------------------------------------------------------------- 
  Function Edit_Model(p Hashmap) return Hashmap is
    r_Disease Clr_Diseases%rowtype;
  begin
    r_Disease := z_Clr_Diseases.Lock_Load(i_Company_Id => Ui.Company_Id,
                                          i_Disease_Id => p.r_Number('disease_id'));
  
    return z_Clr_Diseases.To_Map(r_Disease, z.Disease_Id, z.Name, z.Note, z.State);
  end;

  ---------------------------------------------------------------------------------------------------- 
  Procedure Add(p Hashmap) is
    r_Row Clr_Diseases%rowtype;
  begin
    z_Clr_Diseases.To_Row(r_Row, p, z.Name, z.Note, z.State);
  
    r_Row.Company_Id := Ui.Company_Id;
    r_Row.Disease_Id := Clr_Next.Disease_Id;
  
    Clr_Api.Disease_Save(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Edit(p Hashmap) is
    r_Row Clr_Diseases%rowtype;
  begin
    r_Row := z_Clr_Diseases.Lock_Load(i_Company_Id => Ui.Company_Id,
                                      i_Disease_Id => p.r_Number('disease_id'));
  
    z_Clr_Diseases.To_Row(r_Row, p, z.Name, z.Note, z.State);
  
    Clr_Api.Disease_Save(r_Row);
  end;

end Ui_Clinic4;
/
