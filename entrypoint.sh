#!/usr/bin/env bash

if [ -f /tmp/.aws/credentials ]
then
  mkdir -p /root/.aws
  cp /tmp/.aws/credentials ~/.aws/
  chown root:root ~/.aws/credentials
fi

cd packer-infra
##packer build -var "environment=$ENVIRONMENT" -var "file_name=$FILE_NAME" -var "public_key_name=$SSH_KEY" -var-file=env/$PACKER_NAME.json $PACKER_NAME.json

cd -
cd ansible

ansible-playbook -vvvv tf-infra.yml --extra-vars "environ=$ENVIRONMENT state=$STATE hosted_zone_id=$HOSTED_ZONE_ID region=$REGION project_name=$PROJECT_NAME state=$STATE public_key_name=$SSH_KEY file_name=$FILE_NAME"

/bin/bash