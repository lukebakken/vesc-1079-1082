.PHONY: clean down import up

RABBITMQ_DOCKER_TAG ?= 3-management

export RABBITMQ_QUEUE_TYPE

clean: down
	docker compose rm

down:
	docker compose down --volumes

import:
	/bin/sh $(CURDIR)/import-defs.sh

up:
ifeq ($(RABBITMQ_QUEUE_TYPE),quorum)
	/bin/sh $(CURDIR)/template-defs.sh
else ifeq ($(RABBITMQ_QUEUE_TYPE),classic)
	/bin/sh $(CURDIR)/template-defs.sh
else
	$(error Please set RABBITMQ_QUEUE_TYPE to 'quorum' or 'classic')
endif
ifdef DOCKER_FRESH
	docker compose build --no-cache --pull --build-arg RABBITMQ_DOCKER_TAG=$(RABBITMQ_DOCKER_TAG)
	docker compose up --pull always
else
	docker compose build --build-arg RABBITMQ_DOCKER_TAG=$(RABBITMQ_DOCKER_TAG)
	docker compose up
endif
