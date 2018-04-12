#!/bin/bash
set -euo pipefail

export DOCKER_DISCORD_PY_FAILTMP="$(mktemp)"
export DOCKER_DISCORD_PY_PASSTMP="$(mktemp)"

for dockerdirectory in *; do
    if [ -d $dockerdirectory ]; then
        cd $dockerdirectory;
        . ./upload.sh;
        cd ..;
    fi;
done

export DOCKER_DISCORD_PY_FAILED="$(cat ${DOCKER_DISCORD_PY_FAILTMP})"
export DOCKER_DISCORD_PY_OK="$(cat ${DOCKER_DISCORD_PY_PASSTMP})"

echo -e "\n-- UPLOAD OK --\n${DOCKER_DISCORD_PY_OK:-.}\n\n-- UPLOAD FAIL --\n${DOCKER_DISCORD_PY_FAILED:-.}"

if [[ $DOCKER_DISCORD_PY_FAILED ]]; then
    exit 2;
fi