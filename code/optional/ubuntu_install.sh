#1/bin/bash

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

function menu(){
  show_header
  echo
  echo "========================================================="
  echo -e "\t\tPACKAGE MENU"
  echo "========================================================="
  echo " [1] Telegram"
  echo " [2] LibreOffice"
  echo " [3] Transmission"
  echo " [4] Postman"
  echo "========================================================="
  echo "[Choose a package you want to install]: "
}

clear
menu

read opcao
case "$opcao" in
  1)
    echo "Installing Telegram..."
    ansible-playbook --ask-become-pass telegram/telegram_install.yaml
  ;;
  2)
    echo "Installing LibreOffice..."
    ansible-playbook --ask-become-pass libreoffice_install.yaml
  ;;
  3)
    echo "Installing Transmission..."
    ansible-playbook --ask-become-pass transmission_install.yaml
  ;;
  4)
    echo "Installing Postman..."
    echo "not implement yet"
  ;;
  *)
    echo "Invalid Option"
  ;;
esac