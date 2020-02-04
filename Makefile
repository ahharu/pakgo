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

ifndef PROJECT_NAME
override PROJECT_NAME = 'pakgo'
endif

ifndef SSH_KEY
override SSH_KEY = 'pakgo'
endif

ifndef STATE
override STATE = 'present'
endif

ifndef ENVIRONMENT
override ENVIRONMENT = 'dev'
endif


deploy:
		./build.sh $(PROJECT_NAME)
		docker-compose run --rm -v ~/.aws/credentials:/tmp/.aws/credentials -e REGION="$(REGION)" -e PACKER_NAME="$(PACKER_NAME)" -e PROJECT_NAME="$(PROJECT_NAME)" -e ENVIRONMENT="$(ENVIRONMENT)" -e STATE="$(STATE)" -e SSH_KEY="$(SSH_KEY)" pakgo
		docker logout
