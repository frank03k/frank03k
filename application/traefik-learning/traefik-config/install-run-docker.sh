#!/usr/bin/env bash -euo
# os patching
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
# install docker components
sudo apt install docker docker-compose -y
# start application
docker-compose -f /traefik-config/docker-compose.yml up -d
