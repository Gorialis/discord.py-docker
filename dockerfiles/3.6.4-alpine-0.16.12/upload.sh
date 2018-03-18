#!/bin/bash
set -euo pipefail

docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-alpine-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-alpine-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-alpine-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-alpine-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-alpine-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-alpine-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-alpine-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-alpine-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-alpine-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:alpine-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:alpine-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:alpine-async
