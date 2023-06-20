from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

from tasks import import_table_into_staging


with DAG(
    "create_postgres_warehouse_from_mysql",
    start_date=datetime(1900, 1, 1),
    schedule_interval="@once",
) as _:
    [
        import_table_into_staging("CLAIM"),
        import_table_into_staging("INVOICE"),
        import_table_into_staging("INVOICE_ITEM"),
        import_table_into_staging("TREATMENT"),
    ] >> BashOperator(
        task_id="run_dbt_transformations",
        bash_command="/usr/scripts/run_dbt_across_containers.sh "
    )
