#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd $SCRIPT_DIR

# color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# log functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# add path to /etc/bash.bashrc if not already present
add_path_of() {
    if ! grep -q "$1" /etc/bash.bashrc; then
        if grep -q "^export PATH=" /etc/bash.bashrc; then
            sed -i "s/^export PATH=.*$/export PATH=$PATH:$1/g" /etc/bash.bashrc
        else
            echo "export PATH=$PATH:$1" >> /etc/bash.bashrc
        fi
        log_info "Added '$1' to PATH in /etc/bash.bashrc"
    fi
}

# Initialization starts here...
log_info "Starting initialization script..."

# Install basic development tools
log_info "Installing basic development tools..."
apt-get update \
&& apt-get install -y \
    build-essential \
    curl \
    fontconfig \
    htop \
    jq \
    nano \
    tree \
    unzip \
    vim \
    wget \
    zip

# Set timezone to Asia/Tokyo
log_info "Setting timezone to Asia/Tokyo..."
if ! timedatectl set-timezone Asia/Tokyo; then
    log_warn "Failed to set timezone (this is normal on WSL1)"
fi

# Backup and configure /bash.bashrc
log_info "Configuring shell environment..."
if [ -f /etc/bash.bashrc ]; then
    cp /etc/bash.bashrc /etc/bash.bashrc.backup_$(date +%Y%m%d_%H%M%S)
    log_info "Created backup of /etc/bash.bashrc"
fi

# Install Nerd Fonts
cd /usr/share/fonts/

FontName="JetBrainsMono"
if [ ! -f ./$FontName.zip ]; then
    log_info "Installing $FontName..."
    if wget -P . https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/$FontName.zip; then
        unzip $FontName.zip \
            && fc-cache -fv
    else
        log_error "Failed to download $FontName"
    fi
fi

FontName="MoralerspaceHWJPDOC_v2.0.0"
if [ ! -f ./$FontName.zip ]; then
    log_info "Installing $FontName..."
    if wget -P . https://github.com/yuru7/moralerspace/releases/download/v2.0.0/$FontName.zip; then
        unzip $FontName.zip \
            && fc-cache -fv
    else
        log_error "Failed to download $FontName"
    fi
fi

# Add aliases (customize as needed)
if ! grep -q "alias ll='ls -alF'" /etc/bash.bashrc; then
    echo "alias ll='ls -alF'" >> /etc/bash.bashrc
    log_info "Created alias 'll' for 'ls -alF'"
fi
if ! grep -q "alias la='ls -A'" /etc/bash.bashrc; then
    echo "alias la='ls -A'" >> /etc/bash.bashrc
    log_info "Created alias 'la' for 'ls -A'"
fi
if ! grep -q "alias l='ls -CF'" /etc/bash.bashrc; then
    echo "alias l='ls -CF'" >> /etc/bash.bashrc
    log_info "Created alias 'l' for 'ls -CF'"
fi
if ! grep -q "alias ..='cd ..'" /etc/bash.bashrc; then
    echo "alias ..='cd ..'" >> /etc/bash.bashrc
    log_info "Created alias '..' for 'cd ..'"
fi
if ! grep -q "alias ...='cd ../..'" /etc/bash.bashrc; then
    echo "alias ...='cd ../..'" >> /etc/bash.bashrc
    log_info "Created alias '...' for 'cd ../..'"
fi
if ! grep -q "alias gs='git status'" /etc/bash.bashrc; then
    echo "alias gs='git status'" >> /etc/bash.bashrc
    log_info "Created alias 'gs' for 'git status'"
fi
if ! grep -q "alias gp='git pull'" /etc/bash.bashrc; then
    echo "alias gp='git pull'" >> /etc/bash.bashrc
    log_info "Created alias 'gp' for 'git pull'"
fi
if ! grep -q "alias gc='git commit'" /etc/bash.bashrc; then
    echo "alias gc='git commit'" >> /etc/bash.bashrc
    log_info "Created alias 'gc' for 'git commit'"
fi

# Cleanup unnecessary packages
log_info "Cleaning up unnecessary packages..."
apt-get autoremove -y
apt-get clean

# Install additional tools
log_info "Installing additional tools..."

# Loop through all subdirectories in lexicographical order
for dir in $(find "$SCRIPT_DIR" -mindepth 1 -maxdepth 1 -type d | sort); do
    if [ -f "$dir/init.sh" ]; then
        dir_name=$(basename "$dir")
        log_info "Executing $dir_name/init.sh..."
        cd "$dir"
        if source ./init.sh; then
            log_info "Completed $dir_name/init.sh"
        else
            log_error "Failed to execute $dir_name/init.sh"
        fi
        cd "$SCRIPT_DIR"
    fi
done

source /etc/bash.bashrc

cat << '_EOF_' >> /etc/entrypoint.sh

exec "$@"

_EOF_

log_info "====================================="
log_info "Completed initialization script."
log_info "====================================="