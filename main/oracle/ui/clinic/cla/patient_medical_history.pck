create or replace package Ui_Clinic1 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/patient_medical_history
  ----------------------------------------------------------------------------------------------------
  Function Query_Clinics return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Procedure Add(p Hashmap);
  ----------------------------------------------------------------------------------------------------
  Procedure Edit(p Hashmap);
end Ui_Clinic1;
/
create or replace package body Ui_Clinic1 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/patient_medical_history
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
    r_Row.Company_Id                 := v_Company_Id;
    r_Row.Patient_Medical_History_Id := i_Patient_Medical_History_Id;
    z_Cla_Patient_Medical_Histories.To_Row(r_Row,
                                           p,
                                           z.Patient_Medical_History_Number,
                                           z.Last_Name,
                                           z.First_Name,
                                           z.Patronymic,
                                           z.Passport_Number,
                                           z.Birth_Date,
                                           z.Gender,
                                           z.Clinic_Id,
                                           z.Phone,
                                           z.Height,
                                           z.Weight,
                                           z.Address,
                                           z.Job);
    if Is_Add = 'Y' then
      r_Row.Patient_Medical_History_Number := Cla_Core.Gen_Gen_Document_Number(i_Company_Id => v_Company_Id,
                                                                               i_Filial_Id  => Ui.Filial_Id,
                                                                               i_Table      => Zt.Cla_Patient_Medical_Histories,
                                                                               i_Column     => z.Patient_Medical_History_Number);
    end if;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Query_Clinics return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('clr_clinics', Fazo.Zip_Map('company_id', Ui.Company_Id, 'state', 'A'), true);
  
    q.Number_Field('clinic_id');
  
    q.Varchar2_Field('name');
  
    return q;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap is
  begin
    return Fazo.Zip_Map(z.Gender, Cla_Pref.c_Gender_Male);
  end;

  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap is
    r_Row  Cla_Patient_Medical_Histories%rowtype;
    result Hashmap;
  begin
    r_Row := z_Cla_Patient_Medical_Histories.Lock_Load(i_Company_Id                 => Ui.Company_Id,
                                                       i_Patient_Medical_History_Id => p.r_Number('patient_medical_history_id'));
  
    result := z_Cla_Patient_Medical_Histories.To_Map(r_Row,
                                                     z.Patient_Medical_History_Id,
                                                     z.Patient_Medical_History_Number,
                                                     z.Last_Name,
                                                     z.First_Name,
                                                     z.Patronymic,
                                                     z.Passport_Number,
                                                     z.Birth_Date,
                                                     z.Gender,
                                                     z.Clinic_Id,
                                                     z.Phone,
                                                     z.Height,
                                                     z.Weight,
                                                     z.Address,
                                                     z.Job);
    Result.Put('clinic_name',
               z_Clr_Clinics.Load(i_Company_Id => Ui.Company_Id, i_Clinic_Id => r_Row.Clinic_Id).Name);
  
    return result;
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Add(p Hashmap) is
    r_Row Cla_Patient_Medical_Histories%rowtype;
  begin
    Fill_Record(r_Row, p, Cla_Next.Patient_Medical_History_Id, 'Y');
  
    Cla_Api.Patient_Medical_History_Save(r_Row);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Edit(p Hashmap) is
    r_Row Cla_Patient_Medical_Histories%rowtype;
  begin
    r_Row := z_Cla_Patient_Medical_Histories.Lock_Load(i_Company_Id                 => Ui.Company_Id,
                                                       i_Patient_Medical_History_Id => p.r_Number('patient_medical_history_id'));
    Fill_Record(r_Row, p, p.r_Number('patient_medical_history_id'));
  
    Cla_Api.Patient_Medical_History_Save(r_Row);
  end;

end Ui_Clinic1;
/
