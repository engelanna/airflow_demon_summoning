with source as (
	select * from {{ source("staging", "CLAIM") }}
)
select * from source
