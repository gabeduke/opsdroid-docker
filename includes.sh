#!/usr/bin/env bash

# pull in external docker-compose files
dcao-include -o docker-compose-includes.yaml includes.yaml

# merge docker-compose files
dcao-merge -o docker-compose-prod.yaml docker-compose.yaml docker-compose-includes.yaml

# Run opsdroid docker-compose cluster
/home/gabeduke/repos/opsdroid-docker/config
