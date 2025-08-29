# Local Airflow with Docker (Single Node - Lightweight Setup)

[![Airflow](https://img.shields.io/badge/Apache%20Airflow-3.0.4-blue?logo=apacheairflow)](https://airflow.apache.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13-blue?logo=postgresql)](https://www.postgresql.org/)
[![Docker Compose](https://img.shields.io/badge/Docker--Compose-Local%20Dev-green?logo=docker)](https://docs.docker.com/compose/)

This project provides a **minimal, local Airflow cluster** running with:

- **LocalExecutor** (lightweight, single-node – no Celery workers or Redis)  
- **PostgreSQL 13** as Airflow metadata DB  
- Optional extension via a **custom Airflow image** that installs additional Python libraries from `requirements.txt`.

---

##  Prerequisites

- [Docker](https://docs.docker.com/get-docker/) >= 20.x  
- [Docker Compose](https://docs.docker.com/compose/) >= v2.x  
- At least **2 CPUs, 4GB RAM, 10GB disk free** (see `airflow-init` resource checks)

---

##  Build Custom Airflow Image

The `Dockerfile` is based on **apache/airflow:3.0.4** and installs additional requirements:

```dockerfile
FROM apache/airflow:3.0.4
COPY requirements.txt /requirements.txt

RUN pip install --no-cache-dir -r /requirements.txt \
  --constraint https://raw.githubusercontent.com/apache/airflow/constraints-3.0.5/constraints-3.11.txt
```

To build it use command (it creates `extending-airflow:latest` image):
```bash
make build-docker-image
```

## Usage
1. Create local airflow directories:

    ```bash
    make create-local-airflow-repositiories
    ```
    This creates local folders: dags/, logs/, plugins/, config/
    and .env file with `AIRFLOW_UID`

    As per official airflow documentation, setting up `AIRFLOW_UID` is necesary on linux systems in order to create folders with proper user ownership

2. Initialize Airflow DB & user:
    ```bash
    make run-init
    ```
    This runs the `airflow-init` one-shot container:
    - Runs DB migrations
    - Creates admin user (airflow / airflow by default)

3. Start Airflow service:
    ```bash
    make run
    ```

4. Stop stack:
    ```bash
    make down
    ```

5. Remove stack with volumes:
    ```bash
    make down-clean
    ```

6. Delete local folders with dags/plugins/logs/config and env:
    ```bash
    make delete-local-airflow-repositories
    ```

# Ports
Airflow webserver:
- Host: 8084
- Container: 8080


# Notes
- Executor: LocalExecutor (single machine, parallelism enabled)
- No Celery / Redis: lightweight stack for dev/testing
- Airflow config: mounted from ./config/airflow.cfg
- Custom libs: add to requirements.txt and rebuild