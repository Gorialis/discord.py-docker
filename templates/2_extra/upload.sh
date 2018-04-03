#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-{{ mktag(version, distro) }}; then echo -e "\nBUILD build2-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else export echo -e "\nBUILD build2-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
