#!/bin/bash

docker exec airflow_demon_summoning-dbt-1 dbt run --full-refresh

exit 0
