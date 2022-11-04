#!/bin/bash

function virtualbox(){
    if ! type virtualbox > /dev/null 2>&1; then
        local version="7.0.2"
        curl "https://download.virtualbox.org/virtualbox/${version}/virtualbox-7.0_${version}-154219~Ubuntu~jammy_amd64.deb"
    else
        echo "virtualbox installed [OK]"
    fi
}

function install_vagrant(){
    if ! type vagrant > /dev/null 2>&1; then
        wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update && sudo apt install vagrant -y
    else
        echo "vagrant installed [OK]"
    fi
}

virtualbox
install_vagrant