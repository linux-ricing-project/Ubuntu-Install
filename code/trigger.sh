#!/bin/bash

root_location=$(pwd)

wget https://github.com/frankjuniorr/ubuntu_install/archive/master.zip -O ubuntu_install.zip
unzip ubuntu_install.zip
rm -rf ubuntu_install.zip

cd ubuntu_install-master/code/playbooks
clear

./run.sh

cd "$root_location"
rm -rf ubuntu_install-master