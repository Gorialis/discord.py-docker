
FROM python:{{ python_version }}-stretch
{% block labels %}{% endblock labels %}

RUN apt update && \
    # basic deps
    apt install -y git openssl ssh gettext sudo build-essential \
    # voice support
    libffi-dev libsodium-dev libopus-dev \
    # uvloop
    libuv1-dev \
    # lxml
    libxml2-dev libxslt1-dev \
    # Pillow
    libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev liblcms2-dev libtiff5-dev tk8.6-dev tcl8.6-dev libwebp-dev libharfbuzz-dev libfribidi-dev \
    # scipy
    libopenblas-dev \
    # wand
    imagemagick

{% block python_setup %}{% endblock %}

WORKDIR /tmp/test

COPY ./test_script.py /tmp/test/test_script.py

RUN python -m pytest -vs test_script.py

WORKDIR /app

CMD ["python"]
