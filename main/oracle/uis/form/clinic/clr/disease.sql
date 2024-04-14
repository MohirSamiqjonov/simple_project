set define off
prompt PATH /clinic/clr/disease
begin
uis.route('/clinic/clr/disease+add$save','Ui_Clinic4.Add','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/clr/disease+add:model','Ui_Clinic4.Add_Model',null,'M','A','Y',null,null,null,'S');
uis.route('/clinic/clr/disease+edit$save','Ui_Clinic4.Edit','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/clr/disease+edit:model','Ui_Clinic4.Edit_Model','M','M','A','Y',null,null,null,'S');

uis.path('/clinic/clr/disease','clinic4');
uis.form('/clinic/clr/disease+add','/clinic/clr/disease','A','A','F','H','M','N',null,'N','S');
uis.form('/clinic/clr/disease+edit','/clinic/clr/disease','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/clr/disease+add','save','A',null,null,'G');
uis.action('/clinic/clr/disease+edit','save','A',null,null,'A');


uis.ready('/clinic/clr/disease+add','.model.save.');
uis.ready('/clinic/clr/disease+edit','.model.save.');

commit;
end;
/
