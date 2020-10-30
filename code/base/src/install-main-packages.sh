#!/bin/bash

################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

# ============================================
# Instala o VSCode caso não esteja instalado
# ============================================
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
      libxss1

    # install vscode
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install -y code
    code --install-extension Shan.code-settings-sync

    # se achar o endereço do repositório no '/etc/apt/source.list', delete.
    # porque a instalação adicionou lá, mas acabou ficando repetido, pq o endereço
    # já é adicionado no '/etc/apt/source.list.d' pelo comando 'add-apt-repository'
    if grep -q "packages.microsoft.com/repos/vscode" /etc/apt/sources.list ;then
      sudo sed -i '/packages.microsoft.com\/repos\/vscode/d' /etc/apt/sources.list
    fi
  fi
}

# ============================================
# Instala o Spotify caso não esteja instalado
# ============================================
install_spotify(){
  if ! type spotify > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install Spotify"
    echo "############################################"

    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] http://repository.spotify.com stable non-free"
    sudo apt install -y spotify-client

    # create folder to spicetify
    [[ ! -d "${HOME}/bin/spicetify" ]] && mkdir -p "${HOME}/bin/spicetify"
    cp "src/install_spicetify.sh" "${HOME}/bin/spicetify"
  fi
}

# ============================================
# Instala o Dropbox caso não esteja instalado
# ============================================
install_dropbox(){
  # check if Dropbox already installed, checking if folder exists
  if [ ! -d "${HOME}/.dropbox-dist" ];then
    echo
    echo "############################################"
    echo " Install Dropbox"
    echo "############################################"

    cd $HOME && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - && cd -

    cp "src/config-files/dropbox.desktop" "${HOME}/.config/autostart"
    sed -i "s|^Exec=.*|Exec=${HOME}/.dropbox-dist/dropboxd|g" "$HOME/.config/autostart/dropbox.desktop"
  fi
}

# ============================================
# Instala o Google Chrome caso não esteja instalado
# ============================================
install_google_chrome(){
  if ! type google-chrome > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install Google Chrome"
    echo "############################################"

    wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    sudo gdebi --non-interactive google-chrome-stable_current_amd64.deb
    rm -rf google-chrome-stable_current_amd64.deb
  fi
}

# ============================================
# Instala o InSync caso não esteja instalado
# ============================================
install_insync(){
  if ! type insync > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Install InSync"
    echo "############################################"

    local so_codename=$(grep "DISTRIB_CODENAME" /etc/lsb-release | cut -d "=" -f2)
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
    sudo add-apt-repository "deb [arch=amd64] http://apt.insync.io/ubuntu ${so_codename} non-free contrib"
    sudo apt install -y insync
  fi
}


# ######################### MAIN #########################
install_vscode
install_spotify
install_dropbox
install_google_chrome
install_insync