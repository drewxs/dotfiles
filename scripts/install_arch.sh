#!/bin/bash

function install_yay {
  exists yay && return
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git "$HOME/yay"
  cd "$HOME/yay" || return
  makepkg -si --noconfirm
  cd "$HOME" || return
}

function install_snap {
  exists snap && return
  yay -S snapd --answerdiff=None
  sudo systemctl enable --now snapd.socket
  sudo systemctl enable --now snapd.apparmor
}

function install_packages {
  sudo pacman -S --noconfirm \
    tmux neofetch wget xclip ripgrep exa bat ncspot \
    xorg-xmodmap xorg-xev xorg-setxkbmap xorg-xset \
    rustup python python-pip go dotnet-sdk \
    docker lazygit neovim tree-sitter stylua shfmt
  yay -S --noconfirm nvm ruby-build rbenv nvim-packer-git

  rustup default nightly
  cargo install languagetool-rust --features full

  nvm install --lts
  nvm alias default node
  if ! exists pnpm; then
    npm i -g pnpm
  fi
  pnpm i -g pnpm neovim eslint_d typescript typescript-language-server @fsouza/prettierd @bufbuild/buf

  ruby_latest_version=$(rbenv install -l | grep -v - | tail -1)
  rbenv install "$ruby_latest_version"
  rbenv global "$ruby_latest_version"
  gem install neovim rails

  pip install --user neovim autopep8
}

function install_dotfiles {
  pwd=$(pwd)

  install_yay
  install_snap
  install_zsh_plugins
  install_tmux_plugins
  install_packages

  cleanup

  cd "$pwd" || return
}
