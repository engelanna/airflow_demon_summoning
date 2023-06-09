from airflow import DAG
from datetime import datetime

from tasks import copy_a_single_table


with DAG("load_mysql_data_into_postgres_staging", start_date=datetime(1900, 1, 1), schedule_interval="@once") as dag:
    (
        copy_a_single_table("CLAIM")
        >> copy_a_single_table("INVOICE")
        >> copy_a_single_table("INVOICE_ITEM")
        >> copy_a_single_table("TREATMENT")
    )

