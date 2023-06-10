create table core.claim (
    amount decimal(19,4),  # fact
    currency varchar(4),
    date_created timestamp,
    date_modified timestamp,
    id int primary key,
    program_id int, # link
    status varchar(25),  # fact
    treatment_id int, # link
    type varchar(25),
);

create table core.invoice (
    date_created timestamp,
    id int primary key,
    status varchar(25),  # fact
    treatment_id int, # link
);

create table core.invoice_item (
    amount decimal(19,4),  # fact
    currency varchar(4),
    date_created timestamp,
    id int primary key,
    invoice_id int, # link
    product_id int, # link
    status varchar(25), # fact
);

create table core.treatment (
    date_created timestamp,
    date_modified timestamp,
    date_submitted timestamp, 
    date_treatment timestamp,
    id int primary key,
    program_id int, # link
    provider_id int, # link
    status varchar(25), # fact
    type varchar(25),
);
