from airflow import DAG
from datetime import datetime

from tasks import move_a_table_from_staging_to_core


with DAG(
    "from_staging_to_core_within_postgres",
    description="Triggered by the upstream 'load_mysql_data_into_postgres_staging' DAG",
    start_date=datetime(1822, 9, 7),
    schedule_interval=None,
) as _:
    [
        move_a_table_from_staging_to_core(table)
        for table in ("claim", "invoice", "invoice_item", "treatment")
    ]
