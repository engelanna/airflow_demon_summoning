/*
    "Actors" who repeatedly appear without mutating every time.
    That includes degenerate dimensions: program, provider.
*/


create table analytics.dim_claim (
    currency varchar(4),
    date_created timestamp,
    date_modified timestamp,
    id int primary key,
    type varchar(25)
);

create table analytics.dim_invoice (
    date_created timestamp,  
    id int primary key,
    invoice_item_ids int[]  
);

create table analytics.dim_invoice_item (
    currency varchar(4),
    date_created timestamp,
    id int primary key
);

create table analytics.dim_program (
    claims_last_7_days int default 0,
    claims_last_28_days int default 0,
    claims_total int default 0,
    id int primary key,
    treatments_last_7_days int default 0,
    treatments_last_28_days int default 0,
    treatments_total int default 0
);

create table analytics.dim_provider (
    id int primary key,
    treatments_last_7_days int default 0, 
    treatments_last_28_days int default 0,
    treatments_total int default 0
);

create table analytics.dim_treatment (
    claims_last_7_days int default 0,
    claims_last_28_days int default 0,
    claims_total int default 0,
    date_created timestamp,  
    date_modified timestamp,
    date_submitted timestamp,  
    date_treatment timestamp,  
    id int primary key,
    invoices_last_7_days int default 0,
    invoices_last_28_days int default 0,
    invoices_total int default 0,
    type varchar(25)
);
