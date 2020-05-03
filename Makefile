IMAGE_NAME=0xnu/alpine3-python3-docker
BUILD=docker build -t
RUN=docker run --rm -it
TESTS=./tests/structure-tests.yaml
CONTAINER_NAME=mmw1
BUILD_NAME=mmw
VERSION=v1.0.10
PROJECT_ID=mindhug-marketing-site
SUBMIT=gcloud builds submit --tag

verify: lint test check security ## Verify everything!
	@echo "lint, test, check and perform security assessment of a Docker image."
	@lint test check security

lint: ## Start Dockerfile linter.
	@echo "Starting Dockerfile linter..."
	@type Dockerfile | docker run --rm -i hadolint/hadolint hadolint --ignore SC2035 -

test: ## Test Docker image.
	@echo "Testing Docker image..."
	@$(BUILD) test -t $(IMAGE_NAME) .

check: ## Sanity check for Docker image.
	@echo "Sanity check for Docker image..."
	@$(BUILD) check -t $(IMAGE_NAME) .

security: ## Check Docker image security.
	@echo "Checking Docker image security..."
	@$(BUILD) security -t $(IMAGE_NAME) --build-arg MICROSCANNER=$(MICROSCANNER) .

dev: ## Spin up development instance.
	@echo "Starting development instance..."
	@python3 ./src/main.py

deploy: ## Send Docker image to GCP.
	@echo " ## Sending Docker image to GCP..."
	@$(SUBMIT) gcr.io/$(PROJECT_ID)/$(CONTAINER_NAME)/$(BUILD_NAME):$(VERSION) .

applychanges: ## Apply changes to GCP Kubernetes Manifests.
	@echo "Applying changes to GCP Kubernetes Manifests..."
	@kubectl apply -f ./k8s/mmw-production.yaml
	@kubectl apply -f ./k8s/mmw-staging.yaml
	@kubectl apply -f ./k8s/mmw-prod.yaml

clean: ## Remove Docker images.
	@echo "Removing Docker images..."
	@docker image prune --all

system: ## Remove Docker at system level.
	@echo "Removing Docker at system level..."
	@docker system prune --all

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: help

.DEFAULT_GOAL := help