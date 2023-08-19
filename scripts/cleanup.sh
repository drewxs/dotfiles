#!/bin/bash

function remove_existing_configurations {
  echo "Removing existing configurations..."
  sudo rm -rf "$HOME/.gitconfig" "$HOME/.tmux.conf" "$HOME/.config/alacritty/alacritty.yml" \
    "$HOME/.cache/nvim" "$HOME/.config/nvim" "$HOME/.local/share/nvim"
}

function create_symlinks {
  echo "Creating symlinks..."
  mkdir -p "$HOME/.config" "$HOME/.config/alacritty"
  ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
  ln -s "$HOME/.dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
  ln -s "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
  ln -s "$HOME/.dotfiles/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
}

function setup_neovim {
  echo "Setting up neovim..."
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

function cleanup {
  [[ "${update_only:=false}" == true ]] && return

  echo "Cleaning up..."
  remove_existing_configurations
  create_symlinks
  setup_neovim

  unset update_only
}
