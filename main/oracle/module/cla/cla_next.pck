create or replace package Cla_Next is
  ----------------------------------------------------------------------------------------------------
  Function Patient_Medical_History_Id return number;
end Cla_Next;
/
create or replace package body Cla_Next is
  ----------------------------------------------------------------------------------------------------
  Function Patient_Medical_History_Id return number is
  begin
    return Cla_Patient_Medical_Histories_Sq.Nextval;
  end;

end Cla_Next;
/
