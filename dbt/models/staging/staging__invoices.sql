with invoices_source as (
	select *
	from {{ source("staging", "INVOICE") }}
)

select *
from invoices_source
