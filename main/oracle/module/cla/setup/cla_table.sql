prompt application module

----------------------------------------------------------------------------------------------------
create table cla_patient_medical_histories(
   company_id                     number(20)                     not null,
   patient_medical_history_id     number(20)                     not null,
   patient_medical_history_number varchar2(10)                   not null,
   last_name                      varchar2(50 char)              not null,
   first_name                     varchar2(50 char)              not null,
   patronymic                     varchar2(50 char)              not null,
   passport_number                varchar2(9)                    not null,
   birth_date                     date                           not null,
   gender                         varchar2(1)                    not null,
   clinic_id                      number                         not null,
   phone                          varchar2(20)                   not null,
   height                         number(3),
   weight                         number(4, 1),
   address                        varchar2(200 char),
   job                            varchar2(100 char),
   created_by                     number(20)                     not null,
   created_on                     timestamp with local time zone not null,
   modified_by                    number(20)                     not null,
   modified_on                    timestamp with local time zone not null,
   constraint cla_patient_medical_histories_pk primary key (company_id, patient_medical_history_id) using index tablespace GWS_INDEX,
   constraint cla_patient_medical_histories_f1 foreign key (company_id, clinic_id) references clr_clinics(company_id, clinic_id),
   constraint cla_patient_medical_histories_f2 foreign key (company_id, created_by) references md_users(company_id, user_id),
   constraint cla_patient_medical_histories_f3 foreign key (company_id, modified_by) references md_users(company_id, user_id)
   constraint cla_patient_medical_histories_u1 unique (patient_medical_history_number) using index tablespace GWS_INDEX,
   constraint cla_patient_medical_histories_u2 unique (passport_number) using index tablespace GWS_INDEX,
   constraint cla_patient_medical_histories_c1 check (regexp_like(passport_number, '^[A-Z]{2}\d{7}$')),
   constraint cla_patient_medical_histories_c2 check (gender in ('M', 'F')),
   constraint cla_patient_medical_histories_c3 check ((height is null and weight is null) or (height is not null and weight is not null))
) tablespace GWS_DATA;

comment on column cla_patient_medical_histories.gender is '(M)ale, (F)emale';

----------------------------------------------------------------------------------------------------
create table cla_visits(
   company_id                 number(20)                     not null,
   visit_id                   number(20)                     not null,
   patient_medical_history_id number(20)                     not null,
   visit_date                 date                           not null,
   note                       varchar2(1000 char),
   created_by                 number(20)                     not null,
   created_on                 timestamp with local time zone not null,
   modified_by                number(20)                     not null,
   modified_on                timestamp with local time zone not null,
   constraint cla_visits_pk primary key (company_id, visit_id) using index tablespace GWS_INDEX,
   constraint cla_visits_f1 foreign key (company_id, patient_medical_history_id) references cla_patient_medical_histories(company_id, patient_medical_history_id) on delete cascade,
   constraint cla_visits_f2 foreign key (company_id, created_by) references md_users(company_id, user_id),
   constraint cla_visits_f3 foreign key (company_id, modified_by) references md_users(company_id, user_id)
);

----------------------------------------------------------------------------------------------------
create table cla_diseases(
   company_id   number(20)                     not null,
   disease_id   number(20)                     not null,
   visit_id     number(20)                     not null,
   note         varchar2(500 char)             not null,
   created_by   number(20)                     not null,
   created_on   timestamp with local time zone not null,
   modified_by  number(20)                     not null,
   modified_on  timestamp with local time zone not null,
   constraint cla_diseases_pk primary key (company_id, disease_id, visit_id) using index tablespace GWS_INDEX,
   constraint cla_diseases_f1 foreign key (company_id, disease_id) references clr_diseases(company_id, disease_id),
   constraint cla_diseases_f2 foreign key (company_id, visit_id) references cla_visits(company_id, visit_id) on delete cascade,
   constraint cla_diseases_f3 foreign key (company_id, created_by) references md_users(company_id, user_id),
   constraint cla_diseases_f4 foreign key (company_id, modified_by) references md_users(company_id, user_id)
);

----------------------------------------------------------------------------------------------------
create table cla_drugs(
   company_id              number(20)                     not null,
   drug_id                 number(20)                     not null,
   visit_id                number(20)                     not null,
   required_count_medicine number(20)                     not null,
   sold_count_medicine     number(20),
   note                    varchar2(200 char),
   created_by              number(20)                     not null,
   created_on              timestamp with local time zone not null,
   modified_by             number(20)                     not null,
   modified_on             timestamp with local time zone not null,
   constraint cla_drugs_pk primary key (company_id, drug_id, visit_id) using index tablespace GWS_INDEX,
   constraint cla_drugs_f1 foreign key (company_id, drug_id) references clr_drugs(company_id, drug_id),
   constraint cla_drugs_f2 foreign key (company_id, visit_id) references cla_visits(company_id, visit_id) on delete cascade,
   constraint cla_drugs_f3 foreign key (company_id, created_by) references md_users(company_id, user_id),
   constraint cla_drugs_f4 foreign key (company_id, modified_by) references md_users(company_id, user_id),
   constraint cla_drugs_c1 check (required_count_medicine >= sold_count_medicine)
);

