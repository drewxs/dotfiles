#!/bin/sh

function package_exists() {
  if ! [[ command -v "$1" ]] &>/dev/null; then
    echo "$1 installation found"
    return false
  fi
  return true
}

function install_yay() {
  package_exists yay && return
  sudo pacman -S --needed git base-devel --noconfirm
  cd ~
  git clone https://aur.archlinux.org/yay/git
  cd yay
  makepkg -si --noconfirm
  cd ~
}

function install_snap() {
  package_exists snap && return
  yay -S snapd --answerdiff=None
  sudo systemctl enable --now snapd.socket
  sudo systemctl enable --now snapd.apparmor
}

function install_packages() {
  sudo pacman -S --noconfirm tmux neofetch wget xclip ripgrep \
    xorg-xmodmap xorg-xev xorg-setxkbmap xorg-xset \
    rustup nodejs npm python python-pip ruby go \
    neovim lazygit docker
  rustup default nightly
  cargo install tree-sitter-cli stylua
  cargo install languagetool-rust --features full
  npm i -g pnpm 
  pnpm i -g neovim eslint_d typescript typescript-language-server @fsouza/prettierd
  gem install neovim
  pip install --user neovim black
}

function install_zsh_plugins() {
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

function install_tmux_plugins() {
  if ! [[ -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

function remove_existing_configurations() {
  sudo rm -rf ~/.cache/nvim ~/.config/nvim/plugin ~/.local/share/nvim
  sudo rm -rf ~/.gitconfig ~/.tmux.conf ~/.zshrc ~/.p10k.zsh ~/.config/nvim ~/.config/alacritty/alacritty.yml
}

function create_symlinks() {
  ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
  ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
  ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
  ln -s ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
  [[ -d ~/.config ]] || mkdir ~/.config
  ln -s ~/.dotfiles/nvim ~/.config/nvim
  [[ -d ~/.config/alacritty ]] || mkdir ~/.config/alacritty
  ln -s ~/.dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
}

install_yay
install_snap
install_packages
install_zsh_plugins
install_tmux_plugins
remove_existing_configurations
create_symlinks
