create or replace package Ui_Clinic13 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/visit_view
  ----------------------------------------------------------------------------------------------------
  Function Query_Diseases(p Hashmap) return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Function Query_Drugs(p Hashmap) return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Function Model(p Hashmap) return Hashmap;
end Ui_Clinic13;
/
create or replace package body Ui_Clinic13 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/visit_view
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
    return b.Translate('UI-CLINIC13:' || i_Message, i_P1, i_P2, i_P3, i_P4, i_P5);
  end;

  ---------------------------------------------------------------------------------------------------- 
  Function Query_Diseases(p Hashmap) return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('cla_diseases',
                    Fazo.Zip_Map('company_id', Ui.Company_Id, 'visit_id', p.r_Number('visit_id')),
                    true);
  
    q.Number_Field('disease_id', 'created_by', 'modified_by');
  
    q.Varchar2_Field('note');
  
    q.Date_Field('created_on', 'modified_on');
  
    q.Refer_Field('disease_name',
                  'disease_id',
                  'clr_diseases',
                  'disease_id',
                  'name',
                  'select *
                     from clr_diseases w
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
  Function Query_Drugs(p Hashmap) return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('cla_drugs',
                    Fazo.Zip_Map('company_id', Ui.Company_Id, 'visit_id', p.r_Number('visit_id')),
                    true);
  
    q.Number_Field('drug_id',
                   'required_count_medicine',
                   'sold_count_medicine',
                   'created_by',
                   'modified_by');
  
    q.Varchar2_Field('note');
  
    q.Date_Field('created_on', 'modified_on');
  
    q.Refer_Field('drug_name',
                  'drug_id',
                  'clr_drugs',
                  'drug_id',
                  'name',
                  'select *
                     from clr_drugs w
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
  Function Model(p Hashmap) return Hashmap is
    v_Company_Id      number := Ui.Company_Id;
    r_Visit           Cla_Visits%rowtype;
    r_Patient_History Cla_Patient_Medical_Histories%rowtype;
    result            Hashmap := Hashmap;
  begin
    r_Visit := z_Cla_Visits.Load(i_Company_Id => v_Company_Id, i_Visit_Id => p.r_Number('visit_id'));
  
    Result.Put_All(z_Cla_Visits.To_Map(r_Visit,
                                       z.Visit_Id,
                                       z.Patient_Medical_History_Id,
                                       z.Visit_Date,
                                       z.Note,
                                       z.Created_On,
                                       z.Modified_On));
    Result.Put('created_by_name',
               z_Md_Users.Load(i_Company_Id => v_Company_Id, i_User_Id => r_Visit.Created_By).Name);
    Result.Put('modified_by_name',
               z_Md_Users.Load(i_Company_Id => v_Company_Id, i_User_Id => r_Visit.Modified_By).Name);
  
    r_Patient_History := z_Cla_Patient_Medical_Histories.Load(i_Company_Id                 => v_Company_Id,
                                                              i_Patient_Medical_History_Id => r_Visit.Patient_Medical_History_Id);
  
    Result.Put_All(z_Cla_Patient_Medical_Histories.To_Map(r_Patient_History,
                                                          z.Patient_Medical_History_Number,
                                                          z.Last_Name,
                                                          z.First_Name,
                                                          z.Patronymic));
  
    Result.Put('age', to_char(sysdate, 'YYYY') - to_char(r_Patient_History.Birth_Date, 'YYYY'));
    Result.Put('gender_name',
               Md_Util.Decode(r_Patient_History.Gender,
                              Cla_Pref.c_Gender_Male,
                              t('gender: male'),
                              Cla_Pref.c_Gender_Female,
                              t('gender: female')));
    return result;
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Validation is
  begin
    update Cla_Diseases
       set Company_Id  = null,
           Disease_Id  = null,
           Visit_Id    = null,
           Note        = null,
           Created_By  = null,
           Created_On  = null,
           Modified_By = null,
           Modified_On = null;
    update Cla_Drugs
       set Company_Id              = null,
           Drug_Id                 = null,
           Visit_Id                = null,
           Required_Count_Medicine = null,
           Sold_Count_Medicine     = null,
           Note                    = null,
           Created_By              = null,
           Created_On              = null,
           Modified_By             = null,
           Modified_On             = null;
  end;

end Ui_Clinic13;
/
