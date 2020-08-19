#!/bin/bash
set -euo pipefail

echo "Uploading stage 0 (minimal)"

if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-$1-buster; then echo -e "UPLOAD build0-$1-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build0-$1-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-$1-alpine; then echo -e "UPLOAD build0-$1-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build0-$1-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
