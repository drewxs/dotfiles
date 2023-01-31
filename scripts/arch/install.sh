#!/bin/sh

pwd=$(pwd)

install_yay () {
  package_exists yay && return
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git $HOME/yay
  cd $HOME/yay
  makepkg -si --noconfirm
  cd $HOME
}

install_snap () {
  package_exists snap && return
  yay -S snapd --answerdiff=None
  sudo systemctl enable --now snapd.socket
  sudo systemctl enable --now snapd.apparmor
}

install_packages () {
  sudo pacman -S --noconfirm tmux neofetch wget xclip ripgrep \
    xorg-xmodmap xorg-xev xorg-setxkbmap xorg-xset \
    rustup python python-pip go dotnet-sdk \
    neovim lazygit docker
  yay -S --noconfirm nvm ruby-build rbenv nvim-packer-git

  rustup default stable
  cargo install tree-sitter-cli stylua
  cargo install languagetool-rust --features full

  nvm install 18
  nvm alias default 18
  if ! package_exists pnpm; then
    npm i -g pnpm
  fi
  pnpm i -g pnpm neovim eslint_d typescript typescript-language-server @fsouza/prettierd

  ruby_latest_version=$(rbenv install -l | grep -v - | tail -1)
  rbenv install $ruby_latest_version
  rbenv global $ruby_latest_version
  gem install neovim rails

  pip install --user neovim black
}

install_yay
install_snap
install_zsh_plugins
install_tmux_plugins
install_packages

if [[ $update_only == false ]]; then
  cleanup
fi

cd $pwd
