#!/bin/bash

function install_yay {
  echo "Installing yay..."
  exists yay && return
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git "$HOME/yay"
  cd "$HOME/yay" || return
  makepkg -si --noconfirm
  cd "$HOME" || return
}

function install_snap {
  echo "Installing snap..."
  exists snap && return
  yay -S --noconfirm --answerdiff=None snapd
  sudo systemctl enable --now snapd.socket
  sudo systemctl enable --now snapd.apparmor
}

function install_sys_packages {
  echo "Installing sys packages..."
  sudo pacman -S --noconfirm \
    tmux neofetch wget xclip ripgrep ncspot \
    xorg-{xmodmap,xev,setxkbmap,xset} \
    docker lazygit tree-sitter shfmt shellcheck \
    luarocks autopep8 python-{neovim,pipx} \
    ttf-sourcecodepro-nerd
  yay -S --noconfirm \
    asdf-vm
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

  echo "Installing elixir..."
  sudo pacman -S --noconfirm elixir

  echo "Installing julia..."
  yay -S --noconfirm julia-bin

  echo "Installing perl..."
  sudo pacman -S --noconfirm perl

  echo "Installing python..."
  sudo pacman -S --noconfirm python python-pip

  echo "Installing go..."
  sudo pacman -S --noconfirm go

  echo "Installing dotnet..."
  yay -S --noconfirm dotnet-sdk-bin

  echo "Installing java..."
  asdf plugin add java
  asdf install java openjdk-11
  asdf global java openjdk-11
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
  install_sys_packages
  install_languages
  install_packages
  install_neovim
  install_zsh_plugins
  install_tmux_plugins

  cleanup

  cd "$pwd" || return
}
