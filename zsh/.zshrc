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
# modes: disabled | auto | reminder
zstyle ":omz:update" mode auto 

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
  zsh-syntax-highlighting
  zsh-autosuggestions
  git
  docker
)

# Sources
source $ZSH/oh-my-zsh.sh
source $HOME/.dotfiles/scripts/shared/plugins.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# Manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor
export EDITOR="nvim"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Aliases
if [[ -x "$(command -v apt-get)" ]]; then
  alias up='sudo apt update && sudo apt upgrade -y'
elif [[ -x "$(command -v pacman)" ]]; then
  alias p="sudo pacman --noconfirm"
  alias y="yay --noconfirm"
  alias up="yay -Syu --noconfirm"
fi

if [[ -x "$(command -v docker)" ]]; then
  alias docker:start="sudo systemctl start docker.service"
  alias docker:stop="sudo systemctl stop docker.service"
fi

if [[ -x "$(command -v docker-compose)" ]]; then
  alias dcud="docker-compose up -d"
  alias dcd="docker-compose down"
  alias dcr="docker-compose restart"
  alias dcp="docker-compose pull"
  alias dclf="docker-compose logs -f"
fi

if [[ -x "$(command -v psql)" ]]; then
  alias pg:start="sudo systemctl start postgresql.service"
  alias pg:stop="sudo systemctl stop postgresql.service"
fi

alias gs="git fetch && git status"
alias gd="git diff --name-only"
alias gdc="git diff --cached --name-only"
alias gds="git diff --staged --name-only"
alias gcm="git commit -m"

alias v="nvim"
alias delsw='find . -type f -name "*.sw[klmnop]" -delete'
alias lg="lazygit"

# Functions

# Kill processes on specified port
# $1: port num
killport () {
  kill -9 $(lsof -t -i:"$1")
}

# Print keycodes on keypress
keys () {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# Check if a package is installed
# $1: command
package_exists () {
  if command -v "$1" &> /dev/null; then
    echo "$1 installation found"
    return 0
  fi
  return 1
}

# Create and cd into a directory
# $1: dir
mkcd () {
  mkdir "$1" && cd "$1"
}

# Check if a directory exists
# $1: dir
# $2: name/identifier
dir_exists () {
  if [[ -d $1 ]] && [[ -n $1 ]]; then
    echo "$2 found"
    return 0
  fi
  return 1
}

# Update packages and tools
upall () {
  up
  if [[ -x "$(command -v rustup)" ]]; then
    rustup update
  fi
  if [[ -x "$(command -v pnpm)" ]]; then
    pnpm update --global --latest
  fi
  if [[ -x "$(command -v gem)" ]]; then
    gem update
  fi
}

# Update dotfiles
# $1: [-f] rerun install
upd () {
  git -C $HOME/.dotfiles pull --ff-only
  while getopts :f opt; do
    case $opt in
      f)
        update_only=true
        if [[ -x "$(command -v apt-get)" ]]; then
          source $HOME/.dotfiles/scripts/debian/install.sh
        elif [[ -x "$(command -v pacman)" ]]; then
          source $HOME/.dotfiles/scripts/arch/install.sh
        fi
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        ;;
    esac
  done
  echo "\nDotfiles updated"
}

# Find (recursively) and list directories with name
# $1: dir name
finddir () {
  find . -name "$1" -type d -prune | xargs du -chs
}

# Find (recursively) and delete all directories with name
# $1: dir name
deldir () {
  find . -name "$1" -type d -prune -exec rm -rf '{}' +
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

# PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 
export PNPM_HOME="$HOME/.local/share/pnpm"
export CARGO_HOME="$HOME/.cargo"
export CARGO_BIN="$CARGO_HOME/bin"
export PATH="$PATH:$PNPM_HOME:$CARGO_HOME:$CARGO_BIN"
eval "$(rbenv init - zsh)"

# compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
