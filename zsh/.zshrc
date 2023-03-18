# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Auto-update mode: disabled | auto | reminder
zstyle ":omz:update" mode auto 

# UI
ZSH_THEME="powerlevel10k/powerlevel10k"
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
)

# ENV
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export ARCHFLAGS="-arch x86_64"

# Sources
source $ZSH/oh-my-zsh.sh
source $HOME/.dotfiles/scripts/shared/plugins.sh
source $HOME/.dotfiles/scripts/shared/cleanup.sh
if [[ -x "$(command -v apt-get)" ]]; then
  source "$HOME/.dotfiles/scripts/debian/install.sh"
elif [[ -x "$(command -v pacman)" ]]; then
  source "$HOME/.dotfiles/scripts/arch/install.sh"
fi

# Config modules
for conf in "$HOME/.dotfiles/zsh/".*.{zsh,sh}; do
  source "${conf}"
done
unset conf

# PATH
export LOCAL_BIN="$HOME/.local/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 
export PNPM_HOME="$HOME/.local/share/pnpm"
export CARGO_HOME="$HOME/.cargo"
export CARGO_BIN="$CARGO_HOME/bin"
export PATH="$PATH:$LOCAL_BIN:$PNPM_HOME:$CARGO_HOME:$CARGO_BIN"
eval "$(rbenv init - zsh)"

# compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
