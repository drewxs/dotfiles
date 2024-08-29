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

echo "Installing sys packages..."
sudo apt-get install -y curl wget tmux git unzip fuse libfuse2 neofetch g++ \
  ninja-build gettext libtool libtool-bin autoconf automake cmake pkg-config shellcheck \
  software-properties-common build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
  bison build-essential libssl-dev libyaml-dev libreadline6-dev libffi-dev libgdbm6 libdb-dev

echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
rm -rf ~/.fzf

if ! install_exists lazygit; then
  echo "Installing lazygit..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  sudo tar -xf lazygit.tar.gz -C /usr/local/bin lazygit
  sudo rm -rf lazygit.tar.gz
fi

if ! install_exists rustc && install_exists cargo; then
  echo "Installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  1
fi
cargo install languagetool-rust --features full

if ! install_exists erlang; then
  echo "Installing erlang..."
  asdf plugin add erlang
  asdf install erlang latest
  asdf global erlang latest
fi

if ! install_exists elixir; then
  echo "Installing elixir..."
  asdf plugin add elixir
  asdf install elixir latest
  asdf global elixir latest
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

if ! install_exists rye; then
  echo "Installing python..."
  curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
fi

if ! install_exists go; then
  echo "Installing go..."
  asdf plugin add golang
  asdf install golang latest
  asdf global golang latest
fi

if ! install_exists dotnet; then
  echo "Installing dotnet..."
  sudo apt-get install -y dotnet-sdk-8.0
fi

if ! install_exists nvim; then
  echo "Installing neovim..."
  sudo rm -rf neovim
  git clone https://github.com/neovim/neovim "$HOME/neovim"
  cd "$HOME"/neovim || return
  git checkout stable
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd "$HOME" || return
  sudo rm -rf neovim
fi

$HOME/.dotfiles/scripts/install_cleanup.sh

cd "$pwd" || exit
