#!/bin/bash

log_info "Started Tmux setup..."
log_output ""

################################################################################
# Set permissions for tmux configuration

log_status "Started setting permissions for Tmux configuration..."

mkdir -p /etc/devbox/dotfiles/tmux/ \
&& set_group_permissions /etc/devbox/dotfiles/tmux/

log_status "Completed."
log_output ""

###############################################################################
# Symlink tmux configuration

log_status "Started symlinking Tmux configuration..."

# for root
mkdir -p /root/.config/ \
&& set_symlink /etc/devbox/dotfiles/tmux/ /root/.config/

# for USER_NAME
mkdir -p "/home/${USER_NAME}/.config/" \
&& set_symlink /etc/devbox/dotfiles/tmux/ "/home/${USER_NAME}/.config/"

log_status "Completed."
log_output ""

################################################################################
log_info "All Tmux setup completed successfully!"
log_output ""
