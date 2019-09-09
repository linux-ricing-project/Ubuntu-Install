#!/bin/bash

function install_options(){
  local options="$*"


  for package in $options;do
    case "$package" in
      "LibreOffice")
        ansible-playbook libreoffice_install.yaml
      ;;
      "Transmission")
        ansible-playbook transmission_install.yaml
      ;;
      "Postman")
        echo "Postman installation..."
        sleep 3
      ;;
      "Telegram")
        ansible-playbook telegram/telegram_install.yaml
      ;;
    esac
  done

  zenity --title "Ubuntu Install" --info \
          --text="Packages installed with success"
}

packages_array=()

# verifica se o LibreOffice está instalado
if ! which "libreoffice" > /dev/null 2>&1; then
  packages_array+=(False LibreOffice)
fi

# verifica se o Transmission está instalado
if ! which "transmission-gtk" > /dev/null 2>&1 ;then
  packages_array+=(False Transmission)
fi

# verifica se o Postman está instalado
if ! which "postman" > /dev/null 2>&1; then
  packages_array+=(False Postman)
fi

# verifica se o Telegram está instalado
if [ -f "$HOME/bin/Telegram/Telegram" ]; then
  packages_array+=(False Telegram)
fi

# se o array estiver vazio, significa dizer que todos os
# pacotes disponíveis já estão instalados.
if [ ${#packages_array[@]} -eq 0 ]; then
    zenity --title "Ubuntu Install" --info \
          --text="All the avaliable packages already installed"
    exit 0
fi

# exibe a listagem dos pacotes disponíveis para instalação
resposta=$(zenity --list --checklist \
    --title="Ubuntu Install"\
    --text="Select a package that you want install"\
    --width=400 --height=400 \
    --column="Select"\
    --column="Package"\
    "${packages_array[@]}")

# se a resposta for vazia, significa que não foi selecionada
# nenhuma opção
if [ -z "$resposta" ];then
  echo "apertou o cancel ou fechou a janela"
  exit 0
fi

options=$(echo "$resposta" | tr "|" " ")
install_options "$options"
