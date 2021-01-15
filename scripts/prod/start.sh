#!/bin/bash
docker network create main
docker-compose -f docker-compose-prod.yml up
