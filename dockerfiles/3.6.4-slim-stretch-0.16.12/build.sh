#!/bin/bash
set -euo pipefail

docker build --no-cache --build-arg GIT_HEAD=${GIT_HEAD:-unknown+unknown} --build-arg BUILD_TIME="$(date -u "+%Y-%m-%d %H:%M:%S UTC")" --tag discord.py:3.6.4-slim-stretch-0.16.12 --tag gorialis/discord.py:3.6.4-slim-stretch-0.16.12 --tag discord.py:3.6.4-slim-stretch-0.16 --tag gorialis/discord.py:3.6.4-slim-stretch-0.16 --tag discord.py:3.6.4-slim-stretch-async --tag gorialis/discord.py:3.6.4-slim-stretch-async --tag discord.py:3.6.4-slim-0.16.12 --tag gorialis/discord.py:3.6.4-slim-0.16.12 --tag discord.py:3.6.4-slim-0.16 --tag gorialis/discord.py:3.6.4-slim-0.16 --tag discord.py:3.6.4-slim-async --tag gorialis/discord.py:3.6.4-slim-async --tag discord.py:3.6-slim-stretch-0.16.12 --tag gorialis/discord.py:3.6-slim-stretch-0.16.12 --tag discord.py:3.6-slim-stretch-0.16 --tag gorialis/discord.py:3.6-slim-stretch-0.16 --tag discord.py:3.6-slim-stretch-async --tag gorialis/discord.py:3.6-slim-stretch-async --tag discord.py:3.6-slim-0.16.12 --tag gorialis/discord.py:3.6-slim-0.16.12 --tag discord.py:3.6-slim-0.16 --tag gorialis/discord.py:3.6-slim-0.16 --tag discord.py:3.6-slim-async --tag gorialis/discord.py:3.6-slim-async --tag discord.py:3-slim-stretch-0.16.12 --tag gorialis/discord.py:3-slim-stretch-0.16.12 --tag discord.py:3-slim-stretch-0.16 --tag gorialis/discord.py:3-slim-stretch-0.16 --tag discord.py:3-slim-stretch-async --tag gorialis/discord.py:3-slim-stretch-async --tag discord.py:3-slim-0.16.12 --tag gorialis/discord.py:3-slim-0.16.12 --tag discord.py:3-slim-0.16 --tag gorialis/discord.py:3-slim-0.16 --tag discord.py:3-slim-async --tag gorialis/discord.py:3-slim-async --tag discord.py:slim-stretch-0.16.12 --tag gorialis/discord.py:slim-stretch-0.16.12 --tag discord.py:slim-stretch-0.16 --tag gorialis/discord.py:slim-stretch-0.16 --tag discord.py:slim-stretch-async --tag gorialis/discord.py:slim-stretch-async --tag discord.py:slim-0.16.12 --tag gorialis/discord.py:slim-0.16.12 --tag discord.py:slim-0.16 --tag gorialis/discord.py:slim-0.16 --tag discord.py:slim-async --tag gorialis/discord.py:slim-async .