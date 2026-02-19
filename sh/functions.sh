#!/bin/bash

# Check if a command exists in PATH
# $1: command
function exists {
  [[ -z "$1" ]] && echo "Usage: exists COMMAND" && return
  [[ -x "$(command -v "$1")" ]] && return 0 || return 1
}

# Create and cd into a directory
# $1: dir
function mkcd {
  [[ -z "$1" ]] && echo "Usage: mkcd DIR" && return
  mkdir -p "$1"
  cd "$1" || return
}

# Kill processes on specified port
# $1: port
function killport {
  [[ -z "$1" ]] && echo "Usage: killport PORT" && return
  kill -9 $(lsof -ti :$1)
}

# Trim whitespace
function trim {
  awk "{\$1=\$1;print}"
}

# Print bytes of a binary file
# $1: file
function bytes {
  [[ -z "$1" ]] && echo "Usage: bytes FILE" && return
  if [[ ! -f "$1" ]]; then
    echo "File not found: $1"
    return 1
  fi
  xxd -p "$1" | tr -d '\n' | sed 's/../& /g'
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
      git -C "$DOTFILES" checkout -- "$DOTFILES"/nvim/lazy-lock.json
      git -C "$DOTFILES" pull --rebase --autostash
      echo "Dotfiles updated"
    fi
  }
  function up_pkg {
    echo "Updating packages..."
    echo "Updating system packages..."
    if exists apt; then
      sudo apt update && sudo apt upgrade -y
      sudo apt autoremove && sudo apt clean
    elif exists pacman; then
      sudo pacman -Syu --noconfirm
      aur_updates=$(yay -Qu --aur --quiet)
      if [ -n "$aur_updates" ]; then
        yay -S --noconfirm $aur_updates
      fi
      paccache -ru
    elif exists brew; then
      brew update && brew upgrade
      brew cleanup
    fi
    echo "Updating rust packages..."
    if exists rustup; then
      rustup update
      cargo install-update -a
    fi
    echo "Updating node packages..."
    if exists npm; then
      npm update --global
    fi
    echo "Updating ruby packages..."
    if exists gem; then
      gem update
    fi
    echo "Updating git extensions..."
    if exists gh; then
      gh extension upgrade --all
    fi
    if exists apt; then
      echo "Updating uv..."
      if exists uv; then
        uv self update
      fi
    fi
  }
  function up_nvim {
    echo "Updating neovim packages..."
    nvim --headless "+MasonUpdate" +qa
    nvim --headless "+TSUpdate" +qa
    nvim --headless "+Lazy! restore" +qa
  }
  function up_all {
    up_dot
    up_pkg
    up_nvim
  }

  [[ $# -eq 0 ]] && up_all
  while getopts :adnpfh opt; do
    case $opt in
    a) up_all ;;
    d) up_dot ;;
    n) up_nvim ;;
    p) up_pkg ;;
    f)
      echo "Clean installing dotfiles..."
      if exists apt; then
        $HOME/.dotfiles/scripts/install_debian.sh
      elif exists pacman; then
        $HOME/.dotfiles/scripts/install_arch.sh
      fi
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
  [[ -z "$1" ]] && echo "Usage: fdel DIR" && return
  fd "$1" --type d --prune . | xargs -I {} rm -rf '{}'
}

# Nuke the current directory and exit
function nuke {
  curr_dir=$(pwd)
  cd ..
  rm -rf "$curr_dir"
  exit
}

# Find listening ports
# $1: port
function port {
  [[ -z "$1" ]] && echo "Usage: port PORT" && return
  ss -tulnp | grep "$1" | trim
}

# Create notes
function note {
  echo -e "date: $(date)\n$*\n" >>"$HOME/notes.txt"
}
function notes {
  cat "$HOME/notes.txt"
}

# Fuzzy find and open with the specified program
# $1: application
function f {
  [[ -z "$1" ]] && echo "Usage: f PROGRAM" && return
  program="$1"
  file=$(fzf --preview="$program --color=always {}")
  if [ -n "$file" ]; then
    $program "$file"
  fi
}

# Load environment variables from file
# $1: path to env file (default = .env)
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

# Activate virtual environment, create if it doesn't exist
# $1: dir (default = .venv)
function venv {
  dir="${1:-.venv}"
  if [[ ! -d "$dir" ]]; then
    python -m venv "$dir"
  fi
  source "$dir/bin/activate"
}

# Create a new rust project and open in neovim
# $1: project name
function cnew {
  [[ -z "$1" ]] && echo "Usage: cnew PROJECT_NAME" && return
  cargo new "$@"
  cd "$1" || return
  echo "# $1" >README.md
  nvim
}

# Create a new typescript project and open in neovim
# $1: project name
function tnew {
  [[ -z "$1" ]] && echo "Usage: tnew PROJECT_NAME" && return
  mkcd "$1"
  mkdir src
  npm init -y
  echo "# $1" >README.md
  touch src/index.ts
  tsc --init
  eslint --init
  nvim
}

function loc {
  [[ -z "$1" ]] && echo "Usage: loc FILETYPE [-l]" && return

  filetypes="$1"
  flag="$2"

  pattern=".*\.($(echo "$filetypes" | tr ',' '|'))$"

  if [[ "$flag" == "-l" ]]; then
    fd --type f --regex "$pattern" --hidden | xargs wc -l
  else
    fd --type f --regex "$pattern" --hidden | xargs wc -l | tail -1 | awk 'END{print $1}'
  fi
}

# Zip a git repository
# $1: dir (default = .)
zipgit() {
  dir="${1:-.}"

  if ! git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: not a git repository"
    return 1
  fi

  if ! git -C "$dir" rev-parse --verify HEAD >/dev/null 2>&1; then
    echo "Error: repository has no commits yet"
    return 1
  fi

  root="$(git -C "$dir" rev-parse --show-toplevel)"
  dest="$(dirname "$root")/$(basename "$root").zip"

  if ! git -C "$root" archive --format=zip --output="$dest" HEAD; then
    echo "Error: failed to create zip archive"
    return 1
  fi

  echo "Archive created: $(realpath "$dest")"
}

# Clone a git repository and cd into it
# $1: repo url
function gcld {
  git clone --recurse-submodules "$1" && cd "$(basename "$1" .git)" || return
}

# Cherry pick a commit from a different repo
# $1: from repo
# $2: commit hash
function gcpr {
  [[ -z "$1" ]] || [[ -z "$2" ]] && echo "Usage: gcp FROM HASH" && return
  git --git-dir="$1"/.git \
    format-patch -k -1 --stdout "$2" |
    git am -3 -k --ignore-whitespace
}

# Convert images in the current directory to webp
# Options:
#   -q  quality (default = 75)
#   -w  max width (default = 1440)
#   -i  overwrite original files
function towebp {
  if ! command -v magick &>/dev/null; then
    echo "Error: imagemagick is not installed"
    return 1
  fi

  local quality=75
  local width=1440
  local inplace=0

  while getopts :q:w:ih opt; do
    case $opt in
    q) quality="$OPTARG" ;;
    w) width="$OPTARG" ;;
    i) inplace=1 ;;
    h)
      echo "Usage: towebp [-q QUALITY] [-w WIDTH] [-i]

Options:
  -q  Quality (default: 75)
  -w  Max width in pixels (default: 1440)
  -i  Overwrite original files"
      return
      ;;
    \?)
      echo "Invalid option: -$OPTARG. Run 'towebp -h' for help" >&2
      return 1
      ;;
    esac
  done

  local count=0

  setopt nullglob 2>/dev/null
  for f in *.jpg *.jpeg *.png *.gif *.bmp *.tiff *.avif *.webp; do
    local out="${f%.*}.webp"
    if [[ "$f" == "$out" ]]; then
      local tmp="${f%.webp}.tmp.webp"
      magick "$f" -resize "${width}>" -quality "$quality" "$tmp" && mv "$tmp" "$out" && {
        echo "Optimized: $f"
        ((count++))
      }
    else
      magick "$f" -resize "${width}>" -quality "$quality" "$out" && {
        [[ $inplace -eq 1 ]] && rm "$f"
        echo "Converted: $f -> $out"
        ((count++))
      }
    fi
  done

  [[ $count -eq 0 ]] && echo "No images found in current directory" || echo "Done: $count image(s) optimized"
}

# Encrypt a file using gpg
# $1: input file
function gpgenc {
  [[ -z "$1" ]] && echo "Usage: gpgenc INPUT_FILE" && return
  input_file="$1"
  gpg --symmetric "$input_file"
}

# Decrypt a file using gpg
# $1: input file
# #2?: output file (default = "decrypted")
function gpgdec {
  [[ -z "$1" ]] && echo "Usage: gpgdec INPUT_FILE [OUTPUT_FILE]" && return
  input_file="$1"
  output_file="${2:-${1%.gpg}}"
  gpg --decrypt "$input_file" >"$output_file"
}

# Print keycodes on keypress
function keys {
  xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
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

# Update grub
function upgrub {
  sudo grub-mkconfig -o /boot/grub/grub.cfg
}

# Burn an ISO to a disk
# $1: disk name
# $2: path to iso
function burniso {
  [[ -z "$1" ]] || [[ -z "$2" ]] && echo "Usage: burniso DISK_NAME PATH_TO_ISO" && return
  disk_name="$1"
  path_to_iso="$2"
  sudo dd bs=4M if="$path_to_iso" of="$disk_name" status=progress oflag=sync
}

# Reformat a drive
# $1: disk name
# $2: partition name
function reformat {
  disk_name="$1"
  disk_partition="$1"1

  # wipe all data
  sudo wipefs --all "$disk_name"

  # create partition
  # gpt -> new -> enter -> write -> yes -> quit
  sudo cfdisk "$disk_name"

  # format partition
  sudo mkfs.vfat "$disk_partition"
}
