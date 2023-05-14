#!/bin/bash

function install_sys_packages {
  echo "Installing sys packages..."
  sudo apt-get install -y curl wget tmux git ripgrep fuse libfuse2 fd-find neofetch \
    ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen \
    software-properties-common build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
    bison build-essential libssl-dev libyaml-dev libreadline6-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev \
    shellcheck
}

function install_cmake {
  echo "Installing cmake..."
  exists cmake && return
  cd "$HOME" || return
  wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2.tar.gz
  sudo tar -xf cmake-3.24.2.tar.gz
  cd cmake-3.24.2 || return
  ./bootstrap
  make
  cd "$HOME" || return
  sudo rm -rf cmake-3*
}

function install_lazygit {
  echo "Installing lazygit..."
  exists lazygit && return
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  sudo tar -xf lazygit.tar.gz -C /usr/local/bin lazygit
  sudo rm -rf lazygit.tar.gz
}

function install_rust {
  echo "Installing rust..."
  if ! exists rustc && exists cargo; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    1
  fi
  cargo install languagetool-rust --features full
}

function install_node {
  echo "Installing node..."
  if ! exists nvm && exists node; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm install 18
    nvm alias default 18
  fi
  if ! exists pnpm; then
    npm i -g pnpm
  fi
}

function install_ruby {
  echo "Installing ruby..."
  if ! exists rbenv; then
    sudo apt-get install -y rbenv
  fi
  ruby_latest_version=$(rbenv install -l | grep -v - | tail -1)
  rbenv install "$ruby_latest_version"
  rbenv global "$ruby_latest_version"
}

function install_python {
  echo "Installing python..."
  exists pip3 && return
  sudo apt-get install -y python3-pip
}

function install_go {
  echo "Installing go..."
  exists go && return
  sudo rm -rf go1.19.2.linux-amd64*
  wget -c https://golang.org/dl/go1.19.2.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.2.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin
  sudo rm -rf go1.19.2.linux-amd64*
}

function install_dotnet {
  echo "Installing dotnet..."
  wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  rm packages-microsoft-prod.deb
  sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0
}

function install_neovim {
  echo "Installing neovim..."
  exists nvim && return
  sudo rm -rf neovim
  git clone https://github.com/neovim/neovim "$HOME/neovim"
  cd "$HOME"/neovim || return
  git checkout stable
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd "$HOME" || return
  sudo rm -rf neovim
  packer_loc="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
  if dir_exists "$packer_loc" "packer"; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_loc"
  fi
}

function install_dotfiles {
  echo "Installing dotfiles..."
  pwd=$(pwd)

  install_sys_packages
  install_cmake
  install_lazygit
  install_rust
  install_node
  install_ruby
  install_python
  install_go
  install_dotnet
  install_packages
  install_neovim
  install_zsh_plugins
  install_tmux_plugins
  install_fonts

  cleanup

  cd "$pwd" || exit
}
