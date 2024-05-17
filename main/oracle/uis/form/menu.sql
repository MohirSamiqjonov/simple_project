set define off
declare
begin
delete md_menus t where t.project_code = 'clinic';
delete md_menu_forms t where t.project_code = 'clinic';
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Menus ====');
uis.menu('clinic',1,'applications',null,'2');
uis.menu('clinic',3,'reference',null,'3');
uis.menu('clinic',5,'admin',null,'1');
uis.menu('clinic',2,'patient_medical_history','1',null);
uis.menu('clinic',4,'clr','3',null);
uis.menu('clinic',6,'general','5',null);
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Menu forms ====');
uis.menu_form('clinic',2,'/clinic/cla/patient_medical_history_list',1,'/clinic/cla/patient_medical_history+add');
uis.menu_form('clinic',2,'/clinic/cla/pharmacy',3,null);
uis.menu_form('clinic',2,'/clinic/cla/visit_list',2,'/clinic/cla/visit+add');
uis.menu_form('clinic',4,'/clinic/clr/clinic_list',2,'/clinic/clr/clinic+add');
uis.menu_form('clinic',4,'/clinic/clr/disease_list',1,'/clinic/clr/disease+add');
uis.menu_form('clinic',4,'/clinic/clr/drug_list',3,'/clinic/clr/drug+add');
uis.menu_form('clinic',6,'/core/md/company_list',1,'/core/md/company_add');
uis.menu_form('clinic',6,'/core/md/filial_list',2,'/core/md/filial+add');
commit;
end;
/
