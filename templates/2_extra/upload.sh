#!/bin/bash
set -euo pipefail

echo "Uploading stage 2 (extra)"

{% for distro in distros.keys() -%}
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-$1-{{ distro }}; then echo -e "UPLOAD build2-$1-{{ distro }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build2-$1-{{ distro }}" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
