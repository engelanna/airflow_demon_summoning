create table staging.claim (
    amount decimal(19,4),
    currency varchar(4),
    date_created timestamp,
    date_modified timestamp,
    id int primary key,
    program_id int,
    status varchar(25),
    treatment_id int,
    type varchar(25),
);

create table staging.invoice (
    date_created timestamp,
    id int primary key,
    status varchar(25),
    treatment_id int,
);

create table staging.invoice_item (
    amount decimal(19,4),
    currency varchar(4),
    date_created timestamp,
    id int primary key,
    invoice_id int,
    status varchar(25),
    product_id int,
);

create table staging.treatment (
    date_created timestamp,
    date_modified timestamp,
    date_submitted timestamp, 
    date_treatment timestamp,
    id int primary key,
    program_id int,
    provider_id int,
    status varchar(25),
    type varchar(25),
);
