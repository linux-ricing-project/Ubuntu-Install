#!/bin/bash
################################################################################
# Descrição:
#    Script usado para automaizar o donwload e a execução do "run.sh"
#
################################################################################
# Uso:
#    wget -O installer.sh https://raw.githubusercontent.com/frankjuniorr/Ubuntu-Install/master/code/trigger.sh
#    chmod +x installer.sh
#    ./installer.sh
#
################################################################################
# Autor: Frank Junior <frankcbjunior@gmail.com>
################################################################################

root_location=$(pwd)
branch="master"

wget "https://github.com/linux-ricing-project/Ubuntu-Install/archive/${branch}.zip" -O "ubuntu_install.zip"
unzip ubuntu_install.zip
rm -rf ubuntu_install.zip

cd "Ubuntu-Install-${branch}/code/base"
clear

./run.sh

# rm -rf "${root_location}/Ubuntu-Install-${branch}"