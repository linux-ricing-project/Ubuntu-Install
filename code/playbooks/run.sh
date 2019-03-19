#!/bin/bash

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
  echo "Fazendo as atualizações iniciais..."
  echo "==========================================="
  sudo apt -y upgrade
  sudo apt -y dist-upgrade
  sudo apt -y full-upgrade

	echo "==========================================="
  echo "instalando o ansible..."
  echo "==========================================="
	sudo apt -y install software-properties-common
	sudo apt-add-repository --yes --update ppa:ansible/ansible
	sudo apt -y install ansible curl wget
}

show_header
init_updates

# runnind playbook
echo "==========================================="
echo "running ansible job"
echo "==========================================="
ansible-playbook --ask-become-pass main.yaml

clear
echo "==========================================="
echo "OK"
echo "Everything is installed."
echo "Is recommended restart the machine now"
echo "==========================================="