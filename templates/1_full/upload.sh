#!/bin/bash
set -euo pipefail

{% for version, distro in product(python_versions.keys(), distros.keys()) -%}
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-{{ mktag(version, distro) }}
{% endfor %}
