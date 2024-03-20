#!/bin/bash

function install_sys_packages {
  echo "Installing sys packages..."
  sudo apt-get install -y curl wget tmux git unzip fuse libfuse2 neofetch g++ \
    ninja-build gettext libtool libtool-bin autoconf automake cmake pkg-config shellcheck \
    software-properties-common build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
    bison build-essential libssl-dev libyaml-dev libreadline6-dev libffi-dev libgdbm6 libdb-dev
}

function install_lazygit {
  echo "Installing lazygit..."
  install_exists lazygit && return
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  sudo tar -xf lazygit.tar.gz -C /usr/local/bin lazygit
  sudo rm -rf lazygit.tar.gz
}

function install_rust {
  echo "Installing rust..."
  if ! install_exists rustc && install_exists cargo; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    1
  fi
  cargo install languagetool-rust --features full
}

function install_elixir {
  echo "Installing erlang and elixir..."
  install_exists elixir && return
  asdf plugin add erlang
  asdf install erlang latest
  asdf global erlang latest
  asdf plugin add elixir
  asdf install elixir latest
  asdf global elixir latest
}

function install_node {
  echo "Installing node..."
  if ! install_exists node; then
    asdf plugin add nodejs
    asdf install nodejs latest:20
    asdf global nodejs latest:20
  fi
  if ! install_exists pnpm; then
    npm i -g pnpm
  fi
}

function install_ruby {
  echo "Installing ruby..."
  install_exists ruby && return
  asdf plugin add ruby
  asdf install ruby latest
  asdf global ruby latest
}

function install_python {
  echo "Installing python..."
  install_exists rye && return
  curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
}

function install_go {
  echo "Installing go..."
  install_exists go && return
  asdf plugin add golang
  asdf install golang latest
  asdf global golang latest
}

function install_dotnet {
  echo "Installing dotnet..."
  sudo apt-get install -y dotnet-sdk-8.0
}

function install_neovim {
  echo "Installing neovim..."
  install_exists nvim && return
  sudo rm -rf neovim
  git clone https://github.com/neovim/neovim "$HOME/neovim"
  cd "$HOME"/neovim || return
  git checkout stable
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd "$HOME" || return
  sudo rm -rf neovim
}

function install_dotfiles {
  echo "Installing dotfiles..."
  pwd=$(pwd)

  install_sys_packages
  install_lazygit
  install_asdf
  install_rust
  install_elixir
  install_node
  install_ruby
  install_python
  install_go
  install_dotnet
  install_packages
  install_neovim
  install_zsh_plugins
  install_tmux_plugins

  cleanup

  cd "$pwd" || exit
}
