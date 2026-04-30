if [[ ! -e /etc/toolbox/.after-first-start && $UID -eq 0 ]]; then
    echo "---Stage0: First-start configure:APT"
    rm /etc/apt/sources.list
    rm -rf /etc/apt/sources.list.d/*
    echo "deb $TOOLBOX_APT_MIRROR noble main restricted universe multiverse" >> /etc/apt/sources.list
    echo "deb $TOOLBOX_APT_MIRROR noble-updates main restricted universe multiverse" >> /etc/apt/sources.list
    echo "deb $TOOLBOX_APT_MIRROR noble-backports main restricted universe multiverse" >> /etc/apt/sources.list
    echo "deb $TOOLBOX_APT_SECURE noble-security main restricted universe multiverse" >> /etc/apt/sources.list
    apt update && apt upgrade -y && apt clean
    echo "---Stage0: First-start configure:User"
    if [[ $TOOLBOX_USER_PRECONFIGURE -eq 0 ]]; then
        groupadd -g $TOOLBOX_UID_GID $TOOLBOX_USERNAME
        useradd -m -G sudo -u $TOOLBOX_UID_GID -g $TOOLBOX_UID_GID -s /bin/bash $TOOLBOX_USERNAME
        echo "$TOOLBOX_USERNAME:$TOOLBOX_USERNAME" | chpasswd
    else
        echo "!!!WARNING: You user is preconfigured as $TOOLBOX_SHELL_USER and the default password is same as username."
    fi
    echo "!!!WARNING: You user is $TOOLBOX_USERNAME and the default password is same as username. remember to change if you want."
    echo "---Stage0: First-start configure:Info of this image"
    echo "This image contains:$TOOLBOX_IMAGE_CONTENT"
    echo "Description here:$(cat /etc/toolbox/image-desc.txt)"
    echo "3 Second for you to reading..."
    sleep 3
    touch /etc/toolbox/.after-first-start
fi

echo "---Stage1: Update system"

if [[ TOOLBOX_AUTOUPDATE != "0" && $UID -eq 0 ]]; then
    apt update && apt upgrade -y
fi

echo "---Stage2: Run your command"
if [[ $UID -eq 0 ]]; then
    gosu $TOOLBOX_SHELL_USER $@
else
    exec $@
fi