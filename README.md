# Docker-Compose Opsdroid

*TL/DR*
This repository will quickly deploy the opsdroid bot alongside a Jenkins instance in docker containers using docker-compose. using a connector of your choice you can easily build jobs. This also provides a template how to use docker-compose to deploy an opsdroid bot alonside a service of your choice. To use your new skill, simply modify the `includes.yaml` file to pull in your skill's docker-compose file.

This repository makes it easy to extend the opsdroid bot with custom modules using Docker and Docker-Compose. This project assumes that you are already familiar with using opsdroid, please reference the official [documentation](http://opsdroid.readthedocs.io/en/latest/configuration-reference/) for more information. 

In the provided is an example connection to Jenkins, the `jenkins_home` directory is mounted to `.jenkins_home`. This directory can be copied to wherever you intend to deploy your final project. To deploy a bot using this repository, first make sure you have the pre-requisites installed (listed below). You will likely want to clone the skills that will be used into a sibling directory. You will need to adjust the `includes.yaml` file to the relative path to the skill directory. You will need to modify any paths in the skill `docker-compose.yaml` file as well. All configurations are mounted from the config directory, you will want to add any connectors or skills that you have in your normal configuration file.


## Run

*Setup:*
* Make sure you have the [prerequisites](Prerequisites) installed.
* in the `config` directory in this repository, copy `jenkins_credentials.yaml.example` to `jenkins_credentials.yaml` with the username and password you intend to use when setting up Jenkins. This will allow the opsdroid bot to connect and build jobs. You may also want to add any skills or customizations from another opsdroid configuration to the `configuration.yaml` file.

*Deploy:*
* Run `./build_stack.sh`. This will pull in the remote docker-compose file for the Opsdroid-Jenkins skill, merge it with the docker-compose file in this repository, and deploy the bot container alongside a jenkins instace.
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
* you will need to install [compose-addons](https://github.com/dnephin/compose-addons): `pip install compose-addons`


## Project Structure:

This section provides more detail into how this repository operates & details how to use docker-compose with opsdroid.

---

#### `Includes.yaml`

The includes file is what brings in remote docker-compose files. The sytax is important for allowing *docker-compose addons* (*dcao*) to perform it's magic. I recommend building your custom opsdroid skills in a sibling directory to this project and using the relative path to the compose file in the `includes.yaml` file. The namespace is also important for *dcao* to tie multiple compose files together

#### `Docker-Compose-core.yaml`

The compose core file is used as a base when *dcao* merges compose files together. Anything defined here will be over written if re-defined in subsequent compose files in the `includes.yaml` 

#### `build_stack.sh`

Build stack is a simple shell script to run the deploy pipeline from start to finish. After running the build stack, the new `docker-compose.yaml` can be used for future deployments.

#### `./config`

Opsdroid allows the syntax `!include` in it's configuration files and referenced by relative paths. If you extend your skill configuration using includes, you can host them in this directory. The entire directory is mounted into the container and should provide all of the necessary configuration the opsdroid container needs to operate. 
