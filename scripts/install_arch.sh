#!/bin/bash

function install_yay {
  echo "Installing yay..."
  install_exists yay && return
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git "$HOME/yay"
  cd "$HOME/yay" || return
  makepkg -si --noconfirm
  cd "$HOME" || return
}

function install_snap {
  echo "Installing snap..."
  install_exists snap && return
  yay -S --noconfirm --answerdiff=None snapd
  sudo systemctl enable --now snapd.socket
  sudo systemctl enable --now snapd.apparmor
}

function install_sys_packages {
  echo "Installing sys packages..."
  sudo pacman -S --noconfirm \
    wezterm tmux neofetch onefetch wget xclip up ttf-sourcecodepro-nerd \
    docker docker-compose github-cli lazygit direnv python-distutils-extra thefuck \
    tree-sitter shfmt shellcheck luarocks luacheck
}

function install_languages {
  echo "Installing rust..."
  if ! install_exists cargo; then
    sudo pacman -S --noconfirm rustup
    rustup default nightly
    cargo install languagetool-rust --features full
  fi

  echo "Installing node..."
  if ! install_exists node; then
    asdf plugin add nodejs
    asdf install nodejs latest:20
    asdf global nodejs latest:20
  fi
  if ! install_exists pnpm; then
    npm i -g pnpm
  fi

  echo "Installing ruby..."
  if ! install_exists ruby; then
    asdf plugin add ruby
    asdf install ruby latest
    asdf global ruby latest
  fi

  echo "Installing elixir..."
  if ! install_exists elixir; then
    sudo pacman -S --noconfirm elixir
  fi

  echo "Installing julia..."
  if ! install_exists julia; then
    yay -S --noconfirm julia-bin
  fi

  echo "Installing perl..."
  if ! install_exists perl; then
    sudo pacman -S --noconfirm perl
  fi

  echo "Installing python..."
  if ! install_exists rye; then
    curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
  fi

  echo "Installing go..."
  if ! install_exists go; then
    sudo pacman -S --noconfirm go
  fi

  echo "Installing dotnet..."
  if ! install_exists dotnet; then
    yay -S --noconfirm dotnet-sdk-bin
  fi

  echo "Installing java..."
  if ! install_exists java; then
    asdf plugin add java
    asdf install java openjdk-17
    asdf global java openjdk-17
  fi
}

function install_neovim {
  echo "Installing neovim..."
  sudo pacman -S --noconfirm neovim
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
