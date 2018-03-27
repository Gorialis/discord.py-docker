#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
docker build --no-cache --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION={{ version }} --build-arg DISTRO={{ distro }} --tag discord.py:build2-{{ mktag(version, distro) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-{{ mktag(version, distro) }} .
{% endfor %}
