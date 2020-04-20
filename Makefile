.PHONY: build dev prod inspect clean system

APP_PORT=8080
IMAGE_NAME=0xnu/alpine3-python3-docker
CONTAINER_NAME=mmw
VERSION=v0.1
# PROJECT_ID=mindhug-marketing-site

build:
	docker build -t $(IMAGE_NAME):latest -t $(CONTAINER_NAME):$(VERSION) .

dev:
	docker run --rm -p $(APP_PORT):8080 --name $(CONTAINER_NAME) $(IMAGE_NAME)

prod:
	docker push gcr.io/${PROJECT_ID}/$(CONTAINER_NAME):$(VERSION)

inspect:
	docker inspect $(CONTAINER_NAME)

clean:
	docker image prune --all

system:
	docker system prune --all
