#!/bin/bash

################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

##########################################################
install_ansible(){
  if ! type ansible > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install Ansible"
    echo "############################################"

    pip3 install --user ansible
  fi
}

##########################################################
install_docker(){
    if ! type docker > /dev/null 2>&1; then
        echo
        echo "############################################"
        echo " Install Docker"
        echo "############################################"

        sudo apt-get install -y \
            ca-certificates \
            curl \
            gnupg \
            lsb-release

        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

        echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        sudo apt-get update

        sudo apt-get install -y \
            docker-ce \
            docker-ce-cli \
            containerd.io \
            docker-compose-plugin

        sudo usermod -aG docker $USER

        sudo systemctl enable docker
        sudo systemctl enable containerd
  fi
}

##########################################################
install_terraform(){
    if ! type terraform > /dev/null 2>&1; then
        echo
        echo "############################################"
        echo " Install Terraform"
        echo "############################################"

        wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
        sudo apt update && sudo apt install -y terraform
    fi
}

# ######################### MAIN #########################
install_ansible
install_docker
install_terraform