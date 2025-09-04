FROM apache/airflow:3.0.4

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
      curl ca-certificates \
      openjdk-17-jre-headless \
      build-essential libkrb5-dev \
    && rm -rf /var/lib/apt/lists/*

ENV SPARK_VERSION=4.0.0 HADOOP_VERSION=3
RUN curl -L https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
  | tar -xz -C /opt \
  && ln -s /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark
ENV SPARK_HOME=/opt/spark
ENV PATH="$SPARK_HOME/bin:$PATH"
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

USER airflow

COPY requirements.txt /requirements.txt

RUN pip install --no-cache-dir -r /requirements.txt \
  --constraint https://raw.githubusercontent.com/apache/airflow/constraints-3.0.4/constraints-3.12.txt