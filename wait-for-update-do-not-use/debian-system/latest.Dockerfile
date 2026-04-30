FROM aerialdreamxl/docker-quickenv:latest-base

ENV DQE_VARIANT=1 DQE_SYSTEMD=0 DQE_SSH=0
RUN apt update && apt install -y vim nano htop git curl wget git-lfs fastfetch tmux systemd libpam-systemd pipewire-audio-client-libraries openssh-server && apt clean && rm -rf /var/lib/apt/lists/* && rm -f /etc/ssh/ssh_host_*_key*