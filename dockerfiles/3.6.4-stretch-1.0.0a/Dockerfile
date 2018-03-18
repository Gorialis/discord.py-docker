#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#

FROM python:3.6.4-stretch

ARG BUILD_TIME=unknown
ARG GIT_HEAD=unknown
LABEL maintainer="Devon R <Gorialis>"
LABEL creation_time="2018-03-18 14:24:59 UTC"
LABEL build_time=$BUILD_TIME
LABEL git_head=$GIT_HEAD
LABEL image_tags="3.6.4-stretch-1.0.0a;3.6.4-stretch-1.0.0;3.6.4-stretch-1.0;3.6.4-stretch-rewrite;3.6.4-1.0.0a;3.6.4-1.0.0;3.6.4-1.0;3.6.4-rewrite;3.6-stretch-1.0.0a;3.6-stretch-1.0.0;3.6-stretch-1.0;3.6-stretch-rewrite;3.6-1.0.0a;3.6-1.0.0;3.6-1.0;3.6-rewrite;3-stretch-1.0.0a;3-stretch-1.0.0;3-stretch-1.0;3-stretch-rewrite;3-1.0.0a;3-1.0.0;3-1.0;3-rewrite;stretch-1.0.0a;stretch-1.0.0;stretch-1.0;stretch-rewrite;1.0.0a;1.0.0;1.0;rewrite"

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
    git checkout rewrite && \
    pip install -U .[voice,docs]

WORKDIR /tmp/test

COPY ./test_script.py /tmp/test/test_script.py

RUN python -m pytest -vs test_script.py

WORKDIR /app

CMD ["python"]