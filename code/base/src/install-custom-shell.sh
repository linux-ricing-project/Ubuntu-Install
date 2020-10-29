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

    local hack_font_link="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf"
    local fira_code_link="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf"

    cd "$font_location"

    # fira code
    if ! fc-list | grep -q "Fira"; then
        wget "$fira_code_link" --directory-prefix "${font_location}"
    fi

    # hack font
    if ! fc-list | grep -q "Hack"; then
        wget "$hack_font_link" --directory-prefix "${font_location}"
    fi

    cd -

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

    # TODO: linkar aqui o 'frank.zsh-theme' para '~/.oh-my-zsh/themes'
    # [[ -f "${HOME}/.zshrc" ]] && rm -rf "${HOME}/.zshrc"
    # cp '.zshrc' "$HOME"
    # cp 'frank.zsh-theme' "${HOME}/.oh-my-zsh/themes"
    # cp '.p10k.zsh' "$HOME"

    # transformando o zsh no shell padrão
    chsh -s $(which zsh)
  fi
}

# ######################### MAIN #########################
install_colorls
install_fonts
install_shell
