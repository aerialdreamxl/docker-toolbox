FROM aerialdreamxl/supervisord-toolbox:ubuntu-cn
ARG CODESVR_VERSION=4.132.0
# DEVELOPER_PASSWORD : JupyterLab and code-server's password
ENV DEVELOPER_PASSWORD=password
COPY conf.d/code-server.conf /etc/supervisor/conf.d/code-server.conf
COPY conf.d/jupyterlab.conf /etc/supervisor/conf.d/jupyterlab.conf
COPY per-startup/00-jupyterlab.sh /etc/toolbox/scripts/per-startup/00-jupyterlab.sh
COPY per-startup/01-codesvr.sh /etc/toolbox/scripts/per-startup/01-codesvr.sh
RUN uv pip install jupyterlab ipywidgets tqdm --system --break-system-packages && \
    gosu ubuntu:ubuntu /bin/bash -c "cd /home/ubuntu && mkdir /home/ubuntu/workdir && mkdir -p /home/ubuntu/.config/uv && \
    touch ~/sys-env.sh && \
    cd /home/ubuntu && wget https://gh-proxy.com/https://github.com/coder/code-server/releases/download/v${CODESVR_VERSION}/code-server-${CODESVR_VERSION}-linux-amd64.tar.gz && \
    tar xvf code-server-${CODESVR_VERSION}-linux-amd64.tar.gz && mv code-server-${CODESVR_VERSION}-linux-amd64 .codesvr && mkdir -p /home/ubuntu/.config/code-server/"
EXPOSE 8000 8100
VOLUME ["/home/ubuntu/workdir"]