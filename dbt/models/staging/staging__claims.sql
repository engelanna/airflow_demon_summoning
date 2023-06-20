with claims_source as (
	select *
	from {{ source("staging", "CLAIM") }}
)

select *
from claims_source
