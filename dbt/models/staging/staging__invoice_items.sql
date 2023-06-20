select * from {{ source("staging", "invoice_item") }}
