FROM aerialdreamxl/supervisord-toolbox:ubuntu-cn
COPY --chown=ubuntu:ubuntu hermes-installer.sh /hermes-installer.sh
# RUN apt update && apt upgrade -y && \
#     apt install -y ripgrep ffmpeg && apt clean && rm -rf /var/lib/apt/lists/* && \
#     mkdir /hermes-data && chown ubuntu:ubuntu /hermes-data && \
#     gosu ubuntu:ubuntu /bin/bash -c "uv venv -p 3.11 ~/.hermes/.venv" && \
#     gosu ubuntu:ubuntu /bin/bash -c "source ~/.hermes/.venv/bin/activate && cd ~/.hermes/ && git clone https://ghfast.top/https://github.com/NousResearch/hermes-agent.git && cd hermes-agent && uv pip install pip --index-url $PIP_SOURCE && uv pip install .[all] --index-url $PIP_SOURCE && mkdir -p /home/ubuntu/.local/bin && ln -sf ~/.hermes/.venv/bin/hermes ~/.local/bin/hermes" && \
#     gosu ubuntu:ubuntu /bin/bash -c "hermes doctor"
#     #gosu ubuntu:ubuntu /bin/bash -c "bash /hermes-installer.sh --skip-setup && hermes doctor && cd /hermes-data && rm -rf *"

RUN apt update && apt upgrade -y && apt install -y ripgrep ffmpeg make python-is-python3 gcc g++ && apt clean && rm -rf /var/lib/apt/lists/* && \
    mkdir /hermes-data && chown ubuntu:ubuntu /hermes-data && \
    gosu ubuntu:ubuntu /bin/bash -c "cat /hermes-installer.sh | bash -s -- --skip-setup" && \
    gosu ubuntu:ubuntu /bin/bash -c "hermes doctor"

VOLUME ["/hermes-data"]
ENV HERMES_HOME=/hermes-data
COPY 01-hermes-setup.sh /etc/toolbox/scripts/run-once/01-hermes-setup.sh
COPY conf.d/hermes-dashboard.conf /etc/supervisor/conf.d/hermes-dashboard.conf
COPY conf.d/hermes-gateway.conf /etc/supervisor/conf.d/hermes-gateway.conf
EXPOSE 8642 9119

