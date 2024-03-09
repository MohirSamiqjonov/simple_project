create or replace package Cla_Core is
  ---------------------------------------------------------------------------------------------------- 
  Function Gen_Gen_Document_Number
  (
    i_Company_Id number,
    i_Filial_Id  number,
    i_Table      Fazo_Schema.w_Table_Name,
    i_Column     varchar2
  ) return varchar2;
end Cla_Core;
/
create or replace package body Cla_Core is
  ---------------------------------------------------------------------------------------------------- 
  Function Gen_Gen_Document_Number
  (
    i_Company_Id number,
    i_Filial_Id  number,
    i_Table      Fazo_Schema.w_Table_Name,
    i_Column     varchar2
  ) return varchar2 is
  begin
    return Lpad(Md_Core.Sequence_Nextval(i_Company_Id => i_Company_Id,
                                         i_Filial_Id  => i_Filial_Id,
                                         i_Code       => i_Table.Name || ':' || i_Column),
                10,
                0);
  end;

end Cla_Core;
/
