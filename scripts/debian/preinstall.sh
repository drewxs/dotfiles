#!/bin/sh

function preinstall () {
  sudo apt update && sudo apt upgrade -y
  sudo apt install zsh
  sudo rm -rf .oh-my-zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

preinstall
