#!/usr/bin/env bash

PROJECT_NAME=$1

./build-${PROJECT_NAME}.sh
echo "$PROJECT_NAME"

$FILE_EXECUTE

docker-compose build