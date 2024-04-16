set define off
prompt PATH /clinic/cla/visit_list
begin
uis.route('/clinic/cla/visit_list$delete','Ui_Clinic12.Del','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/cla/visit_list:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S');
uis.route('/clinic/cla/visit_list:table','Ui_Clinic12.Query',null,'Q','A',null,null,null,null,'S');

uis.path('/clinic/cla/visit_list','clinic12');
uis.form('/clinic/cla/visit_list','/clinic/cla/visit_list','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/cla/visit_list','add','A','/clinic/cla/visit+add','S','O');
uis.action('/clinic/cla/visit_list','delete','A',null,null,'A');
uis.action('/clinic/cla/visit_list','edit','A','/clinic/cla/visit+edit','S','O');
uis.action('/clinic/cla/visit_list','view','A','/clinic/cla/visit_view','S','O');

uis.form_sibling('clinic','/clinic/cla/visit_list','/clinic/cla/patient_medical_history_list',1);

uis.ready('/clinic/cla/visit_list','.add.delete.edit.model.view.');

commit;
end;
/
