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
  echo " [2] Transmission"
  echo " [3] Postman"
  echo "========================================================="
  read -p "[Choose a package you want to install]: " opcao
}

clear
menu

case "$opcao" in
  1)
    echo "Installing Telegram..."
    ansible-playbook telegram/telegram_install.yaml
  ;;
  2)
    echo "Installing Transmission..."
    ansible-playbook --ask-become-pass transmission_install.yaml
  ;;
  3)
    echo "Installing Postman..."
    ansible-playbook postman/postman_install.yaml
  ;;
  *)
    echo "Invalid Option"
  ;;
esac