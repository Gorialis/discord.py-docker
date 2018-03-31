#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker build --no-cache -f {{ distro }}.Dockerfile --build-arg PYTHON_VERSION={{ version }} --tag discord.py:build1-{{ mktag(version, distro) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-{{ mktag(version, distro) }} .; then export DOCKER_DISCORD_PY_OK="${DOCKER_DISCORD_PY_OK:-.}\nBUILD build1-{{ mktag(version, distro) }}"; else export DOCKER_DISCORD_PY_FAILED="${DOCKER_DISCORD_PY_FAILED:-.}\nBUILD build1-{{ mktag(version, distro) }}"; fi
{% endfor %}
