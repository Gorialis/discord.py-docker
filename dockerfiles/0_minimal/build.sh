#!/bin/bash
set -euo pipefail

if docker build --no-cache -f stretch.Dockerfile --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION=3.6.5 --tag discord.py:build0-3.6.5-stretch --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-3.6.5-stretch .; then echo -e "\nBUILD build0-3.6.5-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else export echo -e "\nBUILD build0-3.6.5-stretch" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache -f slim-stretch.Dockerfile --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION=3.6.5 --tag discord.py:build0-3.6.5-slim-stretch --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-3.6.5-slim-stretch .; then echo -e "\nBUILD build0-3.6.5-slim-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else export echo -e "\nBUILD build0-3.6.5-slim-stretch" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache -f alpine.Dockerfile --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION=3.6.5 --tag discord.py:build0-3.6.5-alpine --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-3.6.5-alpine .; then echo -e "\nBUILD build0-3.6.5-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else export echo -e "\nBUILD build0-3.6.5-alpine" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
