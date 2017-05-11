SHELL := /bin/bash
CWD := $(shell pwd)
IMAGE := "jamrizzi/php-nginx-alpine:php7"
SOME_CONTAINER := $(shell echo some-$(IMAGE) | sed 's/[^a-zA-Z0-9]//g')
DOCKERFILE := $(CWD)/php7/Dockerfile

.PHONY: all
all: clean fetch_dependancies build

.PHONY: build
build:
	@docker build -t $(IMAGE) -f $(DOCKERFILE) $(CWD)
	@echo built $(IMAGE)

.PHONY: pull
pull:
	@docker pull $(IMAGE)
	@echo pulled $(IMAGE)

.PHONY: push
push:
	@docker tag $(IMAGE) jamrizzi/php-nginx-alpine:latest
	@docker push jamrizzi/php-nginx-alpine:latest
	@docker push $(IMAGE)
	@echo pushed $(IMAGE)

.PHONY: run
run:
	@docker run --name $(SOME_CONTAINER) --rm -p 8888:8888 $(IMAGE)
	@echo ran $(IMAGE)

.PHONY: ssh
ssh:
	@docker run --name $(SOME_CONTAINER) --rm -it --entrypoint /bin/sh -p 8888:8888 $(IMAGE)

.PHONY: essh
essh:
	@docker exec -it $(SOME_CONTAINER) /bin/sh

.PHONY: clean
clean:
	@echo cleaned

.PHONY: fetch_dependancies
fetch_dependancies: docker
	@echo fetched dependancies
.PHONY: docker
docker:
ifeq ($(shell whereis docker), $(shell echo docker:))
	@curl -L https://get.docker.com/ | bash
endif
	@echo fetched docker
