#!/bin/bash

# point domain.tld to this machine

mkdir /mnt/traefik
cp ./traefik.toml /mnt/traefik/
docker-compose up -d
