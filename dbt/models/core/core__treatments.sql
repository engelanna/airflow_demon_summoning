with treatments_source as (
    select *
    from {{ ref("staging__treatments") }}
),

allowed_columns as (
    select
        id,
        status,
        date_created,
        date_modified,
        date_submitted,
        date_treatment,
        provider_id,
        program_id
    from treatments_source
)

select *
from allowed_columns
