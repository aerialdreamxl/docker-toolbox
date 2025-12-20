echo "[INFO] Making sources.list as you opinion..."

source /etc/os-release

rm /etc/apt/sources.list
rm -rf /etc/apt/sources.list.d/*
echo "deb ${DQE_APT_MIRROR} ${VERSION_CODENAME} main contrib non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb ${DQE_APT_MIRROR} ${VERSION_CODENAME}-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb ${DQE_APT_MIRROR} ${VERSION_CODENAME}-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list
echo "deb ${DQE_APT_SECURE} ${VERSION_CODENAME}-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list

echo "[INFO] APT Main mirror is set to ${DQE_APT_MIRROR}"
echo "[INFO] APT Security mirror is set to ${DQE_APT_SECURE}"

echo "[INFO] Updating system..."
apt update && apt upgrade -y