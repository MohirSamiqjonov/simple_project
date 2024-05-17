prompt Partitioning CLA tables

alter table CLA_PATIENT_MEDICAL_HISTORIES modify partition by list (COMPANY_ID) automatic (partition PART_HEAD values (0)) online update indexes (
  CLA_PATIENT_MEDICAL_HISTORIES_PK local tablespace GWS_INDEX,
  CLA_PATIENT_MEDICAL_HISTORIES_U1 local tablespace GWS_INDEX,
  CLA_PATIENT_MEDICAL_HISTORIES_U2 local tablespace GWS_INDEX
);

alter table CLA_VISITS modify partition by list (COMPANY_ID) automatic (partition PART_HEAD values (0)) online update indexes (
  CLA_VISITS_PK local tablespace GWS_INDEX
);

alter table CLA_DISEASES modify partition by list (COMPANY_ID) automatic (partition PART_HEAD values (0)) online update indexes (
  CLA_DISEASES_PK local tablespace GWS_INDEX
);

alter table CLA_DRUGS modify partition by list (COMPANY_ID) automatic (partition PART_HEAD values (0)) online update indexes (
  CLA_DRUGS_PK local tablespace GWS_INDEX
);
