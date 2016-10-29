#!/bin/bash

source ./lib/utils.sh 

check_zsh() {
    # set zsh as the user login shell
    CURRENTSHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
    if [[ "$CURRENTSHELL" != "/usr/local/bin/zsh" ]]; then
        bot "setting newer homebrew zsh (/usr/local/bin/zsh) as your shell (password required)"
        # sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
        # chsh -s /usr/local/bin/zsh
        sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh > /dev/null 2>&1
        ok
    else
        ok "looks like you are already using zsh. Woot!"
    fi
}

bot "checking default shell"

check_zsh
