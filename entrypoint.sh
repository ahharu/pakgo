#!/usr/bin/env bash

if [ -f /tmp/.aws/credentials ]
then
  mkdir -p /root/.aws
  cp /tmp/.aws/credentials ~/.aws/
  chown root:root ~/.aws/credentials
fi

cd packer-infra
packer build -var-file=env/$PACKER_NAME.json $PACKER_NAME.json

cd ansible

ansible-playbook -vvvv tf-infra.yml --extra-vars "environ=$ENVIRONMENT state=$STATE hosted_zone_id=$HOSTED_ZONE_ID region=$REGION project_name=$PROJECT_NAME state=$STATE public_key_name=$PUBLIC_KEY_NAME"

/bin/bash