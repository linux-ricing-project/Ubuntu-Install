#!/bin/bash

################################################################################
#
# Descrição:
#    Script usado para instalar o ambiente de desenvolvimento ná máquina
#
################################################################################
#
# Uso:
#    ./developmnent_install.sh
#
################################################################################
#
# Autor: Frank Junior <frankcbjunior@gmail.com>
# Desde: 19-04-2018
# Versão: 1
#
################################################################################


################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
  set -e


################################################################################
# Variáveis - todas as variáveis ficam aqui

readonly ANDROID_STUDIO_FOLDER="$HOME/android_ambiente"

  # mensagem de help
    nome_do_script=$(basename "$0")

    mensagem_help="
  Uso: $nome_do_script [OPÇÕES] <NOME_DO_SCRIPT>

  Descrição: .....

  OPÇÕES: - opcionais
    -h, --help  Mostra essa mesma tela de ajuda

  PARAM - obrigatório
    - descrição do PARAM

  Ex.: ./$nome_do_script -h
  Ex.: ./$nome_do_script PARAM
  "


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
    local text_yellow="$(tput setaf 3 2>/dev/null || echo '\e[0;33m')"
    local text_reset="$(tput sgr 0 2>/dev/null || echo '\e[0m')"

    printf "${text_yellow}$1${text_reset}\n"
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
# Instala o Android Studio
# ============================================
  android_studio_install(){
    if [ ! -d "${ANDROID_STUDIO_FOLDER}/android-studio" ];then

      local android_studio_zip=''

      # libs necessárias para a instalação do Android Studio
      _print_info "instalando dependencias..."
      sudo apt install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

      link_download=$(curl --silent https://developer.android.com/studio/#downloads |\
      grep "https://dl.google.com/dl/android/studio/ide-zips" |\
      grep -m1 "linux" |\
      cut -d "=" -f2 |\
      sed 's/\"//g')

      android_studio_zip=$(basename "$link_download")

      # fazendo download do arquivo zip do Android Studio
      _print_info "fazendo download..."
      wget --no-check-certificate --no-cookies --header \
      "Cookie: oraclelicense=accept-securebackup-cookie" "$link_download"

      _print_info "instalando..."

      # criando o diretório de instalação
      mkdir "$ANDROID_STUDIO_FOLDER"

      # movendo para o diretório correto
      mv "$android_studio_zip" "$ANDROID_STUDIO_FOLDER"
      # entrando no diretório
      cd "$ANDROID_STUDIO_FOLDER"
      # extraindo o zip
      _print_info "extraindo..."
      unzip -q "$android_studio_zip"
      # deletando o zip
      rm "$android_studio_zip"

      _print_info "Android Studio instalado em $ANDROID_STUDIO_FOLDER"
    else
      _print_success "O Android Studio já está instalado em ${ANDROID_STUDIO_FOLDER}/android-studio"
    fi

  }

  # ============================================
  # Instala o Postman
  # ============================================
  postman_install(){
    if ! type postman > /dev/null 2>&1; then
      _print_info "Instalando o Postman..."

      echo "download...."
      wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz

      echo "extraindo...."
      sudo tar -xzf postman.tar.gz -C /opt

      echo "deletando o .tar.gz...."
      rm postman.tar.gz

      echo "linkando de /opt para /usr/bin...."
      sudo ln -s /opt/Postman/Postman /usr/bin/postman

      echo "criando arquivo .desktop"

      local postmanFile="[Desktop Entry]
      Encoding=UTF-8
      Name=Postman
      Exec=postman
      Icon=/opt/Postman/resources/app/assets/icon.png
      Terminal=false
      Type=Application
      Categories=Development;"

      echo "$postmanFile" > ~/.local/share/applications/postman.desktop
    else
      _print_success "o Postman já está instalado"
    fi
  }

  # ============================================
  # Função Main
  # ============================================
  main(){

    _print_info "==========================================="
    _print_info "Instalação do Postman"
    _print_info "==========================================="
    echo ""

    postman_install

    _print_info "==========================================="
    _print_info "Instalação do NodeJs"
    _print_info "==========================================="
    echo ""

    sudo apt install -y nodejs npm

    _print_info "==========================================="
    _print_info "Instalação do Java 8"
    _print_info "==========================================="
    echo ""

    # instalando Java8 através do instalador
    sudo ./java_install.sh

    _print_info "==========================================="
    _print_info "Instalação do Android Studio"
    _print_info "==========================================="
    echo ""

    android_studio_install
  }

  # ============================================
  # Função que exibe o help
  # ============================================
  verifyHelp(){
    case "$1" in

      # mensagem de help
      -h | --help)
        _print_info "$mensagem_help"
        exit "$SUCESSO"
      ;;

    esac
  }

################################################################################
# Main - execução do script

  # trata interrrupção do script em casos de ctrl + c (SIGINT) e kill (SIGTERM)
  trap _exception SIGINT SIGTERM
  verifyHelp "$1"
  validacoes
  main "$1"

################################################################################
# FIM do Script =D
