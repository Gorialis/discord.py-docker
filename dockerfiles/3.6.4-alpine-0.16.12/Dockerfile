#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#

FROM python:3.6.4-alpine

ARG BUILD_TIME=unknown
ARG GIT_HEAD=unknown
LABEL maintainer="Devon R <Gorialis>"
LABEL creation_time="2018-03-20 18:37:13 UTC"
LABEL build_time=$BUILD_TIME
LABEL git_head=$GIT_HEAD
LABEL image_tags="3.6.4-alpine-0.16.12;3.6.4-alpine-0.16;3.6.4-alpine-async;3.6-alpine-0.16.12;3.6-alpine-0.16;3.6-alpine-async;3-alpine-0.16.12;3-alpine-0.16;3-alpine-async;alpine-0.16.12;alpine-0.16;alpine-async"

ENV LD_LIBRARY_PATH /usr/local/lib:/usr/lib

# echo development repo into syncable packages
RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk update && \
    # basic deps
    apk add -q git mercurial openssl openssh alpine-sdk bash gettext sudo build-base linux-headers \
    # voice support
    libffi-dev libsodium-dev opus opus-dev \
    # uvloop
    libuv-dev \
    # lxml
    libxml2-dev libxslt-dev \
    # cairosvg
    cairo-dev \
    # Pillow
    jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev harfbuzz-dev fribidi-dev libpng-dev \
    # scipy
    openblas-dev \
    # wand
    imagemagick-dev

# update pip if it's out of date
RUN pip install -U pip -q --retries 30

# extras
RUN pip install -U Cython -q --retries 30
RUN pip install -U aiofiles aiomysql aioredis asyncpg beautifulsoup4 cairosvg click colorlog colorthief fuzzywuzzy[speedup] humanize lru-dict lxml matplotlib numpy objgraph parsedatetime Pillow psutil pycrypto pycryptodome pytest pytest-cov python-dateutil PyYAML ruamel.yaml sqlalchemy tabulate tox twine uvloop wand watchdog youtube-dl -q --retries 30
RUN pip install -U scipy -q --retries 30

WORKDIR /tmp/discord.py

RUN git clone https://github.com/Rapptz/discord.py.git . && \
    git checkout async && \
    pip install -U .[voice,docs] && \
    rm -rf /tmp/discord.py

# remove wheel cache
RUN rm -rf /root/.cache/pip/wheels

WORKDIR /tmp/test_image

COPY ./test_script.py /tmp/test_image/test_script.py

# run test set pre-removal
RUN python -m pytest -vs test_script.py

# remove (hopefully) unneeded development headers
RUN apk del -q libffi-dev libsodium-dev libxml2-dev cairo-dev harfbuzz-dev fribidi-dev

# run test set post-removal
RUN python -m pytest -vs test_script.py

# remove test data
RUN rm -rf /tmp/test_image

WORKDIR /app

CMD ["python"]