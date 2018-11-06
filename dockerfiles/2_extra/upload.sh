#!/bin/bash
set -euo pipefail

if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.7.1-stretch; then echo -e "UPLOAD build2-3.7.1-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build2-3.7.1-stretch" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.7.1-slim-stretch; then echo -e "UPLOAD build2-3.7.1-slim-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build2-3.7.1-slim-stretch" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.7.1-alpine; then echo -e "UPLOAD build2-3.7.1-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build2-3.7.1-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.6.7-stretch; then echo -e "UPLOAD build2-3.6.7-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build2-3.6.7-stretch" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.6.7-slim-stretch; then echo -e "UPLOAD build2-3.6.7-slim-stretch" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build2-3.6.7-slim-stretch" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker push ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.6.7-alpine; then echo -e "UPLOAD build2-3.6.7-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL UPLOAD build2-3.6.7-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
