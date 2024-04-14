set define off
prompt PATH /clinic/clr/drug
begin
uis.route('/clinic/clr/drug+add$save','Ui_Clinic9.Add','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/clr/drug+add:model','Ui_Clinic9.Add_Model',null,'M','A','Y',null,null,null,'S');
uis.route('/clinic/clr/drug+edit$save','Ui_Clinic9.Edit','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/clr/drug+edit:model','Ui_Clinic9.Edit_Model','M','M','A','Y',null,null,null,'S');

uis.path('/clinic/clr/drug','clinic9');
uis.form('/clinic/clr/drug+add','/clinic/clr/drug','A','A','F','H','M','N',null,'N','S');
uis.form('/clinic/clr/drug+edit','/clinic/clr/drug','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/clr/drug+add','save','A',null,null,'A');
uis.action('/clinic/clr/drug+edit','save','A',null,null,'A');


uis.ready('/clinic/clr/drug+add','.model.save.');
uis.ready('/clinic/clr/drug+edit','.model.save.');

commit;
end;
/
