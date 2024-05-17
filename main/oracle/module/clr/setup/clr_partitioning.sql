prompt Partitioning CLR tables

alter table CLR_DISEASES modify partition by list (COMPANY_ID) automatic (partition PART_HEAD values (0)) online update indexes (
  CLR_DISEASES_PK local tablespace GWS_INDEX,
  CLR_DISEASES_U1 local tablespace GWS_INDEX
);

alter table CLR_CLINICS modify partition by list (COMPANY_ID) automatic (partition PART_HEAD values (0)) online update indexes (
  CLR_CLINICS_PK local tablespace GWS_INDEX,
  CLR_CLINICS_U1 local tablespace GWS_INDEX
);

alter table CLR_DRUGS modify partition by list (COMPANY_ID) automatic (partition PART_HEAD values (0)) online update indexes (
  CLR_DRUGS_PK local tablespace GWS_INDEX,
  CLR_DRUGS_U1 local tablespace GWS_INDEX
);
