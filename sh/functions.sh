#!/bin/bash

# Kill processes on specified port
# $1: port num
function killport {
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

# Check if a command exists and echo the result
# $1: command
function exists {
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
  [[ -x "$(command -v "$1")" ]] && return 0 || return 1
}

# Create and cd into a directory
# $1: dir
function mkcd {
  mkdir -p "$1"
  cd "$1" || exit
}

# Check if a directory exists
# $1: dir
# $2: name/identifier
function dir_exists {
  if [[ -d $1 ]] && [[ -n $1 ]]; then
    echo "$2 found"
    return 0
  fi
  return 1
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
    echo "Updating neovim..."
    nvim --headless "+Lazy! sync" +qa
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

  [[ $# -eq 0 ]] && up_dot && up_pkg
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

# Find (recursively) and list directories with name
# $1: dir name
function finddir {
  find . -name "$1" -type d -prune | xargs du -chs
}

# Find (recursively) and delete all directories with name
# $1: dir name
function deldir {
  find . -name "$1" -type d -prune -exec rm -rf '{}' +
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
        export "${line?}"
      fi
    done <"$env_file"
    echo "$env_file loaded"
  else
    echo "$env_file not found"
  fi
}
