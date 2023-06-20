/*
    To avoid complexity & get a clean load, the script preserves the following from the its MySQL source:
        - the table names (including capitalization)
        - the column order
*/

create table staging."INVOICE_ITEM" (
    id int primary key,
    status varchar(25),
    date_created timestamp,
    invoice_id int,
    product_id int,
    currency varchar(4),
    amount decimal(19,4)
);

create table staging."INVOICE" (
    id int primary key,
    status varchar(25),
    date_created timestamp,
    treatment_id int
);

create table staging."CLAIM" (
    id int primary key,
    status varchar(25),
    type varchar(25),
    date_created timestamp,
    date_modified timestamp,
    treatment_id int,
    program_id int,
    amount decimal(19,4),
    currency varchar(4)
);

create table staging."TREATMENT" (
    id int primary key,
    status varchar(25),
    date_created timestamp,
    date_modified timestamp,
    date_submitted timestamp, 
    date_treatment timestamp,
    provider_id int,
    program_id int
);
