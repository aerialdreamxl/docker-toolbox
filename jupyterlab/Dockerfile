FROM ubuntu:noble
ARG APT_MIRROR=http://archive.ubuntu.com/ubuntu/ APT_SECURE=http://security.ubuntu.com/ubuntu/ PIP_SOURCE=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/
ENV TERM=xterm-256color JUPYTER_PASSWORD=jupyterlab
COPY entrypoint.sh /entrypoint.sh
RUN userdel ubuntu && \
    rm /etc/apt/sources.list && \
    rm -rf /etc/apt/sources.list.d/* && \
    echo "deb $APT_MIRROR noble main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb $APT_MIRROR noble-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb $APT_MIRROR noble-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb $APT_SECURE noble-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt update && apt upgrade -y && apt install -y libgl1 sudo curl wget nano vim git python3-pip && apt clean && rm -rf /var/lib/apt/lists/* && \
    groupadd -g 1000 jupyteruser && useradd -m -G sudo -s /bin/bash -u 1000 -g 1000 jupyteruser && \
    echo "jupyteruser:jupyteruser" | chpasswd && \
    chown jupyteruser:jupyteruser /entrypoint.sh
USER jupyteruser
ENV PATH=/home/jupyteruser/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN mkdir /home/jupyteruser/workdir && mkdir -p /home/jupyteruser/.config/uv && pip config set global.index-url $PIP_SOURCE && \
    pip install jupyterlab uv ipywidgets tqdm --break-system-packages && \
    echo "[[index]]" >> /home/jupyteruser/.config/uv/uv.toml && \
    echo "url = \"$PIP_SOURCE\"" >> /home/jupyteruser/.config/uv/uv.toml && \
    echo "default = true" >> /home/jupyteruser/.config/uv/uv.toml && \
    cd ~ && wget https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/v22.16.0/node-v22.16.0-linux-x64.tar.xz && \
    tar xvf node-v22.16.0-linux-x64.tar.xz && cp -r node-v22.16.0-linux-x64/* ~/.local && rm -rf node-v22.16.0-linux-x64 && rm ~/node-v22.16.0-linux-x64.tar.xz && \
    cd ~ && node -v && npm -v && npm config set registry https://registry.npmmirror.com && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter lab build --minimize=False && touch ~/sys-env.sh 
WORKDIR /home/jupyteruser/workdir
EXPOSE 8000
VOLUME ["/home/jupyteruser/workdir"]
STOPSIGNAL SIGTERM
CMD ["/bin/bash","/entrypoint.sh"]
