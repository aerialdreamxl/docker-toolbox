if [ ! -f /home/ubuntu/.config/code-server/config.yaml ]; then
    echo "bind-addr: 0.0.0.0:8100" >> /home/ubuntu/.config/code-server/config.yaml
    echo "auth: password" >> /home/ubuntu/.config/code-server/config.yaml
    echo "password: ${DEVELOPER_PASSWORD}" >> /home/ubuntu/.config/code-server/config.yaml
fi