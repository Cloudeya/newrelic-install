.PHONY: all verify lint test check security dev deploy clean system

IMAGE_NAME=0xnu/alpine3-python3-docker
BUILD=docker build -t
RUN=docker run --rm -it
TESTS=./tests/structure-tests.yaml
CONTAINER_NAME=mmw1
BUILD_NAME=mmw
VERSION=v0.19
PROJECT_ID=mindhug-marketing-site
SUBMIT=gcloud builds submit --tag

all: verify dev

verify: lint test validate check

lint:
	type Dockerfile | docker run --rm -i hadolint/hadolint hadolint --ignore SC2035 -

test:
	$(BUILD) test -t $(IMAGE_NAME) .

check:
	$(BUILD) check -t $(IMAGE_NAME) .

security:
	$(BUILD) security -t $(IMAGE_NAME) --build-arg MICROSCANNER=$(MICROSCANNER) .

dev:
	python3 ./src/main.py

deploy:
	$(SUBMIT) gcr.io/$(PROJECT_ID)/$(CONTAINER_NAME)/$(BUILD_NAME):$(VERSION) .

clean:
	docker image prune --all

system:
	docker system prune --all
