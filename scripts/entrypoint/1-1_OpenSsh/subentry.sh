#!/bin/bash

log_info "Started OpenSsh setup..."
log_output ""

################################################################################
# Set permissions for ssh configuration

log_status "Started setting permissions for SSH configuration..."

mkdir -p /etc/ssh/
chown -R :root "/etc/ssh/" \
    && chmod -R 700 "/etc/ssh/"

mkdir -p /root/.ssh/
mkdir -p "/home/${USER_NAME}/.ssh/"

log_status "Completed."
log_output ""

################################################################################
# Create /var/run/sshd directory

log_status "Creating /var/run/sshd directory..."

mkdir -p /var/run/sshd

log_status "Completed."
log_output ""

################################################################################
# Ensure SSH host keys exist

log_status "Ensuring SSH host keys exist..."

if [ ! -f /etc/ssh/ssh_host_rsa_key ] || \
    [ ! -f /etc/ssh/ssh_host_ecdsa_key ] || \
    [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
    log_info "Generating SSH host keys..."
    log_output ""

    ssh-keygen -A

    log_info "SSH host keys generated successfully"
    log_output ""
else
    log_info "SSH host keys already exist"
    log_output ""
fi

log_status "Completed."
log_output ""

################################################################################
# Start OpenSSH server

log_status "Starting OpenSSH server..."

sudo /usr/sbin/sshd

log_status "Completed."
log_output ""

################################################################################
log_info "All OpenSsh setup completed successfully!"
log_output ""
