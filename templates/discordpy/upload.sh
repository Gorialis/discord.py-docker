#!/bin/bash
set -euo pipefail

{% for version, distro, checkout, stage in product(python_versions.values(), distros.values(), checkouts.values(), [['minimal'], ['full', ''], ['extras']]) -%}
{%- for tagdata in product(version, distro, checkout, stage) -%}
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:{{ mktag(*tagdata) }}; then echo -e "\nUPLOAD {{ mktag(*tagdata) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else export echo -e "\nUPLOAD {{ mktag(*tagdata) }}" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
{%- endfor %}
