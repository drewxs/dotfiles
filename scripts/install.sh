#!/bin/sh

function install_apt_packages() {
  sudo apt-get install -y zsh ripgrep fuse libfuse2 ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
}

function install_cmake() {
  cd ~
  wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2.tar.gz
  tar -xf cmake-3.24.2.tar.gz
  cd cmake-3.24.2
  ./bootstrap
  make
  cd ~
  rm -rf cmake-3.24.2 cmake-3.24.2.tar.gz
}

function install_packer() {
  git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

function install_lazygit() {
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar -xf lazygit.tar.gz -C /usr/local/bin lazygit
}

function install_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function install_node() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  nvm install 16
}

function install_npm_packages() {
  npm i -g pnpm @fsouza/prettierd eslint_d typescript-language-server
}

function install_neovim() {
  git clone https://github.com/neovim/neovim
  cd neovim
  git checkout stable
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd ~
  rm -rf neovim
}

install_apt_packages
install_cmake
install_packer
install_lazygit
install_rust
install_node
install_npm_packages
install_neovim

# remove existing configurations
rm -rf .gitconfig .tmux.conf .zshrc .p10k.zsh .config/nvim

# create symlinks 
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
ln -s ~/.dotfiles/nvim ~/.config/nvim
