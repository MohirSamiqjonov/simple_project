prompt bill project
declare
  v_Project_Code varchar2(10) := Clinic.Project_Code;
begin
  update Md_Projects t
     set t.Visible = 'N'
   where t.Project_Code = Core.Project_Code;

  z_Md_Projects.Save_One(i_Project_Code      => v_Project_Code,
                         i_Path_Prefix_Set   => v_Project_Code,
                         i_Module_Prefix_Set => 'clr,cla',
                         i_Intro_Form        => '/clinic/intro/dashboard',
                         i_Visible           => 'Y',
                         i_Parent_Code       => Core.Project_Code,
                         i_Version           => Clinic.Version);
  commit;
end;
/
