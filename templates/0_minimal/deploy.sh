#!/bin/bash
set -euo pipefail

echo "Deploying stage 0 (minimal)"

. ./build.sh $1 | grep -v -E "(^Sending build context to Docker daemon|^[0-9a-f]{12}: (Waiting|Verifying|Pulling|Downloading|Extracting|Download complete)|^ ---> (Running in )?[0-9a-f]{12}|^Removing intermediate container [0-9a-f]{12}|^Step [0-9]+\/[0-9]+ : (ARG|LABEL) \S+(=\".+\")?$|^Successfully built [0-9a-f]{12})" \
&& . ./upload.sh $1 | grep -v -E "(^The push refers to repository \[docker\.io|^[0-9a-f]{12}: (Waiting|Preparing|Pushing|Layer already exists|Mounted from))"
