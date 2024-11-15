up:
	docker compose up || docker-compose up

elephant:
	docker exec -it airflow_demon_summoning-warehouse-1 psql -p 5432 -U postgres -d postgres

dolphin:
	docker exec -it airflow_demon_summoning-transactional_db-1 mysql -u root -p

down:
	docker rm --force \
		airflow_demon_summoning-airflow_metadata_db-1 \
		airflow_demon_summoning-airflow_scheduler-1 \
		airflow_demon_summoning-airflow_webserver-1 \
		airflow_demon_summoning-dbt-1 \
		airflow_demon_summoning-transactional_db-1 \
		airflow_demon_summoning-warehouse-1

boom:
	make down && docker rmi postgres:15 mysql:5.6 --force
