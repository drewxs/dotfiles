#!/bin/sh

function package_exists() {
  if ! [ command -v "$1" ] &>/dev/null; then
    echo "$1 installation found"
    return false
  fi
  return true
}

function update() {
  sudo pacman -Syu --noconfirm
}

function install_yay() {
  cd ~
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay/git
  cd yay
  makepkg -si
  cd ~
}

function install_arch_packages() {
  sudo pacman -Sy neofetch rust nodejs npm python python-pip ruby go git lazygit neovim
}

# install zsh
function install_zsh() {
  package_exists zsh && return
  sudo pacman -S --noconfirm zsh
  # plugins
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

function install_nvim_packages() {
  cargo install tree-sitter-cli stylua
  npm i -g neovim pnpm @fsouza/prettierd eslint_d typescript-language-server
  sudo gem install neovim shopify-cli
  pip install neovim
}

function install_snap() {
  yay -S snapd
  sudo systemctl enable --now snapd.socket
}

update
install_yay
install_arch_packages
install_zsh
install_nvim_packages

# remove existing configurations
rm -rf .gitconfig .tmux.conf .zshrc .p10k.zsh .config/nvim

# create symlinks
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
[[ -d .config ]] || mkdir .config
ln -s ~/.dotfiles/nvim ~/.config/nvim
