#!/bin/bash
set -euo pipefail

echo "Building stage 1 (full)"

if docker build --no-cache -f buster.Dockerfile --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=$1 --tag discord.py:build1-$1-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-$1-buster .; then echo -e "BUILD build1-$1-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build1-$1-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache -f slim-buster.Dockerfile --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=$1 --tag discord.py:build1-$1-slim-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-$1-slim-buster .; then echo -e "BUILD build1-$1-slim-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build1-$1-slim-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache -f alpine.Dockerfile --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=$1 --tag discord.py:build1-$1-alpine --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-$1-alpine .; then echo -e "BUILD build1-$1-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build1-$1-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
