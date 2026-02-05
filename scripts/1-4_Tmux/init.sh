#!/bin/bash

log_info "Started Tmux setup..."
log_output ""

################################################################################
# install latest tmux

log_status "Started Tmux installation..."

if ! apt-get update \
&& apt-get install -y tmux; then
    log_error "Failed to install Tmux"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
# Set permissions for tmux configuration

log_status "Started setting permissions for Tmux configuration..."

if ! chown -R :${GROUP_NAME} /etc/devbox/dotfiles/tmux/; then
    log_error "Failed to change group ownership of /etc/devbox/dotfiles/tmux/"
    exit 1
fi
if ! chmod g+x /etc/devbox/dotfiles/tmux/; then
    log_error "Failed to change group ownership of /etc/devbox/dotfiles/tmux/"
    exit 1
fi
if ! chmod -R g+rw /etc/devbox/dotfiles/tmux/; then
    log_error "Failed to set permissions on /etc/devbox/dotfiles/tmux/"
    exit 1
fi

###############################################################################
# Symlink tmux configuration

log_status "Started symlinking Tmux configuration..."

# for root
mkdir -p /root/.config/
if ! ln -sf /etc/devbox/dotfiles/tmux/ /root/.config/; then
    log_error "Failed to link Tmux configuration for root user"
    exit 1
fi

# for USER_NAME
if ! sudo -u "${USER_NAME}" bash <<'EOF'
mkdir -p "$HOME/.config/"
ln -sf /etc/devbox/dotfiles/tmux "$HOME/.config/"
EOF
then
    log_error "Failed to link Tmux configuration"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
log_info "All Tmux setup completed successfully!"
log_output ""
