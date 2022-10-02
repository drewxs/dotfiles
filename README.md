# Dotfiles

My zsh/tmux/neovim configurations.

## Prerequisites

neovim

```sh
$ sudo apt install neovim
```

packer

```sh
$ git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

ripgrep

```sh
$ sudo apt install ripgrep
```

typescript-language-server

```sh
$ npm i -g typescript-language-server
```

prettierd

```sh
$ npm i -g @fsouza/prettierd
```

eslint_d

```sh
$ npm i -g eslint_d
```

Font - [Source Code Pro](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro)

## Setup

Clone repo

```sh
$ git clone https://github.com/kito0/dotfiles ~/.dotfiles
```

Create symlinks

```sh
$ ~/.dotfiles/scripts/create_symlinks.sh
```

### TODO

- Automate neovim pre-req installations
- Automate zsh setup/config
