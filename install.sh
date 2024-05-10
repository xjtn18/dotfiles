#!/bin/bash

# Set DOTFILES_DIR to the directory of the script
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Pull the latest changes from git
git pull

# Remove any existing version of these files
rm -f "$HOME/.tmux.conf"
rm -f "$HOME/.rgignore"
rm -f "$HOME/.config/lazygit/config.yml"
rm -rf "$HOME/.config/nvim"

# Create symbolic links (soft links) for the files
ln -s "${DOTFILES_DIR}/.tmux.conf" "$HOME/.tmux.conf"
ln -s "${DOTFILES_DIR}/.rgignore" "$HOME/.rgignore"
ln -s "${DOTFILES_DIR}/lazygit.yml" "$HOME/.config/lazygit/config.yml"
ln -s "${DOTFILES_DIR}/nvim" "$HOME/.config/nvim"

echo "Finished. Dotfiles are now synced."
