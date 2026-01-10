#!/bin/bash

if ! apt-get install -y --no-install-recommends openssh-server; then
    log_error "Failed to install OpenSsh Server"
    exit 1
fi

chmod 755 /etc/ssh/

log_info "Configuring SSH server..."
mkdir -p /var/run/sshd
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# Generate SSH host keys if they don't exist
if [ ! -f /etc/ssh/ssh_host_rsa_key ] || \
    [ ! -f /etc/ssh/ssh_host_ecdsa_key ] || \
    [ ! -f /etc/ssh/ssh_host_ed25519_key ] || \
    [ ! -f /etc/ssh/ssh_host_dsa_key ]; then
    log_info "Generating SSH host keys..."
    ssh-keygen -A
    log_info "SSH host keys generated successfully"
else
    log_info "SSH host keys already exist"
fi

cat << '_EOF_' >> /etc/entrypoint.sh

# Ensure SSH host keys exist
if [ ! -f /etc/ssh/ssh_host_rsa_key ] || \
    [ ! -f /etc/ssh/ssh_host_ecdsa_key ] || \
    [ ! -f /etc/ssh/ssh_host_ed25519_key ] || \
    [ ! -f /etc/ssh/ssh_host_dsa_key ]; then
    log_info "Generating SSH host keys..."
    ssh-keygen -A
    log_info "SSH host keys generated successfully"
else
    log_info "SSH host keys already exist"
fi

/usr/sbin/sshd -D
_EOF_