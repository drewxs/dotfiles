#!/bin/bash

# Package manager
if [[ -x "$(command -v apt-get)" ]]; then
  alias p="sudo apt -y"
elif [[ -x "$(command -v pacman)" ]]; then
  alias p="sudo pacman --noconfirm"
  alias y="yay --noconfirm"
fi

# General
alias l="exa -lah"
alias ls="exa"
alias cls="clear"
alias cl="cls && l"
alias cat="bat"
alias top="htop"
alias c="cargo"
alias v="nvim"
alias tmux="tmux -2"
alias lg="lazygit"
alias serve="npx http-server"

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
alias gst="git stash"

# Docker
alias d:start="sudo systemctl start docker.service"
alias d:stop="sudo systemctl stop docker.service"
alias d="docker"
alias drm="docker ps -aq | xargs docker stop | xargs docker rm"
alias dsp="docker system prune -a -f"
alias dspv="docker system prune -a -f --volumes"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker inspect"
alias dim="docker images"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dcp="docker-compose pull"
alias dcl="docker-compose logs -f"

# Postgres
alias pg:start="sudo systemctl start postgresql.service"
alias pg:stop="sudo systemctl stop postgresql.service"
