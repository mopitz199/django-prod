# Check if docker network is present (if not, this deployment is being done the first time)
docker network create main;
DOCKER_NETWORK_ID=$(docker network inspect main -f '{{ .Id }}')
if [[ "${DOCKER_NETWORK_ID}" == "" ]]; then 
    docker-compose -f docker-compose-prod.yml up -d traefik;
    touch ./.colors;
    echo -e "export DEPLOYED_COLOR=blue" > .colors;
    echo -e "export IDLE_COLOR=green\n" >> .colors;
fi

# Get the latest colors config
source ./.colors

# Build and bring up new containers
# git pull
# docker-compose build --pull api
docker-compose -f docker-compose-prod.yml up -p $IDLE_COLOR  -d -e DEPLOYMENT_COLOR=$IDLE_COLOR  --scale api=1 --force-recreate api

# Bring down old containers once new ones are working
while [[ $(curl -s --location --request GET 'http://localhost/deployment_color' | tr -d \") != $IDLE_COLOR ]]; do :; done
docker-compose -f docker-compose-prod.yml -p $DEPLOYED_COLOR down

# Update the .colors config
echo -e "export DEPLOYED_COLOR="${IDLE_COLOR} > .colors
echo -e "export IDLE_COLOR="${DEPLOYED_COLOR} >> .colors

# Prune unused images/layers (from old deployment)
docker image prune -f