#!/bin/bash
set -euo pipefail

. ./build.sh | grep -v -E "(^[0-9a-f]{12}: (Waiting|Verifying|Pulling|Downloading|Extracting|Download complete)|^ ---> (Running in )?[0-9a-f]{12}|^Removing intermediate container [0-9a-f]{12})" \
&& . ./upload.sh | grep -v -E "^[0-9a-f]{12}: (Waiting|Preparing|Pushing|Layer already exists|Mounted from)"