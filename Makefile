create-local-airflow-repositiories:
	@mkdir ./dags ./config ./logs ./plugins ./libs ./data
	@printf "AIRFLOW_UID=%s\nAIRFLOW_GUID=%s\n" "$$(id -u)" "$$(id -g)" > .env
	@chown -R $$(id -u):$$(id -g) dags config logs plugins libs data

create-docker-network-bridge:
	docker network create network-etl

delete-local-airflow-repositories:
	rm -rf ./dags ./comfig ./logs ./plugins ./config ./libs ./data .env

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
