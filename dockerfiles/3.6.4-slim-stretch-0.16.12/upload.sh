#!/bin/bash
set -euo pipefail

docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim-stretch-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim-stretch-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim-stretch-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6.4-slim-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim-stretch-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim-stretch-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim-stretch-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3.6-slim-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim-stretch-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim-stretch-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim-stretch-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:3-slim-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim-stretch-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim-stretch-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim-stretch-async
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim-0.16.12
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim-0.16
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:slim-async
