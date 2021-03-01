{% include 'WARNING' %}
ARG PYTHON_VERSION

FROM python:$PYTHON_VERSION-alpine
{% include 'LABEL' %}

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/lib \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.50.0

# add extra apk repositories to allow more deps to be resolved in-house
RUN \
    echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-8.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN \
    # basic deps
    apk --no-cache add -q git mercurial cloc openssl openssl-dev openssh alpine-sdk bash gettext sudo build-base gnupg linux-headers xz \
    # voice support
    libffi-dev libsodium-dev opus-dev ffmpeg && \
    # install rust with rustup
    unameArch="$(uname -m)" && \
    case "${unameArch##*-}" in \
        x86_64) rustArch='x86_64-unknown-linux-musl'; rustupSha256='05c5c05ec76671d73645aac3afbccf2187352fce7e46fc85be859f52a42797f6' ;; \
        aarch64) rustArch='aarch64-unknown-linux-musl'; rustupSha256='6a8a480d8d9e7f8c6979d7f8b12bc59da13db67970f7b13161ff409f0a771213' ;; \
        *) echo >&2 "unsupported architecture: ${dpkgArch}"; exit 1 ;; \
    esac && \
    rustup_url="https://static.rust-lang.org/rustup/archive/1.23.1/${rustArch}/rustup-init" && \
    wget "$rustup_url" && \
    echo "${rustupSha256} *rustup-init" | sha256sum -c - && \
    chmod +x rustup-init && \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host ${rustArch} && \
    rm rustup-init && \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
    rustup --version && \
    cargo --version && \
    rustc --version && \
    # do this symlink for numpy
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
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
