set define off
prompt PATH /clinic/intro/dashboard
begin
uis.route('/clinic/intro/dashboard:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S');

uis.path('/clinic/intro/dashboard','clinic2');
uis.form('/clinic/intro/dashboard','/clinic/intro/dashboard','A','A','F','H','M','N',null,'N','S');





uis.ready('/clinic/intro/dashboard','.model.');

commit;
end;
/
