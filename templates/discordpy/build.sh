#!/bin/bash
set -euo pipefail

{% for version, distro, checkout, stage in variations -%}
if [ $1 = "{{ version[0] }}" ];
then
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION={{ version[0] }} --build-arg DISTRO={{ distro[0] }} --build-arg CHECKOUT={{ checkout[0] }} --build-arg BUILD_STAGE={{ stage[0] }} {% for tagdata in product(version[1], distro[1], checkout[1], stage[1]) %}--tag discord.py:{{ mktag(*tagdata) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:{{ mktag(*tagdata) }} {% endfor %}.; then echo -e "BUILD {{ mktag(version[1][0], distro[1][0], checkout[1][0], stage[1][0]) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD {{ mktag(version[1][0], distro[1][0], checkout[1][0], stage[1][0]) }}" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi;
fi
{% endfor %}
