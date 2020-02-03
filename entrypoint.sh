#!/usr/bin/env bash

if [ -f /tmp/.aws/credentials ]
then
  mkdir -p /root/.aws
  cp /tmp/.aws/credentials ~/.aws/
  chown root:root ~/.aws/credentials
fi

cd packer-infra
##packer build -var-file=env/$PACKER_NAME.json $PACKER_NAME.json

/bin/bash