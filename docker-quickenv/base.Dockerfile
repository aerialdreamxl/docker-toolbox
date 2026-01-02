FROM debian

COPY dqe-files/ /etc/docker-quickenv/
COPY sources-bootstrap.list /etc/apt/sources.list
RUN rm /etc/apt/sources.list.d/debian.sources && apt update && apt install -y sudo locales tzdata curl wget vim bash-completion ca-certificates gosu && apt clean && rm -rf /var/lib/apt/lists/*
ENV DQE_ROOT=/etc/docker-quickenv \
DQE_USER=user \
DQE_USER_NAME=user \
DQE_USER_UID=1000 \
DQE_USER_GID=1000 \
DQE_SYS_LANG=en_US.UTF-8 \
DQE_SYS_TZ=UTC \
DQE_APT_MIRROR="http://deb.debian.org/debian" \
DQE_APT_SECURE="http://security.debian.org/debian-security" \
DQE_VARIANT=0 \
TERM=xterm-256color

ENTRYPOINT ["bash","/etc/docker-quickenv/entrypoint.sh"]
CMD []