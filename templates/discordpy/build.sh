#!/bin/bash
set -euo pipefail

{% for version, distro, checkout, stage in product(python_versions.items(), distros.items(), checkouts.items(), [[0, ['minimal']], [1, ['full', '']], [2, ['extras']]]) -%}
if docker build --no-cache --build-arg PYTHON_VERSION={{ version[0] }} --build-arg DISTRO={{ distro[0] }} --build-arg CHECKOUT={{ checkout[0] }} --build-arg BUILD_STAGE={{ stage[0] }} {% for tagdata in product(version[1], distro[1], checkout[1], stage[1]) %}--tag discord.py:{{ mktag(*tagdata) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:{{ mktag(*tagdata) }} {% endfor %}.; then echo -e "\nBUILD {{ mktag(version[1][0], distro[1][0], checkout[1][0], stage[1][0]) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else export echo -e "\nBUILD {{ mktag(version[1][0], distro[1][0], checkout[1][0], stage[1][0]) }}" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
