#!/bin/bash

wget https://github.com/frankjuniorr/ubuntu_install/archive/master.zip -O ubuntu_install.zip
unzip ubuntu_install.zip
rm -rf ubuntu_install.zip

cd ubuntu_install-master/code/playbooks
clear

./run.sh

cd ~ 
rm -rf ubuntu_install-master