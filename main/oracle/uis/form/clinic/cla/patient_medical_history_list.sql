set define off
prompt PATH /clinic/cla/patient_medical_history_list
begin
uis.route('/clinic/cla/patient_medical_history_list$delete','Ui_Clinic3.Del','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/cla/patient_medical_history_list:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S');
uis.route('/clinic/cla/patient_medical_history_list:table','Ui_Clinic3.Query',null,'Q','A',null,null,null,null,'S');

uis.path('/clinic/cla/patient_medical_history_list','clinic3');
uis.form('/clinic/cla/patient_medical_history_list','/clinic/cla/patient_medical_history_list','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/cla/patient_medical_history_list','add','A','/clinic/cla/patient_medical_history+add','S','O');
uis.action('/clinic/cla/patient_medical_history_list','add_visit','A','/clinic/cla/visit+add','S','O');
uis.action('/clinic/cla/patient_medical_history_list','delete','A',null,null,'A');
uis.action('/clinic/cla/patient_medical_history_list','edit','A','/clinic/cla/patient_medical_history+edit','S','O');
uis.action('/clinic/cla/patient_medical_history_list','open_visits','A','/clinic/cla/visit_list','S','O');


uis.ready('/clinic/cla/patient_medical_history_list','.add.add_visit.delete.edit.model.open_visits.');

commit;
end;
/
