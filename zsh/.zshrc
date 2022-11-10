# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Auto-update behavior.
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Command execution time stamp shown in the history command output.
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyy-mm-dd"

# Plugins list.
# Standard plugins: $ZSH/plugins/
# Custom plugins: $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
git
zsh-syntax-highlighting
zsh-autosuggestions
docker
)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# Manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Aliases
alias up='sudo pacman -Syyu'

alias gd='git diff --name-only'
alias gdc='git diff --cached --name-only'
alias gds='git diff --staged --name-only'
alias gcm='git commit -m'

alias nv='nvim'
alias delsw='find . -type f -name "*.sw[klmnop]" -delete'
alias lg='lazygit'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/drew/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# compinstall
zstyle :compinstall filename '/home/drew/.zshrc'
autoload -Uz compinit
compinit
