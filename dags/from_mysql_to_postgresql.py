from airflow import DAG
from datetime import datetime

from tasks import import_table_into_staging


with DAG(
    "from_mysql_to_postgresql",
    start_date=datetime(1900, 1, 1),
    schedule_interval="@once",
) as _:
    [
        import_table_into_staging("CLAIM"),
        import_table_into_staging("INVOICE"),
        import_table_into_staging("INVOICE_ITEM"),
        import_table_into_staging("TREATMENT"),
    ]
