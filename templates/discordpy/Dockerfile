{% include 'WARNING' %}
ARG DOCKER_REPO
ARG PYTHON_VERSION
ARG DISTRO
ARG BUILD_STAGE

FROM $DOCKER_REPO/discord.py:build$BUILD_STAGE-$PYTHON_VERSION-$DISTRO

ARG CHECKOUT

WORKDIR /tmp/tests

COPY tests.py /tmp/tests/runtest.py

RUN INSTALL_TARGET="discord.py[voice,docs]${CHECKOUT:+" @ git+https://github.com/Rapptz/discord.py@"}${CHECKOUT}" && \
    echo "Install target: ${INSTALL_TARGET}" && \
    # install d.py
    pip install -U "${INSTALL_TARGET}" -q --retries 30 && \
    # delete the cache in prep for tests
    rm -rf /root/.cache/pip/* && \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' + && \
    # test that the test can run without the cache
    pytest -vs /tmp/tests/runtest.py && \
    # remove the cache again
    rm -rf /tmp/tests && \
    rm -rf /root/.cache/pip/* && \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' +

WORKDIR /app

CMD ["python"]
