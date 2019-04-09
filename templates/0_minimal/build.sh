#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker build --no-cache -f {{ distro }}.Dockerfile --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION={{ version }} --tag discord.py:build0-{{ mktag(version, distro) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-{{ mktag(version, distro) }} .; then echo -e "BUILD build0-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build0-{{ mktag(version, distro) }}" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
