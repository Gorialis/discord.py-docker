#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#
ARG PYTHON_VERSION
FROM discord.py:build0-$PYTHON_VERSION-slim-stretch

RUN apt-get update && \
    # uvloop
    apt-get install -y -qq libuv1-dev \
    # lxml
    libxml2-dev libxslt1-dev \
    # cairosvg
    libcairo2-dev \
    # Pillow
    libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev liblcms2-dev libtiff5-dev tk8.6-dev tcl8.6-dev libwebp-dev libharfbuzz-dev libfribidi-dev \
    # wand
    imagemagick \
    # apt is so noisy
    > /dev/null && \
    # install minor deps
    pip install -U asyncpg coverage flake8 lxml git+https://github.com/numpy/numpy@maintenance/1.14.x#egg=numpy Pillow psutil pycryptodome pytest-cov pytest-faulthandler ruamel.yaml uvloop youtube-dl -q --retries 30 && \
    pip install -U matplotlib -q --retries 30 && \
    # remove caches
    rm -rf /root/.cache/pip/* && \
    rm -rf /var/lib/apt/lists/* && \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' +

WORKDIR /app

CMD ["python"]