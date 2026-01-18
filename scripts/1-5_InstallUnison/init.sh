#!/bin/bash

log_info "Installing Unison file synchronization tool..."
if ! apt-get update || ! apt-get install -y unison; then
    log_error "Failed to install Unison"
    exit 1
fi

# Create Unison configuration directory
mkdir -p /root/.unison

# Add aliases for Unison to /etc/bash.bashrc
if ! grep -q "alias unison-status=" /etc/bash.bashrc; then
    echo "alias unison-status='ps aux | grep -v grep | grep unison'" >> /etc/bash.bashrc
    log_info "Created alias 'unison-status' for checking Unison process"
fi

if ! grep -q "alias unison-log=" /etc/bash.bashrc; then
    echo "alias unison-log='tail -f /var/log/unison.log'" >> /etc/bash.bashrc
    log_info "Created alias 'unison-log' for viewing Unison log"
fi

if ! grep -q "alias unison-restart=" /etc/bash.bashrc; then
    echo "alias unison-restart='pkill unison; nohup unison default > /var/log/unison.log 2>&1 &'" >> /etc/bash.bashrc
    log_info "Created alias 'unison-restart' for restarting Unison sync"
fi

# Set appropriate permissions (read/write for owner, read for others)
chmod 644 /etc/devenv/unison/default.prf
mkdir -p /root/.unison/
ln -sf /etc/devenv/unison/default.prf /root/.unison/default.prf
log_info "Unison profile linked to /root/.unison/default.prf"
