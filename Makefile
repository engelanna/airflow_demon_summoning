up:
	docker compose up || docker-compose up

elephant:
	docker exec -it carepay_engelanna-warehouse-1 psql -p 5432 -U postgres -d postgres

dolphin:
	docker exec -it carepay_engelanna-transactional_db-1 mysql -u root -p

down:
	docker rm --force \
		carepay_engelanna-airflow_scheduler-1 \
		carepay_engelanna-airflow_metadata_db-1 \
		carepay_engelanna-dbt-1 \
		carepay_engelanna-transactional_db-1 \
		carepay_engelanna-warehouse-1

boom:
	make down && docker rmi postgres:15 mysql:5.6 --force
