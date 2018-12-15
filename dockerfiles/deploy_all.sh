#!/bin/bash
set -euo pipefail

export DOCKER_DISCORD_PY_FAILTMP="$(mktemp)"
export DOCKER_DISCORD_PY_PASSTMP="$(mktemp)"

GIT_HEAD=${GIT_HEAD:-unknown+unknown}
echo "deploying with git head ${GIT_HEAD}"

for dockerdirectory in *; do
    if [ -d $dockerdirectory ]; then
        cd $dockerdirectory;
        . ./deploy.sh;
        cd ..;
    fi;
done

export DOCKER_DISCORD_PY_FAILED="$(cat ${DOCKER_DISCORD_PY_FAILTMP})"
export DOCKER_DISCORD_PY_OK="$(cat ${DOCKER_DISCORD_PY_PASSTMP})"

echo -e "\n-- DEPLOY OK --\n${DOCKER_DISCORD_PY_OK:-.}\n\n-- DEPLOY FAIL --\n${DOCKER_DISCORD_PY_FAILED:-.}"

if [[ $DOCKER_DISCORD_PY_FAILED ]]; then
    exit 2;
fi