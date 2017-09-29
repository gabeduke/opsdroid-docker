#!/usr/bin/env bash

# pull in external docker-compose files
dcao-include -o docker-compose-includes.yaml includes.yaml

# merge docker-compose files
dcao-merge -o docker-compose.yaml docker-compose-core.yaml docker-compose-includes.yaml

# Run opsdroid docker-compose cluster
docker-compose up -d