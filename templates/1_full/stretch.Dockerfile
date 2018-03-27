{% include 'WARNING' %}
ARG PYTHON_VERSION
FROM discord.py:build0-$PYTHON_VERSION-stretch

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
    pip install -U {{ minor_deps|join(' ') }} -q --retries 30 && \
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
