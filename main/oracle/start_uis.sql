set define off;
prompt ==== **start UIS** =====
begin uis.clear_form_translations('clinic'); uis.clear_form_siblings('clinic'); commit; end;
/
@@uis\form\clinic\cla\patient_medical_history.sql;
@@uis\form\clinic\cla\patient_medical_history_list.sql;
@@uis\form\clinic\cla\pharmacy.sql;
@@uis\form\clinic\cla\visit.sql;
@@uis\form\clinic\cla\visit_list.sql;
@@uis\form\clinic\cla\visit_view.sql;
@@uis\form\clinic\clr\clinic.sql;
@@uis\form\clinic\clr\clinic_list.sql;
@@uis\form\clinic\clr\disease.sql;
@@uis\form\clinic\clr\disease_list.sql;
@@uis\form\clinic\clr\drug.sql;
@@uis\form\clinic\clr\drug_list.sql;
@@uis\form\clinic\intro\dashboard.sql;
@@uis\form\company_head_form.sql;
@@uis\form\license_form.sql;
@@uis\form\menu.sql;
@@uis\form\module.sql;
@@uis\form\non_subscription_form.sql;
@@uis\form\quickstart.sql;
@@uis\form\tape.sql;
@@uis\form\translate_code.sql;
