#!/bin/bash
set -euo pipefail

echo "Building stage 1 (full)"

{% for distro in distros.keys() -%}
if docker build --no-cache -f {{ distro }}.Dockerfile --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=$1 --tag discord.py:build1-$1-{{ distro }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-$1-{{ distro }} .; then echo -e "BUILD build1-$1-{{ distro }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build1-$1-{{ distro }}" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
