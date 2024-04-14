create or replace package Ui_Clinic11 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/pharmacy
  ----------------------------------------------------------------------------------------------------
  Function Get_Drugs(p Hashmap) return Arraylist;
  ---------------------------------------------------------------------------------------------------- 
  Procedure save(p Hashmap);
  ----------------------------------------------------------------------------------------------------
  Function Dosage_Form_Name(i_Dosage_Form varchar2) return varchar2;
end Ui_Clinic11;
/
create or replace package body Ui_Clinic11 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/pharmacy
  ----------------------------------------------------------------------------------------------------
  Function t
  (
    i_Message varchar2,
    i_P1      varchar2 := null,
    i_P2      varchar2 := null,
    i_P3      varchar2 := null,
    i_P4      varchar2 := null,
    i_P5      varchar2 := null
  ) return varchar2 is
  begin
    return b.Translate('UI-CLINIC11:' || i_Message, i_P1, i_P2, i_P3, i_P4, i_P5);
  end;

  ----------------------------------------------------------------------------------------------------
  Function Dosage_Form_Name(i_Dosage_Form varchar2) return varchar2 is
  begin
    case i_Dosage_Form
      when Clr_Pref.c_Df_Table then
        return t('dosage form: table');
      when Clr_Pref.c_Df_Capsule then
        return t('dosage form: capsule');
      when Clr_Pref.c_Df_Syrup then
        return t('dosage form: syrup');
      else
        b.Raise_Fatal('invalid dosage form');
    end case;
  end;

  ---------------------------------------------------------------------------------------------------- 
  Procedure Check_Passport(i_Passport_Number varchar2) is
    v_Exists varchar2(1);
  begin
  
    select 'x'
      into v_Exists
      from Cla_Patient_Medical_Histories w
     where w.Company_Id = Ui.Company_Id
       and w.Passport_Number = i_Passport_Number;
  exception
    when No_Data_Found then
      b.Raise_Error(t('not found passport in system'));
  end;

  ----------------------------------------------------------------------------------------------------
  Function Get_Drugs(p Hashmap) return Arraylist is
    v_Company_Id      number := Ui.Company_Id;
    v_Passport_Number Cla_Patient_Medical_Histories.Passport_Number%type := p.r_Varchar2('passport_number');
    v_Drugs           Matrix_Varchar2 := Matrix_Varchar2();
  begin
    Check_Passport(v_Passport_Number);
    select Array_Varchar2(d.Drug_Id,
                          w.Name,
                          Dosage_Form_Name(w.Dosage_Form),
                          d.Visit_Id,
                          d.Required_Count_Medicine,
                          d.Sold_Count_Medicine,
                          d.Note)
      bulk collect
      into v_Drugs
      from Cla_Drugs d
      join Clr_Drugs w
        on w.Company_Id = d.Company_Id
       and w.Drug_Id = d.Drug_Id
     where d.Company_Id = v_Company_Id
       and d.Required_Count_Medicine <> Nvl(d.Sold_Count_Medicine, 0)
       and exists
     (select 1
              from Cla_Visits v
             where v.Company_Id = d.Company_Id
               and v.Visit_Id = d.Visit_Id
               and Months_Between(sysdate, v.Visit_Date) <= 3
               and exists (select 1
                      from Cla_Patient_Medical_Histories h
                     where h.Company_Id = v.Company_Id
                       and h.Patient_Medical_History_Id = v.Patient_Medical_History_Id
                       and h.Passport_Number = v_Passport_Number));
  
    return Fazo.Zip_Matrix(v_Drugs);
  end;

  ---------------------------------------------------------------------------------------------------- 
  Procedure save(p Hashmap) is
    v_Company_Id number := Ui.Company_Id;
    v_List       Arraylist := p.r_Arraylist('drugs');
    v_Hashmap    Hashmap;
  begin
    for i in 1 .. v_List.Count
    loop
      v_Hashmap := Treat(v_List.r_Hashmap(i) as Hashmap);
      Cla_Api.Update_Drug(i_Company_Id          => v_Company_Id,
                          i_Drug_Id             => v_Hashmap.r_Number('drug_id'),
                          i_Visit_Id            => v_Hashmap.r_Number('visit_id'),
                          i_Sold_Count_Medicine => v_Hashmap.r_Number('sold_count_medicine'));
    end loop;
  end;

end Ui_Clinic11;
/
