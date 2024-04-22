prompt reference module

---------------------------------------------------------------------------------------------------- 
create table clr_diseases(
   company_id  number(20)                     not null,
   disease_id  number(20)                     not null,
   name        varchar2(100 char)             not null,
   note        varchar2(500 char),
   state       varchar2(1)                    not null,
   created_by  number(20)                     not null,
   created_on  timestamp with local time zone not null,
   modified_by number(20)                     not null,
   modified_on timestamp with local time zone not null,
   constraint clr_diseases_pk primary key (company_id, disease_id) using index tablespace GWS_INDEX,
   constraint clr_diseases_f1 foreign key (company_id, created_by) references md_users(company_id, user_id),
   constraint clr_diseases_f2 foreign key (company_id, modified_by) references md_users(company_id, user_id),
   constraint clr_diseases_c1 check (state in ('A', 'P'))
);

create unique index clr_diseases_u1 on clr_diseases(company_id, upper(name)) tablespace GWS_INDEX;

---------------------------------------------------------------------------------------------------- 
create table clr_clinics(
   company_id  number(20)                     not null,
   clinic_id   number(20)                     not null,
   name        varchar2(100 char)             not null,
   region_id   number(20)                     not null,
   state       varchar2(1)                    not null,
   created_by  number(20)                     not null,
   created_on  timestamp with local time zone not null,
   modified_by number(20)                     not null,
   modified_on timestamp with local time zone not null,
   constraint clr_clinics_pk primary key (company_id, clinic_id) using index tablespace GWS_INDEX,
   constraint clr_clinics_f1 foreign key (company_id, region_id) references md_regions(company_id, region_id),
   constraint clr_clinics_f2 foreign key (company_id, created_by) references md_users(company_id, user_id),
   constraint clr_clinics_f3 foreign key (company_id, modified_by) references md_users(company_id, user_id),
   constraint clr_clinics_c1 check (state in ('A', 'P'))
);

create unique index clr_clinics_u1 on clr_clinics(company_id, upper(name)) tablespace GWS_INDEX;

---------------------------------------------------------------------------------------------------- 
create table clr_drugs(
   company_id  number(20)                     not null,
   drug_id     number(20)                     not null,
   name        varchar2(200 char)             not null,
   dosage_form varchar2(1)                    not null,
   created_by  number(20)                     not null,
   created_on  timestamp with local time zone not null,
   modified_by number(20)                     not null,
   modified_on timestamp with local time zone not null,
   constraint clr_drugs_pk primary key (company_id, drug_id) using index tablespace GWS_INDEX,
   constraint clr_drugs_f1 foreign key (company_id, created_by) references md_users(company_id, user_id),
   constraint clr_drugs_f2 foreign key (company_id, modified_by) references md_users(company_id, user_id),
   constraint clr_drugs_c1 check (dosage_form in ('T', 'C', 'S'))
);

create unique index clr_drugs_u1 on clr_drugs(company_id, upper(name)) tablespace GWS_INDEX;

comment on column clr_drugs.dosage_form is '(T)ablet, (C)apsule, (S)yrup';
