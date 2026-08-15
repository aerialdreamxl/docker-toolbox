if [[ ! -f "${HERMES_HOME}"/config.yaml ]]; then
    gosu ubuntu:ubuntu /bin/bash -c "hermes setup"
fi