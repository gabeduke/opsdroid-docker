import random
import jenkins

from opsdroid.matchers import match_regex


class BuildServer:
    def __init__(self, config, job):
        self.job = job
        username = config['credentials']['username']
        password = config['credentials']['password']

        server = jenkins.Jenkins('http://jenkins:8080', username=username, password=password)
        server.build_job(self.job)


@match_regex(r'build', case_sensitive=False)
async def build_job(opsdroid, config, message):
    try:
        await message.respond(random.choice(config['language']['build-confirm']))
        BuildServer(config, 'builder')
    except KeyError:
        await message.respond('Configuration not found')
