FROM 192.168.3.111:4000/aerialdreamxl/supervisord-toolbox:noble
ARG PIP_SOURCE=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple \
    CODESVR_VERSION=4.117.0
# DEVELOPER_PASSWORD : JupyterLab and code-server's password
ENV DEVELOPER_PASSWORD=password
COPY conf.d/code-server.conf /etc/supervisor/conf.d/code-server.conf
COPY conf.d/jupyterlab.conf /etc/supervisor/conf.d/jupyterlab.conf
COPY per-startup/00-jupyterlab.sh /etc/toolbox/scripts/per-startup/00-jupyterlab.sh
COPY per-startup/01-codesvr.sh /etc/toolbox/scripts/per-startup/01-codesvr.sh
RUN gosu ubuntu:ubuntu /bin/bash -c "pip config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple && mkdir -p /home/ubuntu/.config/uv && \
    echo \"[[index]]\" >> /home/ubuntu/.config/uv/uv.toml && \
    echo 'url = \"$PIP_SOURCE\"' >> /home/ubuntu/.config/uv/uv.toml && \
    echo \"default = true\" >> /home/ubuntu/.config/uv/uv.toml && \
    cd /home/ubuntu && mkdir /home/ubuntu/workdir && mkdir -p /home/ubuntu/.config/uv && \
    uv pip install jupyterlab ipywidgets tqdm -i $PIP_SOURCE && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter lab build --minimize=False && touch ~/sys-env.sh && \
    cd /home/ubuntu && wget https://gh-proxy.com/https://github.com/coder/code-server/releases/download/v${CODESVR_VERSION}/code-server-${CODESVR_VERSION}-linux-amd64.tar.gz && \
    tar xvf code-server-${CODESVR_VERSION}-linux-amd64.tar.gz && mv code-server-${CODESVR_VERSION}-linux-amd64 .codesvr && mkdir -p /home/ubuntu/.config/code-server/"
EXPOSE 8000 8100
VOLUME ["/home/ubuntu/workdir"]