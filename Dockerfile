FROM apache/airflow:3.0.4
COPY requirements.txt /requirements.txt

RUN pip install --no-cache-dir -r /requirements.txt \
  --constraint https://raw.githubusercontent.com/apache/airflow/constraints-3.0.5/constraints-3.11.txt