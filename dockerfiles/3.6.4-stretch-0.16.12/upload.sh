#!/bin/bash
set -euo pipefail

docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-stretch-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-stretch-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-stretch-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-stretch-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-stretch-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-stretch-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-stretch-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-stretch-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-stretch-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:stretch-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:stretch-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:stretch-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:async
