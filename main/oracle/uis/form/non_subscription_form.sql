set define off
declare
begin
delete md_non_subscription_forms t where t.project_code = 'clinic';
dbms_output.put_line('==== Non subscription form ====');
commit;
end;
/
