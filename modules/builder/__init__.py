import random
import jenkins
import logging

from opsdroid.matchers import match_regex

_LOGGER = logging.getLogger(__name__)

class BuildServer:
    def __init__(self, config, job):
        self.job = job
        try:
            username = config['credentials']['username']
            password = config['credentials']['password']
        except FileNotFoundError:
            _LOGGER.error('jenkins_credentials.yaml not found. Please copy from template in config/jenkins_credentials.yaml.example')

        server = jenkins.Jenkins('http://jenkins:8080', username=username, password=password)
        server.build_job(self.job)


@match_regex(r'build', case_sensitive=False)
async def build_job(opsdroid, config, message):
    try:
        await message.respond(random.choice(config['language']['build-confirm']))
        BuildServer(config, 'builder')
    except KeyError:
        await message.respond('Configuration not found')
