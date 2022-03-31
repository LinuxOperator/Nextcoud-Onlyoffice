#!/bin/sh

mkdir -p /portainer/Files/Inputs/certs/
cd /portainer/Files/Inputs/certs/
curl -O https://raw.githubusercontent.com/LinuxOperator/Nextcoud-Onlyoffice/main/example-certs/tls.crt
curl -O https://raw.githubusercontent.com/LinuxOperator/Nextcoud-Onlyoffice/main/example-certs/tls.key

mkdir -p /portainer/Files/Inputs/nginx
cd /portainer/Files/Inputs/nginx
curl -O https://raw.githubusercontent.com/LinuxOperator/Nextcoud-Onlyoffice/main/nginx.conf
