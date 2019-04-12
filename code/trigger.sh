#!/bin/bash

root_location=$(pwd)

wget https://github.com/frankjuniorr/ubuntu_install/archive/dev.zip -O ubuntu_install.zip
unzip ubuntu_install.zip
rm -rf ubuntu_install.zip

cd ubuntu_install-dev/code/playbooks
clear

./run.sh

rm -rf "${root_location}/ubuntu_install-dev"