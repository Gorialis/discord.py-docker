#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#
ARG PYTHON_VERSION

FROM python:$PYTHON_VERSION-slim-buster

ARG BUILD_TIME=unknown
ARG GIT_HEAD=unknown
LABEL maintainer="Devon R <Gorialis>"
LABEL creation_time="2020-01-25 15:16:56 UTC"
LABEL build_time=$BUILD_TIME
LABEL git_head=$GIT_HEAD

RUN apt-get update && \
    # basic deps
    apt-get install -y -qq git mercurial cloc openssl ssh gettext sudo build-essential \
    # voice support
    libffi-dev libsodium-dev libopus-dev ffmpeg \
    # apt is so noisy
    > /dev/null && \
    # update pip, install Cython, pytest, youtube-dl
    pip install -U pip Cython git+https://github.com/pytest-dev/pytest@master#egg=pytest git+https://github.com/PyCQA/astroid@master#egg=astroid youtube-dl -q --retries 30 && \
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