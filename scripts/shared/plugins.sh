#!/bin/sh

install_zsh_plugins () {
  zsh_autosuggestions="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  zsh_syntax_highlighting="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  powerlevel10k="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

  if ! dir_exists $zsh_autosuggestions "zsh plugin: zsh-autosuggestions"; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $zsh_autosuggestions
  fi
  if ! dir_exists $zsh_syntax_highlighting "zsh plugin: zsh-syntax-highlighting"; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $zsh_syntax_highlighting
  fi
  if ! dir_exists $powerlevel10k "oh-my-zsh theme: powerlevel10k"; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $powerlevel10k
  fi
}

install_tmux_plugins () {
  tpm="~/.tmux/plugins/tpm"
  tmux_power="~/.tmux/plugins/tmux-power"

  if ! dir_exists $tpm "tmux plugin: tpm"; then
    git clone https://github.com/tmux-plugins/tpm $tpm
  fi
  if ! dir_exists $tmux_power "tmux plugin: tmux-power"; then
    git clone https://github.com/drewxs/tmux-power $tmux_power
  fi
}
