#!/bin/bash
set -euo pipefail

docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-alpine-1.0.0a
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-alpine-1.0.0
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-alpine-1.0
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-alpine-rewrite
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-alpine-1.0.0a
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-alpine-1.0.0
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-alpine-1.0
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-alpine-rewrite
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-alpine-1.0.0a
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-alpine-1.0.0
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-alpine-1.0
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-alpine-rewrite
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:alpine-1.0.0a
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:alpine-1.0.0
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:alpine-1.0
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:alpine-rewrite
