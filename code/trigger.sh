#!/bin/bash

root_location=$(pwd)

wget https://github.com/frankjuniorr/Ubuntu-Install/archive/master.zip -O ubuntu_install.zip
unzip ubuntu_install.zip
rm -rf ubuntu_install.zip

cd ubuntu_install-master/code/base
clear

./run.sh

rm -rf "${root_location}/ubuntu_install-master"