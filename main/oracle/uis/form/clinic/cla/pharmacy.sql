set define off
prompt PATH /clinic/cla/pharmacy
begin
uis.route('/clinic/cla/pharmacy$save','Ui_Clinic11.Save','M',null,'A',null,null,null,null,'S');
uis.route('/clinic/cla/pharmacy:get_drugs','Ui_Clinic11.Get_Drugs','M','L','A',null,null,null,null,'S');
uis.route('/clinic/cla/pharmacy:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S');

uis.path('/clinic/cla/pharmacy','clinic11');
uis.form('/clinic/cla/pharmacy','/clinic/cla/pharmacy','A','A','F','H','M','N',null,'N','S');



uis.action('/clinic/cla/pharmacy','get_drugs','A',null,null,'G');
uis.action('/clinic/cla/pharmacy','save','A',null,null,'A');


uis.ready('/clinic/cla/pharmacy','.get_drugs.model.save.');

commit;
end;
/
