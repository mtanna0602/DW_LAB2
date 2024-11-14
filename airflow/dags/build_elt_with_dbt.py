"""
A basic dbt DAG that shows how to run dbt commands via the BashOperator.
Follows the standard dbt seed, run, and test pattern.
"""

from pendulum import datetime
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.hooks.base import BaseHook

DBT_PROJECT_DIR = "/opt/airflow/dbt"

# Retrieve Snowflake connection
try:
    conn = BaseHook.get_connection('snowflake_conn')
except Exception as e:
    raise ValueError("Failed to retrieve Snowflake connection. Ensure 'snowflake_conn' is configured in Airflow.") from e

# Define required environment variables
required_env_vars = {
    "DBT_USER": conn.login,
    "DBT_PASSWORD": conn.password,
    "DBT_ACCOUNT": conn.extra_dejson.get("account"),
    "DBT_SCHEMA": conn.schema,
    "DBT_DATABASE": conn.extra_dejson.get("database"),
    "DBT_ROLE": conn.extra_dejson.get("role"),
    "DBT_WAREHOUSE": conn.extra_dejson.get("warehouse"),
    "DBT_TYPE": "snowflake",
}

# Check for missing environment variables
missing_vars = [key for key, value in required_env_vars.items() if value is None]
if missing_vars:
    raise ValueError(f"The following environment variables are missing in the Snowflake connection: {', '.join(missing_vars)}")

with DAG(
    "BuildELT_dbt",
    start_date=datetime(2024, 10, 14),
    description="A sample Airflow DAG to invoke dbt runs using a BashOperator",
    schedule_interval=None,  # Changed to `schedule_interval` for clarity
    catchup=False,
    default_args={"env": required_env_vars},
) as dag:
    # dbt run task
    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command=f"/home/airflow/.local/bin/dbt run --profiles-dir {DBT_PROJECT_DIR} --project-dir {DBT_PROJECT_DIR}",
    )

    # dbt test task
    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command=f"/home/airflow/.local/bin/dbt test --profiles-dir {DBT_PROJECT_DIR} --project-dir {DBT_PROJECT_DIR}",
    )

    # dbt snapshot task
    dbt_snapshot = BashOperator(
        task_id="dbt_snapshot",
        bash_command=f"/home/airflow/.local/bin/dbt snapshot --profiles-dir {DBT_PROJECT_DIR} --project-dir {DBT_PROJECT_DIR}",
    )

    # Define task dependencies
    dbt_run >> dbt_test >> dbt_snapshot
