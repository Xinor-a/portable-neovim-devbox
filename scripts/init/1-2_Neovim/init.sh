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
