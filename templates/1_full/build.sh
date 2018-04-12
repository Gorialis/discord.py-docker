#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker build --no-cache -f {{ distro }}.Dockerfile --build-arg PYTHON_VERSION={{ version }} --tag discord.py:build1-{{ mktag(version, distro) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-{{ mktag(version, distro) }} .; then echo -e "BUILD build1-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "BUILD build1-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
