#!/bin/bash

echo "[INFO] Adding a regular user..."
if [[ -z $DQE_USER_PASS ]]; then
    echo "[WARN] You didn't set a user password!"
    echo "[WARN] Default password will be same as your username."
    export DQE_USER_PASS=$DQE_USER_NAME
fi

groupadd -g $DQE_USER_GID $DQE_USER_NAME
useradd -m -g $DQE_USER_GID -G sudo -s /bin/bash -u $DQE_USER_UID $DQE_USER_NAME
echo "${DQE_USER_NAME}:${DQE_USER_PASS}" | chpasswd

if [[ -n $DQE_ROOT_PASS ]]; then
    echo "root:${DQE_ROOT_PASS}" | chpasswd
fi