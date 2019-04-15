#!/bin/bash

root_location=$(pwd)
# Variável para fins de teste
branch="dev"

wget https://github.com/frankjuniorr/ubuntu_install/archive/${branch}.zip -O ubuntu_install.zip
unzip ubuntu_install.zip
rm -rf ubuntu_install.zip

cd ubuntu_install-${branch}/code/base
clear

./run.sh

rm -rf "${root_location}/ubuntu_install-${branch}"