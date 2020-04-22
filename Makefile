.PHONY: all verify lint test check security build dev prod validate dive deploy clean system

APP_PORT=8080
DOCS_PORT=5000
IMAGE_NAME=0xnu/alpine3-python3-docker
BUILD=docker build -t
RUN=docker run --rm -it
TESTS=./kubernetes/structure-tests.yaml
CONTAINER_NAME=mmw1
VERSION=v0.10
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

build:
	$(BUILD) $(IMAGE_NAME):latest -t $(CONTAINER_NAME):$(VERSION) .

dev:
	$(BUILD) dev -t $(IMAGE_NAME) .
	$(RUN) -p $(APP_PORT):8080 $(IMAGE_NAME)

.prod-build:
	$(BUILD) prod -t $(IMAGE_NAME) .

prod: .prod-build
	$(RUN) -p $(APP_PORT):8080 $(IMAGE_NAME)

validate: .prod-build
	$(RUN) -v /var/run/docker.sock:/var/run/docker.sock -v $(CURDIR)/$(TESTS):/tmp/tests.yaml gcr.io/gcp-runtimes/container-structure-test test --image $(IMAGE_NAME) --config /tmp/tests.yaml

dive: .prod-build
	$(RUN) -v //var/run/docker.sock:/var/run/docker.sock wagoodman/dive $(IMAGE_NAME)

deploy:
	$(SUBMIT) gcr.io/$(PROJECT_ID)/$(CONTAINER_NAME):$(VERSION) .

clean:
	docker image prune --all

system:
	docker system prune --all
