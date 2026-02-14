#!/bin/bash

log_info "Started OpenSsh setup..."
log_output ""

################################################################################
# Install latest OpenSsh Client

log_status "Started OpenSsh Client installation..."

if ! apt-get update \
|| ! apt-get install -y --no-install-recommends openssh-client; then
    log_error "Failed to install OpenSsh Client"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
log_info "All OpenSsh setup completed successfully!"
log_output ""
