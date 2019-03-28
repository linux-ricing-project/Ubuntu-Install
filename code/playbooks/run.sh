#!/bin/bash

################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

# ============================================
# mostrar o banner inicial
# ============================================
show_header(){
cat << "HEADER"
   __  ____                __           ____           __        ____
  / / / / /_  __  ______  / /___  __   /  _/___  _____/ /_____ _/ / /
 / / / / __ \/ / / / __ \/ __/ / / /   / // __ \/ ___/ __/ __ `/ / /
/ /_/ / /_/ / /_/ / / / / /_/ /_/ /  _/ // / / (__  ) /_/ /_/ / / /
\____/_.___/\__,_/_/ /_/\__/\__,_/  /___/_/ /_/____/\__/\__,_/_/_/

HEADER
}

# ============================================
# Fazendo as atualizações iniciais
# ============================================
init_updates(){
  # updagrade inicial, por volta de uns 300 MB
  echo "==========================================="
  echo "Do the initial upgrades..."
  echo "==========================================="
  sudo apt -y upgrade
  sudo apt -y dist-upgrade
  sudo apt -y full-upgrade

	echo "==========================================="
  echo "Installing Ansible..."
  echo "==========================================="
  if ! type ansible > /dev/null 2>&1; then
    sudo apt -y install software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt -y install ansible curl wget
  fi
}

show_header
init_updates

# runnind playbook
echo "==========================================="
echo "Running Ansible Job"
echo "==========================================="
ansible-playbook --ask-become-pass main.yaml

echo "==========================================="
echo "Getting the dotfiles repo..."
echo "==========================================="
cd ~
wget https://github.com/frankjuniorr/dotfiles/archive/master.zip -O dotfiles.zip
unzip dotfiles.zip
rm -rf dotfiles.zip
cd dotfiles-master

clear
echo "==========================================="
echo "The dotfiles directory is in your HOME"
echo "If you wish install now, execute:"
echo "cd ~/dotfiles-master"
echo "./install_dotfiles.sh"
echo
echo "OK"
echo "Everything is installed."
echo "Is recommended restart the machine now"
echo "==========================================="