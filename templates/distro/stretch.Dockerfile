
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
    # scipy
    libopenblas-dev \
    # wand
    imagemagick \
    # apt is so noisy
    > /dev/null

{% block python_setup %}{% endblock %}

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
