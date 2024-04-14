set define off
prompt PATH /clinic/cla/visit_view
begin
uis.route('/clinic/cla/visit_view:diseases','Ui_Clinic13.Query_Diseases','M','Q','A',null,null,null,null,'S');
uis.route('/clinic/cla/visit_view:drugs','Ui_Clinic13.Query_Drugs','M','Q','A',null,null,null,null,'S');
uis.route('/clinic/cla/visit_view:model','Ui_Clinic13.Model','M','M','A','Y',null,null,null,'S');

uis.path('/clinic/cla/visit_view','clinic13');
uis.form('/clinic/cla/visit_view','/clinic/cla/visit_view','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/cla/visit_view','edit','A','/clinic/cla/visit+edit','S','O');


uis.ready('/clinic/cla/visit_view','.edit.model.');

commit;
end;
/
