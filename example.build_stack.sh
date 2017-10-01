#!/usr/bin/env bash

# otherwise docker daemon will create with root level permission
mkdir -p ~/.jenkins_home

# pull in external docker-compose files
git clone \
    https://github.com/gabeduke/opsdroid-jenkins \
    config/modules/opsdroid-jenkins

# merge docker-compose files
docker-compose \
    -f docker-compose-core.yaml \
    -f config/modules/opsdroid-jenkins/docker-compose.yaml \
    config > docker-compose.yaml

# Run opsdroid docker cluster
docker-compose up -d --build
