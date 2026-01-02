echo "[INFO] Setting up SSH server..."

if [[ ! $DQE_VARIANT -ge 1 ]]; then
    echo "[INFO] SSH not included, nothing to do"
    exit 0
fi

if [[ $DQE_SSH -ne 1 ]]; then
    systemctl disable ssh
    echo "[INFO] SSH disabled, nothing to do"
    exit 0
fi

echo "[INFO] Regenerating SSH host keys..."
ssh-keygen -A

if [[ $DQE_SYSTEMD -eq 1 ]]; then
    echo "[INFO] Systemd will start ssh later"
    systemctl enable ssh
else
    echo "[INFO] starting sshd in background"
    /usr/sbin/sshd -D -e  >> "$DQE_ROOT/openssh-server.log" 2>&1 &
fi