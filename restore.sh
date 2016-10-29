#!/usr/bin/env bash

source ./lib/utils.sh

if [[ -z $1 ]]; then
  error "you need to specify a backup folder date. Take a look in ~/.dotfiles_backup/ to see which backup date you wish to restore."
  exit 1
fi

if [[ ! `(find ~/.dotfiles_backup/ -depth 1) | grep $1` ]]; then
    error "there is no such a directory in ~/.dotfiles_backup."
    exit 1
fi

bot "Do you wish to change your shell back to bash?"
read -r -p "[Y|n] " response

if [[ $response =~ ^(no|n|N) ]];then
    bot "ok, leaving shell as zsh..."
else
    bot "ok, changing shell to bash..."
    chsh -s $(which bash);ok
fi

bot "Restoring dotfiles from backup..."

pushd ~/.dotfiles_backup/$1

for file in .*; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi

  running "restored ~/$file"
  if [[ -e ~/$file ]]; then
      unlink $file;
  fi

  if [[ -e ./$file ]]; then
      mv ./$file ./
  fi
  ok
done

popd

bot "Woot! All done."
