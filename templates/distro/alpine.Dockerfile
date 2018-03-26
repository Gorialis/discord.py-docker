
FROM python:{{ python_version }}-alpine
{% block labels %}{% endblock labels %}

ENV LD_LIBRARY_PATH /usr/local/lib:/usr/lib

# echo development repo into syncable packages
RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk update && \
    # basic deps
    apk add -q git mercurial openssl openssh alpine-sdk bash gettext sudo build-base linux-headers \
    # voice support
    libffi-dev libsodium-dev opus-dev \
    # uvloop
    libuv-dev \
    # lxml
    libxml2-dev libxslt-dev \
    # cairosvg
    cairo-dev \
    # Pillow
    jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev harfbuzz-dev fribidi-dev libpng-dev \
    # wand
    imagemagick-dev

{% block python_setup %}{% endblock %}

WORKDIR /tmp/test_image

COPY ./test_script.py /tmp/test_image/test_script.py

# run test set
RUN python -m pytest -vs test_script.py

# remove test data and caches
RUN rm -rf /tmp/test_image && \
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
