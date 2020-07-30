#
# WARNING: THIS DOCKERFILE IS AUTO-GENERATED
# DIRECT EDITS WILL BE DESTROYED WHEN THIS FILE IS NEXT GENERATED
# PLEASE EDIT THE TEMPLATES INSTEAD OF THIS FILE
#
ARG DOCKER_REPO
ARG PYTHON_VERSION
ARG DISTRO

FROM $DOCKER_REPO/discord.py:build1-$PYTHON_VERSION-$DISTRO

# install major deps
RUN pip install -U "aiomysql" "aioredis" "beautifulsoup4" "cairosvg" "colorlog" "colorthief" "fuzzywuzzy[speedup]" "h5py @ git+https://github.com/h5py/h5py@master" "humanize" "lru-dict" "objgraph" "parsedatetime" "python-dateutil" "PyYAML" "sqlalchemy" "tabulate" "tox" "twine" "wand" -q --retries 30 && \
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