create or replace package Ui_Clinic7 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/clinic_list
  ----------------------------------------------------------------------------------------------------
  Function Query return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Procedure Del(p Hashmap);
end Ui_Clinic7;
/
create or replace package body Ui_Clinic7 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/clinic_list
  ----------------------------------------------------------------------------------------------------
  Function Query return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('select w.* 
                       from clr_clinics w 
                      where w.company_id = :company_id',
                    Fazo.Zip_Map('company_id',
                                 Ui.Company_Id,
                                 'uz_region_id',
                                 Clr_Pref.c_Uz_Region_Id));
  
    q.Number_Field('clinic_id', 'region_id', 'created_by', 'modified_by');
  
    q.Varchar2_Field('name', 'state');
  
    q.Date_Field('created_on', 'modified_on');
  
    q.Option_Field('state_name',
                   'state',
                   Array_Varchar2('A', 'P'),
                   Array_Varchar2(Ui.t_Active, Ui.t_Passive));
  
    q.Refer_Field('region_name',
                  'region_id',
                  'md_regions',
                  'region_id',
                  'name',
                  'select *
                     from md_regions w
                    where w.company_id = :company_id
                      and connect_by_isleaf = 1
                     start with w.region_id = :uz_region_id
                   connect by w.company_id = prior w.company_id
                       and w.parent_id = prior w.region_id');
  
    q.Refer_Field('created_by_name',
                  'created_by',
                  'md_users',
                  'user_id',
                  'name',
                  'select * 
                     from md_users w 
                    where w.company_id = :company_id');
  
    q.Refer_Field('modified_by_name',
                  'modified_by',
                  'md_users',
                  'user_id',
                  'name',
                  'select * 
                     from md_users w 
                    where w.company_id = :company_id');
    return q;
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Del(p Hashmap) is
    v_Ids Array_Number := p.r_Array_Number('clinic_id');
  begin
    for i in 1 .. v_Ids.Count
    loop
      Clr_Api.Clinic_Delete(i_Company_Id => Ui.Company_Id, i_Clinic_Id => v_Ids(i));
    end loop;
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Validation is
  begin
    update Clr_Clinics
       set Company_Id  = null,
           Clinic_Id   = null,
           name        = null,
           Region_Id   = null,
           State       = null,
           Created_By  = null,
           Created_On  = null,
           Modified_By = null,
           Modified_On = null;
    update Md_Regions
       set Company_Id = null,
           Region_Id  = null,
           name       = null,
           Parent_Id  = null;
    update Md_Users
       set Company_Id = null,
           User_Id    = null,
           name       = null;
  end;

end Ui_Clinic7;
/
