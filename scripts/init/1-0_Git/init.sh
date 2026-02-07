#!/bin/bash

log_info "Started Git setup..."
log_output ""

################################################################################
# Install latest git

log_status "Started Git installation..."

if ! apt-get update \
&& apt-get install -y git; then
    log_error "Failed to install Git"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
log_info "All Git setup completed successfully!"
log_output ""
