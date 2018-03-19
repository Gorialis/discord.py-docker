#!/bin/bash
set -euo pipefail

DOCKER_DISCORD_PY_FAILED=""
DOCKER_DISCORD_PY_OK=""

GIT_HEAD=${GIT_HEAD:-unknown+unknown}
echo "deploying with git head ${GIT_HEAD}"

for dockerdirectory in *; do
    if [ -d $dockerdirectory ]; then
        cd $dockerdirectory;
        if ./deploy.sh; then
            DOCKER_DISCORD_PY_OK="$DOCKER_DISCORD_PY_OK\n$dockerdirectory";
        else
            DOCKER_DISCORD_PY_FAILED="$DOCKER_DISCORD_PY_FAILED\n$dockerdirectory";
        fi
        cd ..;
    fi;
done

echo -e "\n\nDEPLOY OK: $DOCKER_DISCORD_PY_OK\n\nDEPLOY FAIL: $DOCKER_DISCORD_PY_FAILED"

if [[ $DOCKER_DISCORD_PY_FAILED ]]; then
    exit 2;
fi
