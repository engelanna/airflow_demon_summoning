with invoice_items_source as (
	select *
	from {{ source("staging", "INVOICE_ITEM") }}
)

select *
from invoice_items_source
