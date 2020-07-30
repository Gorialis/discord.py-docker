#!/bin/bash
set -euo pipefail

echo "Building stage 0 (minimal)"

{% for distro in distros.keys() -%}
if docker build --no-cache -f {{ distro }}.Dockerfile --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION=$1 --tag discord.py:build0-$1-{{ distro }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-$1-{{ distro }} .; then echo -e "BUILD build0-$1-{{ distro }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build0-$1-{{ distro }}" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
