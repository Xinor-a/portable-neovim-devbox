#!/bin/bash

log_info "Started Neovim setup..."
log_output ""

################################################################################
# Install latest nvim

log_status "Started Neovim installation..."

if [ "$(uname -m)" = "x86_64" ]; then
    ARCH="x86_64"
elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH="arm64"
else
    log_error "Unsupported architecture: $(uname -m)"
    exit 1
fi

if ! curl -fLO https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux-$ARCH.tar.gz; then
    log_error "Failed to download latest Neovim"
    exit 1
fi
rm -rf /opt/nvim
tar -C /opt -xzf nvim-linux-$ARCH.tar.gz
ln -s /opt/nvim-linux-$ARCH/bin/nvim /usr/local/bin/nvim
chmod u+x /usr/local/bin/nvim

log_status "Completed."
log_output ""

################################################################################
# Set permissions for Neovim configuration

mkdir -p /etc/nvim/lazy/

log_status "Started setting permissions for Neovim configuration..."

if ! chown -R :${GROUP_NAME} /etc/nvim/lazy; then
    log_error "Failed to change group ownership of /etc/nvim/lazy"
    exit 1
fi
if ! chmod g+x /etc/nvim/lazy; then
    log_error "Failed to set execute permission on /etc/nvim/lazy"
    exit 1
fi
if ! chmod -R g+rw /etc/nvim/lazy; then
    log_error "Failed to set read/write permissions on /etc/nvim/lazy"
    exit 1
fi

if ! chown -R :${GROUP_NAME} /etc/devbox/dotfiles/nvim/; then
    log_error "Failed to change group ownership of /etc/devbox/dotfiles/nvim/"
    exit 1
fi
if ! chmod g+x /etc/devbox/dotfiles/nvim/; then
    log_error "Failed to set execute permission on /etc/devbox/dotfiles/nvim/"
    exit 1
fi
if ! chmod -R g+rw /etc/devbox/dotfiles/nvim/; then
    log_error "Failed to set read/write permissions on /etc/devbox/dotfiles/nvim/"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
# Symlink Neovim configuration

log_status "Started symlinking Neovim configuration..."

# for root
mkdir -p /root/.local/share/nvim/
mkdir -p /root/.config/
if ! ln -s /etc/nvim/lazy/ /root/.local/share/nvim/ \
|| ! ln -s /etc/devbox/dotfiles/nvim/ /root/.config/; then
    log_error "Failed to link Neovim configuration for root user"
    exit 1
fi

# for USER_NAME
if ! sudo -u "${USER_NAME}" bash <<'EOF'
mkdir -p $HOME/.local/share/nvim/
mkdir -p $HOME/.config/
ln -s /etc/nvim/lazy/ "$HOME/.local/share/nvim/"
ln -s /etc/devbox/dotfiles/nvim/ "$HOME/.config/"
EOF
then
    log_error "Failed to link Neovim configuration for ${USER_NAME}"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
# Install tree-sitter CLI

log_status "Started tree-sitter CLI installation..."

if ! apt-get update \
|| ! apt-get install -y nodejs npm; then
    log_error "Failed to install Node.js and npm"
    exit 1
fi

if ! npm install -g tree-sitter-cli@0.25.10; then
    log_error "Failed to install tree-sitter CLI"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
log_info "All Neovim setup completed successfully!"
log_output ""
