#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker build --no-cache --build-arg PYTHON_VERSION={{ version }} --build-arg DISTRO={{ distro }} --tag discord.py:build2-{{ mktag(version, distro) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-{{ mktag(version, distro) }} .; then export DOCKER_DISCORD_PY_OK="${DOCKER_DISCORD_PY_OK:-.}\nBUILD build2-{{ mktag(version, distro) }}"; else export DOCKER_DISCORD_PY_FAILED="${DOCKER_DISCORD_PY_FAILED:-.}\nBUILD build2-{{ mktag(version, distro) }}"; fi
{% endfor %}
