#!/bin/bash

log_info "Started OpenSsh setup..."
log_output ""

################################################################################
# Install latest OpenSsh Server

log_status "Started OpenSsh Server installation..."

if ! apt-get update \
|| ! apt-get install -y --no-install-recommends openssh-server; then
    log_error "Failed to install OpenSsh Server"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
# Set permissions for ssh configuration

log_status "Started setting permissions for SSH configuration..."

if ! chown -R :${GROUP_NAME} /etc/devbox/ssh/; then
    log_error "Failed to change group ownership of /etc/devbox/ssh/"
    exit 1
fi
if ! chmod g+x /etc/devbox/ssh/; then
    log_error "Failed to set execute permission on /etc/devbox/ssh/"
    exit 1
fi
if ! chmod -R g+rw /etc/devbox/ssh/; then
    log_error "Failed to set read/write permissions on /etc/devbox/ssh/"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
# Create /var/run/sshd directory

log_status "Creating /var/run/sshd directory..."

mkdir -p /var/run/sshd

log_status "Completed."
log_output ""

################################################################################
log_info "All OpenSsh setup completed successfully!"
log_output ""
