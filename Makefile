up:
	docker compose up || docker-compose up

elephant:
	docker exec -it airflow-demon-summoning-warehouse-1 psql -p 5432 -U postgres -d postgres

dolphin:
	docker exec -it airflow-demon-summoning-transactional_db-1 mysql -u root -p

down:
	docker rm --force \
		airflow-demon-summoning-airflow_metadata_db-1 \
		airflow-demon-summoning-airflow_scheduler-1 \
		airflow-demon-summoning-airflow_webserver-1 \
		airflow-demon-summoning-dbt-1 \
		airflow-demon-summoning-transactional_db-1 \
		airflow-demon-summoning-warehouse-1

boom:
	make down && docker rmi postgres:15 mysql:5.6 --force
