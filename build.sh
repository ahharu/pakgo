#!/usr/bin/env bash

PROJECT_NAME=$1

./build-${PROJECT_NAME}.sh
echo "$PROJECT_NAME"

docker-compose build