#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker build --no-cache --build-arg PYTHON_VERSION={{ version }} --build-arg DISTRO={{ distro }} --tag discord.py:build2-{{ mktag(version, distro) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-{{ mktag(version, distro) }} .; then echo -e "\nBUILD build2-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else export echo -e "\nBUILD build2-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
