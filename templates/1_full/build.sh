#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
docker build --no-cache -f {{ distro }}.Dockerfile --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION={{ version }} --tag discord.py:build1-{{ mktag(version, distro) }} --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-{{ mktag(version, distro) }} .
{% endfor %}
