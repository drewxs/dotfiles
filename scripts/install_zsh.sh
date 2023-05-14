#!/bin/bash

echo "Installing zsh..."
if ! exists zsh; then
  if exists apt-get; then
    sudo apt update && sudo apt upgrade -y
    sudo apt install zsh
  elif exists pacman; then
    sudo pacman -Syu --noconfirm
    sudo pacman -S zsh
  fi
  sudo rm -rf "$HOME/.zshrc" "$HOME/.p10k.zsh"
  ln -s "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
  ln -s "$HOME/.dotfiles/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
fi

echo "Installing oh-my-zsh..."
if ! exists omz; then
  sudo rm -rf .oh-my-zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
