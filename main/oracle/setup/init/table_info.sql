prompt clinic table info
declare
  v_Project_Code varchar2(10) := Clinic.Project_Code;
  --------------------------------------------------
  Procedure Table_Info
  (
    Table_Name          varchar2,
    Field_Id            varchar2,
    Field_Name          varchar2,
    Translate_Procedure varchar2,
    Uri                 varchar2,
    Uri_Procedure       varchar2,
    View_Kind           varchar2
  ) is
  begin
    z_Md_Table_Infos.Insert_One(i_Table_Name          => Table_Name,
                                i_Project_Code        => v_Project_Code,
                                i_Field_Id            => Field_Id,
                                i_Field_Name          => Field_Name,
                                i_Translate_Procedure => Translate_Procedure,
                                i_Uri                 => Uri,
                                i_Uri_Procedure       => Uri_Procedure,
                                i_View_Kind           => View_Kind);
  end;
begin
  delete Md_Table_Infos t
   where t.Project_Code = v_Project_Code;

  ---- CLR ----
  Table_Info('CLR_DISEASES', 'DISEASE_ID', 'NAME', '', '', '', 'O');
  Table_Info('CLR_CLINICS', 'CLINIC_ID', 'NAME', '', '', '', 'O');
  Table_Info('CLR_DRUGS', 'DRUG_ID ', 'NAME', '', '', '', 'O');
  ---- CLA ----
  Table_Info('CLA_PATIENT_MEDICAL_HISTORIES', 'PATIENT_MEDICAL_HISTORY_ID', 'PATIENT_MEDICAL_HISTORY_NUMBER', '', '', '', 'O');
  Table_Info('CLA_VISITS', 'VISIT_ID', 'VISIT_ID', '', '', '', 'O');
  Table_Info('CLA_DISEASES', 'DISEASE_ID', 'DISEASE_ID', '', '', '', 'O');
  Table_Info('CLA_DRUGS', 'DRUG_ID', 'DRUG_ID', '', '', '', 'O');
  commit;
end;
/
