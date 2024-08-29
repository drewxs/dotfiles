#!/bin/bash

echo "Installing zsh..."
if [[ -x "$(command -v zsh)" ]]; then
  echo "zsh installation found..."
else
  if [[ -x "$(command -v apt)" ]]; then
    sudo apt update && sudo apt upgrade -y
    sudo apt install zsh
  elif [[ -x "$(command -v pacman)" ]]; then
    sudo pacman -Syu --noconfirm
    sudo pacman -S zsh
  fi
  sudo rm -rf "$HOME/.zshrc" "$HOME/.p10k.zsh"
  ln -s "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
  ln -s "$HOME/.dotfiles/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
fi

echo "Installing oh-my-zsh..."
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  echo "oh-my-zsh installation found..."
else
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
