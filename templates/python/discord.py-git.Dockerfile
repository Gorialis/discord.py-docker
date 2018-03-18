WORKDIR /tmp/discord.py

RUN git clone https://github.com/Rapptz/discord.py.git . && \
    git checkout {{ checkout }} && \
    pip install -U .[voice,docs]