set define off
prompt PATH /clinic/cla/visit
begin
uis.route('/clinic/cla/visit+add$save','Ui_Clinic10.Add','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/cla/visit+add:diseases','Ui_Clinic10.Query_Diseases',null,'Q','A',null,null,null,null,'S');
uis.route('/clinic/cla/visit+add:drugs','Ui_Clinic10.Query_Drugs',null,'Q','A',null,null,null,null,'S');
uis.route('/clinic/cla/visit+add:model','Ui_Clinic10.Add_Model','M','M','A','Y',null,null,null,'S');
uis.route('/clinic/cla/visit+add:patient_medical_histories','Ui_Clinic10.Query_Patient_Medical_Histories',null,'Q','A',null,null,null,null,'S');
uis.route('/clinic/cla/visit+edit$save','Ui_Clinic10.Edit','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/cla/visit+edit:diseases','Ui_Clinic10.Query_Diseases',null,'Q','A',null,null,null,null,'S');
uis.route('/clinic/cla/visit+edit:drugs','Ui_Clinic10.Query_Drugs',null,'Q','A',null,null,null,null,'S');
uis.route('/clinic/cla/visit+edit:model','Ui_Clinic10.Edit_Model','M','M','A','Y',null,null,null,'S');
uis.route('/clinic/cla/visit+edit:patient_medical_histories','Ui_Clinic10.Query_Patient_Medical_Histories',null,'Q','A',null,null,null,null,'S');

uis.path('/clinic/cla/visit','clinic10');
uis.form('/clinic/cla/visit+add','/clinic/cla/visit','A','A','F','H','M','N',null,'N','S');
uis.form('/clinic/cla/visit+edit','/clinic/cla/visit','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/cla/visit+add','save','A',null,null,'A');
uis.action('/clinic/cla/visit+edit','save','A',null,null,'A');


uis.ready('/clinic/cla/visit+edit','.model.save.');
uis.ready('/clinic/cla/visit+add','.model.save.');

commit;
end;
/
