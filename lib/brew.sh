#!/bin/bash

# Install CLI formula via Homebrew

source ./lib/utils.sh

brew_formula_list=(
    # foundational tools .dotfiles/ rely on
    #'git'
    'ruby'
    'nvm'
    'zsh'

    # other tools
    'coreutils' # GNU core utilities (those that come with OS X are outdated)
    'git'
    #'ack'
    'bash'
    'bash-completion'
    #'ffmpeg'
    #'graphicsmagick'
    #'jpeg'
    #'macvim --override-system-vim'
    'node'
    #'optipng'
    #'phantomjs'
    'tree'
    'wget'
)

check_brew() {
    brew_bin=$(which brew) 2>&1 > /dev/null
    if [[ $? != 0 ]]; then
        action "installing homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        if [[ $? != 0 ]]; then
            error "unable to install homebrew, script $0 abort!"
            exit 2
        fi
    else
        ok
        # Make sure we’re using the latest Homebrew
        bot "updating homebrew"
        brew update
        ok
        bot "before installing brew packages, we can upgrade any outdated packages."
        read -r -p "run brew upgrade? [y|N] " response
        if [[ $response =~ ^(y|yes|Y) ]];then
            # Upgrade any already-installed formulae
            #action "upgrade brew packages"
            brew upgrade
            ok "brews updated"
        else
            ok "skipped brew package upgrades";
        fi
    fi
}

brew_install() {
    running "brew $1"
    brew list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        gapplication "brew install $1"
        brew install $1
        if [[ $? != 0 ]]; then
            error "failed to install $1!"
            # exit -1
        fi
    fi
    ok
}

bot "checking homebrew install and update"

check_brew

bot "install CLI tools via homebrew"

for formula in ${brew_formula_list[@]};
do
    brew_install ${formula}
done
