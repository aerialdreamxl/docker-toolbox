if [[ ! -f "${HERMES_HOME}"/config.yaml ]]; then
    gosu ubuntu:ubuntu /bin/bash -c "hermes setup"
fi

if [[ $TOOLBOX_HERMES_PUBLISH == 1 ]]; then
    rm /etc/supervisor/conf.d/hermes-dashboard.conf /etc/supervisor/conf.d/hermes-dashboard-proxy.conf
    mv /etc/supervisor/conf.d/hermes-dashboard-publish.conf.disabled /etc/supervisor/conf.d/hermes-dashboard.conf
    echo "WARN: Published Hermes Agent Dashboard"
fi

if [[ -n $(ls -A "${HERMES_HOME}/profiles" 2>/dev/null) ]]; then
    echo "INFO: Multi-profile setup detected, adding configuration..."
    for profile in ${HERMES_HOME}/profiles/*/; do
        profilename=$(basename $profile)
        echo Added Profile: $profilename
        cat <<EOF > /etc/supervisor/conf.d/hermes-gateway-$profilename.conf
[program:hermes-gateway-$profilename]
command=gosu ubuntu:ubuntu /bin/bash -c "hermes -p $profilename gateway run"
directory=/home/ubuntu
user=root
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/hermes-gateway-$profilename.log
stderr_logfile=/var/log/supervisor/hermes-gateway-$profilename.log
EOF
    done
fi