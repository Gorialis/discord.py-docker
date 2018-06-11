#!/bin/bash
set -euo pipefail

if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.7.0b5-stretch; then echo -e "UPLOAD build1-3.7.0b5-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "UPLOAD build1-3.7.0b5-stretch" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.7.0b5-slim-stretch; then echo -e "UPLOAD build1-3.7.0b5-slim-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "UPLOAD build1-3.7.0b5-slim-stretch" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.7.0b5-alpine; then echo -e "UPLOAD build1-3.7.0b5-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "UPLOAD build1-3.7.0b5-alpine" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.6.5-stretch; then echo -e "UPLOAD build1-3.6.5-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "UPLOAD build1-3.6.5-stretch" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.6.5-slim-stretch; then echo -e "UPLOAD build1-3.6.5-slim-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "UPLOAD build1-3.6.5-slim-stretch" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.6.5-alpine; then echo -e "UPLOAD build1-3.6.5-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "UPLOAD build1-3.6.5-alpine" >> ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
