with invoices_source as (
    select *
    from {{ ref("staging__invoices") }}
),

treatments_source as (
    select *
    from {{ ref("staging__treatments") }}
),

coalesce_date_created_from_treatment_table as (
    select
        i.id,
        i.status,
        coalesce(i.date_created, t.date_created) as date_created,
        i.treatment_id
    from invoices_source i
    left join treatments_source t
    on i.treatment_id = t.id
)

select *
from coalesce_date_created_from_treatment_table
