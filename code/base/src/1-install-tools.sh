#!/bin/bash

################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

##########################################################
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

##########################################################
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

##########################################################
install_dependencies(){
  echo
  echo "############################################"
  echo " Install some important tools"
  echo "############################################"

  sudo apt install -y \
    apt-transport-https \
    net-tools \
    ffmpeg
}

##########################################################
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

# ######################### MAIN #########################
install_dependencies
install_extract_tools

if [ $DESKTOP_SESSION = "gnome" ];then
  install_ubuntu_packages
fi

install_tools