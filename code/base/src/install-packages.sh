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
install_ansible(){
  if ! type ansible > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install Ansible"
    echo "############################################"

    pip3 install --user ansible
    ansible --version
  fi
}

# ============================================
# instalação do "Albert", um lançador de apps
# link: https://github.com/albertlauncher/albert
# ============================================
install_albert(){
# instalação apenas pro Ubuntu 20.04
if [ $(grep "DISTRIB_RELEASE" /etc/lsb-release | cut -d "=" -f2) == "20.04" ];then
  echo
  echo "############################################"
  echo " Install Albert"
  echo "############################################"

  echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/manuelschneid3r.list
  curl -fsSL 'https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/manuelschneid3r.gpg > /dev/null
  sudo apt update
  sudo apt install -y albert

  # essas linhas ficariam no repo de dotfiles
  # albert_themes_folder="/usr/share/albert/org.albert.frontend.widgetboxmodel/themes"
  # [[ ! -d "$albert_themes_folder" ]] && mkdir -p "$albert_themes_folder"
  # sudo cp "Nord.qss" "$albert_themes_folder"
  # sudo chmod 644 "${albert_themes_folder}/Nord.qss"

  # [[ ! -d "${HOME}/.config/albert" ]] && mkdir -p "${HOME}/.config/albert"
  # [[ -f "${HOME}/.config/albert/albert.conf" ]] && rm -rf "${HOME}/.config/albert/albert.conf"
  # cp "albert.conf" "${HOME}/.config/albert/albert.conf"
fi
}

# ######################### MAIN #########################
install_dependencies
install_extract_tools
install_ubuntu_packages
install_tools
install_ansible
install_albert