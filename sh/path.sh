#!/bin/bash

path_envs=()

if [[ "$(uname)" == "Darwin" ]]; then
  export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
  export PNPM_HOME="$HOME/Library/pnpm"
  export GOPATH="$XDG_DATA_HOME/go"
  export GEM_HOME="$HOME/.gem"

  path_envs+=(
    "$HOME/bin"
    "/usr/local/bin"
    "$PNPM_HOME"
    "$CARGO_HOME/bin"
    "$GOPATH/bin"
    "$GEM_HOME/bin"
  )

  if exists android-studio; then
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    path_envs+=(
      "$ANDROID_HOME/platform-tools"
      "$ANDROID_HOME/tools"
      "$ANDROID_HOME/tools/bin"
      "$ANDROID_HOME/emulator"
    )
  fi

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

  . /usr/local/opt/asdf/libexec/asdf.sh
else
  export PNPM_HOME="$XDG_DATA_HOME/pnpm"
  export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
  export GOPATH="$XDG_DATA_HOME/go"
  export ASDF_DIR="$HOME/.asdf"
  export DOTNET_ROOT="$HOME/.dotnet"

  path_envs+=(
    "$HOME/bin"
    "$HOME/.local/bin"
    "$PNPM_HOME"
    "$CARGO_HOME/bin"
    "$XDG_DATA_HOME/mix/escripts"
    "$GOPATH/bin"
    "$DOTNET_ROOT"
  )

  if exists android-studio; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    path_envs+=(
      "$ANDROID_HOME/emulator"
      "$ANDROID_HOME/tools"
      "$ANDROID_HOME/tools/bin"
      "$ANDROID_HOME/platform-tools"
    )
  fi

  if exists nvcc; then
    if [[ -d "/opt/cuda/bin" ]]; then
      path_envs+=("/opt/cuda/bin")
    elif [[ -d "/usr/local/cuda/bin" ]]; then
      path_envs+=("/usr/local/cuda/bin")
    fi
  fi

  if [[ -d "/snap/bin" ]]; then
    path_envs+=("/snap/bin")
  fi

  if [[ -d "$HOME/nvim-linux64/bin" ]]; then
    path_envs+=("$HOME/nvim-linux64/bin")
  fi

  . "$HOME/.asdf/asdf.sh"
fi

PATH="$PATH:$( IFS=":" ; echo "${path_envs[*]}" )"

if exists direnv; then
  eval "$(direnv hook zsh)"
fi

if exists thefuck; then
  eval "$(thefuck --alias)"
fi
