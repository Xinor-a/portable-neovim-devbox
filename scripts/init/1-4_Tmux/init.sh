#!/bin/bash

log_info "Started Tmux setup..."
log_output ""

################################################################################
# install latest tmux

log_status "Started Tmux installation..."

if ! apt-get update \
&& apt-get install -y tmux; then
    log_error "Failed to install Tmux"
    exit 1
fi

log_status "Completed."
log_output ""

################################################################################
log_info "All Tmux setup completed successfully!"
log_output ""
