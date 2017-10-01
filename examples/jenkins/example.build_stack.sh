#!/usr/bin/env bash

PROJECT_ROOT=$(git rev-parse --show-toplevel)
CONFIG_DIR=${PROJECT_ROOT}/config/
MODULES_DIR=${PROJECT_ROOT}/config/modules/
PWD=$(pwd)

echo 'Copy example configs'
cp example.configuration.yaml ${CONFIG_DIR}/configuration.yaml
cp example.jenkins_credentials.yaml ${CONFIG_DIR}/jenkins_credentials.yaml

# otherwise docker daemon will create with root level permission
echo 'Touch ~/.jenkins_home'
mkdir -p ~/.jenkins_home

echo 'Pull in external docker-compose files'
git clone \
    https://github.com/gabeduke/opsdroid-jenkins \
    ${MODULES_DIR}/opsdroid-jenkins \
    || true #ignore errors if directory already exists

echo 'Merge docker-compose files'
docker-compose \
    -f ${PROJECT_ROOT}/core_docker-compose.yaml \
    -f ${MODULES_DIR}/opsdroid-jenkins/docker-compose.yaml \
    config > ${PROJECT_ROOT}/jenkins_docker-compose.yaml

echo 'Run opsdroid docker cluster'
pushd ${PROJECT_ROOT}
    docker-compose \
    -f jenkins_docker-compose.yaml \
    up -d --build --force-recreate
popd