/*
	Gather all the interesting timestamps across a business process' lifetime
    in a single spot, and you get shared dimensions.
*/


create table analytics.dim_claim_lifecycle (
    date_claim_created timestamp,
    date_claim_modified timestamp,
    date_invoice_created timestamp,
    date_treatment_happened timestamp,
    date_treatment_modified timestamp,
    date_treatment_submitted timestamp,
    dim_claim_id int,
    dim_invoice_id int,
    dim_program_id int,
    dim_provider_id int,
    dim_treatment_id int,
    id int primary key
);
