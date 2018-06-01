#!/bin/bash

################################################################################
# Descrição:
# 	Instala o JDK 8 da Oracle no Ubuntu
#
################################################################################
# Uso:
# sudo ./java_install.sh
#
################################################################################
# Autor: Frank Junior <frankcbjunior@gmail.com>
# Desde: 2013-07-22
# Versão: 1
################################################################################


################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e


################################################################################
# Variáveis - todas as variáveis ficam aqui

# URL do site da Oracle
readonly ORACLE_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"

# path onde o java será instalado
java_location="/usr/lib/jvm"

# pacote .tar.gz
jdk_tar_gz=""

################################################################################
# Utils - funções de utilidades

# códigos de retorno
# [condig-style] constantes devem começar com 'readonly'
readonly SUCESSO=0
readonly ERRO=1

# debug = 0, desligado
# debug = 1, ligado
debug=0

# ============================================
# Função pra imprimir informação
# ============================================
_print_info(){
  local amarelo="\033[33m"
  local reset="\033[m"

  printf "${amarelo}$1${reset}\n"
}

# ============================================
# Função pra imprimir mensagem de sucesso
# ============================================
_print_success(){
  local verde="\033[32m"
  local reset="\033[m"

  printf "${verde}$1${reset}\n"
}

# ============================================
# Função pra imprimir erros
# ============================================
_print_error(){
  local vermelho="\033[31m"
  local reset="\033[m"

  printf "${vermelho}[ERROR] $1${reset}\n"
}

# ============================================
# Função de debug
# ============================================
_debug_log(){
  [ "$debug" = 1 ] && _print_info "[DEBUG] $*"
}

# ============================================
# tratamento das exceções de interrupções
# ============================================
_exception(){
  return "$ERRO"
}

################################################################################
# Validações - regras de negocio até parametros

# ============================================
# tratamento de validacoes
# ============================================
validacoes(){
  # verifica se o script foi rodado com sudo
	if [ ! $(id -u) -eq 0 ];then
		_print_error "rode o script com sudo"
		exit "$ERRO"
  fi
}

################################################################################
# Funções do Script - funções próprias e específicas do script

# ============================================
# faz o donwload do JDK
# ============================================
download_jdk(){
	local arquitetura=''
	local link_download=''

	# verifica a arquitetura do computador
	if [ $(arch) = 'x86_64' ];then
		arquitetura="x64"
	else
		arquitetura="i586"
	fi

	# 1. baixando o html do site da Oracle
	# 2. procurando pela string de donwload
	# 3. pegando apenas a strings com a url de download
	# 4. mais uma filtragem pra pegar apenas a url de donwload
	# 5. removendo as aspas
	# 6. pegando apenas a primeira ocorrencia da busca pela string de arquitetura

	link_download=$(curl --silent "$ORACLE_URL" | \
	grep 'http://download.oracle.com/otn-pub/java/jdk.*\.tar\.gz' | \
	cut -d ":" -f4-5 | \
	cut -d "," -f1 | \
	sed 's/\"//g' | \
	grep -m 1 "$arquitetura")

	# pegando o nome do arquivo que será feito o download
	jdk_tar_gz=$(basename "$link_download")

	# e finalmente, fazendo o download do arquivo do JDK
	wget --no-check-certificate --no-cookies --header \
	"Cookie: oraclelicense=accept-securebackup-cookie" "$link_download"
}

# ============================================
# criando o diretório onde será instalado o jdk
# ============================================
_java_install_location(){
	if [ ! -d $java_location ]; then
		_print_info "criando diretório java em $java_location"
		mkdir -p $java_location
	fi
}

# ============================================
# Função que instala o java no diretório correto
# ============================================
java_install(){
	# criando o diretório onde o java será instalado
	_java_install_location

	# pegando o nome do diretorio que o tar.gz vai extrair
	java=$(tar -tf $jdk_tar_gz | cut -d "/" -f1 | uniq)

	# movendo o tar.gz para o diretorio de instalação do java
	mv $jdk_tar_gz $java_location

	#entrando no path
	cd $java_location
	# extraindo todos os .tar.gz
	tar -xzf *.tar.gz
	#deletando todos os tar.gz
	rm *.tar.gz
}

# ============================================
# Informando ao Ubuntu aonde sua instalação do Java está localizada
# ============================================
java_set_location(){
	# informando onde está sua localização padrão do java
	update-alternatives --install "/usr/bin/javac" "javac" "$java_location/$java/bin/javac" 1
	update-alternatives --install "/usr/bin/java" "java" "$java_location/$java/bin/java" 1
}

# ============================================
# Informando ao Ubuntu que esse é a sua instalação default de Java
# ============================================
java_set_default(){
	# Informando que essa é sua instalação default do java
	update-alternatives --set "javac" "$java_location/$java/bin/javac"
	update-alternatives --set "java" "$java_location/$java/bin/java"
}

# ============================================
# atualizando o path no $HOME/.bashrc
# ============================================
update_path(){
	echo "" >> $HOME/.bashrc
	echo "#------- instalação do java -------" >> $HOME/.bashrc
	echo "JAVA_HOME=$java_location/$java" >> $HOME/.bashrc
	echo 'PATH=$PATH:$JAVA_HOME/bin' >> $HOME/.bashrc
	echo 'export JAVA_HOME' >> $HOME/.bashrc
	echo 'export PATH' >> $HOME/.bashrc

	#reload no $HOME/.bashrc
	source $HOME/.bashrc
}

# ============================================
# Função Main
# ============================================
main(){
  if [ ! -d "$java_location" ];then
    # fazendo o download do JDK
    download_jdk

    _print_info "instalando java..."
    # instalando o java
    java_install
    java_set_location
    java_set_default

    update_path

    _print_info "JDK instalado com sucesso"
  else
    _print_success "Já existe uma instalação do java em $java_location"
  fi

}

################################################################################
# Main - execução do script

# trata interrrupção do script em casos de ctrl + c (SIGINT) e kill (SIGTERM)
trap _exception SIGINT SIGTERM

validacoes
main

################################################################################
# FIM do Script =D
