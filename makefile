default: help

SRC_DIR=src
DEST_DIR=public

DEST_INDEX=$(DEST_DIR)/index.html
SRC_INDEX=$(SRC_DIR)/index.html

GIT_SHA=$(shell git rev-parse --short HEAD)
PROJECT=$(shell basename $$(pwd))

NODE_MODULES=$(shell jq -r '.["dependencies"] * .["devDependencies"] | keys[] | "node_modules/" + .' package.json )

build: index static ## Build the app

index: | $(DEST_INDEX)

$(DEST_INDEX):
	@mkdir public
	cp $(SRC_INDEX) $(DEST_INDEX)

static: $(DEST_DIR)/fonts
	cp -r $(SRC_DIR)/js $(SRC_DIR)/css $(DEST_DIR)/

$(DEST_DIR)/fonts: node_modules
	@mkdir -p $(DEST_DIR)/fonts $(DEST_DIR)/css
	cp node_modules/@fortawesome/fontawesome-free/css/all.css $(DEST_DIR)/css/
	cp node_modules/@fortawesome/fontawesome-free/webfonts/fa-* $(DEST_DIR)/fonts/

node_modules: $(NODE_MODULES)
$(NODE_MODULES):
	npm ci

help: ## Show this help.
	@echo "Targets:"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' -e 's/:.*##/:/' -e 's/^/  /'

clean: ## Clean up build artifacts
	rm -rf node_modules $(DEST_DIR)

docker-build: ## Build a docker container of this project
	docker build . -t $(PROJECT):$(GIT_SHA)

docker-run: ## Run the docker container of this project
	docker run --rm --publish 8080:8080 $(PROJECT):$(GIT_SHA)

curl: ## Curl the docker container of this project
	curl localhost:8080

.PHONY: default clean node_modules index help docker-build docker-run curl
