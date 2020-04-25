.PHONY: all verify lint test check security build dev prod validate dive kubesp kubesp-ingress certmanager hcm deploy clean system

APP_PORT=8080
DOCS_PORT=5000
IMAGE_NAME=0xnu/alpine3-python3-docker
BUILD=docker build -t
RUN=docker run --rm -it
TESTS=./tests/structure-tests.yaml
CONTAINER_NAME=mmw1
VERSION=v0.15
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

helm:
	chmod +x ./helm/secure_helm.sh
	chmod +x ./helm/secure_redis.sh
	./helm/secure_helm.sh && ./helm/secure_redis.sh

kubesp:
	kubectl create -f ./k8s/mindhug-staging.yaml
	kubectl create -f ./k8s/mindhug-prod.yaml
	kubectl get service

kubesp-ingress:
	kubectl create -f ./k8s/mindhug-ingress.yaml

certmanager:
	kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.14.1/cert-manager.crds.yaml
	kubectl create namespace cert-manager

# Add Jetstack Helm repository to Helm. It hosts the Cert-Manager chart.
hcm:
	helm repo add jetstack https://charts.jetstack.io
	helm install cert-manager --version v0.14.1 --namespace cert-manager jetstack/cert-manager

letsencrypt:
	kubectl create -f letsencrypt-issuer.yaml
	kubectl apply -f mindhug-ingress.yaml
	kubectl describe certificate mindhug-tls

deploy:
	$(SUBMIT) gcr.io/$(PROJECT_ID)/$(CONTAINER_NAME):$(VERSION) .

clean:
	docker image prune --all

system:
	docker system prune --all
