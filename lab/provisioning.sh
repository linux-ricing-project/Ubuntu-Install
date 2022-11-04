    #!/bin/bash

    # change keyboard layout
    sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"br\"/g' /etc/default/keyboard

    # change timezone
    timedatectl set-timezone America/Recife

    # install locale: 'pt_BR.UTF-8'
    locale-gen pt_BR.UTF-8
    locale-gen en_US.UTF-8

    # change locale
    update-locale \
    LANG="en_US.UTF-8" \
    LC_NUMERIC="pt_BR.UTF-8" \
    LC_TIME="pt_BR.UTF-8" \
    LC_MONETARY="pt_BR.UTF-8" \
    LC_PAPER="pt_BR.UTF-8" \
    LC_NAME="pt_BR.UTF-8" \
    LC_ADDRESS="pt_BR.UTF-8" \
    LC_TELEPHONE="pt_BR.UTF-8" \
    LC_MEASUREMENT="pt_BR.UTF-8" \
    LC_IDENTIFICATION="pt_BR.UTF-8"

    apt-get update && sudo apt-get upgrade -y
    apt-get install -y build-essential dkms

    export DEBIAN_FRONTEND=noninteractive

    apt-get install -y kubuntu-desktop firefox

    virtualbox_version="6.1.36"
    vbox_guest_additions_file="VBoxGuestAdditions_${virtualbox_version}.iso"

    wget "http://download.virtualbox.org/virtualbox/${virtualbox_version}/${vbox_guest_additions_file}"
    mkdir /media/VBoxGuestAdditions
    mount -o loop,ro ${vbox_guest_additions_file} /media/VBoxGuestAdditions
    sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
    rm ${vbox_guest_additions_file}
    umount /media/VBoxGuestAdditions
    rmdir /media/VBoxGuestAdditions

    reboot