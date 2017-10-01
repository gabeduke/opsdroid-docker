# Docker-Compose Opsdroid

*TL/DR*


This repository will quickly deploy the opsdroid bot alongside a Jenkins instance in docker containers using docker-compose. using a connector of your choice you can easily build jobs. This also provides a template how to use docker-compose to deploy an opsdroid bot alonside a service of your choice. 

This repository makes it easy to extend the opsdroid bot with custom modules using Docker and Docker-Compose. This project assumes that you are already familiar with using opsdroid, please reference the official [documentation](http://opsdroid.readthedocs.io/en/latest/configuration-reference/) for more information. 

In the provided is an example connection to Jenkins, the `jenkins_home` directory is mounted to `.jenkins_home`. This directory can be copied to wherever you intend to deploy your final project. To deploy a bot using this repository, first make sure you have the pre-requisites installed (listed below). 


## Run

*Setup:*
* Make sure you have the [prerequisites](Prerequisites) installed.

*Deploy:*
* run `example.build_stack.sh`: This will pull in the remote docker-compose file for the Opsdroid-Jenkins skill, merge it with the docker-compose file in this repository, and deploy the bot container alongside a jenkins instance.
    * Optional Configuration steps:
        * Edit `config/jenkins_credentials.yaml` to match the credentials you intend on using for jenkins
        * Edit `config/configuration.yaml` to include any skills or customizations from another opsdroid configuration. However, be advised that there are some configurations that are necessary for opsdroid to function well in a container. There are no customizations necessary for this example to function.
    * Verify the containers are running: `docker ps`
    * Verify the bot is running: `docker logs opsdroid` (`CTRL + C` to exit)
    * Verify Jenkins is running: `docker logs jenkins`. On first run, make sure you grab the *First Time Authentication Token* (`CTRL + C` to exit)
    
*Usage:*
* You can access jenkins at [localhost:8080](http://localhost:8081). The first time access token can be found by running `docker logs jenkins` in a terminal
    * If following the example then you will need to create a jenkins job called `builder` that takes no parameters
* Using the opsdroid desktop connector, type `build`. If you navigate back to jenkins in your browser, you will see the job queue and execute. 


## Prerequisites:

*Opsdroid Connector*
* To follow the example in this tutorial you will want to have the [Opsdroid Desktop Client](https://github.com/opsdroid/opsdroid-desktop) installed. This will allow communication via websocket to the containerized bot.

*Docker:*
* You will need to install [docker](https://docs.docker.com/engine/installation/)
* You will need to install [docker-compose](https://docs.docker.com/compose/install/)


## Project Structure:

This section provides more detail into how this repository operates & details how to use docker-compose with opsdroid.

---

#### `Docker-Compose-core.yaml`

The compose core file is used as a base when *dcao* merges compose files together. Anything defined here will be over written if re-defined in subsequent compose files in the `includes.yaml` 

#### `example.build_stack.sh`

Build stack is a simple shell script to run the deploy pipeline from start to finish. After running the build stack, the new `docker-compose.yaml` can be used for future deployments.

#### `./config`

Opsdroid allows the syntax `!include` in it's configuration files and referenced by relative paths. If you extend your skill configuration using includes, you can host them in this directory.
