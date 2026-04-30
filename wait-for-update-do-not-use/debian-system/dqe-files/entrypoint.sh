#!/bin/bash
# Docker QuickENV entrypoint script

cli_userspace(){
    if [[ $# -eq 0 ]]; then
        echo "[INFO] You didn't use a script, entering shell!"
        gosu $DQE_USER bash -c "source ${DQE_ROOT}/env.sh && bash"
    else
        gosu $DQE_USER bash -c "source ${DQE_ROOT}/env.sh && $@"
    fi
    return 0
}

enter_userspace(){
    echo "[INFO] Loading per-startup daemons..."
    bash $DQE_ROOT/sys-daemons/ssh.sh
    echo "[INFO] Done! Prepareing you userspace..."
    if [[ $DQE_SYSTEMD -eq 1 ]]; then
        if [[ $DQE_VARIANT -ge 1 ]]; then
            echo "[INFO] Systemd takeover activated!"
            echo "[INFO] remember your password to login the system!"
            exec /sbin/init
        else
            echo "[FATAL] This image varient didn't have systemd support, exiting..."
            exit 1
        fi
    else
        cli_userspace $@
    fi
}

echo "========================================"
echo "Starting your environment, please wait..."
echo "========================================"

source /etc/os-release

if [[ $EUID -ne 0 ]]; then
    echo "[FATAL] not running as root"
    echo "Are you using docker's -user option?"
    echo "please use -e DQE_USER_UID=<your uid> and -e DQE_USER_GID=<your gid> instead"
    exit 1
fi

if [[ ! -d $DQE_ROOT ]]; then
    echo "[FATAL] data folder not found"
    echo "Please don't just copy this script to your image"
    echo "No? check you mountpoint settings"
    exit 1
fi

if [[ -e $DQE_ROOT/.finished ]]; then
    echo "[INFO] Seems like everything is done before!"
    enter_userspace "$@"
    exit
fi

unset PRETTY_NAME NAME VERSION_ID VERSION VERSION_CODENAME DEBIAN_VERSION_FULL ID HOME_URL SUPPORT_URL BUG_REPORT_URL

echo "source ${DQE_ROOT}/env.sh" >> /etc/skel/.profile

echo "[INFO] Loading system plugins..."
bash $DQE_ROOT/sys-plugins/apt-mirror.sh
bash $DQE_ROOT/sys-plugins/locale-and-tz.sh
bash $DQE_ROOT/sys-plugins/regular-user.sh

echo "source ${DQE_ROOT}/env.sh" > /etc/profile.d/docker_quickenv.sh
touch $DQE_ROOT/.finished

enter_userspace "$@"