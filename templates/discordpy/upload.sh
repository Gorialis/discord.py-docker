#!/bin/bash
set -euo pipefail

{% for version, distro, checkout, stage in product(python_versions.values(), distros.values(), checkouts.values(), [['minimal'], ['full', ''], ['extras']]) -%}
{%- for tagdata in product(version, distro, checkout, stage) -%}
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:{{ mktag(*tagdata) }}
{% endfor %}
{%- endfor %}