import random

from opsdroid.matchers import match_regex


@match_regex(r'how are you', case_sensitive=False)
async def how_are_you(opsdroid, config, message):
    try:
        await message.respond(random.choice(config['language']['how-are-you']))
    except KeyError:
        await message.respond('Configuration not found')
