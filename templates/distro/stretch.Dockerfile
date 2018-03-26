
FROM python:{{ python_version }}-stretch
{% block labels %}{% endblock labels %}

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
    # wand
    imagemagick \
    # apt is so noisy
    > /dev/null

{% block python_setup %}{% endblock %}

# remove wheel cache
RUN rm -rf /root/.cache/pip/*

WORKDIR /tmp/test_image

COPY ./test_script.py /tmp/test_image/test_script.py

# run test set
RUN python -m pytest -vs test_script.py

# remove test data and caches
RUN rm -rf /tmp/test_image && \
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
