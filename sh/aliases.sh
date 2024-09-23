#!/bin/bash

# Package managers
if [[ -x "$(command -v apt)" ]]; then
  alias p="sudo apt -y"
elif [[ -x "$(command -v pacman)" ]]; then
  alias p="sudo pacman --noconfirm"
  alias y="yay --noconfirm"
  alias pclean="sudo pacman -Qtdq | sudo pacman -Rns -"
fi
if [[ -x "$(command -v brew)" ]]; then
  alias b="brew"
fi

# General
alias cls="clear"
alias cl="cls && l"
alias lt="ls --human-readable --size -1 -S --classify"
alias lr="ls -t -1"
alias c="cargo"
alias v="nvim"
alias j="just"
alias lg="lazygit"
alias lzd="lazydocker"
alias nf="neofetch"
alias serve="npx http-server"
alias fc="fd --type f . | wc -l"
alias clip="xclip -sel c"
alias ports="ss -tulanp"
alias dot="cd ~/.dotfiles && nvim"

# Overrides
alias cat="bat"
alias top="htop"
alias pip="pip3"
alias python="python3"
alias tmux="tmux -2"
alias curl="curl -w '\n'"

# Git
alias gs="git status"
alias gfs="git fetch && git status"
alias gd="git diff --name-only"
alias gds="git diff --staged --name-only"
alias grss='git restore --staged'
alias gcm="git commit -m"
alias gu="git reset --soft HEAD~1"
alias guu="git reset --hard HEAD~1"
alias grao="git remote add origin"
alias gpuo="git push -u origin"
alias gpuom="git push -u origin main"
alias grgu="git remote get-url origin"
alias grsu="git remote set-url origin"
alias gst="git stash"
alias ghcs="gh copilot suggest"
alias ghce="gh copilot explain"

# Docker
alias d:start="sudo systemctl start docker.service"
alias d:stop="sudo systemctl stop docker.service"
alias d="docker"
alias drm="docker ps -aq | xargs docker stop | xargs docker rm"
alias dsp="docker system prune -af"
alias dspv="docker system prune -af --volumes"
alias dvp="docker volume prune"
alias dvpa="docker volume prune -af"
alias dclean="dsp && dspv && dvpa"
alias dnuke="drm && dclean"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker inspect"
alias dim="docker images"
alias dc="docker compose"
alias dcu="docker compose up"
alias dcud="docker compose up -d"
alias dcd="docker compose down"
alias dcw="docker compose watch"
alias dcr="docker compose run"
alias dcrr="docker compose run --rm"
alias dcrs="docker compose restart"
alias dcp="docker compose pull"
alias dcl="docker compose logs -f"
alias dcbd="docker compose build"
alias devc='bash <(curl -s https://raw.githubusercontent.com/drewxs/nvim-dev-container/main/devc.sh)'

# Postgres
alias pg:start="sudo systemctl start postgresql.service"
alias pg:stop="sudo systemctl stop postgresql.service"
