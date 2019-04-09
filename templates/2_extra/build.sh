#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION={{ version }} --build-arg DISTRO={{ distro }} --tag discord.py:build2-{{ mktag(version, distro) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-{{ mktag(version, distro) }} .; then echo -e "BUILD build2-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-{{ mktag(version, distro) }}" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
