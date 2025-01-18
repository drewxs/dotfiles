#!/bin/bash

function install_exists {
  [[ -z "$1" ]] && echo "Usage: install_exists <command>" && return
  if command -v "$1" &>/dev/null; then
    echo "$1 installation found"
    return 0
  fi
  echo "$1 installation not found"
  return 1
}

echo "Installing dotfiles..."
pwd=$(pwd)

$HOME/.dotfiles/scripts/install_shared.sh

if ! install_exists yay; then
  echo "Installing yay..."
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git "$HOME/yay"
  cd "$HOME/yay" || return
  makepkg -si --noconfirm
  cd "$HOME" || return
fi

echo "Installing system packages..."
sudo pacman -S --noconfirm \
  pacman-contrib wezterm tmux neofetch onefetch fzf wget xclip up ttf-sourcecodepro-nerd \
  docker docker-compose docker-buildx github-cli lazygit thefuck python-distutils-extra \
  tree-sitter shfmt shellcheck direnv luarocks luacheck sqlfluff uv \
  discord
yay -S --noconfirm google-chrome visual-studio-code-bin slack-desktop \
  lazydocker gitmux fpp google-java-format

if ! install_exists docker; then
  echo "Installing docker..."
  sudo pacman -S --noconfirm docker docker-compose docker-buildx
  systemctl enable docker.socket
fi

if ! install_exists cargo; then
  echo "Installing rust..."
  sudo pacman -S --noconfirm rustup
  rustup default nightly
  cargo install languagetool-rust --features full
fi

if ! install_exists node; then
  echo "Installing node..."
  asdf plugin add nodejs
  asdf install nodejs latest:20
  asdf global nodejs latest:20
fi

if ! install_exists ruby; then
  echo "Installing ruby..."
  asdf plugin add ruby
  asdf install ruby latest
  asdf global ruby latest
fi

if ! install_exists elixir; then
  echo "Installing elixir..."
  sudo pacman -S --noconfirm elixir
fi

if ! install_exists go; then
  echo "Installing go..."
  sudo pacman -S --noconfirm go
fi

if ! install_exists dotnet; then
  echo "Installing dotnet..."
  yay -S --noconfirm dotnet-sdk-bin
fi

if ! install_exists java; then
  echo "Installing java..."
  asdf plugin add java
  asdf install java openjdk-17
  asdf global java openjdk-17
fi

echo "Installing neovim..."
sudo pacman -S --noconfirm neovim

echo "Installing github extensions..."
gh extension install github/gh-copilot
gh extension install dlvhdr/gh-dash

$HOME/.dotfiles/scripts/install_cleanup.sh

cd "$pwd" || exit
