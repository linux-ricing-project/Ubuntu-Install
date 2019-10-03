#!/bin/bash

function info_dialog(){
  local message="$1"

  zenity --title "Ubuntu Install" --info \
          --text="$message" \
          --width=200
}

function install_options(){
  local options="$*"
  # em shell script, o zero é sucesso, e 1 é false.
  local result="error"

  local mySudoPassword=$(zenity --password --title="Ubuntu Install")
  if [ -z "$mySudoPassword" ];then
    echo "user password is blank"
    unset mySudoPassword
    exit 1
  fi

  for package in $options;do
    case "$package" in
      "LibreOffice")
        ansible-playbook --user=$USER --extra-vars "ansible_sudo_pass=$mySudoPassword" libreoffice_install.yaml
        test $? == "0" && result="success" || result="error"
      ;;
      "Transmission")
        ansible-playbook --user=$USER --extra-vars "ansible_sudo_pass=$mySudoPassword" transmission_install.yaml
        test $? == "0" && result="success" || result="error"
      ;;
      "Postman")
        echo "Postman installation..."
        sleep 3
      ;;
      "Telegram")
        ansible-playbook --user=$USER --extra-vars "ansible_sudo_pass=$mySudoPassword" telegram/telegram_install.yaml
        test $? == "0" && result="success" || result="error"
      ;;
    esac

    unset mySudoPassword
  done

  if [ "$result" == "success" ];then
    info_dialog "Packages installed with success"
  else
    info_dialog "the installation was failed"
  fi
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
    info_dialog "All the avaliable packages already installed"
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
