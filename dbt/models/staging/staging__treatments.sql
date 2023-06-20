with source as (
	select *
	from {{ source("staging", "TREATMENT") }}
)

select *
from source
