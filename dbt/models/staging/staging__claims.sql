with source as (
	select * from {{ source("staging", "claim") }}
)
select * from source
