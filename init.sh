#!/bin/bash

# run this on the docker host where you are setting up vault/goldfish
# point vault.domain.tld and goldfish.domain.tld to this machine

set -e

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
SETTINGS="$SCRIPTPATH/settings.sh"

if [ ! -f $SETTINGS ]; then
  echo "Please copy settings.sh.template to settings.sh first and edit it according to your requirements"
  exit 1
fi

source $SETTINGS

echo "Email: $EMAIL"
echo "Vault:$VAULT"
echo "Goldfish:$GOLDFISH"

sed "s/mail@domain.tld/$EMAIL/g" traefik.toml.template > traefik.toml
sed "s/vault.domain.tld/$VAULT/g" traefik.toml > traefik.toml.tmp && mv traefik.toml.tmp traefik.toml
sed "s/goldfish.domain.tld/$GOLDFISH/g" traefik.toml > traefik.toml.tmp && mv traefik.toml.tmp traefik.toml
sed "s/vault.domain.tld/$VAULT/g" docker-compose.yml.template > docker-compose.yml
sed "s/goldfish.domain.tld/$GOLDFISH/g" docker-compose.yml > docker-compose.yml.tmp && mv docker-compose.yml.tmp docker-compose.yml

mkdir -p /mnt/traefik
cp ./traefik.toml /mnt/traefik/
docker-compose up -d
