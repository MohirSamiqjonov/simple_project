set define off
declare
------------------------------
procedure company_head_forms(a varchar2) is begin
z_md_company_head_forms.insert_one(a);
end;
begin
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== Company Head forms ====');
delete md_company_head_forms where form like '/clinic/%';
commit;
end;
/
