/* 
    Statuses that change across time, with *NO* slicing across dimensions.
*/

/*

create table analytics.fct_claim_atomic (
    activity_date timestamp,
    activity_status varchar(25),
    amount decimal(19,4),
    dim_claim_id int,
);

create table analytics.fct_invoice_atomic (
    activity_date timestamp,
    activity_status varchar(25),
    dim_invoice_id int,
);

create table analytics.fct_invoice_item_atomic (
    activity_date timestamp,
    activity_status varchar(25),
    amount decimal(19,4),
    currency varchar(4),
    dim_invoice_item_id int,
);

create table analytics.fct_treatment_atomic (
    activity_date timestamp,
    activity_status varchar(25),
    dim_treatment id int,
);

*/
