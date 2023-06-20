select * from {{ source("staging", "INVOICE_ITEM") }}
