#!/bin/bash
set -euo pipefail

if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.7.0-stretch; then echo -e "UPLOAD build1-3.7.0-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-3.7.0-stretch" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.7.0-slim-stretch; then echo -e "UPLOAD build1-3.7.0-slim-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-3.7.0-slim-stretch" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.7.0-alpine; then echo -e "UPLOAD build1-3.7.0-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-3.7.0-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.6.6-stretch; then echo -e "UPLOAD build1-3.6.6-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-3.6.6-stretch" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.6.6-slim-stretch; then echo -e "UPLOAD build1-3.6.6-slim-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-3.6.6-slim-stretch" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build1-3.6.6-alpine; then echo -e "UPLOAD build1-3.6.6-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build1-3.6.6-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
