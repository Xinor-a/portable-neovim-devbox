#!/bin/bash

log_info "Started Git setup..."
log_output ""

################################################################################
# Set permissions for git configuration

log_status "Started setting permissions for git configuration..."

mkdir -p /etc/devbox/dotfiles/git/
set_group_permissions /etc/devbox/dotfiles/git/

log_status "Completed."
log_output ""

################################################################################
# Symlink git configuration

log_status "Started symlinking Git configuration..."

# for root
set_symlink /etc/devbox/dotfiles/git/.gitconfig /root/.gitconfig
set_symlink /etc/devbox/dotfiles/git/.gitattributes /root/.gitattributes

# for USER_NAME
set_symlink /etc/devbox/dotfiles/git/.gitconfig "/home/${USER_NAME}/.gitconfig"
set_symlink /etc/devbox/dotfiles/git/.gitattributes "/home/${USER_NAME}/.gitattributes"

log_status "Completed."
log_output ""

################################################################################
log_info "All Git setup completed successfully!"
log_output ""
