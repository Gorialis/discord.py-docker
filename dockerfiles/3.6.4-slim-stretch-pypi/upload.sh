#!/bin/bash
set -euo pipefail

docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim-stretch-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim-stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim-stretch-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim-stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim-stretch-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim-stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim-stretch-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim-stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim
