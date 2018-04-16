{% include 'WARNING' %}
ARG PYTHON_VERSION
ARG DISTRO
ARG BUILD_STAGE

FROM discord.py:build$BUILD_STAGE-$PYTHON_VERSION-$DISTRO

ARG CHECKOUT

# install d.py
RUN pip install -U git+https://github.com/Rapptz/discord.py@$CHECKOUT#egg=discord.py[voice,docs] -q --retries 30

WORKDIR /tmp/tests

COPY tests.py /tmp/tests/runtest.py

RUN pytest -vs /tmp/tests/runtest.py && \
    # remove caches
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
