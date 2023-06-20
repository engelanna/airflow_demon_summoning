from airflow.decorators import task
from airflow.operators.bash_operator import BashOperator


@task
def run_dbt_transformations(**context):
    # The space after .sh prevents Airflow from applying a Jinja template.

    BashOperator(
        task_id=context["task_instance"].task_id,
        bash_command="/usr/scripts/run_dbt_across_containers.sh "
    )
