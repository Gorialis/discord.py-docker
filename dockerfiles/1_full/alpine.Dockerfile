#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#
ARG PYTHON_VERSION
FROM discord.py:build0-$PYTHON_VERSION-alpine

RUN apk update && \
    # uvloop
    apk add -q libuv-dev \
    # lxml
    libxml2-dev libxslt-dev \
    # cairosvg
    cairo-dev \
    # Pillow
    jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev harfbuzz-dev fribidi-dev libpng-dev \
    # wand
    fontconfig libltdl libxext ghostscript glib libbz2 libgcc libgomp libjpeg-turbo librsvg libwebp libx11 musl pango && \
    export IM_BUILD_HOME=$(mktemp -d) && \
    cd $IM_BUILD_HOME && \
    wget https://www.imagemagick.org/download/ImageMagick-6.9.10-0.tar.xz && \
    wget https://www.imagemagick.org/download/ImageMagick-6.9.10-0.tar.xz.asc && \
    ## bizarrely this often fails on the first try
    (gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "89AB63D48277377A"; \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "89AB63D48277377A") && \
    gpg --batch --verify ImageMagick-6.9.10-0.tar.xz.asc ImageMagick-6.9.10-0.tar.xz && \
    tar -xf ImageMagick-6.9.10-0.tar.xz && \
    cd ImageMagick-6.9.10-0 && \
    ./configure -q && \
    make -j "$(nproc)" | grep -v -E "^.*(CC|CXX|is deprecated).*$" && \
    make install | grep -v -E "^.*(/usr/bin/install|install:|config/install-sh|mkdir|ln -s|(^|\s)cp(\s|$)).*$" && \
    ldconfig /usr/local/lib && \
    cd / && \
    rm -rf $IM_BUILD_HOME && \
    # install minor deps
    pip install -U asyncpg coverage flake8 lxml git+https://github.com/numpy/numpy@maintenance/1.14.x#egg=numpy Pillow psutil pycryptodome pytest-cov ruamel.yaml uvloop youtube-dl -q --retries 30 && \
    pip install -U matplotlib -q --retries 30 && \
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