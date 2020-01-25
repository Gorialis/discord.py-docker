#!/bin/bash
set -euo pipefail

{% for distro in distros.keys() -%}
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=$1 --build-arg DISTRO={{ distro }} --tag discord.py:build2-$1-{{ distro }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-$1-{{ distro }} .; then echo -e "BUILD build2-$1-{{ distro }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-$1-{{ distro }}" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
