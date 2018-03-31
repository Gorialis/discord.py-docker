#!/bin/bash
set -euo pipefail

{% for version, distro, checkout, stage in product(python_versions.values(), distros.values(), checkouts.values(), [['minimal'], ['full', ''], ['extras']]) -%}
{%- for tagdata in product(version, distro, checkout, stage) -%}
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:{{ mktag(*tagdata) }}; then export DOCKER_DISCORD_PY_OK="${DOCKER_DISCORD_PY_OK:-.}\nUPLOAD {{ mktag(*tagdata) }}"; else export DOCKER_DISCORD_PY_FAILED="${DOCKER_DISCORD_PY_FAILED:-.}\nUPLOAD {{ mktag(*tagdata) }}"; fi
{% endfor %}
{%- endfor %}
