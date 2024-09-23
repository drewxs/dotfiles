#!/bin/bash

function dir_exists {
  [[ -z "$1" ]] && echo "Usage: dir_exists <dir> <identifier>" && return
  if [[ -d $1 ]] && [[ -n $1 ]]; then
    echo "$2 found"
    return 0
  fi
  return 1
}

echo "Installing zsh plugins..."
zsh_autosuggestions="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
zsh_syntax_highlighting="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
powerlevel10k="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if ! dir_exists "$zsh_autosuggestions" "zsh plugin: zsh-autosuggestions"; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$zsh_autosuggestions"
fi
if ! dir_exists "$zsh_syntax_highlighting" "zsh plugin: zsh-syntax-highlighting"; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_syntax_highlighting"
fi
if ! dir_exists "$powerlevel10k" "oh-my-zsh theme: powerlevel10k"; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$powerlevel10k"
fi

echo "Installing tmux plugins..."
tpm="$HOME/.tmux/plugins/tpm"
tmux_power="$HOME/.tmux/plugins/tmux-power"
if ! dir_exists "$tpm" "tmux plugin: tpm"; then
  git clone https://github.com/tmux-plugins/tpm "$tpm"
fi
if ! dir_exists "$tmux_power" "tmux plugin: tmux-power"; then
  git clone https://github.com/drewxs/tmux-power "$tmux_power"
fi

echo "Installing packages..."
cargo install cargo-info cargo-update tree-sitter-cli stylua eza bat bottom ripgrep fd-find sd skim just jnv
npm i -g neovim typescript typescript-language-server eslint eslint_d prettier @fsouza/prettierd @bufbuild/buf sql-formatter tldr
gem install neovim rails
pip install neovim
if exists apt; then
  go install github.com/arl/gitmux@latest
fi
if ! [[ -x "$(command -v asdf)" ]]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
fi
