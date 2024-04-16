set define off;
prompt ==== **start table** ===== 
prompt ==== CLR =====
@@module\clr\setup\clr_table.sql;
@@module\clr\setup\clr_sequence.sql;
prompt ==== CLA =====
@@module\cla\setup\cla_table.sql;
@@module\cla\setup\cla_sequence.sql;

exec fazo_z.run;
@@start.sql;
