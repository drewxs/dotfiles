#!/bin/bash

function preinstall {
	sudo pacman -Syu --noconfirm
	sudo pacman -S zsh
	sudo rm -rf .oh-my-zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

preinstall
