create or replace package Ui_Clinic12 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/visit_list
  ----------------------------------------------------------------------------------------------------
  Function Query return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Procedure Del(p Hashmap);
end Ui_Clinic12;
/
create or replace package body Ui_Clinic12 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/visit_list
  ----------------------------------------------------------------------------------------------------
  Function Query return Fazo_Query is
    q Fazo_Query;
  begin
  
    q := Fazo_Query('cla_visits', Fazo.Zip_Map('company_id', Ui.Company_Id), true);
  
    q.Number_Field('visit_id', 'patient_medical_history_id', 'created_by', 'modified_by');
    q.Varchar2_Field('note');
    q.Date_Field('visit_date', 'created_on', 'modified_on');
  
    q.Multi_Number_Field('drug_ids', 'cla_drugs', '@visit_id = $visit_id', 'drug_id');
    q.Multi_Number_Field('disease_ids', 'cla_diseases', '@visit_id = $visit_id', 'disease_id');
  
    q.Refer_Field('drug_names',
                  'drug_ids',
                  'clr_drugs',
                  'drug_id',
                  'name',
                  'select *
                     from clr_drugs w
                    where w.company_id = :company_id');
  
    q.Refer_Field('disease_names',
                  'disease_ids',
                  'clr_diseases',
                  'disease_id',
                  'name',
                  'select *
                     from clr_diseases w
                    where w.company_id = :company_id');
  
    q.Refer_Field('patient_medical_history_number',
                  'patient_medical_history_id',
                  'cla_patient_medical_histories',
                  'patient_medical_history_id',
                  'patient_medical_history_number',
                  'select *
                     from cla_patient_medical_histories w
                    where w.company_id = :company_id');
  
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
    v_Ids Array_Number := p.r_Array_Number('visit_id');
  begin
    for i in 1 .. v_Ids.Count
    loop
      Cla_Api.Visit_Delete(i_Company_Id => Ui.Company_Id, i_Visit_Id => v_Ids(i));
    end loop;
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Validation is
  begin
    update Cla_Visits
       set Company_Id                 = null,
           Visit_Id                   = null,
           Patient_Medical_History_Id = null,
           Visit_Date                 = null,
           Note                       = null,
           Created_By                 = null,
           Created_On                 = null,
           Modified_By                = null,
           Modified_On                = null;
    update Cla_Drugs
       set Drug_Id = null;
    update Cla_Diseases
       set Disease_Id = null;
    update Clr_Drugs
       set Company_Id = null,
           Drug_Id    = null,
           name       = null;
    update Clr_Diseases
       set Company_Id = null,
           Disease_Id = null,
           name       = null;
    update Cla_Patient_Medical_Histories
       set Company_Id                     = null,
           Patient_Medical_History_Id     = null,
           Patient_Medical_History_Number = null;
    update Md_Users
       set Company_Id = null,
           User_Id    = null,
           name       = null; 
  end;

end Ui_Clinic12;
/
