#!/bin/sh

remove_existing_configurations () {
  sudo rm -rf ~/.gitconfig ~/.tmux.conf ~/.zshrc ~/.p10k.zsh ~/.config/nvim ~/.config/alacritty/alacritty.yml
}

create_symlinks () {
  mkdir -p ~/.config ~/.config/alacritty
  ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
  ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
  ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
  ln -s ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
  ln -s ~/.dotfiles/nvim ~/.config/nvim
  ln -s ~/.dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
}

setup_neovim () {
  sudo rm -rf ~/.cache/nvim ~/.config/nvim/plugin ~/.local/share/nvim
  nvim --headless -c 'PackerSync'
}

cleanup () {
  remove_existing_configurations
  create_symlinks
  setup_neovim
}
