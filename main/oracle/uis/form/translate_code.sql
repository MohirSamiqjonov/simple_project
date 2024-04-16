set define off
declare
begin
delete mt_translate_codes t where t.project_code = 'clinic';
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Project translate codes ====');
commit;
end;
/
