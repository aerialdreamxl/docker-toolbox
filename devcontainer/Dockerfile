FROM ubuntu:noble
ARG APT_MIRROR=http://archive.ubuntu.com/ubuntu/ \
    APT_SECURE=http://security.ubuntu.com/ubuntu/ \
    PIP_SOURCE=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple \
    CODESVR_VERSION=4.117.0
# DEVELOPER_PASSWORD : JupyterLab and code-server's password
# DEVELOPER_CHINA_MAINLAND : Config mirror sites or not
ENV TERM=xterm-256color DEVELOPER_PASSWORD=password
COPY entrypoint.sh /entrypoint.sh
ENV PATH=/home/ubuntu/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN rm /etc/apt/sources.list && \
    rm /etc/apt/sources.list.d/ubuntu.sources && \
    echo "deb $APT_MIRROR noble main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb $APT_MIRROR noble-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb $APT_MIRROR noble-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb $APT_SECURE noble-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt update && apt upgrade -y && apt install -y libgl1 sudo gosu curl wget nano vim git python3-pip openssh-server supervisor build-essential pkg-config python3 && apt clean && rm -rf /var/lib/apt/lists/* && \
    echo "ubuntu:ubuntu" | chpasswd && mkdir -p /var/log/supervisor && \
    gosu ubuntu:ubuntu /bin/bash -c "pip config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple && mkdir -p /home/ubuntu/.config/uv && \
    echo \"[[index]]\" >> /home/ubuntu/.config/uv/uv.toml && \
    echo 'url = \"$PIP_SOURCE\"' >> /home/ubuntu/.config/uv/uv.toml && \
    echo \"default = true\" >> /home/ubuntu/.config/uv/uv.toml" && \
    gosu ubuntu:ubuntu /bin/bash -c "cd /home/ubuntu && mkdir /home/ubuntu/workdir && mkdir -p /home/ubuntu/.config/uv && \
    pip install jupyterlab uv ipywidgets tqdm --break-system-packages -i $PIP_SOURCE && \
    cd ~ && wget https://mirrors.aliyun.com/nodejs-release/v22.16.0/node-v22.16.0-linux-x64.tar.xz && \
    tar xvf node-v22.16.0-linux-x64.tar.xz && cp -r node-v22.16.0-linux-x64/* ~/.local && rm -rf node-v22.16.0-linux-x64 && rm ~/node-v22.16.0-linux-x64.tar.xz && \
    cd ~ && node -v && npm -v && npm config set registry https://registry.npmmirror.com && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter lab build --minimize=False && touch ~/sys-env.sh" && \
    gosu ubuntu:ubuntu /bin/bash -c "cd /home/ubuntu && wget https://gh-proxy.com/https://github.com/coder/code-server/releases/download/v${CODESVR_VERSION}/code-server-${CODESVR_VERSION}-linux-amd64.tar.gz && \
    tar xvf code-server-${CODESVR_VERSION}-linux-amd64.tar.gz && mv code-server-${CODESVR_VERSION}-linux-amd64 .codesvr && mkdir -p /home/ubuntu/.config/code-server/" && \
    mkdir -p /run/sshd && rm /etc/ssh/ssh_host_*
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY conf.d /etc/supervisor/conf.d
EXPOSE 8000
VOLUME ["/home/ubuntu/workdir"]
STOPSIGNAL SIGTERM
CMD ["/bin/bash","/entrypoint.sh"]
