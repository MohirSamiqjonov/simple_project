create or replace package Ui_Clinic9 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/drug
  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap;
  ---------------------------------------------------------------------------------------------------- 
  Procedure Add(p Hashmap);
  ----------------------------------------------------------------------------------------------------
  Procedure Edit(p Hashmap);
end Ui_Clinic9;
/
create or replace package body Ui_Clinic9 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/drug
  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap is
  begin
    return Fazo.Zip_Map('dosage_form', Clr_Pref.c_Df_Table);
  end;

  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap is
    r_Row  Clr_Drugs%rowtype;
    result Hashmap;
  begin
    r_Row := z_Clr_Drugs.Lock_Load(i_Company_Id => Ui.Company_Id,
                                   i_Drug_Id    => p.r_Number('drug_id'));
  
    result := z_Clr_Drugs.To_Map(r_Row, z.Drug_Id, z.Name, z.Dosage_Form);
  
    return result;
  end;

  ---------------------------------------------------------------------------------------------------- 
  Procedure Add(p Hashmap) is
    r_Row Clr_Drugs%rowtype;
  begin
    r_Row.Company_Id := Ui.Company_Id;
    r_Row.Drug_Id := Clr_Next.Drug_Id;
  
    z_Clr_Drugs.To_Row(r_Row, p, z.Name, z.Dosage_Form);
  
    Clr_Api.Drug_Save(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Edit(p Hashmap) is
    r_Row Clr_Drugs%rowtype;
  begin
    r_Row := z_Clr_Drugs.Lock_Load(i_Company_Id => Ui.Company_Id,
                                   i_Drug_Id    => p.r_Number('drug_id'));
  
    z_Clr_Drugs.To_Row(r_Row, p, z.Name, z.Dosage_Form);
  
    Clr_Api.Drug_Save(r_Row);
  end;

end Ui_Clinic9;
/
