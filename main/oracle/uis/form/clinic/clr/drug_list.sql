set define off
prompt PATH /clinic/clr/drug_list
begin
uis.route('/clinic/clr/drug_list$delete','Ui_Clinic14.Del','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/clr/drug_list:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S');
uis.route('/clinic/clr/drug_list:table','Ui_Clinic14.Query',null,'Q','A',null,null,null,null,'S');

uis.path('/clinic/clr/drug_list','clinic14');
uis.form('/clinic/clr/drug_list','/clinic/clr/drug_list','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/clr/drug_list','add','A','/clinic/clr/drug+add','S','O');
uis.action('/clinic/clr/drug_list','delete','A',null,null,'A');
uis.action('/clinic/clr/drug_list','edit','A','/clinic/clr/drug+edit','S','O');


uis.ready('/clinic/clr/drug_list','.add.delete.edit.model.');

commit;
end;
/
