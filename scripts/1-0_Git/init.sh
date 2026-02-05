#!/bin/bash

log_info "Started Git setup..."
log_output ""

################################################################################
# Install latest git

log_status "Started Git installation..."

if ! apt-get update \
&& apt-get install -y git; then
    log_error "Failed to install Git"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
# Set permissions for git configuration

log_status "Started setting permissions for Git configuration..."

if ! chown -R :${GROUP_NAME} /etc/devbox/dotfiles/git/; then
    log_error "Failed to change group ownership of /etc/devbox/dotfiles/git/"
    exit 1
fi
if ! chmod g+x /etc/devbox/dotfiles/git/; then
    log_error "Failed to set execute permission on /etc/devbox/dotfiles/git/"
    exit 1
fi
if ! chmod -R g+rw /etc/devbox/dotfiles/git/; then
    log_error "Failed to set read/write permissions on /etc/devbox/dotfiles/git/"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
# Symlink git configuration

log_status "Started symlinking Git configuration..."

# for root
if ! ln -sf /etc/devbox/dotfiles/git/.gitconfig /root/.gitconfig \
|| ! ln -sf /etc/devbox/dotfiles/git/.gitattributes /root/.gitattributes; then
    log_error "Failed to configure Git for root user"
    exit 1
fi

# for USER_NAME
if ! sudo -u "${USER_NAME}" bash <<'EOF'
ln -sf /etc/devbox/dotfiles/git/.gitconfig "/$HOME/"
ln -sf /etc/devbox/dotfiles/git/.gitattributes "/$HOME/"
EOF
then
    log_error "Failed to configure Git for ${USER_NAME}"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
log_info "All git setup completed successfully!"
log_output ""
