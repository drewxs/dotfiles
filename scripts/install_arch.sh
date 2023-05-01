#!/bin/bash

function install_yay {
  echo "Installing yay..."
  exists yay && return
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git "$HOME/yay"
  cd "$HOME/yay" || return
  makepkg -si --noconfirm
  cd "$HOME" || return
}

function install_snap {
  echo "Installing snap..."
  exists snap && return
  yay -S snapd --answerdiff=None
  sudo systemctl enable --now snapd.socket
  sudo systemctl enable --now snapd.apparmor
}

function install_sys_packages {
  echo "Installing sys packages..."
  sudo pacman -S --noconfirm \
    tmux neofetch wget xclip ripgrep exa bat ncspot \
    xorg-xmodmap xorg-xev xorg-setxkbmap xorg-xset \
    docker lazygit tree-sitter stylua shfmt
}

function install_languages {
  echo "Installing rust..."
  sudo pacman -S --noconfirm rustup
  rustup default nightly
  cargo install languagetool-rust --features full

  echo "Installing node..."
  yay -S --noconfirm nvm
  nvm install --lts
  nvm alias default node
  if ! exists pnpm; then
    npm i -g pnpm
  fi

  echo "Installing ruby..."
  yay -S --noconfirm ruby-build rbenv
  ruby_latest_version=$(rbenv install -l | grep -v - | tail -1)
  rbenv install "$ruby_latest_version"
  rbenv global "$ruby_latest_version"

  echo "Installing python..."
  sudo pacman -S --noconfirm python python-pip

  echo "Installing go..."
  sudo pacman -S --noconfirm go

  echo "Installing dotnet..."
  sudo pacman -S --noconfirm dotnet-sdk

  echo "Installing packages..."
  cargo install cargo-info cargo-update tree-sitter-cli stylua exa bat
  pnpm i -g pnpm neovim eslint_d typescript typescript-language-server @fsouza/prettierd @bufbuild/buf
  gem install neovim rails
  pip install --user neovim autopep8
}

function install_neovim {
  echo "Installing neovim..."
  sudo pacman -S --noconfirm neovim
  yay -S --noconfirm nvim-packer-git
}

function install_dotfiles {
  echo "Installing dotfiles..."
  pwd=$(pwd)

  install_yay
  install_snap
  install_zsh_plugins
  install_tmux_plugins
  install_sys_packages
  install_languages
  install_neovim

  cleanup

  cd "$pwd" || return
}
