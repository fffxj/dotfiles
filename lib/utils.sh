#!/bin/bash

# Colorized echo helpers
#
# https://github.com/atomantic/dotfiles/blob/master/lib_sh/echos.sh

ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

bot() {
    echo -e "\n$COL_GREEN\[._.]/$COL_RESET - "$1
}

bot2 () {
    echo -e "$COL_GREEN"
    echo -e "+--        --+"
    echo -e "|            |"
    echo -e "+_ ✖ ___ ✔ __+"
    echo -e "\n - $1"
    echo -e "$COL_RESET"
}

ok() {
    echo -e "$COL_GREEN[ok]$COL_RESET "$1
}

ok2() {
    echo -e "$COL_GREEN[✔]$COL_RESET "$1
}

error() {
    echo -e "$COL_RED[error]$COL_RESET "$1
}

error2() {
    echo -e "$COL_RED[✖]$COL_RESET "$1
}

warning() {
    echo -e "$COL_YELLOW[warning]$COL_RESET "$1
}

warning2() {
    echo -e "$COL_YELLOW[!]$COL_RESET "$1
}

running() {
    echo -en "$COL_YELLOW ⇒ $COL_RESET"$1" "
}

action() {
    echo -e "\n$COL_YELLOW[action]:$COL_RESET\n ⇒ $1..."
}

#
# Utils functions
#

# Ask for the administrator password upfront just one time
ask_for_sudo() {
    # Ask for the administrator password upfront
    sudo -v

    # Update existing `sudo` time stamp until this script has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

################################################################################

# # Ask whether confirm or not
# ask_for_confirmation() {
#     printf "\n"
#     warning2 "$1"
#     read -p "Continue? (y/n) " -n 1
#     printf "\n"
# }

# # Test whether the result of an 'ask' is a confirmation
# answer_is_confirmed() {
#     if [[ "$REPLY" =~ ^[Yy]$ ]]; then
#       return 0
#     fi
#     return 1
# }

# # Test whether we're in a git repo
# is_git_repo() {
#     $(git rev-parse --is-inside-work-tree &> /dev/null)
# }

# # Test whether a command exists
# # $1 - cmd to test
# type_exists() {
#     if [ $(type -P $1) ]; then
#       return 0
#     fi
#     return 1
# }
