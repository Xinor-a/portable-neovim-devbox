#!/bin/bash

# Ensure SSH host keys exist
if [ ! -f /etc/ssh/ssh_host_rsa_key ] || \
    [ ! -f /etc/ssh/ssh_host_ecdsa_key ] || \
    [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
    log_info "Generating SSH host keys..."
    ssh-keygen -A
    log_info "SSH host keys generated successfully"
else
    log_info "SSH host keys already exist"
fi

/usr/sbin/sshd