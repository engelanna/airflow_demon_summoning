#!/bin/bash

docker exec carepay_engelanna-dbt-1 dbt run --full-refresh

exit 0
