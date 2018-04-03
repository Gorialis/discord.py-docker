#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-{{ mktag(version, distro) }}; then echo -e "\nUPLOAD build1-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else export echo -e "\nUPLOAD build1-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
