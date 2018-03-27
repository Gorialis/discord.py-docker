#!/bin/bash
set -euo pipefail

docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.6.4-stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.6.4-slim-stretch
docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.6.4-alpine
