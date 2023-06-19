from airflow import DAG
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from datetime import datetime

from tasks import stage_a_table


with DAG(
    "load_mysql_data_into_postgres_staging",
    start_date=datetime(1822, 9, 7),
    schedule_interval="@once",
) as _:
    [
        stage_a_table(table)
        for table in ("CLAIM", "INVOICE", "INVOICE_ITEM", "TREATMENT")
    ] >> TriggerDagRunOperator(
        trigger_dag_id="from_staging_to_core_within_postgres", task_id="_"
    )
