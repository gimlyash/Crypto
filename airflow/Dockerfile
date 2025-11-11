FROM apache/airflow:2.10.1

USER root
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*
USER airflow

COPY dags/ /opt/airflow/dags/
COPY plugins/ /opt/airflow/plugins/


