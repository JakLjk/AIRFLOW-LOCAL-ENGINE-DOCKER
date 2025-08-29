create-local-airflow-repositiories:
	mkdir ./dags ./config ./logs ./plugins
	@echo "AIRFLOW_UID=$$(id -u)" > .env

delete-local-airflow-repositories:
	rm -rf ./dags ./comfig ./logs ./plugins ./config .env

build-docker-image:
	docker build --no-cache --tag extending-airflow:latest .

run-init:
	docker compose up airflow-init

run:
	docker compose up -d

down:
	docker compose down

down-clean:
	docker compose down --volumes --remove-orphans