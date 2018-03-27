#!/bin/bash
set -euo pipefail

docker build --no-cache -f stretch.Dockerfile --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION=3.6.4 --tag discord.py:build1-3.6.4-stretch --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.6.4-stretch .
docker build --no-cache -f slim-stretch.Dockerfile --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION=3.6.4 --tag discord.py:build1-3.6.4-slim-stretch --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.6.4-slim-stretch .
docker build --no-cache -f alpine.Dockerfile --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --build-arg PYTHON_VERSION=3.6.4 --tag discord.py:build1-3.6.4-alpine --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.6.4-alpine .
