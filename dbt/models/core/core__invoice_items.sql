with invoice_items_source as (
    select *
    from {{ ref("staging__invoice_items") }}
),

invoices_source as (
    select *
    from {{ ref("staging__invoices") }}
),

treatments_source as (
    select *
    from {{ ref("staging__treatments") }}
),

coalesce_date_created_from_invoice_and_treatment_tables as (
    select
        ii.id,
        ii.status,
        coalesce(
            ii.date_created,
            i.date_created,
            t.date_created
        ) as date_created,
        ii.invoice_id,
        ii.product_id,
        ii.currency,
        ii.amount
    from invoice_items_source ii
    left join invoices_source i on ii.invoice_id = i.id 
    left join treatments_source t on i.treatment_id = t.id
)

select *
from coalesce_date_created_from_invoice_and_treatment_tables
