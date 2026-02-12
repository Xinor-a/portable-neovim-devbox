#!/bin/bash

log_info "Started Neovim setup..."
log_output ""

################################################################################
# Set permissions for Neovim configuration

log_status "Started setting permissions for Neovim configuration..."

mkdir -p /etc/nvim/lazy/ \
&& set_group_permissions /etc/nvim/lazy/ \
&& set_group_permissions /etc/devbox/dotfiles/nvim/

log_status "Completed."
log_output ""

################################################################################
# Symlink Neovim configuration

log_status "Started symlinking Neovim configuration..."

# for root
mkdir -p /root/.local/share/nvim/ \
&& set_symlink /etc/nvim/lazy/ /root/.local/share/nvim/
mkdir -p /root/.config/ \
&& set_symlink /etc/devbox/dotfiles/nvim/ /root/.config/

# for USER_NAME
mkdir -p "/home/${USER_NAME}/.local/share/nvim/" \
&& set_symlink /etc/nvim/lazy/ "/home/${USER_NAME}/.local/share/nvim/"
mkdir -p "/home/${USER_NAME}/.config/" \
&& set_symlink /etc/devbox/dotfiles/nvim/ "/home/${USER_NAME}/.config/"

log_status "Completed."
log_output ""

################################################################################
log_info "All Neovim setup completed successfully!"
log_output ""
