.PHONY: deploy
SHELL := /bin/bash
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

ifndef REGION
override REGION = 'us-west-2'
endif

ifndef PACKER_NAME
override PACKER_NAME = 'amibuilder-linux'
endif

deploy:
		./build.sh
		docker-compose run --rm -v ~/.aws/credentials:/tmp/.aws/credentials -e PACKER_NAME="$(PACKER_NAME)" pakgo
		docker logout
