# Dotfiles

My zsh/tmux/neovim configurations.

## Prerequisites

neovim

```sh
sudo apt install neovim
```

zsh

```sh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

packer

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

lazygit

```sh
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
```

ripgrep

```sh
sudo apt install ripgrep
```

typescript-language-server

```sh
npm i -g typescript-language-server
```

prettierd

```sh
npm i -g @fsouza/prettierd
```

eslint_d

```sh
npm i -g eslint_d
```

Font - [Source Code Pro](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro)

## Setup

Clone repo

```sh
git clone https://github.com/kito0/dotfiles ~/.dotfiles
```

Create symlinks

```sh
~/.dotfiles/scripts/create_symlinks.sh
```

### TODO

- Automate neovim pre-req installations
- Automate zsh setup/config
