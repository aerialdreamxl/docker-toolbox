FROM aerialdreamxl/supervisord-toolbox:ubuntu-cn
COPY --chown=ubuntu:ubuntu hermes-installer.sh /hermes-installer.sh

RUN apt update && apt upgrade -y && apt install -y ripgrep ffmpeg make python-is-python3 gcc g++ libnss3 libnspr4 nginx socat && apt clean && rm -rf /var/lib/apt/lists/* && \
    mkdir /hermes-data && chown ubuntu:ubuntu /hermes-data && \
    gosu ubuntu:ubuntu /bin/bash -c "cat /hermes-installer.sh | bash -s -- --skip-setup" && \
    gosu ubuntu:ubuntu /bin/bash -c "hermes doctor" && rm /hermes-installer.sh

VOLUME ["/hermes-data"]
ENV HERMES_HOME=/hermes-data
COPY 01-hermes-setup.sh /etc/toolbox/scripts/run-once/01-hermes-setup.sh
COPY conf.d/hermes-dashboard.conf /etc/supervisor/conf.d/hermes-dashboard.conf
COPY conf.d/hermes-gateway.conf /etc/supervisor/conf.d/hermes-gateway.conf
COPY conf.d/hermes-dashboard-proxy.conf /etc/supervisor/conf.d/hermes-dashboard-proxy.conf
#COPY hermes-nginx-conf /hermes-nginx-conf
EXPOSE 8642 9119

