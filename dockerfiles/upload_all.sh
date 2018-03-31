#!/bin/bash
set -euo pipefail

export DOCKER_DISCORD_PY_FAILED=""
export DOCKER_DISCORD_PY_OK=""

for dockerdirectory in *; do
    if [ -d $dockerdirectory ]; then
        cd $dockerdirectory;
        . ./upload.sh;
        cd ..;
    fi;
done

echo -e "\n\nUPLOAD OK: ${DOCKER_DISCORD_PY_OK:-.}\n\nUPLOAD FAIL: ${DOCKER_DISCORD_PY_FAILED:-.}"

if [[ $DOCKER_DISCORD_PY_FAILED ]]; then
    exit 2;
fi