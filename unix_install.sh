#!/bin/bash

# Pull the latest changes from git
git pull

# Set DOTFILES_DIR to the directory of the script
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create symbolic links (soft links) for the files
ln -sf "${DOTFILES_DIR}/.bashrc" "$HOME/.bashrc"

ln -sf "${DOTFILES_DIR}/.tmux.conf" "$HOME/.tmux.conf"

ln -sf "${DOTFILES_DIR}/.rgignore" "$HOME/.rgignore"

mkdir -p "$HOME/.config/lazygit"
ln -sf "${DOTFILES_DIR}/lazygit.yml" "$HOME/.config/lazygit/config.yml"

rm -rf "$HOME/.config/nvim"
ln -s "${DOTFILES_DIR}/nvim" "$HOME/.config/nvim"

ln -s "${DOTFILES_DIR}/.inputrc" "$HOME/.inputrc"

echo "Dotfiles are now synced."
