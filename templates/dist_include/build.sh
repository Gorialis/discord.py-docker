#!/bin/bash
set -euo pipefail

docker build --no-cache --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" {% for tag in tags %}--tag discord.py:{{ tag or 'latest' }} --tag gorialis/discord.py:{{ tag or 'latest' }} {% endfor %}.
