#!/bin/sh

function package_exists() {
  if ! [ command -v "$1" ] &>/dev/null; then
    echo "$1 installation found"
    return false
  fi
  return true
}

function update() {
  sudo apt update && sudo apt upgrade -y
}

function install_apt_packages() {
  sudo apt-get install -y curl wget zsh tmux git ripgrep fuse libfuse2 fd-find neofetch \
    ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip doxygen \
    software-properties-common build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
    bison build-essential libssl-dev libyaml-dev libreadline6-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
}

# install zsh
function install_zsh() {
  package_exists zsh && return
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # plugins
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

function install_cmake() {
  package_exists cmake && return
  cd ~
  sudo rm -rf cmake-3*
  wget https://github.com/Kitware/CMake/releases/download/v3.24.2/cmake-3.24.2.tar.gz
  sudo tar -xf cmake-3.24.2.tar.gz
  cd cmake-3.24.2
  ./bootstrap
  make
  sudo rm -rf cmake-3*
  cd ~
}

function install_lazygit() {
  package_exists lazygit && return
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  sudo tar -xf lazygit.tar.gz -C /usr/local/bin lazygit
  sudo rm -rf lazygit.tar.gz
}

function install_rust() {
  if ! package_exists rustc && package_exists cargo; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    1
  fi
  cargo install tree-sitter-cli stylua
}

function install_node() {
  if ! package_exists nvm && package_exists node; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm install 16
  fi
  npm i -g neovim pnpm @fsouza/prettierd eslint_d typescript-language-server
}

function install_ruby() {
  if ! package_exists rbenv; then
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    source ~/.zshrc
  fi
  rbenv install 3.1.0
  rbenv global 3.1.0
  sudo gem install neovim shopify-cli
}

function install_go() {
  package_exists go && return
  sudo rm -rf go1.19.2.linux-amd64*
  wget -c https://golang.org/dl/go1.19.2.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.2.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin
  sudo rm -rf go1.19.2.linux-amd64*
}

function install_pip() {
  package_exists pip3 || sudo apt-get install -y python3-pip
  pip3 install neovim
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
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

function install_packer() {
  sudo rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
}

function remove_existing_configurations() {
  cd ~
  rm -rf ~/.cache/nvim ~/.config/nvim/plugin ~/.local/share/nvim
  rm -rf .gitconfig .tmux.conf .zshrc .p10k.zsh .config/nvim
}

function create_symlinks() {
  ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
  ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
  ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
  ln -s ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
  [[ -d .config ]] || mkdir .config
  ln -s ~/.dotfiles/nvim ~/.config/nvim
}

update
install_apt_packages
install_zsh
install_cmake
install_lazygit
install_rust
install_node
install_rust
install_ruby
install_go
install_pip
install_neovim
install_packer
remove_existing_configurations
create_symlinks
