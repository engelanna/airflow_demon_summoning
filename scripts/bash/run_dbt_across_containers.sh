#!/bin/bash

docker exec -it carepay_engelanna-dbt-1 dbt run --full-refresh
exit 66
