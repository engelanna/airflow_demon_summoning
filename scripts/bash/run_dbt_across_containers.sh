#!/bin/bash

docker exec airflow-demon-summoning-dbt-1 dbt run --full-refresh

exit 0
