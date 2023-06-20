/* 
    Statuses that change across time.
    Slices across dimensions are available, should we need it.
*/

create table analytics.fct_claims_activity (
    activity_date timestamp,
    activity_status varchar(25),
    amount decimal(19,4),
    dim_claim_id int,
    dim_program_id int,
    dim_treatment_id int,
    id int primary key
);

create table analytics.fct_invoices_activity (
    activity_date timestamp,
    activity_status varchar(25),
    dim_invoice_id int,
    dim_treatment_id int,
    id int primary key
);

create table analytics.fct_invoice_items_activity (
    activity_date timestamp,
    activity_status varchar(25),
    amount decimal(19,4),
    currency varchar(4),
    dim_invoice_id int,
    dim_invoice_item_id int,
    dim_product_id int,
    id int primary key
);

create table analytics.fct_treatments_activity (
    activity_date timestamp,
    activity_status varchar(25),
    dim_program_id int,
    dim_provider_id int,
    dim_treatment_id int,
    id int primary key
);
