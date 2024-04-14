create or replace package Clr_Pref is
  ---------------------------------------------------------------------------------------------------- 
  c_Uz_Region_Id constant number := 1;
  ----------------------------------------------------------------------------------------------------
  --dosage form
  c_Df_Table   constant varchar2(1) := 'T';
  c_Df_Capsule constant varchar2(1) := 'C';
  c_Df_Syrup   constant varchar2(1) := 'S';
end Clr_Pref;
/
create or replace package body Clr_Pref is

end Clr_Pref;
/
