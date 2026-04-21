#!/bin/bash

if [[ -x "$(command -v pacman)" ]]; then
  $HOME/.dotfiles/scripts/install_arch.sh
elif [[ -x "$(command -v apt)" ]]; then
  $HOME/.dotfiles/scripts/install_debian.sh
else
  echo "Unsupported system"
  exit 1
fi
