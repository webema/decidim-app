.PHONY: all build push build-ci push-ci

image_name := ema/decidim-app
repo_uri := nexus.devops-e.de:8090

all: build push

build:
	docker build --pull --build-arg FA_NPM_TOKEN -t $(image_name) .

push:
	docker tag $(image_name):latest $(repo_uri)/$(image_name):latest
	docker push $(repo_uri)/$(image_name):latest

build-ci: build

push-ci: push
