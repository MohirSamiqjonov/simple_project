set define off
prompt PATH /clinic/clr/clinic_list
begin
uis.route('/clinic/clr/clinic_list$delete','Ui_Clinic7.Del','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/clr/clinic_list:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S');
uis.route('/clinic/clr/clinic_list:table','Ui_Clinic7.Query',null,'Q','A',null,null,null,null,'S');

uis.path('/clinic/clr/clinic_list','clinic7');
uis.form('/clinic/clr/clinic_list','/clinic/clr/clinic_list','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/clr/clinic_list','add','A','/clinic/clr/clinic+add','S','O');
uis.action('/clinic/clr/clinic_list','delete','A',null,null,'A');
uis.action('/clinic/clr/clinic_list','edit','A','/clinic/clr/clinic+edit','S','O');


uis.ready('/clinic/clr/clinic_list','.add.delete.edit.model.');

commit;
end;
/
