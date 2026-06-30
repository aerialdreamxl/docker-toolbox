if [[ ! -f /hermes-data/config.yaml ]]; then
    gosu ubuntu:ubuntu /bin/bash -c "hermes setup"
fi