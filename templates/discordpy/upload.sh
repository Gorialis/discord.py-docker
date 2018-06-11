#!/bin/bash
set -euo pipefail

{% for version, distro, checkout, stage in variations -%}
{%- for tagdata in product(version, distro, checkout, stage) -%}
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:{{ mktag(*tagdata) }}; then echo -e "UPLOAD {{ mktag(*tagdata) }}" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "UPLOAD {{ mktag(*tagdata) }}" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
{% endfor %}
{%- endfor %}
