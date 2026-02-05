#!/bin/bash

set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd $SCRIPT_DIR

################################################################################
# Log functions

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_output() {
    echo -e "${NC}$1"
}

log_status() {
    echo -e "${NC}[STATUS]${NC} $1"
}

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

################################################################################
# Function to add a path to $PATH if not already present

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

################################################################################
# Initialization starts here...

log_output "========================================"
log_info "Started initialization script."
log_output ""

################################################################################
# Install basic development tools

log_status "Installing basic development tools..."

if ! apt-get update \
|| ! apt-get install -y \
    build-essential \
    curl \
    fontconfig \
    htop \
    jq \
    less \
    nano \
    tree \
    unzip \
    vim \
    wget \
    zip \
|| ! apt-get autoremove -y \
|| ! rm -rf /var/lib/apt/lists/*; then
    log_error "Failed to install basic development tools"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
# Backup and configure /bash.bashrc

log_status "Started to create backup of /etc/bash.bashrc..."

cp /etc/bash.bashrc /etc/bash.bashrc.backup_$(date +%Y%m%d_%H%M%S)

log_status "Completed."
log_output ""

################################################################################
# Set permissions for /etc/devbox/dotfiles/

log_status "Started setting permissions for /etc/devbox/dotfiles/..."

if ! chown -R :${GROUP_NAME} /etc/devbox/dotfiles/; then
    log_error "Failed to change group ownership of /etc/devbox/dotfiles/"
    exit 1
fi
if ! chmod g+x /etc/devbox/dotfiles/; then
    log_error "Failed to set execute permission on /etc/devbox/dotfiles/"
    exit 1
fi
if ! chmod -R g+rw /etc/devbox/dotfiles/; then
    log_error "Failed to set read/write permissions on /etc/devbox/dotfiles/"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
# Add basic aliases

log_status "Started adding aliases to /etc/bash.bashrc..."

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

log_status "Completed."
log_output ""

################################################################################
# Install additional tools

log_output "========================================"
log_info "Started sub initialization scripts..."
log_output ""

# Loop through all subdirectories in lexicographical order
for dir in $(find "$SCRIPT_DIR" -mindepth 1 -maxdepth 1 -type d | sort); do
    if [ -f "$dir/init.sh" ]; then
        dir_name=$(basename "$dir")

        log_output "=============================="
        log_info "Executing $dir_name/init.sh..."
        log_output ""

        cd "$dir"

        # Source the init.sh script
        if source ./init.sh; then
            log_info "Completed $dir_name/init.sh"
            log_output ""
        else
            log_error "Failed to execute $dir_name/init.sh"
            log_output ""
        fi

        log_info "End of $dir_name/init.sh..."
        log_output "=============================="
        log_output ""

        cd "$SCRIPT_DIR"
    fi
done

log_info "All sub initialization scripts completed."
log_output "========================================"
log_output ""

################################################################################
# Set permissions for entrypoint script and bash.bashrc

chmod +x /etc/scripts/entrypoint/entrypoint.sh

################################################################################

log_output "========================================"
log_info "Completed initialization script."
log_output "========================================"
