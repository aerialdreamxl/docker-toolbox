if [[ ! -f "${HERMES_HOME}"/config.yaml ]]; then
    gosu ubuntu:ubuntu /bin/bash -c "hermes setup"
fi

if [[ $TOOLBOX_HERMES_PUBLISH == 1 ]]; then
    rm /etc/supervisor/conf.d/hermes-dashboard.conf /etc/supervisor/conf.d/hermes-dashboard-proxy.conf
    mv /etc/supervisor/conf.d/hermes-dashboard-publish.conf.disabled /etc/supervisor/conf.d/hermes-dashboard.conf
    echo "WARN: Published Hermes Agent Dashboard"
fi