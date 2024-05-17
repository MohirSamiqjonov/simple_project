create or replace package Clr_Audit is
  ---------------------------------------------------------------------------------------------------- 
  Procedure Audit_Start(i_Company_Id number);
  ----------------------------------------------------------------------------------------------------
  Procedure Audit_Stop(i_Company_Id number);
end Clr_Audit;
/
create or replace package body Clr_Audit is
  ---------------------------------------------------------------------------------------------------- 
  Procedure Audit_Start(i_Company_Id number) is
  begin
    Md_Api.Audit_Start_One(i_Company_Id  => i_Company_Id,
                           i_Table_Name  => 'CLR_DISEASES',
                           i_Column_List => 'DISEASE_ID,NAME,NOTE,STATE,CREATED_BY,CREATED_ON');
  
    Md_Api.Audit_Start_One(i_Company_Id  => i_Company_Id,
                           i_Table_Name  => 'CLR_CLINICS',
                           i_Column_List => 'CLINIC_ID,NAME,REGION_ID,STATE,CREATED_BY,CREATED_ON');
  
    Md_Api.Audit_Start_One(i_Company_Id  => i_Company_Id,
                           i_Table_Name  => 'CLR_DRUGS',
                           i_Column_List => 'DRUG_ID,NAME,DOSAGE_FORM,CREATED_BY,CREATED_ON');
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Audit_Stop(i_Company_Id number) is
    v_Tables Array_Varchar2 := Array_Varchar2('CLR_DISEASES,CLR_CLINICS,CLR_DRUGS');
  begin
    for i in 1 .. v_Tables.Count
    loop
      Md_Api.Audit_Stop_One(i_Company_Id => i_Company_Id, i_Table_Name => v_Tables(i));
    end loop;
  end;
  
end Clr_Audit;
/
