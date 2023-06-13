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
    tmux neofetch wget xclip ripgrep ncspot \
    xorg-xmodmap xorg-xev xorg-setxkbmap xorg-xset \
    docker lazygit tree-sitter stylua shfmt shellcheck
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

  echo "Installing python..."
  sudo pacman -S --noconfirm python python-pip

  echo "Installing go..."
  sudo pacman -S --noconfirm go

  echo "Installing dotnet..."
  sudo yay -S --noconfirm dotnet-sdk-bin

  echo "Installing java..."
  sudo pacman -S --noconfirm jdk-openjdk
}

function install_neovim {
  echo "Installing neovim..."
  sudo pacman -S --noconfirm neovim
  yay -S --noconfirm nvim-packer-git
}

function install_fonts {
  echo "Installing fonts..."
  if [[ $(find /usr/share/fonts/TTF/SauceCodeProNerdFontMono-{Medium,Bold,Italic,BoldItalic}.ttf 2>/dev/null | wc -l) -gt 3 ]]; then
    echo "Font installations found"
    return
  fi
  curl -LOJ "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/SourceCodePro.zip"
  sudo unzip -nj "SourceCodePro.zip" SauceCodeProNerdFontMono-{Medium,Bold,Italic,BoldItalic}.ttf -d "/usr/share/fonts/TTF"
  rm -rf "SourceCodePro.zip"
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
  install_fonts

  cleanup

  cd "$pwd" || return
}
