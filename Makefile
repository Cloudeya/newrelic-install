.PHONY: build dev inspect clean

APP_PORT=8080
IMAGE_NAME=0xnu/alpine3-python3-docker
CONTAINER_NAME=mindhug-marketing-website-v1

build:
	docker build -t $(IMAGE_NAME) .

dev:
	docker run --rm -p $(APP_PORT):8080 --name $(CONTAINER_NAME) $(IMAGE_NAME)

inspect:
	docker inspect $(CONTAINER_NAME)

clean:
	docker system prune
