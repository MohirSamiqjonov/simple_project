create or replace package Ui_Clinic1 is
  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Procedure Add(p Hashmap);
end Ui_Clinic1;
/
create or replace package body Ui_Clinic1 is
  ----------------------------------------------------------------------------------------------------
  Procedure Fill_Record
  (
    r_Row                        out nocopy Cla_Patient_Medical_Histories%rowtype,
    p                            Hashmap,
    i_Patient_Medical_History_Id number,
    Is_Add                       varchar2 := null
  ) is
    v_Company_Id number := Ui.Company_Id;
  begin
    if Is_Add = 'Y' then
      r_Row.Company_Id := v_Company_Id;
    
      r_Row.Patient_Medical_History_Number := Cla_Core.Gen_Gen_Document_Number(i_Company_Id => v_Company_Id,
                                                                               i_Filial_Id  => Ui.Filial_Id,
                                                                               i_Table      => Zt.Cla_Patient_Medical_Histories,
                                                                               i_Column     => z.Patient_Medical_History_Number);
    end if;
    r_Row.Patient_Medical_History_Id := i_Patient_Medical_History_Id;
    z_Cla_Patient_Medical_Histories.To_Row(r_Row,
                                           p,
                                           z.Last_Name,
                                           z.First_Name,
                                           z.Patronymic,
                                           z.Passport_Number,
                                           z.Birth_Date,
                                           z.Gender,
                                           z.Phone,
                                           z.Height,
                                           z.Weight,
                                           z.Address,
                                           z.Job);
  end;

  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap is
  begin
    return Fazo.Zip_Map(z.Phone, '+998 ', z.Gender, 'M');
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Add(p Hashmap) is
    r_Row Cla_Patient_Medical_Histories%rowtype;
  begin
    Fill_Record(r_Row, p, Cla_Next.Patient_Medical_History_Id, 'Y');
  
    Cla_Api.Save(r_Row);
  end;

end Ui_Clinic1;
/
