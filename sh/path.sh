#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  export BIN="$HOME/bin"
  export LOCAL_BIN="/usr/local/bin"
  export RUSTUP_HOME="$HOME/.local/share/rustup"
  export PNPM_HOME="$HOME/Library/pnpm"
  export CARGO_HOME="$HOME/.local/share/cargo"
  export CARGO_BIN="$CARGO_HOME/bin"
  export GO_BIN="$GOPATH/bin"
  export CARGO_BIN="$HOME/.local/share/cargo/bin"
  export GEM_HOME="$HOME/.gem"
  export GEM_BIN="$GEM_HOME/bin"
  export PATH="$PATH:$BIN:$LOCAL_BIN:$PNPM_HOME:$GO_BIN:$CARGO_BIN:$MIX_BIN:$RUBY_BIN:$GEM_BIN"

  if exists android-studio; then
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    export PATH=$PATH:$ANDROID_HOME/emulator
  fi

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

  . /usr/local/opt/asdf/libexec/asdf.sh
else
  export BIN="$HOME/bin"
  export LOCAL_BIN="$HOME/.local/bin"
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export RUSTUP_HOME="$HOME/.local/share/rustup"
  export CARGO_HOME="$HOME/.local/share/cargo"
  export CARGO_BIN="$CARGO_HOME/bin"
  export MIX_BIN="$HOME/.local/share/mix/escripts"
  export GOPATH="$HOME/.local/share/go"
  export GO_BIN="$GOPATH/bin"
  export ASDF_DIR="$HOME/.asdf"
  export PATH="$PATH:$BIN:$LOCAL_BIN:$PNPM_HOME:$CARGO_HOME:$CARGO_BIN:$MIX_BIN:$GOPATH:$GO_BIN"

  if exists android-studio; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    ANDROID_PATHS=$(eval echo "$ANDROID_HOME/{emulator,tools,tools/bin,platform-tools}" | tr ' ' ':')
    export PATH="$PATH:$ANDROID_PATHS}"
  fi

  if exists nvcc; then
    if [[ -d "/opt/cuda/bin" ]]; then
      export PATH="$PATH:/opt/cuda/bin"
    elif [[ -d "/usr/local/cuda/bin" ]]; then
      export PATH="$PATH:/usr/local/cuda/bin"
    fi
  fi

  if [[ -d "$PATH:/snap/bin" ]]; then
    export PATH="$PATH:/snap/bin"
  fi

  if [[ -d "$HOME/nvim-linux64/bin" ]]; then
    export PATH="$PATH:$HOME/nvim-linux64/bin"
  fi

  . "$HOME/.asdf/asdf.sh"
fi

if exists direnv; then
  eval "$(direnv hook zsh)"
fi

if exists thefuck; then
  eval "$(thefuck --alias)"
fi
