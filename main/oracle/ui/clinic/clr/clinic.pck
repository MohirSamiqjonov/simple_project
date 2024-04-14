create or replace package Ui_Clinic5 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/clinic
  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Procedure Add(p Hashmap);
  ----------------------------------------------------------------------------------------------------
  Procedure Edit(p Hashmap);
  ----------------------------------------------------------------------------------------------------
  Function Load_Regions return Arraylist;
end Ui_Clinic5;
/
create or replace package body Ui_Clinic5 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/clinic
  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap is
    result Hashmap := Hashmap;
  begin
    Result.Put('regions', Load_Regions);
    Result.Put('state', 'A');
  
    return result;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap is
    r_Row  Clr_Clinics%rowtype;
    result Hashmap;
  begin
    r_Row := z_Clr_Clinics.Load(i_Company_Id => Ui.Company_Id,
                                i_Clinic_Id  => p.r_Number('clinic_id'));
  
    result := z_Clr_Clinics.To_Map(r_Row, z.Clinic_Id, z.Name, z.Region_Id, z.State);
  
    Result.Put('regions', Load_Regions);
  
    return result;
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Add(p Hashmap) is
    r_Row Clr_Clinics%rowtype;
  begin
    r_Row.Company_Id := Ui.Company_Id;
    r_Row.Clinic_Id  := Clr_Next.Clinic_Id;
  
    z_Clr_Clinics.To_Row(r_Row, p, z.Name, z.Region_Id, z.State);
  
    Clr_Api.Clinic_Save(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Edit(p Hashmap) is
    r_Row Clr_Clinics%rowtype;
  begin
    r_Row := z_Clr_Clinics.Lock_Load(i_Company_Id => Ui.Company_Id,
                                     i_Clinic_Id  => p.r_Number('clinic_id'));
  
    z_Clr_Clinics.To_Row(r_Row, p, z.Name, z.Region_Id, z.State);
  
    Clr_Api.Clinic_Save(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Function Load_Regions return Arraylist is
    result Arraylist := Arraylist;
  begin
    for r in (select *
                from Md_Regions w
               where w.Company_Id = Ui.Company_Id
               start with w.Region_Id = Clr_Pref.c_Uz_Region_Id
              connect by w.Parent_Id = prior w.Region_Id)
    loop
      Result.Push(Fazo.Zip_Map('region_id', r.Region_Id, 'parent_id', r.Parent_Id, 'name', r.Name));
    end loop;
  
    return result;
  end;

end Ui_Clinic5;
/
