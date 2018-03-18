#!/bin/bash
set -euo pipefail

{% for tag in tags %}docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:{{ tag or 'latest' }}
{% endfor %}
