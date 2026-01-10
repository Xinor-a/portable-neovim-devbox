#!/bin/bash

# Starship - Tokyo Night installation
if ! curl -sS https://starship.rs/install.sh | sh -s -- -y; then
    log_error "Failed to install Starship"
    exit 1
fi

chmod 766 /etc/devenv/starship/starship.toml

## Installation and setting for Starship prompt
if ! grep -q "eval \"\$(starship init bash)\"" /etc/bash.bashrc; then
    echo "eval \"\$(starship init bash)\"" >> /etc/bash.bashrc
    log_info "Created alias 'eval \"\$(starship init bash)\"' for Starship prompt"
fi
if ! grep -q "export STARSHIP_CONFIG=/etc/devenv/starship/starship.toml" /etc/bash.bashrc; then
    echo "export STARSHIP_CONFIG=/etc/devenv/starship/starship.toml" >> /etc/bash.bashrc
    log_info "Created alias 'export STARSHIP_CONFIG=/etc/devenv/starship/starship.toml' for Starship prompt"
fi