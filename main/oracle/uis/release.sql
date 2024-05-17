set define off
set serveroutput on
declare
v_project_code varchar2(10) := 'clinic';
--------------------------------------------------
procedure form(a varchar2, b varchar2) is begin
z_md_release_forms.save_one(i_PROJECT_CODE=>v_project_code,i_FORM=>a,i_ACTION_SET=>b);end;
--------------------------------------------------
procedure garbage(a varchar2) is begin
z_md_garbage_forms.insert_try(i_PROJECT_CODE=>v_project_code,i_FORM=>a);end;
begin
delete md_release_forms t where t.project_code = v_project_code;
delete md_garbage_forms t where t.project_code = v_project_code;
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Release forms ====');
form('/clinic/cla/patient_medical_history+add','.model.save.');
form('/clinic/cla/patient_medical_history+edit','.model.save.');
form('/clinic/cla/patient_medical_history_list','.add.add_visit.delete.edit.model.open_visits.');
form('/clinic/cla/pharmacy','.get_drugs.model.save.');
form('/clinic/cla/visit+add','.model.save.');
form('/clinic/cla/visit+edit','.model.save.');
form('/clinic/cla/visit_list','.add.delete.edit.model.view.');
form('/clinic/cla/visit_view','.edit.model.');
form('/clinic/clr/clinic+add','.model.save.');
form('/clinic/clr/clinic+edit','.model.save.');
form('/clinic/clr/clinic_list','.add.delete.edit.model.');
form('/clinic/clr/disease+add','.model.save.');
form('/clinic/clr/disease+edit','.model.save.');
form('/clinic/clr/disease_list','.add.delete.edit.model.');
form('/clinic/clr/drug+add','.model.save.');
form('/clinic/clr/drug+edit','.model.save.');
form('/clinic/clr/drug_list','.add.delete.edit.model.');
form('/clinic/intro/dashboard','.model.');
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Garbages ====');
commit;
end;
/
