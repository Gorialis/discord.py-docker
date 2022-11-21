#!/bin/bash
set -euo pipefail

echo "Building stage 2 (extra)"

if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=$1 --build-arg DISTRO=bullseye --tag discord.py:build2-$1-bullseye --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-$1-bullseye .; then echo -e "BUILD build2-$1-bullseye" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-$1-bullseye" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=$1 --build-arg DISTRO=slim-bullseye --tag discord.py:build2-$1-slim-bullseye --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-$1-slim-bullseye .; then echo -e "BUILD build2-$1-slim-bullseye" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-$1-slim-bullseye" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=$1 --build-arg DISTRO=alpine --tag discord.py:build2-$1-alpine --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-$1-alpine .; then echo -e "BUILD build2-$1-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-$1-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
