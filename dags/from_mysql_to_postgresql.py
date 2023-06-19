from airflow import DAG
from airflow.models.baseoperator import chain
from datetime import datetime

from tasks import (
    import_table_into_staging,
    move_table_from_staging_to_core,
)


with DAG(
    "from_mysql_to_postgresql",
    start_date=datetime(1900, 1, 1),
    schedule_interval="@once",
) as _:
    chain(
        [
            import_table_into_staging("CLAIM"),
            import_table_into_staging("INVOICE"),
            import_table_into_staging("INVOICE_ITEM"),
            import_table_into_staging("TREATMENT"),
        ],
        [
            move_table_from_staging_to_core("claim"),
            move_table_from_staging_to_core("invoice"),
            move_table_from_staging_to_core("invoice_item"),
            move_table_from_staging_to_core("treatment"),
        ],
    )
