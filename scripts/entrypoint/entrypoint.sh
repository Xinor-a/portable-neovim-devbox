#!/bin/bash

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

if [ ! -f /etc/devbox/dotfiles/bash.bashrc ]; then
    if [ ! -e /etc/bash.bashrc ]; then
        ls -t /etc/bash.bashrc.backup*.bak | head -n 1 | xargs -I{} cp {} /etc/devbox/dotfiles/bash.bashrc
    elif [ -f /etc/bash.bashrc ]; then
        cp /etc/bash.bashrc /etc/bash.bashrc.backup_$(date +%Y%m%d_%H%M%S)
        mv /etc/bash.bashrc /etc/devbox/dotfiles/bash.bashrc
    elif [ -L /etc/bash.bashrc ]; then
        rm /etc/bash.bashrc
        ls -t /etc/bash.bashrc.backup*.bak | head -n 1 | xargs -I{} cp {} /etc/devbox/dotfiles/bash.bashrc
    fi
elif [ -f /etc/bash.bashrc ]; then
    cp /etc/bash.bashrc /etc/bash.bashrc.backup_$(date +%Y%m%d_%H%M%S)
fi
if ! chown -R :${GROUP_NAME} /etc/devbox/dotfiles/; then
    log_error "Failed to change group ownership of /etc/devbox/dotfiles/"
    exit 1
fi
if ! chmod g+x /etc/devbox/dotfiles/; then
    log_error "Failed to set execute permission on /etc/devbox/dotfiles/"
    exit 1
fi
if ! chmod -R g+rwX /etc/devbox/dotfiles/; then
    log_error "Failed to set read/write permissions on /etc/devbox/dotfiles/"
    exit 1
fi
ln -sf /etc/devbox/dotfiles/bash.bashrc /etc/bash.bashrc
ln -sf /etc/devbox/dotfiles/bash.bashrc /root/.bashrc
ln -sf /etc/devbox/dotfiles/bash.bashrc /home/$USER_NAME/.bashrc

# Loop through all subdirectories in lexicographical order
for dir in $(find "$SCRIPT_DIR" -mindepth 1 -maxdepth 1 -type d | sort); do
    if [ -f "$dir/subentry.sh" ]; then
        dir_name=$(basename "$dir")
        echo $dir
        echo $dir_name
        log_info "Executing $dir_name/subentry.sh..."
        cd "$dir"
        if source ./subentry.sh; then
            log_info "Completed $dir_name/subentry.sh"
        else
            log_error "Failed to execute $dir_name/subentry.sh"
        fi
        cd "$SCRIPT_DIR"
    fi
done

exec gosu $USER_NAME "$@"
