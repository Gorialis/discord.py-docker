#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#

FROM python:3.6.4-slim-stretch

ARG BUILD_TIME=unknown
ARG GIT_HEAD=unknown
LABEL maintainer="Devon R <Gorialis>"
LABEL creation_time="2018-03-18 14:24:59 UTC"
LABEL build_time=$BUILD_TIME
LABEL git_head=$GIT_HEAD
LABEL image_tags="3.6.4-slim-stretch-0.16.12;3.6.4-slim-stretch-0.16;3.6.4-slim-stretch-async;3.6.4-slim-0.16.12;3.6.4-slim-0.16;3.6.4-slim-async;3.6-slim-stretch-0.16.12;3.6-slim-stretch-0.16;3.6-slim-stretch-async;3.6-slim-0.16.12;3.6-slim-0.16;3.6-slim-async;3-slim-stretch-0.16.12;3-slim-stretch-0.16;3-slim-stretch-async;3-slim-0.16.12;3-slim-0.16;3-slim-async;slim-stretch-0.16.12;slim-stretch-0.16;slim-stretch-async;slim-0.16.12;slim-0.16;slim-async"

RUN apt update && \
    # basic deps
    apt install -y git openssl ssh gettext sudo build-essential \
    # voice support
    libffi-dev libsodium-dev libopus-dev \
    # uvloop
    libuv1-dev \
    # lxml
    libxml2-dev libxslt1-dev \
    # Pillow
    libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev liblcms2-dev libtiff5-dev tk8.6-dev tcl8.6-dev libwebp-dev libharfbuzz-dev libfribidi-dev \
    # scipy
    libopenblas-dev \
    # wand
    imagemagick

# update pip if it's out of date
RUN pip install -U pip --retries 30

# extras
RUN pip install -U Cython --retries 30
RUN pip install -U aiofiles aiomysql aioredis asyncpg beautifulsoup4 click colorlog fuzzywuzzy[speedup] humanize lru-dict lxml matplotlib numpy objgraph parsedatetime Pillow psutil pycrypto pycryptodome pytest pytest-cov python-dateutil PyYAML ruamel.yaml sqlalchemy tabulate tox twine uvloop wand watchdog youtube-dl --retries 30
RUN pip install -U scipy --retries 30

WORKDIR /tmp/discord.py

RUN git clone https://github.com/Rapptz/discord.py.git . && \
    git checkout async && \
    pip install -U .[voice,docs]

WORKDIR /tmp/test

COPY ./test_script.py /tmp/test/test_script.py

RUN python -m pytest -vs test_script.py

WORKDIR /app

CMD ["python"]