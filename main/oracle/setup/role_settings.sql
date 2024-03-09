set define off
set serveroutput on
declare
v_company_id number := md_pref.c_company_head;
g_role_ids fazo.number_code_aat;
------------------------------
function role_id(i_pcode varchar2) return number is begin
return g_role_ids(i_pcode);exception when no_data_found then g_role_ids(i_pcode) := md_util.role_id(i_company_id=>v_company_id,i_pcode=>i_pcode); return g_role_ids(i_pcode);end;
------------------------------
procedure form_actions(i_pcode varchar2,i_form varchar2,i_action_key varchar2) is begin
z_md_role_form_actions.insert_one(i_company_id=>v_company_id,i_role_id=>role_id(i_pcode),i_form=>i_form,i_action_key=>i_action_key);end;
------------------------------
procedure grid_columns(i_pcode varchar2,i_form varchar2,i_grid varchar2,i_grid_column varchar2) is begin
z_md_role_revoked_columns.insert_one(i_company_id=>v_company_id,i_role_id=>role_id(i_pcode),i_form=>i_form,i_grid=>i_grid,i_grid_column=>i_grid_column);end;
------------------------------
procedure projects(i_pcode varchar2,i_project_code varchar2) is begin
z_md_role_projects.insert_one(i_company_id=>v_company_id,i_role_id=>role_id(i_pcode),i_project_code=>i_project_code);end;
begin
Ui_Auth.Logon_As_System(i_Company_Id => v_Company_Id);
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== delete role form actions == == ');
delete from md_role_form_actions q where q.company_id = v_company_id
and exists (select 1 from md_roles w where w.company_id = q.company_id and w.role_id = q.role_id
and upper(w.pcode) like 'CLINIC:%');
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== delete role grid columns == == ');
delete from md_role_revoked_columns q where q.company_id = v_company_id
and exists (select 1 from md_roles w where w.company_id = q.company_id and w.role_id = q.role_id
and upper(w.pcode) like 'CLINIC:%');
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== delete role projects == == ');
delete from md_role_projects q where q.company_id = v_company_id
and exists (select 1 from md_roles w where w.company_id = q.company_id and w.role_id = q.role_id
and upper(w.pcode) like 'CLINIC:%');
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== role form actions == == ');
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== role revoked grid columns ====');
----------------------------------------------------------------------------------------------------
dbms_output.put_line('==== role projects ====');
commit;
end;
/
