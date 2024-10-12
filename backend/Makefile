SHELL := /bin/bash

.PHONY: all
all: rebuild start

.PHONY: build
build:
	@docker-compose build

.PHONY: rebuild
rebuild:
	@docker-compose build --force-rm

.PHONY: start
start:
	@docker-compose up -d

.PHONY: stop
stop:
	@docker-compose stop

.PHONY: restart
restart: stop start

.PHONY: logs
logs:
	@docker-compose logs -f --tail 100

.PHONY: pg-cli
pg-cli:
	@docker exec -it 33routes-postgres psql -U postgres -d 33routes

.PHONY: rm-pg-data
rm-pg-data:
	@rm -rf database/postgres/data && \
	mkdir database/postgres/data

.PHONY: clear-all
clear-all: clear rm-pg-data

.PHONY: clear
clear:
	@docker-compose kill  && \
	docker-compose rm -f 




# .PHONY: k8s-deploy
# k8s-deploy:
# 	kubectl apply -f kubernetes/api-gateway-deployment.yaml
# 	kubectl apply -f kubernetes/auth-service-deployment.yaml
# 	kubectl apply -f kubernetes/user-service-deployment.yaml
# 	kubectl apply -f kubernetes/route-service-deployment.yaml

# .PHONY: k8s-delete
# k8s-delete:
# 	kubectl delete -f kubernetes/api-gateway-deployment.yaml
# 	kubectl delete -f kubernetes/auth-service-deployment.yaml
# 	kubectl delete -f kubernetes/user-service-deployment.yaml
# 	kubectl delete -f kubernetes/route-service-deployment.yaml
