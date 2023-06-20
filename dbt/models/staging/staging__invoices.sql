select * from {{ source("staging", "INVOICE") }}
