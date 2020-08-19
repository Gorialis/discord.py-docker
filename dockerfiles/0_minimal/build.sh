#!/bin/bash
set -euo pipefail

echo "Building stage 0 (minimal)"

if docker build --no-cache -f buster.Dockerfile --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION=$1 --tag discord.py:build0-$1-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-$1-buster .; then echo -e "BUILD build0-$1-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build0-$1-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache -f alpine.Dockerfile --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION=$1 --tag discord.py:build0-$1-alpine --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-$1-alpine .; then echo -e "BUILD build0-$1-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build0-$1-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
