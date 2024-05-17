create or replace package Cla_Audit is
  ----------------------------------------------------------------------------------------------------
  Procedure Patient_Medical_History_Start(i_Company_Id number);
  ----------------------------------------------------------------------------------------------------
  Procedure Patient_Medical_History_Stop(i_Company_Id number);
  ----------------------------------------------------------------------------------------------------
  Procedure Visit_Start(i_Company_Id number);
  ----------------------------------------------------------------------------------------------------
  Procedure Visit_Stop(i_Company_Id number);
end Cla_Audit;
/
create or replace package body Cla_Audit is
  ----------------------------------------------------------------------------------------------------
  Procedure Patient_Medical_History_Start(i_Company_Id number) is
  begin
    Md_Api.Audit_Start_One(i_Company_Id  => i_Company_Id,
                           i_Table_Name  => 'CLA_PATIENT_MEDICAL_HISTORIES',
                           i_Column_List => 'PATIENT_MEDICAL_HISTORY_ID,PATIENT_MEDICAL_HISTORY_NUMBER,LAST_NAME,FIRST_NAME,PATRONYMIC,PASSPORT_NUMBER,BIRTH_DATE,GENDER,CLINIC_ID,PHONE,HEIGHT,WEIGHT,ADDRESS,JOB,CREATED_BY,CREATED_ON');
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Patient_Medical_History_Stop(i_Company_Id number) is
  begin
    Md_Api.Audit_Stop_One(i_Company_Id => i_Company_Id,
                          i_Table_Name => 'CLA_PATIENT_MEDICAL_HISTORIES');
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Visit_Start(i_Company_Id number) is
  begin
    Md_Api.Audit_Start_One(i_Company_Id  => i_Company_Id,
                           i_Table_Name  => 'CLA_VISITS',
                           i_Column_List => 'VISIT_ID,PATIENT_MEDICAL_HISTORY_ID,VISIT_DATE,NOTE,CREATED_BY,CREATED_ON');
  
    Md_Api.Audit_Start_One(i_Company_Id  => i_Company_Id,
                           i_Table_Name  => 'CLA_DISEASES',
                           i_Column_List => 'DISEASE_ID,VISIT_ID,NOTE,CREATED_BY,CREATED_ON',
                           i_Parent_Name => 'CLA_VISITS');
  
    Md_Api.Audit_Start_One(i_Company_Id  => i_Company_Id,
                           i_Table_Name  => 'CLA_DRUGS',
                           i_Column_List => 'DRUG_ID,VISIT_ID,REQUIRED_COUNT_MEDICINE,SOLD_COUNT_MEDICINE,NOTE,CREATED_BY,CREATED_ON',
                           i_Parent_Name => 'CLA_VISITS');
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Visit_Stop(i_Company_Id number) is
  begin
    Md_Api.Audit_Stop_One(i_Company_Id => i_Company_Id, i_Table_Name => 'CLA_VISITS');
  
    Md_Api.Audit_Stop_One(i_Company_Id => i_Company_Id, i_Table_Name => 'CLA_DISEASES');
  
    Md_Api.Audit_Stop_One(i_Company_Id => i_Company_Id, i_Table_Name => 'CLA_DRUGS');
  end;

end Cla_Audit;
/
