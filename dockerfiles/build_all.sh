#!/bin/bash
set -euo pipefail

export DOCKER_DISCORD_PY_FAILTMP="$(mktemp)"
export DOCKER_DISCORD_PY_PASSTMP="$(mktemp)"

GIT_HEAD=${GIT_HEAD:-unknown+unknown}
echo "building with git head ${GIT_HEAD}"

for dockerdirectory in *; do
    if [ -d $dockerdirectory ]; then
        cd $dockerdirectory;
        . ./build.sh;
        cd ..;
    fi;
done

export DOCKER_DISCORD_PY_FAILED="$(cat ${DOCKER_DISCORD_PY_FAILTMP})"
export DOCKER_DISCORD_PY_OK="$(cat ${DOCKER_DISCORD_PY_PASSTMP})"

echo -e "\n\nBUILD OK: ${DOCKER_DISCORD_PY_OK}\n\nBUILD FAIL: ${DOCKER_DISCORD_PY_FAILED}"

if [[ $DOCKER_DISCORD_PY_FAILED ]]; then
    exit 2;
fi