#!/bin/bash
echo "[INFO] Trying to apply language and timezone settings..."

echo "export LANG=$DQE_SYS_LANG" >> $DQE_ROOT/env.sh
sed -i "s/# ${DQE_SYS_LANG}/${DQE_SYS_LANG}/g" /etc/locale.gen
locale-gen

if [[ ! -f "/usr/share/zoneinfo/$DQE_SYS_TZ" ]]; then
    echo "[ERROR] Timezone not exist, Timezone settings will not effective!"
    exit 0
fi

ln -sf "/usr/share/zoneinfo/$DQE_SYS_TZ" /etc/localtime
echo "$DQE_SYS_TZ" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata