set define off
prompt PATH /clinic/clr/disease_list
begin
uis.route('/clinic/clr/disease_list$delete','Ui_Clinic6.Del','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/clr/disease_list:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S');
uis.route('/clinic/clr/disease_list:table','Ui_Clinic6.Query',null,'Q','A',null,null,null,null,'S');

uis.path('/clinic/clr/disease_list','clinic6');
uis.form('/clinic/clr/disease_list','/clinic/clr/disease_list','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/clr/disease_list','add','A','/clinic/clr/disease+add','S','O');
uis.action('/clinic/clr/disease_list','delete','A',null,null,'A');
uis.action('/clinic/clr/disease_list','edit','A','/clinic/clr/disease+edit','S','O');


uis.ready('/clinic/clr/disease_list','.add.delete.edit.model.');

commit;
end;
/
