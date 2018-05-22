#!/bin/bash

################################################################################
# Descrição:
#   Script to initial configs to Ubuntu 18.04 Minimal Installation.
#
################################################################################
# Uso:
#    ./ubuntu_install.sh
#
################################################################################
# Autor: Frank Junior <frankcbjunior@gmail.com>
# Desde: 18-10-2017
# Versão: 1
################################################################################


################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

################################################################################
# Variáveis - todas as variáveis ficam aqui

baseDir=$(pwd)

################################################################################
# Utils - funções de utilidades

# códigos de retorno
# [condig-style] constantes devem começar com 'readonly'
readonly SUCESSO=0
readonly ERRO=1

# debug = 0, desligado
# debug = 1, ligado
debug=0

# ============================================
# Função pra imprimir informação
# ============================================
_print_info(){
  local amarelo="\033[33m"
  local reset="\033[m"

  printf "${amarelo}$1${reset}\n"
}

# ============================================
# Função pra imprimir mensagem de sucesso
# ============================================
_print_success(){
  local verde="\033[32m"
  local reset="\033[m"

  printf "${verde}$1${reset}\n"
}

# ============================================
# Função pra imprimir mensagem de titulo
# ============================================
_print_title(){
  local text_cyan="$(tput setaf 6 2>/dev/null || echo '\e[0;36m')"
  local text_reset="$(tput sgr 0 2>/dev/null || echo '\e[0m')"

  printf "${text_cyan}$1${text_reset}\n"
}

# ============================================
# Função pra imprimir erros
# ============================================
_print_error(){
  local vermelho="\033[31m"
  local reset="\033[m"

  printf "${vermelho}[ERROR] $1${reset}\n"
}

# ============================================
# Função de debug
# ============================================
_debug_log(){
  [ "$debug" = 1 ] && _print_info "[DEBUG] $*"
}

# ============================================
# tratamento das exceções de interrupções
# ============================================
_exception(){
  return "$ERRO"
}

################################################################################
# Validações - regras de negocio até parametros

# ============================================
# tratamento de validacoes
# ============================================
validacoes(){
	return "$SUCESSO"
}

################################################################################
# Funções do Script - funções próprias e específicas do script

# ============================================
# Fazendo as atualizações iniciais
# ============================================
init_updates(){
  # updagrade inicial, por volta de uns 300 MB
  _print_info "Fazendo as atualizações iniciais..."
  sudo apt -y upgrade
  sudo apt -y dist-upgrade

  # instalações dos pacotes de comunicação primeiro.
  sudo apt install -y curl wget
}

# ============================================
# adicionando repositórios dos Themes
# ============================================
add_themes(){
  _print_info "Adicionando repositórios dos Themes..."

  # para o Adapta theme (Material Design)
  if [ ! -f /etc/apt/sources.list.d/tista-ubuntu-adapta-bionic.list ];then
    sudo apt-add-repository ppa:tista/adapta -y
  else
    _print_success "Repositório do Adapta-theme já existe"
  fi

  if [ ! -f /etc/apt/sources.list.d/papirus-ubuntu-papirus-bionic.list ];then
    # pacote de icones pro Adapta theme (icones Material)
    sudo apt-add-repository ppa:papirus/papirus -y
  else
    _print_success "Repositório do Adapta-icon (Papirus) já existe"
  fi

  if [ ! -f /etc/apt/sources.list.d/communitheme-ubuntu-ppa-bionic.list ];then
    # instalação do CommunityTheme
    sudo add-apt-repository ppa:communitheme/ppa -y
  else
    _print_success "Repositório do CommunitTheme já existe"
  fi

}

# ============================================
# adicionando repositório do Spotify
# ============================================
add_spotify_repo(){
  if [ ! -f /etc/apt/sources.list.d/spotify.list ];then
    _print_info "Adicionando repositório do Spotify..."
    # 1. Add the Spotify repository signing keys to be able to verify downloaded packages
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
    # 2. Add the Spotify repository
    echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  else
    _print_success "Repositório do Spotify já existe"
  fi
}

# ============================================
# adicionando repositório do Atom
# ============================================
add_atom_repo(){
  if [ ! -f /etc/apt/sources.list.d/atom.list ];then
    _print_info "Adicionando repositório do Atom..."
    curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
  else
    _print_success "repostiório do Atom já existe"
  fi
}

# ============================================
# adicionando repositório do LibreOffice
# ============================================
add_libreOffice_repo(){
  if [ ! -f /etc/apt/sources.list.d/libreoffice-ubuntu-ppa-bionic.list ];then
    _print_info "Adicionando repositório do LibreOffice..."
    sudo add-apt-repository ppa:libreoffice/ppa -y
  else
    _print_success "o repositório do LibreOffice já está instalado"
  fi
}

# ============================================
# adicionando repositório do Transmission
# ============================================
add_transmission_repo(){
  if [ ! -f /etc/apt/sources.list.d/transmissionbt-ubuntu-ppa-bionic.list ];then
    _print_info "Adicionando repositório do Transmission..."
    sudo add-apt-repository ppa:transmissionbt/ppa -y
  else
    _print_success "repositório do Transmission já existe"
  fi
}

# ============================================
# instalação dos Dark Themes
# ============================================
install_themes(){

  _print_info "Instalando temas..."

  sudo apt -y install \
  adapta-gtk-theme \
  papirus-icon-theme \
  ubuntu-communitheme-session
}

# ============================================
# instalação dos Calibre - Kindle ebook management
# ============================================
install_calibre(){
  if ! type calibre > /dev/null 2>&1; then
    _print_info "Instalando o Calibre..."
    sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
  else
    _print_success "O Calibre já está instalado"
  fi
}

# ============================================
# instalação do Google Chrome
# ============================================
install_google_chrome(){
  if ! type google-chrome > /dev/null 2>&1; then
    _print_info "Instalando Google Chrome..."
    # fazendo download
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    # instalando usando o 'gdebi'
    sudo gdebi google-chrome-stable_current_amd64.deb
    # removendo o pacote.deb
    rm google-chrome-stable_current_amd64.deb
  else
    _print_success "O Google Chrome já está instalado"
  fi
}

# ============================================
# Instala o Telegram Desktop
# ============================================
install_telegram(){
  cd ~ > /dev/null

  if [ ! -d $HOME/Telegram ];then
    _print_info "Instalando Telegram Desktop..."
    # fazendo donwload do Telegram
    wget https://telegram.org/dl/desktop/linux -O telegram.tar.xz
    wget https://telegram.org/img/t_logo.png -O telegram_logo_raw.png
    # extraindo o arquivo compactado
    tar -xvf telegram.tar.xz

    # convertendo o tamanho do icone para 128x128 (o original vem (256x256)
    convert -resize 128x128 telegram_logo_raw.png telegram_logo.png

    mv telegram_logo.png Telegram/

    # deletando os arquivos
    rm telegram.tar.xz
    rm telegram_logo_raw.png

    local telegramDesktopFile='[Desktop Entry]
    Type=Application
    Exec=/home/@user@/Telegram/Telegram
    Icon=/home/@user@/Telegram/telegram_logo.png
    Hidden=false
    NoDisplay=false
    Name[en_US]=Telegram
    Name=Telegram
    Comment[en_US]=
    Comment=
    '

    telegramDesktopFile=$(echo "$telegramDesktopFile" | sed "s/@user@/$USER/g")

    echo "$telegramDesktopFile" > $HOME/.local/share/applications/telegram.desktop

    _print_success "O Telegram foi instalado em $HOME/Telegram"
  else
    _print_success "Telegram já está instalado em $HOME/Telegram"
  fi

  cd "$baseDir" > /dev/null

}

# ============================================
# Instala plugins and add-ons pro Atom.
# ============================================
upgrade_atom(){
  _print_info "Upgrade Atom..."
  # Install some Atom Packages

  # Atom package to set specific file icons in tree
  if [ ! -d ~/.atom/packages/file-icons ];then
    apm install file-icons
  else
    _print_success "file-icons já está instalado"
  fi

  # Atom package to Material Design Theme
  if [ ! -d ~/.atom/packages/atom-material-ui ];then
    apm install atom-material-ui
  else
    _print_success "atom-material-ui já está instalado"
  fi

  # Atom package to Material Design syntax dark
  if [ ! -d ~/.atom/packages/atom-material-syntax-dark ];then
    apm install atom-material-syntax-dark
  else
    _print_success "atom-material-syntax-dark já está instalado"
  fi

# Atom package to auto formatting code [with ctrl+alt+b]
  if [ ! -d ~/.atom/packages/atom-beautify ];then
    apm install atom-beautify
  else
    _print_success "atom-beautify já está instalado"
  fi

  # Python code that use to formatting Shell Script.
  # this is necessary to [atom-beautify] works
  # pip install beautysh
}

# ============================================
# instalando o Dropbox
# ============================================
install_dropbox(){

  if [ ! -d ~/.dropbox-dist/ ];then
    _print_info "Instalando o Dropbox..."

    cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

    dropboxFile='[Desktop Entry]
    Type=Application
    Exec=/home/@user@/.dropbox-dist/dropboxd
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    Name[en_US]=Dropbox
    Name=Dropbox
    Comment[en_US]=
    Comment=
    '
    dropboxFile=$(echo "$dropboxFile" | sed "s/@user@/$USER/")

    if [ ! -d ~/.config/autostart ];then
      mkdir ~/.config/autostart
    fi
    echo "$dropboxFile" > ~/.config/autostart/dropbox.desktop
  else
    _print_success "Dropbox já está instalado"
  fi

  cd "$baseDir" > /dev/null
}

# ============================================
# instala ferramentas e programas utils
# ============================================
install_packages(){
  _print_info "Instalando algumas ferramentas e utilitários..."

  # [gksu] - (DEU ERRO) para executar o “Disk Usage Analyzer (baobab)”, usando o  “gksudo baobab”
  # [git]
  # [meld] - usado para os diffs do git
  # [vim]
  # [gdebi-core] - 'gdebi' is a simple way to install deb files, installaling dependencies too
  # [transmission] - torrent client
  # [libreOffice] - packages about LibreOffice
  # [gnome-tweak-tool] - usado para customizar a interface gráfica
  # [atom] - IDE
  # [python-pip] - Instalador de pacotes do Python
  # [browser-plugin-vlc] - VLC
  # [lame] - create mp3 audio files
  # [sound-juicer] - rip cdrom
  # [ImageMagick] - pacote para manipualções de imagens
  # [ubuntu-restricted-extras] - pacotes extras do Ubuntu: mp3 codec, font tts da Microsoft....

  sudo apt -y install \
  git \
  meld \
  vim \
  gdebi-core \
  transmission \
  libreoffice-gtk2 libreoffice-gnome \
  gnome-tweak-tool \
  spotify-client \
  atom \
  python-pip \
  browser-plugin-vlc \
  lame \
  sound-juicer \
  ImageMagick \
  ubuntu-restricted-extras

  install_telegram
  install_google_chrome
  install_calibre
  install_dropbox

  upgrade_atom
}

# ============================================
# limpa dependencias
# ============================================
clean_dependencies(){
  # apt fix-broken
  # pra consertar possíveis dependencias e pacotes quebrados
  sudo apt -f -y install
  # remover pacotes não mais utilizados
  sudo apt-get autoremove -y
  # deletar os pacotes .deb em '/var/cache/apt/archives/'
  sudo apt-get clean -y
}

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
# Função Main
# ============================================
main(){

  _print_title "==========================================="
  _print_title "[01/06] Upgrade inicial..."
  _print_title "==========================================="
  echo ""

  init_updates

  _print_title "==========================================="
  _print_title "[02/06] Add repositories..."
  _print_title "==========================================="
  echo ""

  add_spotify_repo
  add_atom_repo
  add_themes
  add_libreOffice_repo
  add_transmission_repo

  # Atualizando....
  _print_title "==========================================="
  _print_title "[03/06] Update packages..."
  _print_title "==========================================="
  echo ""

  sudo apt update

  _print_title "==========================================="
  _print_title "[04/06] Install packages..."
  _print_title "==========================================="
  echo ""

  install_themes
  install_packages

  _print_title "==========================================="
  _print_title "[05/06] Clean dependencies..."
  _print_title "==========================================="
  echo ""

  clean_dependencies

  _print_title "==========================================="
  _print_title "[06/06] Install development environment..."
  _print_title "==========================================="
  echo ""

  cd "$baseDir" > /dev/null
  ./development_install.sh

  clear
  _print_success "pronto, tudo OK."
  _print_success "Se você acabou de formatar o computador, é bom resetar a máquina =D"
}

################################################################################
# Main - execução do script

# trata interrrupção do script em casos de ctrl + c (SIGINT) e kill (SIGTERM)
trap _exception SIGINT SIGTERM

validacoes
show_header
main

################################################################################
# FIM do Script =D
