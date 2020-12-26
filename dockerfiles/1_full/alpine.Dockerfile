#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#
ARG DOCKER_REPO
ARG PYTHON_VERSION

FROM $DOCKER_REPO/discord.py:build0-$PYTHON_VERSION-alpine

RUN \
    # uvloop
    apk --no-cache --allow-untrusted add -q libuv-dev \
    # lxml
    libxml2-dev libxslt-dev \
    # cairosvg
    cairo-dev \
    # Pillow
    jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev harfbuzz-dev fribidi-dev libpng-dev giflib-dev \
    # wand
    imagemagick6-dev \
    # h5py
    hdf5-dev \
    # debugging
    gdb && \
    # always install numpy separately
    pip install -U numpy --retries 30 && \
    # install minor deps
    pip install -U "asyncpg" "click" "coverage" "flake8" "lxml" "matplotlib" "Pillow" "psutil" "pycryptodome" "pylint" "pytest-cov" "PyYAML" "ruamel.yaml" "toml" "twine" -q --retries 30 && \
    # remove caches
    rm -rf /root/.cache/pip/* && \
    rm -rf /var/cache/apk/* && \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' +

WORKDIR /app

CMD ["python"]