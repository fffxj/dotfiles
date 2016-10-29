#!/bin/bash

# Install GUI tools via Homebrew Cask

source ./lib/utils.sh

cask_formula_list=(
    'iterm2'
    'alfred'
    #'dropbox'
    '1password'

    'keycastr'
    'licecap'
)

check_cask() {
    output=$(brew tap | grep cask)
    if [[ $? != 0 ]]; then
        #action "installing brew-cask"
        require_brew caskroom/cask/brew-cask
    fi
    brew tap caskroom/versions > /dev/null 2>&1
    ok
}

brew_cask_install() {
    running "brew cask $1"
    brew cask list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew cask install $1"
        brew cask install --appdir="~/Applications" $1
        if [[ $? != 0 ]]; then
            error "failed to install $1!"
            # exit -1
        fi
    fi
    ok
}

bot "checking brew-cask install"

check_cask

bot "install GUI tools via homebrew"

for formula in ${cask_formula_list[@]}; do
    brew_cask_install $formula
done
