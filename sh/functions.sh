#!/bin/bash

# Check if a command exists and echo the result
# $1: command
function exists {
  [[ -z "$1" ]] && echo "Usage: exists <command>" && return
  if command -v "$1" &>/dev/null; then
    echo "$1 installation found"
    return 0
  fi
  echo "$1 installation not found"
  return 1
}

# Check if a command exists in PATH
# $1: command
function cmd_exists {
  [[ -z "$1" ]] && echo "Usage: cmd_exists <command>" && return
  [[ -x "$(command -v "$1")" ]] && return 0 || return 1
}

# Create and cd into a directory
# $1: dir
function mkcd {
  [[ -z "$1" ]] && echo "Usage: mkcd <dir>" && return
  mkdir -p "$1"
  cd "$1" || exit
}

# Kill processes on specified port
# $1: port
function killport {
  [[ -z "$1" ]] && echo "Usage: killport <port>" && return
  kill -9 "$(lsof -t -i:"$1")"
}

# Trim whitespace
function trim {
  awk "{\$1=\$1;print}"
}

# Print keycodes on keypress
function keys {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# Update packages and dotfiles
function upd {
  function up_dot {
    echo "Updating dotfiles..."
    DOTFILES="$HOME/.dotfiles"
    git -C "$DOTFILES" fetch
    if [[ $(git -C "$DOTFILES" rev-parse HEAD) == $(git -C "$DOTFILES" rev-parse @\{u\}) ]]; then
      echo "No updates to pull"
    else
      git -C "$DOTFILES" pull --rebase --autostash
      echo "Dotfiles updated"
    fi
  }
  function up_nvim {
    echo "Updating neovim packages..."
    nvim --headless "+Lazy! restore" +qa
    nvim --headless "+MasonUpdate" +qa
  }
  function up_pkg {
    echo "Updating packages..."
    echo "Updating system packages..."
    if cmd_exists apt-get; then
      sudo apt update && sudo apt upgrade -y
    elif cmd_exists pacman; then
      yay -Syu --noconfirm
    elif cmd_exists brew; then
      brew update && brew upgrade
    fi
    echo "Updating rust packages..."
    if cmd_exists rustup; then
      rustup update
      cargo install-update -a
    fi
    echo "Updating node packages..."
    if cmd_exists pnpm; then
      pnpm update --global --latest
    fi
    echo "Updating ruby packages..."
    if cmd_exists gem; then
      gem update
    fi
  }
  function up_all {
    up_dot
    up_nvim
    up_pkg
  }

  [[ $# -eq 0 ]] && up_all
  while getopts :adpnfh opt; do
    case $opt in
    a) up_all ;;
    d) up_dot ;;
    n) up_nvim ;;
    p) up_pkg ;;
    f)
      echo "Clean installing dotfiles..."
      export update_only=false
      install_dotfiles
      ;;
    h)
      echo "Updater

Usage: upd [OPTIONS]

Options:
  -a  Update all (default)
  -d  Update dotfiles
  -n  Update neovim
  -p  Update packages
  -f  Clean install dotfiles"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "Run 'upd -h' for help"
      ;;
    esac
  done
}

# Find (recursively) and delete all directories with name
# $1: dir
function fdel {
  [[ -z "$1" ]] && echo "Usage: fdel <dir>" && return
  fd "$1" --type d --prune . | xargs -I {} rm -rf '{}'
}

# Find listening ports
# $1: port
function port() {
  [[ -z "$1" ]] && echo "Usage: port <port>" && return
  ss -tulnp | grep "$1" | trim
}

# Create notes
function note {
  echo -e "date: $(date)\n$*\n" >>"$HOME/notes.txt"
}
function notes {
  cat "$HOME/notes.txt"
}

# Test truecolor support
function testtc {
  awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
  }'
}

# Load environment variables from file
# Defaults to .env in current directory
# $1: path to env file
function loadenv {
  env_file="${1:-.env}"
  if [[ -f "$env_file" ]]; then
    while IFS= read -r line; do
      if [[ -n "$line" ]] && [[ "$line" != \#* ]]; then
        line=$(echo "$line" | xargs | sed -e "s/^['\"]//" -e "s/['\"]$//")
        export "${line?}"
      fi
    done <"$env_file"
    echo "$env_file loaded"
  else
    echo "$env_file not found"
  fi
}

# Create a new rust project and open in neovim
# $1: project name
function cnew {
  [[ -z "$1" ]] && echo "Usage: cnew <project_name>" && return
  cargo new "$@"
  cd "$1" || exit
  echo "# $1" >README.md
  nvim
}

# Create a new typescript project and open in neovim
# $1: project name
function tnew {
  [[ -z "$1" ]] && echo "Usage: tnew <project_name>" && return
  mkcd "$1"
  mkdir src
  npm init -y
  echo "# $1" >README.md
  touch src/index.ts
  tsc --init
  eslint --init
  nvim
}

# Clone a git repository and cd into it
# $1: repo url
function gcld {
  git clone --recurse-submodules "$1" && cd "$(basename "$1" .git)" || exit
}
