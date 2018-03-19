#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#

FROM python:3.6.4-stretch

ARG BUILD_TIME=unknown
ARG GIT_HEAD=unknown
LABEL maintainer="Devon R <Gorialis>"
LABEL creation_time="2018-03-20 16:38:27 UTC"
LABEL build_time=$BUILD_TIME
LABEL git_head=$GIT_HEAD
LABEL image_tags="3.6.4-stretch-pypi;3.6.4-stretch;3.6.4-pypi;3.6.4;3.6-stretch-pypi;3.6-stretch;3.6-pypi;3.6;3-stretch-pypi;3-stretch;3-pypi;3;stretch-pypi;stretch;pypi;latest"

RUN apt update && \
    # basic deps
    apt install -y -qq git openssl ssh gettext sudo build-essential \
    # voice support
    libffi-dev libsodium-dev libopus-dev \
    # uvloop
    libuv1-dev \
    # lxml
    libxml2-dev libxslt1-dev \
    # cairosvg
    libcairo2-dev \
    # Pillow
    libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev liblcms2-dev libtiff5-dev tk8.6-dev tcl8.6-dev libwebp-dev libharfbuzz-dev libfribidi-dev \
    # scipy
    libopenblas-dev \
    # wand
    imagemagick \
    # apt is so noisy
    > /dev/null

# update pip if it's out of date
RUN pip install -U pip -q --retries 30

# extras
RUN pip install -U Cython -q --retries 30
RUN pip install -U aiofiles aiomysql aioredis asyncpg beautifulsoup4 cairosvg click colorlog colorthief fuzzywuzzy[speedup] humanize lru-dict lxml matplotlib numpy objgraph parsedatetime Pillow psutil pycrypto pycryptodome pytest pytest-cov python-dateutil PyYAML ruamel.yaml sqlalchemy tabulate tox twine uvloop wand watchdog youtube-dl -q --retries 30
RUN pip install -U scipy -q --retries 30

RUN pip install -U discord.py[voice,docs] --retries 30

# remove wheel cache
RUN rm -rf /root/.cache/pip/wheels

WORKDIR /tmp/test_image

COPY ./test_script.py /tmp/test_image/test_script.py

# run test set pre-removal
RUN python -m pytest -vs test_script.py

# remove (hopefully) unneeded development headers
RUN apt purge -y -qq libffi-dev libsodium-dev libuv1-dev libxml2-dev libxslt1-dev libcairo2-dev libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev liblcms2-dev libtiff5-dev tk8.6-dev tcl8.6-dev libwebp-dev libharfbuzz-dev libfribidi-dev libopenblas-dev \
    # apt is noisy
    > /dev/null

# run test set post-removal
RUN python -m pytest -vs test_script.py

# remove test data
RUN rm -rf /tmp/test_image

WORKDIR /app

CMD ["python"]