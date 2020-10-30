#!/bin/bash
################################################################################
# Descrição:
#    Script principal para fazer todas as instalações que eu uso.
#    O script é voltado para Ubuntu 20.04 com Gnome
#
################################################################################
# Uso:
#    ./run.sh
#
################################################################################
# Autor: Frank Junior <frankcbjunior@gmail.com>
################################################################################

################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

# ============================================
# mostrar o banner inicial
# ============================================
# link: http://patorjk.com/software/taag/#p=display&c=bash&f=ANSI%20Shadow&t=Ubuntu%20Install
show_header(){
cat << "HEADER"
   __  ____                __           ____           __        ____
  / / / / /_  __  ______  / /___  __   /  _/___  _____/ /_____ _/ / /
 / / / / __ \/ / / / __ \/ __/ / / /   / // __ \/ ___/ __/ __ `/ / /
/ /_/ / /_/ / /_/ / / / / /_/ /_/ /  _/ // / / (__  ) /_/ /_/ / / /
\____/_.___/\__,_/_/ /_/\__/\__,_/  /___/_/ /_/____/\__/\__,_/_/_/
                                        Developed by Frank Junior
HEADER
}

# ============================================
# Pré configurações
# ============================================
pre_config(){
  echo "############################################"
  echo " Pré-Config"
  echo "############################################"

  echo "[DEBUG]: Create a my own bin folder"
  [[ ! -d "${HOME}/bin" ]] && mkdir "${HOME}/bin"

  echo "[DEBUG]: Remove useless folders"
  [[ -d "${HOME}/Templates" ]] && rm -rf "${HOME}/Templates"
  [[ -f "${HOME}/examples.desktop" ]] && rm -rf "${HOME}/examples.desktop"

  echo "[DEBUG]: Create autostart folder"
  [[ ! -d "${HOME}/.config/autostart" ]] && mkdir -p "${HOME}/.config/autostart"
}

# ============================================
# Instalação do python3 e pip3
# ============================================
python3_pip3_install(){

  if ! type pip3 > /dev/null 2>&1; then
    echo
    echo "############################################"
    echo " Python3 and Pip3"
    echo "############################################"

    sudo apt -y install \
        python3-distutils \
        python3-testresources

    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py --user

    source ~/.profile
    rm -rf get-pip.py

    # essa linha só serve pra debug mesmo, pra garantir que a instalação do pip foi ok.
    pip3 --version
  fi

}

# ============================================
# Instala os principais pacotes iniciais
# ============================================
initial_installations(){
  echo
  echo "############################################"
  echo " Initial Installations"
  echo "############################################"

  sudo apt -y install software-properties-common curl wget
}

# ============================================
# Instala as depêndencias do Ubuntu-Install optional
# ============================================
ubuntu_optional_dependencies(){
  echo
  echo "############################################"
  echo " Install Ubuntu-Optional dependencies"
  echo "############################################"

  pip3 install -r requirements.txt
}

# ============================================
# Fazendo as atualizações iniciais
# ============================================
system_update(){
  echo
  echo "############################################"
  echo " System Update"
  echo "############################################"
  # Isso aqui resolve a frescura do apt-get que já começa bugado com um arquivo de lock ¬¬
  test -f /var/lib/apt/lists/lock && sudo rm -rf /var/lib/apt/lists/lock
  test -f /var/cache/apt/archives/lock && sudo rm -rf /var/cache/apt/archives/lock
  test -f /var/lib/dpkg/lock && sudo rm -rf /var/lib/dpkg/lock
  test -f /var/lib/dpkg/lock-frontend && sudo rm -rf /var/lib/dpkg/lock-frontend

  sudo apt -y upgrade
  sudo apt -y dist-upgrade
  sudo apt -y full-upgrade
}

# ============================================
# limpando o ambiente dos pacotes do apt
# ============================================
clean_environment(){
  echo
  echo "############################################"
  echo " Clean Environment"
  echo "############################################"

  sudo apt -y update && sudo apt -y upgrade
  sudo apt autoremove -y;
  sudo apt autoclean -y;
  sudo apt clean -y
}

# ============================================
# Download meus repositório de dotfiles
# ============================================
download_dotfiles(){
  echo
  echo "############################################"
  echo " Install my dotfiles"
  echo "############################################"

  cd $HOME
  wget "https://github.com/linux-ricing-project/dotfiles/archive/master.zip" -O "dotfiles.zip"
  unzip "dotfiles.zip"
  rm -rf "dotfiles.zip"
  cd dotfiles

  read -p "Enter Git username: " git_username
  read -p "Enter Git email: " git_email

  ./install_dotfiles.sh "$git_username" "$git_email"
  cd $HOME
}

# ============================================
# function that trigger the init installations
# ============================================
init(){
  pre_config
  # upgrade inicial, por volta de uns 300 MB
  system_update
  initial_installations
  python3_pip3_install
  ubuntu_optional_dependencies
}

# ######################### MAIN #########################
show_header
init

bash src/install-packages.sh
bash src/install-main-packages.sh
bash src/install-custom-shell.sh

clean_environment
download_dotfiles

clear
echo "==========================================="
echo "OK"
echo "The dotfiles directory is in your HOME"
echo "Everything is installed."
echo "Is recommended restart the machine now"
echo "==========================================="