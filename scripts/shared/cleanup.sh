#!/bin/bash

function remove_existing_configurations {
	sudo rm -rf "$HOME/.gitconfig" "$HOME/.tmux.conf" "$HOME/.zshrc" "$HOME/.p10k.zsh" "$HOME/.config/nvim" "$HOME/.config/alacritty/alacritty.yml"
}

function create_symlinks {
	mkdir -p "$HOME/.config" "$HOME/.config/alacritty"
	ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
	ln -s "$HOME/.dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
	ln -s "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
	ln -s "$HOME/.dotfiles/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
	ln -s "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"
	ln -s "$HOME/.dotfiles/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
}

function setup_neovim {
	sudo rm -rf "$HOME/.cache/nvim" "$HOME/.config/nvim/plugin" "$HOME/.local/share/nvim"
	nvim --headless -c 'PackerSync'
}

function cleanup {
	if [[ "${update_only:=false}" == true ]]; then
		return
	fi

	remove_existing_configurations
	create_symlinks
	setup_neovim
}
