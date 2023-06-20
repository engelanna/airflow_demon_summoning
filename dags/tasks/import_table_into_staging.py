from airflow.decorators import task
from airflow.models import Connection
from airflow.providers.mysql.hooks.mysql import MySqlHook
from airflow.providers.postgres.hooks.postgres import PostgresHook


@task
def import_table_into_staging(table_name: str):
    mysql_hook = MySqlHook(Connection.get_connection_from_secrets("SOURCE_DB").conn_id)
    postgres_hook = PostgresHook(
        Connection.get_connection_from_secrets("TARGET_WAREHOUSE").conn_id
    )

    postgres_hook.insert_rows(
        rows=mysql_hook.get_records(f"SELECT * FROM {table_name}"),
        table=f'staging."{table_name}"',
    )
