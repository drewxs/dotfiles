# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Auto-update mode: disabled | auto | reminder
zstyle ":omz:update" mode auto

# UI
ZSH_THEME="cypher" # set by `omz`
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd" # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
unset zle_bracketed_paste

# Plugins
# Standard: $ZSH/plugins/ | Custom: $ZSH_CUSTOM/plugins/
plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  git
  docker
  vi-mode
)

# ENV
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export ARCHFLAGS="-arch x86_64"
export MIX_XDG="1"
# XDGBDS
export XDG_CACHE_HOME="$HOME/.cache";
export XDG_CONFIG_HOME="$HOME/.config";
export XDG_DATA_HOME="$HOME/.local/share";
export XDG_STATE_HOME="$HOME/.local/state";

# Sources
source "$ZSH/oh-my-zsh.sh"
source "$HOME/.dotfiles/zsh/.p10k.zsh"
for f in "$HOME/.dotfiles/sh/"*.sh; do source "$f"; done
if [[ -d "$HOME/.rye" ]]; then
  source "$HOME/.rye/env"
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if exists fzf; then
  source <(fzf --zsh)
fi

# PATH
export BIN="$HOME/bin"
export LOCAL_BIN="$HOME/.local/bin"
export PNPM_HOME="$HOME/.local/share/pnpm"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export CARGO_HOME="$HOME/.local/share/cargo"
export CARGO_BIN="$CARGO_HOME/bin"
export MIX_BIN="$HOME/.local/share/mix/escripts"
export GOPATH="$HOME/.local/share/go"
export GO_BIN="$GOPATH/bin"
export ASDF_DIR="$HOME/.asdf"
export PATH="$PATH:$BIN:$LOCAL_BIN:$PNPM_HOME:$CARGO_HOME:$CARGO_BIN:$MIX_BIN:$GOPATH:$GO_BIN"
if exists android-studio; then
  export ANDROID_HOME="$HOME/Android/Sdk"
  ANDROID_PATHS=$(eval echo "$ANDROID_HOME/{emulator,tools,tools/bin,platform-tools}" | tr ' ' ':')
  export PATH="$PATH:$ANDROID_PATHS}"
fi
if exists nvcc; then
  if [[ -d "/opt/cuda/bin" ]]; then
    export PATH="$PATH:/opt/cuda/bin"
  elif [[ -d "/usr/local/cuda/bin" ]]; then
    export PATH="$PATH:/usr/local/cuda/bin"
  fi
fi
if [[ -d "$PATH:/snap/bin" ]]; then
  export PATH="$PATH:/snap/bin"
fi
if [[ -d "$HOME/nvim-linux64/bin" ]]; then
  export PATH="$PATH:$HOME/nvim-linux64/bin"
fi

. "$HOME/.asdf/asdf.sh"
if exists direnv; then
  eval "$(direnv hook zsh)"
fi
if exists thefuck; then
  eval "$(thefuck --alias)"
fi

# compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
