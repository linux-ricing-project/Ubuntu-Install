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
# Instalação do Ansible via Pip.
# A versão que ta no apt-get ta desatualizada pra variar ¬¬
# ============================================
ansible_install(){
  sudo apt -y install software-properties-common \
      curl \
      wget \
      python3-distutils \
      python3-testresources

  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py --user

  source ~/.profile
  rm -rf get-pip.py

  # essa linha só serve pra debug mesmo, pra garantir que a instalação do pip foi ok.
  pip3 --version

  pip3 install --user ansible
  ansible --version
}

# ============================================
# Fazendo as atualizações iniciais
# ============================================
system_update(){
  echo "==========================================="
  echo "Do the initial upgrades..."
  echo "==========================================="

  # Isso aqui resolve a frescura do apt-get que já começa bugado com um arquivo de lock ¬¬
  test -f /var/lib/apt/lists/lock && sudo rm -rf /var/lib/apt/lists/lock
  test -f /var/cache/apt/archives/lock && sudo rm -rf /var/cache/apt/archives/lock
  test -f /var/lib/dpkg/lock && sudo rm -rf /var/lib/dpkg/lock
  test -f /var/lib/dpkg/lock-frontend && sudo rm -rf /var/lib/dpkg/lock-frontend

  sudo apt -y upgrade
  sudo apt -y dist-upgrade
  sudo apt -y full-upgrade
}

init(){
  # updagrade inicial, por volta de uns 300 MB
  system_update

  # ============================================
  # Instalando o Ansible
  # ============================================
  if ! type ansible > /dev/null 2>&1; then
    echo "==========================================="
    echo "Installing Ansible..."
    echo "==========================================="

    ansible_install
  fi
}

show_header
init

echo "==========================================="
echo "Running Ansible Job"
echo "==========================================="
ansible-playbook --ask-become-pass main.yaml

clear
echo "==========================================="
echo "OK"
echo "The dotfiles directory is in your HOME"
echo "Everything is installed."
echo "Is recommended restart the machine now"
echo "==========================================="