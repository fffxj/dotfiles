#!/bin/bash

# Steps to do:
#   1. install package manager (homebrew & brew cask)
#   2. install CLI & GUI tools
#   3. set zsh as default shell
#   4. setup personal git & github config
#   5. install dotfiles by symlink .* from ~ to ~/.dotfiles
#   6. setup sensible macOS defaults

# Reference:
#   sweet \[._.]/ bot install script
#   https://github.com/atomantic/dotfiles/blob/master/install.sh
#
#   nice gitconfig setup automatic set script
#   https://github.com/holman/dotfiles/blob/master/script/bootstrap


source ./lib/utils.sh

bot "Hi! I'm going to install tooling and tweak your system settings. Here I go..."

bot "I need you to enter your sudo password so I can install some things:"
ask_for_sudo

#--------------------------------------------------------------------------------
# install CLI & GUI tools
#--------------------------------------------------------------------------------

bot2 "install CLI & GUI tools"

source ./lib/brew.sh

source ./lib/cask.sh

bot "Alright, cleaning up homebrew cache"
brew cleanup > /dev/null 2>&1
ok

#--------------------------------------------------------------------------------
# custom shell & git
#--------------------------------------------------------------------------------

bot2 "zsh & git"

source ./lib/zsh.sh

source ./lib/custom.sh

#--------------------------------------------------------------------------------
# symlink dotfiles
#--------------------------------------------------------------------------------

bot2 "dotfiles symlink"

source ./lib/symlink.sh

#--------------------------------------------------------------------------------
# macs defaults
#--------------------------------------------------------------------------------

bot2 "macOS defaults"

#source ./lib/osx.sh

bot "Woot! All done."
