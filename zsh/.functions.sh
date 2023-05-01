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

# Check if a command exists
# $1: command
function exists {
  if command -v "$1" &>/dev/null; then
    echo "$1 installation found"
    return 0
  fi
  return 1
}

# Check if a command exists in PATH
# $1: command
function cmd_exists {
  if [[ -x "$(command -v "$1")" ]]; then
    return 0
  fi
  return 1
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
up_usage="Drew's updater

Usage: up [OPTIONS]

Options:
  -s  Update system packages (default)
  -p  Update language packages
  -d  Update dotfiles
  -f  Clean install dotfiles"
function up {
  if [[ $# -eq 0 ]]; then
    upd
  fi
  while getopts :spdfh opt; do
    case $opt in
    s)
      echo "Updating system packages..."
      upd
      ;;
    p)
      echo "Updating packages..."
      if [[ -x "$(command -v rustup)" ]]; then
        rustup update
        cargo install-update -a
      fi
      if [[ -x "$(command -v pnpm)" ]]; then
        pnpm update --global --latest
      fi
      if [[ -x "$(command -v gem)" ]]; then
        gem update
      fi
      ;;
    d)
      echo "Updating dotfiles..."
      DOTFILES="$HOME/.dotfiles"
      git -C "$DOTFILES" fetch
      if [[ $(git -C "$DOTFILES" rev-parse HEAD) == $(git -C "$DOTFILES" rev-parse @\{u\}) ]]; then
        echo "No updates to pull"
      else
        git -C "$DOTFILES" pull --ff-only
        echo "Dotfiles updated"
      fi
      ;;
    f)
      echo "Clean installing dotfiles..."
      export update_only=false
      install_dotfiles
      ;;
    h)
      echo "$up_usage"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "Run 'up -h' for help"
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

# Delete swap files
function delsw {
  find . -type f -name "*.sw[klmnop]" -delete
}

# Create notes
function note {
  echo -e "date: $(date)\n$*\n" >>"$HOME/notes.txt"
}
function notes {
  cat "$HOME/notes.txt"
}

# Mass rename / remove part of filename
function mvrm {
  find . -name "*" -print0 | sed -ze "p;s/\$1//" | xargs -0 -n2 mv
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
