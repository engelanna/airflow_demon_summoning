with claims_source as (
    select *
    from {{ ref("staging__claims") }}
),
treatments_source as (
    select *
    from {{ ref("staging__treatments") }}
),
coalesce_date_created_from_treatment_table as (
    select
        c.id,
        c.status,
        c.type,
        coalesce(c.date_created, t.date_created) as date_created,
        c.date_modified,
        c.treatment_id,
        c.program_id,
        c.amount,
        c.currency
    from claims_source c left join treatments_source t
        on c.treatment_id = t.id
)
select *
from coalesce_date_created_from_treatment_table
