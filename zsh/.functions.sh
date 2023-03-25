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

# Update packages and tools
function upall {
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
function upd {
  DOTFILES="$HOME/.dotfiles"
  git -C "$DOTFILES" fetch
  if [[ $(git -C "$DOTFILES" rev-parse HEAD) == $(git -C "$DOTFILES" rev-parse @\{u\}) ]]; then
    echo "No updates to pull"
    return 0
  else
    git -C "$DOTFILES" pull --ff-only
  fi
  while getopts :f opt; do
    case $opt in
    f)
      export update_only=true
      install_dotfiles
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
    esac
  done
  echo "Dotfiles updated"
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

# Mass rename / remove part of filename
function mvrm {
  find . -name "*" -print0 | sed -ze "p;s/\$1//" | xargs -0 -n2 mv
}
