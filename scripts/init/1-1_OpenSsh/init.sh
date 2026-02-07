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
log_info "All OpenSsh setup completed successfully!"
log_output ""
