create or replace package Ui_Clinic14 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/drug_list
  ----------------------------------------------------------------------------------------------------
  Function Query return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Procedure Del(p Hashmap);
end Ui_Clinic14;
/
create or replace package body Ui_Clinic14 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/clr/drug_list
  ----------------------------------------------------------------------------------------------------
  Function t
  (
    i_Message varchar2,
    i_P1      varchar2 := null,
    i_P2      varchar2 := null,
    i_P3      varchar2 := null,
    i_P4      varchar2 := null,
    i_P5      varchar2 := null
  ) return varchar2 is
  begin
    return b.Translate('UI-CLINIC14:' || i_Message, i_P1, i_P2, i_P3, i_P4, i_P5);
  end;
  
  ----------------------------------------------------------------------------------------------------
  Function Query return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('clr_drugs', Fazo.Zip_Map('company_id', Ui.Company_Id), true);
  
    q.Number_Field('drug_id', 'created_by', 'modified_by');
    q.Varchar2_Field('name', 'dosage_form');
    q.Date_Field('created_on', 'modified_on');
  
    q.Option_Field('dosage_form_name',
                   'dosage_form',
                   Array_Varchar2(Clr_Pref.c_Df_Table, Clr_Pref.c_Df_Capsule, Clr_Pref.c_Df_Syrup),
                   Array_Varchar2(t('dosage form: tablet'),
                                  t('dosage form: capsule'),
                                  t('dosage form: syrup')));
  
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
    v_Ids Array_Number := p.r_Array_Number('drug_id');
  begin
    for i in 1 .. v_Ids.Count
    loop
      Clr_Api.Drug_Delete(i_Company_Id => Ui.Company_Id, i_Drug_Id => v_Ids(i));
    end loop;
  
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Validation is
  begin
    update Clr_Drugs
       set Company_Id  = null,
           Drug_Id     = null,
           name        = null,
           Dosage_Form = null,
           Created_By  = null,
           Created_On  = null,
           Modified_By = null,
           Modified_On = null;
    update Md_Users
       set Company_Id = null,
           User_Id    = null,
           name       = null;
  end;

end Ui_Clinic14;
/
