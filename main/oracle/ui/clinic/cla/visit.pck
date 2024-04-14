create or replace package Ui_Clinic10 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/visit
  ----------------------------------------------------------------------------------------------------
  Function t
  (
    i_Message varchar2,
    i_P1      varchar2 := null,
    i_P2      varchar2 := null,
    i_P3      varchar2 := null,
    i_P4      varchar2 := null,
    i_P5      varchar2 := null
  ) return varchar2;
  ---------------------------------------------------------------------------------------------------- 
  Function Add_Model(p Hashmap) return Hashmap;
  ---------------------------------------------------------------------------------------------------- 
  Function Edit_Model(p Hashmap) return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Procedure Add(p Hashmap);
  ---------------------------------------------------------------------------------------------------- 
  Procedure Edit(p Hashmap);
  ----------------------------------------------------------------------------------------------------
  Function Query_Patient_Medical_Histories return Fazo_Query;
  ---------------------------------------------------------------------------------------------------- 
  Function Query_Diseases return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Function Query_Drugs return Fazo_Query;
end Ui_Clinic10;
/
create or replace package body Ui_Clinic10 is
  ----------------------------------------------------------------------------------------------------  
  -- /clinic/cla/visit
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
    return b.Translate('UI-CLINIC10:' || i_Message, i_P1, i_P2, i_P3, i_P4, i_P5);
  end;

  ---------------------------------------------------------------------------------------------------- 
  Function Add_Model(p Hashmap) return Hashmap is
    v_Patient_Medical_History_Id number := p.o_Number('patient_medical_history_id');
    r_Patient_Medical_History    Cla_Patient_Medical_Histories%rowtype;
    result                       Hashmap := Hashmap;
  begin
    if v_Patient_Medical_History_Id is not null then
      r_Patient_Medical_History := z_Cla_Patient_Medical_Histories.Load(i_Company_Id                 => Ui.Company_Id,
                                                                        i_Patient_Medical_History_Id => v_Patient_Medical_History_Id);
    
      result := z_Cla_Patient_Medical_Histories.To_Map(r_Patient_Medical_History,
                                                       z.Patient_Medical_History_Id,
                                                       z.Patient_Medical_History_Number,
                                                       z.Last_Name,
                                                       z.First_Name,
                                                       z.Patronymic,
                                                       z.Birth_Date);
    end if;
  
    Result.Put('visit_date', Trunc(sysdate));
  
    return result;
  end;

  ---------------------------------------------------------------------------------------------------- 
  Function Edit_Model(p Hashmap) return Hashmap is
    r_Visit                   Cla_Visits%rowtype;
    r_Patient_Medical_History Cla_Patient_Medical_Histories%rowtype;
    v_Company_Id              number := Ui.Company_Id;
    v_Diseases                Matrix_Varchar2 := Matrix_Varchar2();
    v_Drugs                   Matrix_Varchar2 := Matrix_Varchar2();
    result                    Hashmap;
  begin
    r_Visit := z_Cla_Visits.Load(i_Company_Id => v_Company_Id, i_Visit_Id => p.r_Number('visit_id'));
  
    result := z_Cla_Visits.To_Map(r_Visit, z.Visit_Id, z.Visit_Date, z.Note);
  
    r_Patient_Medical_History := z_Cla_Patient_Medical_Histories.Load(i_Company_Id                 => v_Company_Id,
                                                                      i_Patient_Medical_History_Id => r_Visit.Patient_Medical_History_Id);
  
    Result.Put_All(z_Cla_Patient_Medical_Histories.To_Map(r_Patient_Medical_History,
                                                          z.Patient_Medical_History_Id,
                                                          z.Patient_Medical_History_Number,
                                                          z.Last_Name,
                                                          z.First_Name,
                                                          z.Patronymic,
                                                          z.Birth_Date));
    select Array_Varchar2(w.Disease_Id,
                          (select d.Name
                             from Clr_Diseases d
                            where d.Company_Id = w.Company_Id
                              and d.Disease_Id = w.Disease_Id),
                          w.Note)
      bulk collect
      into v_Diseases
      from Cla_Diseases w
     where w.Company_Id = v_Company_Id
       and w.Visit_Id = r_Visit.Visit_Id;
  
    Result.Put('diseases', Fazo.Zip_Matrix(v_Diseases));
  
    select Array_Varchar2(w.Drug_Id,
                          d.Name,
                          Decode(d.Dosage_Form,
                                 Clr_Pref.c_Df_Table,
                                 t('dosage form: tablet'),
                                 Clr_Pref.c_Df_Capsule,
                                 t('dosage form: capsule'),
                                 Clr_Pref.c_Df_Syrup,
                                 t('dosage form: syrup')),
                          w.Required_Count_Medicine,
                          w.Note)
      bulk collect
      into v_Drugs
      from Cla_Drugs w
      join Clr_Drugs d
        on d.Company_Id = w.Company_Id
       and d.Drug_Id = w.Drug_Id
     where w.Company_Id = v_Company_Id
       and w.Visit_Id = r_Visit.Visit_Id;
  
    Result.Put('drugs', Fazo.Zip_Matrix(v_Drugs));
  
    Result.Put('is_edit', 'Y');
  
    return result;
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure save(p Hashmap) is
    v_Company_Id number := Ui.Company_Id;
    r_Visit      Cla_Visits%rowtype;
    r_Disease    Cla_Diseases%rowtype;
    r_Drug       Cla_Drugs%rowtype;
    v_List       Arraylist := p.r_Arraylist('diseases');
    v_Ids        Array_Number := Array_Number();
  begin
    z_Cla_Visits.To_Row(r_Visit, p, z.Visit_Id, z.Patient_Medical_History_Id, z.Visit_Date, z.Note);
  
    r_Visit.Company_Id := v_Company_Id;
    r_Visit.Visit_Id   := Nvl(r_Visit.Visit_Id, Cla_Next.Visit_Id);
  
    Cla_Api.Visit_Save(r_Visit);
  
    -- save diseases
    for i in 1 .. v_List.Count
    loop
      r_Disease := z_Cla_Diseases.To_Row(Treat(v_List.r_Hashmap(i) as Hashmap),
                                         z.Disease_Id,
                                         z.Note);
    
      r_Disease.Company_Id := v_Company_Id;
      r_Disease.Visit_Id   := r_Visit.Visit_Id;
    
      Cla_Api.Disease_Save(r_Disease);
    
      Fazo.Push(v_Ids, r_Disease.Disease_Id);
    end loop;
  
    -- delete not available diseases
    for i in (select w.Disease_Id
                from Cla_Diseases w
               where w.Company_Id = v_Company_Id
                 and w.Visit_Id = r_Visit.Visit_Id
                 and w.Disease_Id not in (select Column_Value
                                            from table(v_Ids)))
    loop
      Cla_Api.Disease_Delete(i_Company_Id => v_Company_Id,
                             i_Disease_Id => i.Disease_Id,
                             i_Visit_Id   => r_Visit.Visit_Id);
    end loop;
  
    v_List := p.r_Arraylist('drugs');
    v_Ids  := Array_Number();
  
    -- save drugs
    for i in 1 .. v_List.Count
    loop
      r_Drug := z_Cla_Drugs.To_Row(Treat(v_List.r_Hashmap(i) as Hashmap),
                                   z.Drug_Id,
                                   z.Required_Count_Medicine,
                                   z.Note);
    
      r_Drug.Company_Id := v_Company_Id;
      r_Drug.Visit_Id   := r_Visit.Visit_Id;
    
      Cla_Api.Drug_Save(r_Drug);
    
      Fazo.Push(v_Ids, r_Drug.Drug_Id);
    end loop;
  
    -- delete not available drugs
    for i in (select w.Drug_Id
                from Cla_Drugs w
               where w.Company_Id = v_Company_Id
                 and w.Visit_Id = r_Visit.Visit_Id
                 and w.Drug_Id not in (select Column_Value
                                         from table(v_Ids)))
    loop
      Cla_Api.Drug_Delete(i_Company_Id => v_Company_Id,
                          i_Drug_Id    => i.Drug_Id,
                          i_Visit_Id   => r_Visit.Visit_Id);
    end loop;
  
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Add(p Hashmap) is
  begin
    save(p);
  end;

  ---------------------------------------------------------------------------------------------------- 
  Procedure Edit(p Hashmap) is
  begin
    z_Cla_Visits.Lock_Only(i_Company_Id => Ui.Company_Id, i_Visit_Id => p.r_Number('visit_id'));
    save(p);
  end;

  ----------------------------------------------------------------------------------------------------
  Function Query_Patient_Medical_Histories return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('cla_patient_medical_histories',
                    Fazo.Zip_Map('company_id', Ui.Company_Id),
                    true);
  
    q.Number_Field('patient_medical_history_id');
  
    q.Varchar2_Field('patient_medical_history_number', 'last_name', 'first_name', 'patronymic');
  
    q.Date_Field('birth_date');
  
    return q;
  end;

  ---------------------------------------------------------------------------------------------------- 
  Function Query_Diseases return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('clr_diseases', Fazo.Zip_Map('company_id', Ui.Company_Id), true);
  
    q.Number_Field('disease_id');
  
    q.Varchar2_Field('name');
  
    return q;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Query_Drugs return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('clr_drugs', Fazo.Zip_Map('company_id', Ui.Company_Id), true);
  
    q.Number_Field('drug_id');
  
    q.Varchar2_Field('name', 'dosage_form');
  
    q.Option_Field('dosage_form_name',
                   'dosage_form',
                   Array_Varchar2(Clr_Pref.c_Df_Table, Clr_Pref.c_Df_Capsule, Clr_Pref.c_Df_Syrup),
                   Array_Varchar2(t('dosage form: tablet'),
                                  t('dosage form: capsule'),
                                  t('dosage form: syrup')));
    return q;
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Validation is
  begin
    update Cla_Patient_Medical_Histories
       set Company_Id                     = null,
           Patient_Medical_History_Id     = null,
           Patient_Medical_History_Number = null,
           Last_Name                      = null,
           First_Name                     = null,
           Patronymic                     = null,
           Birth_Date                     = null;
    update Clr_Diseases
       set Company_Id = null,
           Disease_Id = null,
           name       = null;
    update Clr_Drugs
       set Company_Id  = null,
           Drug_Id     = null,
           name        = null,
           Dosage_Form = null;
  end;

end Ui_Clinic10;
/
