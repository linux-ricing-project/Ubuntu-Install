#!/bin/bash

################################################################################
# Configurações
# set:
# -e: se encontrar algum erro, termina a execução imediatamente
set -e

# ============================================
# Instala o 'colorls', que deixa a saída do comando 'ls' mais bonita
# link: https://github.com/athityakumar/colorls
# ============================================
install_colorls(){
  if ! type colorls > /dev/null 2>&1; then
      sudo apt update
      sudo apt install -y libncurses5-dev libtinfo-dev gcc make ruby ruby-dev ruby-colorize
      sudo gem install colorls

      # TODO: linkar aqui, o diretório 'colorls' para '~/.config'
      # cp -r "colorls" "${HOME}/.config"
  fi
}

# ============================================
# Instala algumas fontes do Nerd-Fonts
# link: https://github.com/ryanoasis/nerd-fonts
# ============================================
install_fonts(){
    echo
    echo "############################################"
    echo " Install Nerd Fonts"
    echo "############################################"

    # instalando as fontes
    local font_location="${HOME}/.local/share/fonts"
    [[ ! -d "$font_location" ]] && mkdir "$font_location"

    local fonts_array=(
        "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf"
    )

    for font in ${fonts_array[*]};do
        local font_name=$(echo $font | cut -d '/' -f9)

        if ! fc-list | grep -q $font_name; then
            wget "$font" --directory-prefix "${font_location}"
        fi
    done

    # refresh fonts
    fc-cache -f -v
}

# ============================================
# Instala as customizações do shell:
# - zsh
# - oh-my-zsh: https://github.com/ohmyzsh/ohmyzsh
# - powerlevel10k: https://github.com/romkatv/powerlevel10k
# ============================================
install_shell(){
  if ! type zsh > /dev/null 2>&1; then
    sudo apt update
    sudo apt install -y zsh

    # instalando o OhMyZSH
    git clone https://github.com/ohmyzsh/ohmyzsh.git ${HOME}/.oh-my-zsh
    # instalando o plugin do zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # instalando o plugin do zsh-completions
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions
    # instalando o plugin do zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # instalando o powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k

    # transformando o zsh no shell padrão
    chsh -s $(which zsh)
  fi
}

# ######################### MAIN #########################
install_colorls
install_fonts
install_shell
