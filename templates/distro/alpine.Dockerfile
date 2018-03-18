
FROM python:{{ python_version }}-alpine
{% block labels %}{% endblock labels %}

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
    # Pillow
    jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev harfbuzz-dev fribidi-dev libpng-dev \
    # scipy
    openblas-dev \
    # wand
    imagemagick-dev

{% block python_setup %}{% endblock %}

WORKDIR /tmp/test

COPY ./test_script.py /tmp/test/test_script.py

RUN python -m pytest -vs test_script.py

WORKDIR /app

CMD ["python"]
