prompt clinic audit info
declare
  -------------------------------
  Procedure Audit_Info
  (
    Table_Name      varchar2,
    Readonly        varchar2,
    Parent_Name     varchar2,
    Start_Procedure varchar2,
    Stop_Procedure  varchar2,
    Uri             varchar2
  ) is
  begin
    z_Md_Audit_Infos.Insert_One(i_Table_Name      => Table_Name,
                                i_Readonly        => Readonly,
                                i_Parent_Name     => Parent_Name,
                                i_Start_Procedure => Start_Procedure,
                                i_Stop_Procedure  => Stop_Procedure,
                                i_Uri             => Uri);
  end;
begin
  delete Md_Audit_Infos t
   where Regexp_Like(t.Table_Name, '^(CLR|CLA)_');
  
  Audit_Info('CLR_DISEASES', 'N', null, 'CLR_AUDIT.AUDIT_START', 'CLR_AUDIT.AUDIT_STOP', '');
  Audit_Info('CLR_CLINICS', 'N', null, 'CLR_AUDIT.AUDIT_START', 'CLR_AUDIT.AUDIT_STOP', '');
  Audit_Info('CLR_DRUGS', 'N', null, 'CLR_AUDIT.AUDIT_START', 'CLR_AUDIT.AUDIT_STOP', '');
  Audit_Info('CLA_PATIENT_MEDICAL_HISTORIES', 'N', null, 'CLA_AUDIT.PATIENT_MEDICAL_HISTORY_START', 'CLA_AUDIT.PATIENT_MEDICAL_HISTORY_STOP', '');
  Audit_Info('CLA_VISITS', 'N', null, 'CLA_AUDIT.VISIT_START', 'CLA_AUDIT.VISIT_STOP', '');
  commit;
end;
/
