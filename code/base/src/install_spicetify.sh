#!/bin/bash

# ##############################################################################
# [Descrição]:
#   Script que instala e configura o spicetify [https://github.com/khanhas/spicetify-cli]
#   * Eu achei mais fácil fazer por aqui do que no Ansible =)
#
# ##############################################################################

spicetify_version="0.9.7"

if [ ! -d $HOME/bin/spicetify ];then
  mkdir $HOME/bin/spicetify
fi

cd $HOME/bin/spicetify

# fazendo download do spicetify
wget "https://github.com/khanhas/spicetify-cli/releases/download/v${spicetify_version}/spicetify-${spicetify_version}-linux-amd64.tar.gz"

# extraind e deletando zip
tar xzf spicetify-${spicetify_version}-linux-amd64.tar.gz
rm -rf spicetify-${spicetify_version}-linux-amd64.tar.gz

# criando um link simbólico pra usar o spicetify como um comando
sudo ln -s $HOME/bin/spicetify/spicetify /usr/bin/spicetify

# essa linha é necessaŕio pra o spicetify ter permissão de alterar o spotify
if [ -d /usr/share/spotify/ ];then
  sudo chmod 777 -R /usr/share/spotify
else
  echo "the spotify installation is not in /usr/share/spotify"
  echo "please, execute the command 'chmod 777' in correct installation path"
  exit 0
fi

# rodando o comando do spicetify pra ele configurar as coisas
spicetify

# criando um backup do estado atual do spotify
spicetify backup apply enable-devtool