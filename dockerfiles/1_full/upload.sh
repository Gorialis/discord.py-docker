#!/bin/bash
set -euo pipefail

echo "Uploading stage 1 (full)"

if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-$1-bullseye; then echo -e "UPLOAD build1-$1-bullseye" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-$1-bullseye" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-$1-slim-bullseye; then echo -e "UPLOAD build1-$1-slim-bullseye" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-$1-slim-bullseye" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-$1-alpine; then echo -e "UPLOAD build1-$1-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-$1-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
