#!/bin/bash

################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

##########################################################
install_vscode(){
  if ! type code > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install VSCode"
    echo "############################################"

    # install dependencies
    sudo apt install -y \
      ca-certificates \
      apt-transport-https \
      gconf2 \
      libasound2 \
      libgtk2.0-0 \
      libxss1 \
      gnome-keyring

    # install vscode
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install -y code

    # se achar o endereço do repositório no '/etc/apt/source.list', delete.
    # porque a instalação adicionou lá, mas acabou ficando repetido, pq o endereço
    # já é adicionado no '/etc/apt/source.list.d' pelo comando 'add-apt-repository'
    if grep -q "packages.microsoft.com/repos/vscode" /etc/apt/sources.list ;then
      sudo sed -i '/packages.microsoft.com\/repos\/vscode/d' /etc/apt/sources.list
    fi
  fi
}

##########################################################
install_spotify(){
  if ! type spotify > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install Spotify"
    echo "############################################"

    curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt install -y spotify-client

  fi
}

##########################################################
install_dropbox(){
  # check if Dropbox already installed, checking if folder exists
  if [ ! -d "${HOME}/.dropbox-dist" ];then
    echo
    echo "############################################"
    echo " Install Dropbox"
    echo "############################################"

    # cd $HOME && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - && cd -

    # cp "config-files/dropbox.desktop" "${HOME}/.config/autostart"
    # sed -i "s|^Exec=.*|Exec=${HOME}/.dropbox-dist/dropboxd|g" "$HOME/.config/autostart/dropbox.desktop"

    wget "http://www.dropbox.com/download/?plat=lnx.x86_64" -O dropbox.tar.gz
    sudo tar -xvf dropbox.tar.gz -C /tmp
    sudo mv /tmp/.dropbox-dist/ /opt/dropbox
    sudo ln -sf /opt/dropbox/dropboxd /usr/bin/dropbox

    sudo cp config-files/dropbox.desktop /usr/share/applications/dropbox.desktop
    cp config-files/dropbox.desktop $HOME/.config/autostart

  fi
}

##########################################################
install_google_chrome(){
  if ! type google-chrome > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install Google Chrome"
    echo "############################################"

    wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt-get install -f
    rm -rf google-chrome-stable_current_amd64.deb

    # set Google Chrome as a default browser in KDE
    if [ $DESKTOP_SESSION = "plasma" ];then
        cp config-files/mimeapps.list $HOME/.config/mimeapps.list
    fi
  fi
}

##########################################################
install_insync(){
  if ! type insync > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install InSync"
    echo "############################################"

    local so_codename=$(grep "DISTRIB_CODENAME" /etc/lsb-release | cut -d "=" -f2)
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
    sudo add-apt-repository -y "deb [arch=amd64] http://apt.insync.io/ubuntu ${so_codename} non-free contrib"
    sudo apt install -y insync
  fi
}

##########################################################
install_telegram(){
  if ! type telegram > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install Telegram"
    echo "############################################"
    sudo apt install telegram-desktop -y
  fi
}

##########################################################
install_1password(){
  if ! type 1password > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install 1Password"
    echo "############################################"

    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list

    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

    sudo apt update && sudo apt install -y 1password
  fi
}


# ######################### MAIN #########################
install_vscode
install_spotify
install_dropbox
install_google_chrome
install_insync
install_telegram
install_1password