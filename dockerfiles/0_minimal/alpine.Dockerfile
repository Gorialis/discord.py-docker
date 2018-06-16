#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#
ARG PYTHON_VERSION
FROM python:$PYTHON_VERSION-alpine

ARG BUILD_TIME=unknown
ARG GIT_HEAD=unknown
LABEL maintainer="Devon R <Gorialis>"
LABEL creation_time="2018-06-16 23:44:40 UTC"
LABEL build_time=$BUILD_TIME
LABEL git_head=$GIT_HEAD

ENV LD_LIBRARY_PATH /usr/local/lib:/usr/lib

# echo development repo into syncable packages
RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk update && \
    # basic deps
    apk add -q git mercurial openssl openssh alpine-sdk bash gettext sudo build-base gnupg linux-headers xz \
    # voice support
    libffi-dev libsodium-dev opus-dev && \
    # update pip, install Cython & pytest
    pip install -U pip Cython pytest -q --retries 30 && \
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