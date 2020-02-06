#!/usr/bin/env bash

if [ ! -d go-hello-world ]
then
  git clone git@github.com:stayforlong/go-hello-world.git
  cd go-hello-world
else
  cd go-hello-world
  git pull
fi

#make docker-build