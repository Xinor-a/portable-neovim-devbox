#!/bin/bash

if ! apt-get install -y --no-install-recommends openssh-server; then
    log_error "Failed to install OpenSsh Server"
    exit 1
fi

chmod 755 /etc/ssh/sshd_config

log_info "Configuring SSH server..."
mkdir -p /var/run/sshd
