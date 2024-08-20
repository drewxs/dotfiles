#!/bin/bash

function remove_existing_configurations {
  echo "Removing existing configurations..."
  sudo rm -rf "$HOME/.gitconfig" "$HOME/.tmux.conf" "$HOME/.config/alacritty/alacritty.toml" \
    "$HOME/.cache/nvim" "$HOME/.config/nvim" "$HOME/.local/share/nvim"
}

function create_symlinks {
  echo "Creating symlinks..."
  mkdir -p "$HOME/.config" "$HOME/.config/wezterm"
  ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
  ln -s "$HOME/.dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
  ln -s "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
  ln -s "$HOME/.dotfiles/term/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
  if [[ -d ~/.config/zed ]]; then
    ln -s "$HOME/.dotfiles/zed/keymap.json" ~/.config/zed/keymap.json
    ln -s "$HOME/.dotfiles/zed/settings.json" ~/.config/zed/settings.json
  fi
}

function cleanup {
  [[ "${update_only:=false}" == true ]] && return

  echo "Cleaning up..."
  remove_existing_configurations
  create_symlinks

  unset update_only
}
