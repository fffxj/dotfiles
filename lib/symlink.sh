#!/bin/bash

# Symlink dotfiles ~/.* from ~ to ~/.dotfiles

source ./lib/utils.sh

symlink_topic_dirs=(
    'bash'
    'shell'
    'zsh'
    'git'
)

symlink_target_dirs=(
    'bin'
    'init'
)

symlink_dotfiles() {
    now=$(date +"%Y.%m.%d.%H.%M.%S")
    
    for dir in ${symlink_topic_dirs[@]}; do
        pushd $dir > /dev/null 2>&1

        for file in .*; do
            if [[ $file == "." || $file == ".." ]]; then
                continue
            fi
            running "linked ~/$file"
            # if the file exists:
            if [[ -e ~/$file ]]; then
                mkdir -p ~/.dotfiles_backup/$now
                mv ~/$file ~/.dotfiles_backup/$now/$file
            fi
            # symlink might still exist
            unlink ~/$file > /dev/null 2>&1
            # create the link
            ln -s ~/.dotfiles/$dir/$file ~/$file
            ok
        done

        popd > /dev/null 2>&1
    done

    ok "original dotfiles already backed up in ~/.dotfiles_backup/$now/"
}

bot "creating symlinks for project dotfiles"

symlink_dotfiles
