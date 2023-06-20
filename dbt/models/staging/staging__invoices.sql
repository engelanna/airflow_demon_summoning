select * from {{ source("staging", "invoice") }}
