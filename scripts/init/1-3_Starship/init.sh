#!/bin/bash

log_info "Started Starship setup..."
log_output ""

################################################################################
# Install latest starship Tokyo Night theme

log_status "Started Starship installation..."

if ! curl -sS https://starship.rs/install.sh | sh -s -- -y; then
    log_error "Failed to install Starship"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
log_info "All Starship setup completed successfully!"
log_output ""
