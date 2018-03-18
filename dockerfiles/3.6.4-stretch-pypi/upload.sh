#!/bin/bash
set -euo pipefail

docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-stretch-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-stretch-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-stretch-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:stretch-pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:pypi
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:latest
