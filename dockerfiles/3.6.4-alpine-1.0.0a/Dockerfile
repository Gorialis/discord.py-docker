#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#

FROM python:3.6.4-alpine

ARG BUILD_TIME=unknown
ARG GIT_HEAD=unknown
LABEL maintainer="Devon R <Gorialis>"
LABEL creation_time="2018-03-18 14:24:59 UTC"
LABEL build_time=$BUILD_TIME
LABEL git_head=$GIT_HEAD
LABEL image_tags="3.6.4-alpine-1.0.0a;3.6.4-alpine-1.0.0;3.6.4-alpine-1.0;3.6.4-alpine-rewrite;3.6-alpine-1.0.0a;3.6-alpine-1.0.0;3.6-alpine-1.0;3.6-alpine-rewrite;3-alpine-1.0.0a;3-alpine-1.0.0;3-alpine-1.0;3-alpine-rewrite;alpine-1.0.0a;alpine-1.0.0;alpine-1.0;alpine-rewrite"

ENV LD_LIBRARY_PATH /usr/local/lib:/usr/lib

# echo development repo into syncable packages
RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk update && \
    # basic deps
    apk add git mercurial openssl openssh alpine-sdk bash gettext sudo build-base linux-headers \
    # voice support
    libffi-dev libsodium-dev opus opus-dev \
    # uvloop
    libuv-dev \
    # lxml
    libxml2-dev libxslt-dev \
    # Pillow
    jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev harfbuzz-dev fribidi-dev libpng-dev \
    # scipy
    openblas-dev \
    # wand
    imagemagick-dev

# update pip if it's out of date
RUN pip install -U pip --retries 30

# extras
RUN pip install -U Cython --retries 30
RUN pip install -U aiofiles aiomysql aioredis asyncpg beautifulsoup4 click colorlog fuzzywuzzy[speedup] humanize lru-dict lxml matplotlib numpy objgraph parsedatetime Pillow psutil pycrypto pycryptodome pytest pytest-cov python-dateutil PyYAML ruamel.yaml sqlalchemy tabulate tox twine uvloop wand watchdog youtube-dl --retries 30
RUN pip install -U scipy --retries 30

WORKDIR /tmp/discord.py

RUN git clone https://github.com/Rapptz/discord.py.git . && \
    git checkout rewrite && \
    pip install -U .[voice,docs]

WORKDIR /tmp/test

COPY ./test_script.py /tmp/test/test_script.py

RUN python -m pytest -vs test_script.py

WORKDIR /app

CMD ["python"]