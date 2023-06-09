from airflow.decorators import task
from airflow.providers.mysql.hooks.mysql import MySqlHook
from airflow.providers.postgres.hooks.postgres import PostgresHook


@task
def copy_a_single_table(table_name: str):
    PostgresHook(postgres_conn_id="target_warehouse").insert_rows(
        table=table_name.lower(),
        rows=MySqlHook(mysql_conn_id="source_db").get_records(
            f"SELECT * FROM {table_name}"
        ),
    )
