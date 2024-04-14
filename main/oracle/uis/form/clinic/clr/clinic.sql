set define off
prompt PATH /clinic/clr/clinic
begin
uis.route('/clinic/clr/clinic+add$save','Ui_Clinic5.Add','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/clr/clinic+add:model','Ui_Clinic5.Add_Model',null,'M','A','Y',null,null,null,'S');
uis.route('/clinic/clr/clinic+edit$save','Ui_Clinic5.Edit','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/clr/clinic+edit:model','Ui_Clinic5.Edit_Model','M','M','A','Y',null,null,null,'S');

uis.path('/clinic/clr/clinic','clinic5');
uis.form('/clinic/clr/clinic+add','/clinic/clr/clinic','A','A','F','H','M','N',null,'N','S');
uis.form('/clinic/clr/clinic+edit','/clinic/clr/clinic','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/clr/clinic+add','save','A',null,null,'A');
uis.action('/clinic/clr/clinic+edit','save','A',null,null,'A');


uis.ready('/clinic/clr/clinic+add','.model.save.');
uis.ready('/clinic/clr/clinic+edit','.model.save.');

commit;
end;
/
