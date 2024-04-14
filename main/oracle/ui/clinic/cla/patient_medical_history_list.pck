create or replace package Ui_Clinic3 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/patient_medical_history_list
  ----------------------------------------------------------------------------------------------------
  Function Query return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Procedure Del(p Hashmap);
end Ui_Clinic3;
/
create or replace package body Ui_Clinic3 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/patient_medical_history_list
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
    return b.Translate('UI-CLINIC3:' || i_Message, i_P1, i_P2, i_P3, i_P4, i_P5);
  end;

  ----------------------------------------------------------------------------------------------------
  Function Query return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('cla_patient_medical_histories',
                    Fazo.Zip_Map('company_id', Ui.Company_Id),
                    true);
  
    q.Number_Field('patient_medical_history_id', 'height', 'weight', 'created_by', 'modified_by');
  
    q.Varchar2_Field('patient_medical_history_number',
                     'last_name',
                     'first_name',
                     'patronymic',
                     'passport_number',
                     'gender',
                     'phone');
  
    q.Date_Field('birth_date', 'created_on', 'modified_on');
  
    q.Option_Field('gender_name',
                   'gender',
                   Array_Varchar2(Cla_Pref.c_Gender_Male, Cla_Pref.c_Gender_Female),
                   Array_Varchar2(t('gender: male'), --
                                  t('gender: female')));
  
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
    v_Ids Array_Number := p.r_Array_Number('patient_medical_history_id');
  begin
    for i in 1 .. v_Ids.Count
    loop
      Cla_Api.Patient_Medical_History_Delete(i_Company_Id                 => Ui.Company_Id,
                                             i_Patient_Medical_History_Id => v_Ids(i));
    end loop;
    
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Validation is
  begin
    update Cla_Patient_Medical_Histories
       set Company_Id                     = null,
           Patient_Medical_History_Id     = null,
           Patient_Medical_History_Number = null,
           Last_Name                      = null,
           First_Name                     = null,
           Patronymic                     = null,
           Passport_Number                = null,
           Birth_Date                     = null,
           Gender                         = null,
           Clinic_Id                      = null,
           Phone                          = null,
           Height                         = null,
           Weight                         = null,
           Created_By                     = null,
           Created_On                     = null,
           Modified_By                    = null,
           Modified_On                    = null;
    update Md_Users
       set Company_Id = null,
           User_Id    = null,
           name       = null;  
  end;

end Ui_Clinic3;
/
