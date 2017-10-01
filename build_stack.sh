#!/usr/bin/env bash

# pull in external docker-compose files
git clone \
    -b docker-compose \
    https://github.com/gabeduke/opsdroid-jenkins \
    config/modules/opsdroid-jenkins

# merge docker-compose files
docker-compose \
    -f docker-compose-core.yaml \
    -f config/modules/opsdroid-jenkins/docker-compose.yaml \
    config > docker-compose.yaml

# Run opsdroid docker-compose cluster
docker-compose up -d --build
