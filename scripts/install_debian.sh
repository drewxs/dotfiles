#!/bin/bash

function install_apt_packages {
  sudo apt-get install -y curl wget tmux git ripgrep fuse libfuse2 fd-find neofetch \
    ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen \
    software-properties-common build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
    bison build-essential libssl-dev libyaml-dev libreadline6-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
}

function install_cmake {
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
  exists lazygit && return
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  sudo tar -xf lazygit.tar.gz -C /usr/local/bin lazygit
  sudo rm -rf lazygit.tar.gz
}

function install_rust {
  if ! exists rustc && exists cargo; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    1
  fi
}

function install_node {
  if ! exists nvm && exists node; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm install 18
    nvm alias default 18
  fi
}

function install_ruby {
  if ! exists rbenv; then
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
    echo "export PATH='$HOME/.rbenv/bin:$PATH'" >>"$HOME/.zshrc"
    echo "eval '$(rbenv init -)'" >>"$HOME/.zshrc"
    source "$HOME/.zshrc"
  fi
  rbenv install 3.1.0
  rbenv global 3.1.0
}

function install_go {
  exists go && return
  sudo rm -rf go1.19.2.linux-amd64*
  wget -c https://golang.org/dl/go1.19.2.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.2.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin
  sudo rm -rf go1.19.2.linux-amd64*
}

function install_pip {
  if ! exists pip3; then
    sudo apt-get install -y python3-pip
  fi
}

function install_dotnet {
  wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  rm packages-microsoft-prod.deb
  sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0
}

function install_packages {
  cargo install languagetool-rust --features full
  cargo install cargo-info tree-sitter-cli stylua exa bat
  if ! exists pnpm; then
    npm i -g pnpm
  fi
  pnpm i -g pnpm neovim eslint_d typescript typescript-language-server @fsouza/prettierd @bufbuild/buf
  sudo gem install neovim shopify-cli
  pip3 install neovim
}

function install_neovim {
  exists nvim && return
  sudo rm -rf neovim
  git clone https://github.com/neovim/neovim "$HOME/neovim"
  cd "$HOME"/neovim || return
  git checkout stable
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd "$HOME" || return
  sudo rm -rf neovim
}

function install_packer {
  packer_loc="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
  if dir_exists "$packer_loc" "packer"; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer_loc"
  fi
}

function install_dotfiles {
  pwd=$(pwd)

  install_apt_packages
  install_zsh_plugins
  install_tmux_plugins
  install_cmake
  install_lazygit
  install_rust
  install_node
  install_rust
  install_ruby
  install_go
  install_pip
  install_dotnet
  install_packages
  install_neovim
  install_packer

  cleanup

  cd "$pwd" || exit
}
