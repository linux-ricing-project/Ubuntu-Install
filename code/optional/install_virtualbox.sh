#!/bin/bash

set -e

# ============================================
# Função de debug
# ============================================
function log(){
  echo "[LOG] $*"
}

# install lsb_release command
if ! type lsb_release > /dev/null 2>&1; then
  sudo apt update && sudo apt install -y lsb_release
fi

log "add source list"
os_codename=$(lsb_release -cs)
echo "deb https://download.virtualbox.org/virtualbox/debian $os_codename contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

log "add GPG key"
curl -sS https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -

log "installing virtualbox-6.1"
sudo apt update && sudo apt install -y virtualbox-6.1