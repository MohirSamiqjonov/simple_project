create or replace package Cla_Api is
  ---------------------------------------------------------------------------------------------------- 
  Procedure save(r_Row Cla_Patient_Medical_Histories%rowtype);
end Cla_Api;
/
create or replace package body Cla_Api is
  ----------------------------------------------------------------------------------------------------
  Procedure save(r_Row Cla_Patient_Medical_Histories%rowtype) is
  begin
    z_Cla_Patient_Medical_Histories.Save_Row(r_Row);
  end;

end Cla_Api;
/
