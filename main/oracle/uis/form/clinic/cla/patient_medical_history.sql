set define off
prompt PATH /clinic/cla/patient_medical_history
begin
uis.route('/clinic/cla/patient_medical_history+add$save','Ui_Clinic1.Add','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/cla/patient_medical_history+add:model','Ui_Clinic1.Add_Model',null,'M','A','Y',null,null,null,'S');
uis.route('/clinic/cla/patient_medical_history:model','Ui_Clinic1.Model','M','M','A','Y',null,null,null,'S');

uis.path('/clinic/cla/patient_medical_history','clinic1');
uis.form('/clinic/cla/patient_medical_history+add','/clinic/cla/patient_medical_history','A','A','F','HM','M','N',null,'N','S');



uis.action('/clinic/cla/patient_medical_history+add','save','A',null,null,'A');


uis.ready('/clinic/cla/patient_medical_history+add','.model.save.');

commit;
end;
/
