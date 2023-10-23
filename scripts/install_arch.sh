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
    xorg-{xmodmap,xev,setxkbmap,xset} tmux neofetch wget xclip ripgrep fd sd up \
    docker lazygit tree-sitter shfmt shellcheck luarocks autopep8 python-{neovim,pipx} \
    ttf-sourcecodepro-nerd
}

function install_asdf {
  echo "Installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
}

function install_languages {
  echo "Installing rust..."
  if ! exists cargo; then
    sudo pacman -S --noconfirm rustup
    rustup default nightly
    cargo install languagetool-rust --features full
  fi

  echo "Installing node..."
  if ! exists node; then
    asdf plugin add nodejs
    asdf install nodejs latest:18
    asdf global nodejs latest:18
  fi
  if ! exists pnpm; then
    npm i -g pnpm
  fi

  echo "Installing ruby..."
  if ! exists ruby; then
    asdf plugin add ruby
    asdf install ruby latest
    asdf global ruby latest
  fi

  echo "Installing elixir..."
  if ! exists elixir; then
    sudo pacman -S --noconfirm elixir
  fi

  echo "Installing julia..."
  if ! exists julia; then
    yay -S --noconfirm julia-bin
  fi

  echo "Installing perl..."
  if ! exists perl; then
    sudo pacman -S --noconfirm perl
  fi

  echo "Installing python..."
  if ! exists pip; then
    sudo pacman -S --noconfirm python python-pip
  fi

  echo "Installing go..."
  if ! exists go; then
    sudo pacman -S --noconfirm go
  fi

  echo "Installing dotnet..."
  if ! exists dotnet; then
    yay -S --noconfirm dotnet-sdk-bin
  fi

  echo "Installing java..."
  if ! exists java; then
    asdf plugin add java
    asdf install java openjdk-11
    asdf global java openjdk-11
  fi
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
  install_asdf
  install_languages
  install_packages
  install_neovim
  install_zsh_plugins
  install_tmux_plugins

  cleanup

  cd "$pwd" || return
}
