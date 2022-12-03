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
  package_exists yay && return
  cd ~
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay/git
  cd yay
  makepkg -si
  cd ~
}

function install_packages() {
  sudo pacman -S --noconfirm git neofetch neovim xclip ripgrep wget \
    xorg-xmodmap xorg-xev xorg-setxkbmap xorg-xset \
    rust nodejs npm python python-pip ruby go
  cargo install tree-sitter-cli stylua
  npm i -g neovim pnpm @fsouza/prettierd eslint_d typescript-language-server @commitlint/cli @commitlint/config-conventional
  gem install neovim shopify-cli
  pip install neovim
}

function install_zsh_plugins() {
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  package_exists zsh && return
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_snap() {
  package_exists snap && return
  yay -S snapd
  sudo systemctl enable --now snapd.socket
  sudo systemctl enable --now snapd.apparmor
}

function remove_existing_configurations() {
  sudo rm -rf ~/.cache/nvim ~/.config/nvim/plugin ~/.local/share/nvim
  sudo rm -rf ~/.gitconfig ~/.tmux.conf ~/.zshrc ~/.p10k.zsh ~/.config/nvim ~/.config/xfce4/terminal/terminalrc ~/.config/alacritty/alacritty.yml ~/.xinitrc
}

function create_symlinks() {
  ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
  ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
  ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
  ln -s ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
  [[ -d .config ]] || mkdir .config
  ln -s ~/.dotfiles/nvim ~/.config/nvim
  ln -s ~/.dotfiles/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
  ln -s ~/.dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
}

update
install_yay
install_packages
install_zsh_plugins
install_snap
remove_existing_configurations
create_symlinks
