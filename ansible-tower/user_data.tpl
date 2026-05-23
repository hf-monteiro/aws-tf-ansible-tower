#!/bin/bash

sudo yum install wget -y
sudo yum update -y

sudo wget https://s3-example.s3.amazonaws.com/ansible-automation-platform-setup-bundle-2.1.0-1.tar.gz
sleep 40

sudo tar xvf ansible-automation-platform-setup-bundle-2.1.0-1.tar.gz
cd ansible-automation-platform-setup-bundle-2.1.0-1

# Lab bootstrap only. Inject real secrets at runtime from SSM/Secrets Manager for shared environments.
ADMIN_PASSWORD=$(openssl rand -base64 24)
PG_PASSWORD=$(openssl rand -base64 24)
REGISTRY_USERNAME="${registry_username:-replace-at-runtime}"
REGISTRY_PASSWORD="${registry_password:-replace-at-runtime}"

sudo sed -i -e "s/admin_password=''/admin_password='$ADMIN_PASSWORD'/g" inventory
sudo sed -i -e "s/pg_password=''/pg_password='$PG_PASSWORD'/g" inventory
sudo sed -i -e "s/registry_username=''/registry_username='$REGISTRY_USERNAME'/g" inventory
sudo sed -i -e "s/registry_password=''/registry_password='$REGISTRY_PASSWORD'/g" inventory



sudo ./setup.sh
sleep 120