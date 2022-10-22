#!/bin/sh

function update() {
  sudo apt update && sudo apt upgrade
}

function install_apt_packages() {
  sudo apt-get install -y curl wget zsh tmux git ripgrep fuse libfuse2 \
    ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen \
    software-properties-common build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev
}

# install zsh
function install_zsh() {
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # zsh plugins
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

function install_cmake() {
  cd ~
  sudo rm -rf cmake-3*
  wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2.tar.gz
  tar -xf cmake-3.24.2.tar.gz
  cd cmake-3.24.2
  ./bootstrap
  make
  sudo rm -rf cmake-3*
  cd ~
}

function install_lazygit() {
  [[ -d lazygit.tar.gz ]] sudo rm -rf lazygit.tar.gz
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar -xf lazygit.tar.gz -C /usr/local/bin lazygit
  sudo rm -rf lazygit.tar.gz
}

function install_rust() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  1
  cargo install stylua
}

function install_node() {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  nvm install 16
  npm i -g neovim pnpm @fsouza/prettierd eslint_d typescript-language-server
}

function install_ruby() {
  sudo apt-get install -y ruby-full
  sudo gem install neovim
}

function install_pip() {
  sudo apt-get install -y python3-pip
  pip3 install pynvim
}

function install_neovim() {
  sudo rm -rf neovim
  git clone https://github.com/neovim/neovim ~/neovim
  cd ~/neovim
  git checkout stable
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd ~
  sudo rm -rf neovim ~/.local/share/nvim
}

function install_packer() {
  sudo rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

update
install_apt_packages
install_zsh
install_cmake
install_lazygit
install_rust
install_node
install_rust
install_pip
install_neovim
install_packer

# remove existing configurations
rm -rf .gitconfig .tmux.conf .zshrc .p10k.zsh .config/nvim

# create symlinks
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
[[ -d .config ]] || mkdir .config
ln -s ~/.dotfiles/nvim ~/.config/nvim