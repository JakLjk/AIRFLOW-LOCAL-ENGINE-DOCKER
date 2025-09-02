FROM apache/airflow:3.0.4

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      libkrb5-dev \
    && rm -rf /var/lib/apt/lists/*
USER airflow

COPY requirements.txt /requirements.txt

RUN pip install --no-cache-dir -r /requirements.txt \
  --constraint https://raw.githubusercontent.com/apache/airflow/constraints-3.0.4/constraints-3.12.txt