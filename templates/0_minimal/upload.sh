#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-{{ mktag(version, distro) }}; then echo -e "UPLOAD build0-{{ mktag(version, distro) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build0-{{ mktag(version, distro) }}" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
