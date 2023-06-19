from airflow.decorators import task
from airflow.models import Connection
from airflow.providers.postgres.hooks.postgres import PostgresHook


@task
def move_table_from_staging_to_core(table_name: str):
    postgres_hook = PostgresHook(
        Connection.get_connection_from_secrets("TARGET_WAREHOUSE").conn_id
    )

    postgres_hook.insert_rows(
        rows=postgres_hook.get_records(f"SELECT * FROM staging.{table_name}"),
        table=f"core.{table_name}",
    )
