#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#
ARG PYTHON_VERSION
ARG DISTRO
ARG BUILD_STAGE

FROM discord.py:build$BUILD_STAGE-$PYTHON_VERSION-$DISTRO

ARG CHECKOUT

WORKDIR /tmp/tests

COPY tests.py /tmp/tests/runtest.py

RUN test $CHECKOUT && \
    # install indev websockets [FIXME]
    pip install -U git+https://github.com/aaugustin/websockets@master#egg=websockets -q --retries 30 && \
    # install d.py
    pip install -U git+https://github.com/Rapptz/discord.py@$CHECKOUT#egg=discord.py[voice,docs] -q --retries 30 && \
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