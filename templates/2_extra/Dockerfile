{% include 'WARNING' %}
ARG PYTHON_VERSION
ARG DISTRO
FROM discord.py:build1-$PYTHON_VERSION-$DISTRO

# install major deps
RUN pip install -U {{ major_deps|join(' ') }} -q --retries 30 && \
    # remove caches
    rm -rf /root/.cache/pip/* && \
    find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' +

WORKDIR /app

CMD ["python"]
