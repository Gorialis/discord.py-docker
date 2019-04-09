{% include 'WARNING' %}
ARG DOCKER_REPO
ARG PYTHON_VERSION

FROM $DOCKER_REPO/discord.py:build0-$PYTHON_VERSION-slim-stretch

RUN apt-get update && \
    # uvloop
    apt-get install -y -qq libuv1-dev \
    # lxml
    libxml2-dev libxslt1-dev \
    # cairosvg
    libcairo2-dev \
    # Pillow
    libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev liblcms2-dev libtiff5-dev tk8.6-dev tcl8.6-dev libwebp-dev libharfbuzz-dev libfribidi-dev libgif-dev \
    # wand
    imagemagick \
    # debugging
    gdb \
    # apt is so noisy
    > /dev/null && \
    # install minor deps
    pip install -U {{ minor_deps.values()|map('enquote')|join(' ') }} -q --retries 30 && \
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
