set define off
declare
begin
delete md_modules t where t.project_code = 'clinic';
delete md_module_forms t where t.project_code = 'clinic';
delete md_module_dependencies t where t.project_code = 'clinic';
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Modules ====');
uis.module('clinic','cla','cla','Y');
uis.module('clinic','clr','clr','Y');
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Module forms ====');
uis.module_form('clinic','cla','/clinic/cla/patient_medical_history+add');
uis.module_form('clinic','cla','/clinic/cla/patient_medical_history+edit');
uis.module_form('clinic','cla','/clinic/cla/patient_medical_history_list');
uis.module_form('clinic','cla','/clinic/cla/pharmacy');
uis.module_form('clinic','cla','/clinic/cla/visit+add');
uis.module_form('clinic','cla','/clinic/cla/visit+edit');
uis.module_form('clinic','cla','/clinic/cla/visit_list');
uis.module_form('clinic','cla','/clinic/cla/visit_view');
uis.module_form('clinic','cla','/clinic/intro/dashboard');
uis.module_form('clinic','clr','/clinic/clr/clinic+add');
uis.module_form('clinic','clr','/clinic/clr/clinic+edit');
uis.module_form('clinic','clr','/clinic/clr/clinic_list');
uis.module_form('clinic','clr','/clinic/clr/disease+add');
uis.module_form('clinic','clr','/clinic/clr/disease+edit');
uis.module_form('clinic','clr','/clinic/clr/disease_list');
uis.module_form('clinic','clr','/clinic/clr/drug+add');
uis.module_form('clinic','clr','/clinic/clr/drug+edit');
uis.module_form('clinic','clr','/clinic/clr/drug_list');
uis.module_form('clinic','clr','/clinic/intro/dashboard');
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Module Dependencies ====');
commit;
end;
/
