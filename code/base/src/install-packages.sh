#!/bin/bash

################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

install_extract_tools(){
  echo
  echo "############################################"
  echo " Install extractor tools"
  echo "############################################"

  sudo apt install -y \
    zip \
    gzip \
    unzip \
    bzip2 \
    tar
}

install_ubuntu_packages(){
  echo
  echo "############################################"
  echo " Install some Ubuntu/Gnome Packages"
  echo "############################################"

  sudo apt install -y \
    gnome-tweak-tool \
    gnome-sushi \
    chrome-gnome-shell \
    baobab \
    gdebi-core \
    dconf-editor
}

install_dependencies(){
  echo
  echo "############################################"
  echo " Install some imortant tools"
  echo "############################################"

  sudo apt install -y \
    apt-transport-https \
    net-tools \
    ffmpeg
}

install_tools(){
  echo
  echo "############################################"
  echo " Install tools/packages that i have most use"
  echo "############################################"

  sudo apt install -y \
    git \
    git-extras \
    meld \
    jq \
    vim \
    nano \
    imagemagick \
    neofetch \
    terminator \
    xclip
}

# ============================================
# Instalação do Ansible via Pip.
# A versão que ta no apt-get ta desatualizada pra variar ¬¬
# ============================================
ansible_install(){
  echo
  echo "############################################"
  echo " Install Ansible"
  echo "############################################"

  pip3 install --user ansible
  ansible --version
}

# ######################### MAIN #########################
install_dependencies
install_extract_tools
install_ubuntu_packages
install_tools

if ! type ansible > /dev/null 2>&1; then
  ansible_install
fi