#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-{{ mktag(version, distro) }}; then export DOCKER_DISCORD_PY_OK="${DOCKER_DISCORD_PY_OK:-.}\nUPLOAD build1-{{ mktag(version, distro) }}"; else export DOCKER_DISCORD_PY_FAILED="${DOCKER_DISCORD_PY_FAILED:-.}\nUPLOAD build1-{{ mktag(version, distro) }}"; fi
{% endfor %}
