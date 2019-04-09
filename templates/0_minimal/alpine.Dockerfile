{% include 'WARNING' %}
ARG PYTHON_VERSION

FROM python:$PYTHON_VERSION-alpine
{% include 'LABEL' %}

ENV LD_LIBRARY_PATH /usr/local/lib:/usr/lib

# echo development repo into syncable packages
RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN \
    # basic deps
    apk --no-cache add -q git mercurial cloc openssl openssl-dev openssh alpine-sdk bash gettext sudo build-base gnupg linux-headers xz \
    # voice support
    libffi-dev libsodium-dev opus-dev ffmpeg && \
    # update pip, install Cython, pytest, youtube-dl
    pip install -U pip Cython pytest youtube-dl -q --retries 30 && \
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
