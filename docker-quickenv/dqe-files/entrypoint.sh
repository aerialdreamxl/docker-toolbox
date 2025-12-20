#!/bin/bash
# Docker QuickENV entrypoint script

# for plugin in "$DQE_ROOT"/plugins/[0-9]*.sh; do
#   [ -f "$plugin" ] && echo "$plugin"
# done

echo "========================================"
echo "Starting your environment, please wait..."
echo "========================================"

if [[ $EUID -ne 0 ]]; then
    echo "Fatal Error: not running as root"
    echo "Are you using docker's -user option?"
    echo "please use -e DQE_USER_UID=<your uid> and -e DQE_USER_GID=<your gid> instead"
    exit 1
fi

if [[ ! -d "/etc/docker-quickenv" ]]; then
    echo "Fatal Error: data folder not found"
    echo "Please don't just copy this script to your image"
    echo "No? check you mountpoint settings"
    exit 1
fi
