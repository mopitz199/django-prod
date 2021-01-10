#!/bin/bash
docker network create web
docker-compose -f docker-compose-prod.yml up
