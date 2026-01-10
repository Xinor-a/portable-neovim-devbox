#!/bin/bash

# install latest nvim
if [ "$(uname -m)" = "x86_64" ]; then
    ARCH="x86_64"
elif [ "$(uname -m)" = "aarch64" ]; then
    ARCH="arm64"
else
    log_error "Unsupported architecture: $(uname -m)"
    exit 1
fi

if ! curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$ARCH.tar.gz; then
    log_error "Failed to download latest Neovim"
    exit 1
fi
if [ -d /opt/nvim-linux-$ARCH ]; then
    log_info "Removing existing Neovim directory"
    rm -rf /opt/nvim-linux-$ARCH
fi
tar -C /opt -xzf nvim-linux-$ARCH.tar.gz

# install tree-sitter CLI
if ! apt-get install -y nodejs npm; then
    log_error "Failed to install Node.js and npm"
    exit 1
fi
npm install -g tree-sitter-cli@0.25.10

mkdir -p /root/.config/
chmod -R 777 /etc/devenv/nvim
ln -sf /etc/devenv/nvim /root/.config/

# set path for nvim config in bash.bashrc
mv /opt/nvim-linux-$ARCH /opt/nvim
add_path_of /opt/nvim/bin