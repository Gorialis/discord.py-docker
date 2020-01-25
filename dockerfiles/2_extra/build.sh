#!/bin/bash
set -euo pipefail

if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.9.0a2 --build-arg DISTRO=buster --tag discord.py:build2-3.9.0a2-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.9.0a2-buster .; then echo -e "BUILD build2-3.9.0a2-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.9.0a2-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.9.0a2 --build-arg DISTRO=slim-buster --tag discord.py:build2-3.9.0a2-slim-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.9.0a2-slim-buster .; then echo -e "BUILD build2-3.9.0a2-slim-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.9.0a2-slim-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.9.0a2 --build-arg DISTRO=alpine --tag discord.py:build2-3.9.0a2-alpine --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.9.0a2-alpine .; then echo -e "BUILD build2-3.9.0a2-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.9.0a2-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.8.1 --build-arg DISTRO=buster --tag discord.py:build2-3.8.1-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.8.1-buster .; then echo -e "BUILD build2-3.8.1-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.8.1-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.8.1 --build-arg DISTRO=slim-buster --tag discord.py:build2-3.8.1-slim-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.8.1-slim-buster .; then echo -e "BUILD build2-3.8.1-slim-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.8.1-slim-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.8.1 --build-arg DISTRO=alpine --tag discord.py:build2-3.8.1-alpine --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.8.1-alpine .; then echo -e "BUILD build2-3.8.1-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.8.1-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.7.6 --build-arg DISTRO=buster --tag discord.py:build2-3.7.6-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.7.6-buster .; then echo -e "BUILD build2-3.7.6-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.7.6-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.7.6 --build-arg DISTRO=slim-buster --tag discord.py:build2-3.7.6-slim-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.7.6-slim-buster .; then echo -e "BUILD build2-3.7.6-slim-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.7.6-slim-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.7.6 --build-arg DISTRO=alpine --tag discord.py:build2-3.7.6-alpine --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.7.6-alpine .; then echo -e "BUILD build2-3.7.6-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.7.6-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.6.10 --build-arg DISTRO=buster --tag discord.py:build2-3.6.10-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.6.10-buster .; then echo -e "BUILD build2-3.6.10-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.6.10-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.6.10 --build-arg DISTRO=slim-buster --tag discord.py:build2-3.6.10-slim-buster --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.6.10-slim-buster .; then echo -e "BUILD build2-3.6.10-slim-buster" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.6.10-slim-buster" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
if docker build --no-cache --build-arg DOCKER_REPO=${DOCKER_UPLOAD_REPOSITORY:-gorialis} --build-arg PYTHON_VERSION=3.6.10 --build-arg DISTRO=alpine --tag discord.py:build2-3.6.10-alpine --tag ${DOCKER_UPLOAD_REPOSITORY:-gorialis}/discord.py:build2-3.6.10-alpine .; then echo -e "BUILD build2-3.6.10-alpine" >> ${DOCKER_DISCORD_PY_PASSTMP:-/dev/null}; else echo -e "FAIL BUILD build2-3.6.10-alpine" | tee -a ${DOCKER_DISCORD_PY_FAILTMP:-/dev/null}; fi
