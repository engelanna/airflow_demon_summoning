from airflow import DAG
from datetime import datetime

from tasks import stage_a_table


with DAG("load_mysql_data_into_postgres_staging", start_date=datetime(1900, 1, 1), schedule_interval="@once") as dag:
    (
        stage_a_table("CLAIM")
        >> stage_a_table("INVOICE")
        >> stage_a_table("INVOICE_ITEM")
        >> stage_a_table("TREATMENT")
    )

