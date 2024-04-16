set define off
declare
begin
delete mt_project_tapes t where t.project_code = 'clinic';
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Project tapes ====');
commit;
end;
/
