# Docker-Compose Opsdroid

## Prerequisites:

* You will need [docker-compose](https://docs.docker.com/compose/install/)

## Usage:

* to run (from project root): `docker-compose up -d --build`
* to extend:
    * Customise `config/configuration.yaml` according to he [documentation conventions](http://opsdroid.readthedocs.io/en/latest/configuration-reference/)
    * add a skill module to the `modules/` directory. This will be mounted to the container into the opsdroid `skills/` directory