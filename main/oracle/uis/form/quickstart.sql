set define off
declare
begin
delete md_quickstart_headings t where t.project_code = 'clinic';
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Quick start ====');
commit;
end;
/
