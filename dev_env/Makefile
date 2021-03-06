include .env
export 

SIMPLE_SQL_UP="CREATE DATABASE simple;"
SIMPLE_SQL_DOWN="DROP DATABASE IF EXISTS simple;"

get_tools:
	sudo pacman -S postgresql-libs

init:
	docker network create dev_env_net

# Use -c argument to execute SQL in the psql
migrate_up:
	psql -h ${POSTGRES_HOST} -p 5432 -U ${POSTGRES_USER} -d postgres -c $(SIMPLE_SQL_UP)

env_up:
	docker-compose up -d

migrate_down:
	psql -h ${POSTGRES_HOST} -p 5432 -U ${POSTGRES_USER} -d postgres -c $(SIMPLE_SQL_DOWN)

env_down:
	docker-compose down

sleep:
	@echo -n "WAITING FOR CONTAINERS..."
	@sleep 30

up: env_up sleep migrate_up

down: migrate_down env_down

all: get_tools init 