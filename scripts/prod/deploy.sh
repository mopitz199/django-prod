#!/bin/bash

# Check if docker network is present (if not, this deployment is being done the first time)
DOCKER_NETWORK_ID=$(docker network inspect main -f '{{ .Id }}')
if [[ "${DOCKER_NETWORK_ID}" == "" ]]; then 
    docker network create main;
    docker-compose -f docker-compose-prod.yml up --force-recreate -d traefik;
    docker-compose -f docker-compose-prod.yml up -d db
    docker-compose -f docker-compose-prod.yml up -d prometheus
    docker-compose -f docker-compose-prod.yml up -d grafana
    touch ./.colors;
    echo -e "export DEPLOYED_COLOR=blue" > .colors;
    echo -e "export IDLE_COLOR=green\n" >> .colors;
fi

# Get the latest colors config
source ./.colors
source ./.env

# Build and bring up new containers
# git pull origin main
# docker-compose -f docker-compose-prod.yml build --pull api
# docker-compose -f docker-compose-prod.yml up -d db
DEPLOYED_COLOR=$IDLE_COLOR docker-compose -f docker-compose-prod.yml -p $IDLE_COLOR up --scale api=1 --force-recreate -d api

# Bring down old containers once new ones are working
while [[ $(curl -s --location --request GET ''$COLOR_URL'' | tr -d \") != $IDLE_COLOR ]]; do :; done
docker-compose -p $DEPLOYED_COLOR -f docker-compose-prod.yml down

# Update the .colors config
echo -e "export DEPLOYED_COLOR="${IDLE_COLOR} > .colors
echo -e "export IDLE_COLOR="${DEPLOYED_COLOR} >> .colors

# Prune unused images/layers (from old deployment)
docker image prune -f