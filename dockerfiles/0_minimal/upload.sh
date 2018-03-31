#!/bin/bash
set -euo pipefail

if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-3.6.5-stretch; then export DOCKER_DISCORD_PY_OK="${DOCKER_DISCORD_PY_OK:-.}\nUPLOAD build0-3.6.5-stretch"; else export DOCKER_DISCORD_PY_FAILED="${DOCKER_DISCORD_PY_FAILED:-.}\nUPLOAD build0-3.6.5-stretch"; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-3.6.5-slim-stretch; then export DOCKER_DISCORD_PY_OK="${DOCKER_DISCORD_PY_OK:-.}\nUPLOAD build0-3.6.5-slim-stretch"; else export DOCKER_DISCORD_PY_FAILED="${DOCKER_DISCORD_PY_FAILED:-.}\nUPLOAD build0-3.6.5-slim-stretch"; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build0-3.6.5-alpine; then export DOCKER_DISCORD_PY_OK="${DOCKER_DISCORD_PY_OK:-.}\nUPLOAD build0-3.6.5-alpine"; else export DOCKER_DISCORD_PY_FAILED="${DOCKER_DISCORD_PY_FAILED:-.}\nUPLOAD build0-3.6.5-alpine"; fi
