#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#
ARG DOCKER_REPO
ARG PYTHON_VERSION

FROM $DOCKER_REPO/discord.py:build0-$PYTHON_VERSION-buster

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
    # h5py
    libhdf5-dev \
    # debugging
    gdb \
    # apt is so noisy
    > /dev/null && \
    # always install numpy separately
    pip install -U numpy --retries 30 && \
    # install minor deps
    pip install -U "asyncpg" "click" "coverage" "flake8" "lxml" "matplotlib" "Pillow" "psutil" "pycryptodome" "pylint" "pytest-cov" "PyYAML" "ruamel.yaml" "toml" "twine" -q --retries 30 && \
    # remove caches
    rm -rf /root/.cache/pip/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' +

WORKDIR /app

CMD ["python"]