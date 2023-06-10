create index idx_invoice_item_date_created on core.invoice_item(date_created);

create index idx_invoice_date_created on core.invoice(date_created);

create index idx_claim_date_created on core.claim(date_created);
create index idx_claim_date_modified on core.claim(date_modified);

create index idx_treatment_date_created on core.treatment(date_created);
create index idx_treatment_date_modified on core.treatment(date_modified);
create index idx_treatment_date_submitted on core.treatment(date_submitted);
create index idx_treatment_date_treatment on core.treatment(date_treatment);
