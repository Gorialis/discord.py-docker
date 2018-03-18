#!/bin/bash
set -euo pipefail

docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-alpine-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-alpine
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-alpine-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-alpine
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-alpine-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-alpine
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:alpine-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:alpine
