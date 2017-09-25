# Docker-Compose Opsdroid

This repository makes it easy to extend the opsdroid bot with custom modules using Docker and Docker-Compose. Custom modules and configurations are mounted into a docker container running opsdroid, without the overhead of obsdroid libraries in your development environment. This project assumes that you are already familiar with extending opsdroid, please reference the official [documentation](http://opsdroid.readthedocs.io/en/latest/configuration-reference/) for more information. More information on debugging your module in Intellij can be found [below](Debugging).

This repository is optimized for Intellij development and includes a run configuration for the docker environment. 

## Prerequisites:

*Docker:*
* You will need to install [docker](https://docs.docker.com/engine/installation/)
* You will need to install [docker-compose](https://docs.docker.com/compose/install/)

*Packages and Env:*

You will need the opsdroid packaged installed as a library in order to develop your modules. These steps may be skipped if you already have a module built and just wish to run the bot. However, if you need to reference opsdroid for debugging or import purposes, these steps will be important.
* Set up a virtualenv & activate: `virtualenv --python=/usr/bin/python3.6 .env && . .env/bin/activate`
* Install opsdroid: `pip3 install opsdroid`

## Usage:

*to run*
* (from project root): `docker-compose up -d --build`

*to extend:*

* Customise `config/configuration.yaml` according to he [documentation conventions](http://opsdroid.readthedocs.io/en/latest/configuration-reference/)
* add a skill module to the `modules/` directory. This will be mounted to the container into the opsdroid `skills/` directory

## Debugging:

* This repository is optimized for development in Intellij and includes a run configuration for the docker enviornment.
    * You will need to build an image to reference `docker-compose build`
    * In terminal get the image id for the container that was created `docker ps -aqf "name=opsdroid"`
    * In the Edit configurations menu, you will need to replace the image id with the referece from the previous step
    * You can now run the container directly through Intellij `Shift + F10` or debug `Shift + F9`