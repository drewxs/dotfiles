# Package manager
if [[ -x "$(command -v apt-get)" ]]; then
  alias up='sudo apt update && sudo apt upgrade -y'
elif [[ -x "$(command -v pacman)" ]]; then
  alias p="sudo pacman --noconfirm"
  alias y="yay --noconfirm"
  alias up="yay -Syu --noconfirm"
  alias upf="yay -Syyu --noconfirm"
fi

# Git
alias gs="git fetch && git status"
alias gd="git diff --name-only"
alias gdc="git diff --cached --name-only"
alias gds="git diff --staged --name-only"
alias gcm="git commit -m"

# Docker
alias docker:start="sudo systemctl start docker.service"
alias docker:stop="sudo systemctl stop docker.service"
alias drm="docker ps -aq | xargs docker stop | xargs docker rm"
alias dsp="docker system prune -a"
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

# Neovim
alias v="nvim"

# Lazygit
alias lg="lazygit"

