#!/bin/bash

# Create project directories if they don't exist
mkdir -p /root/projects /root/projects-master

# Remove stale lock files from previous runs
rm -f ~/.unison/lk* 2>/dev/null

# Perform initial sync
log_info "Starting initial Unison sync..."
if unison default -repeat 0; then
    log_info "Initial Unison sync completed successfully"
else
    log_warn "Initial Unison sync failed or had conflicts (exit code: $?)"
fi

# Start background sync daemon
log_info "Starting Unison background sync..."
nohup unison default > /var/log/unison.log 2>&1 &
UNISON_PID=$!

# Verify the process started
sleep 1
if ps -p "$UNISON_PID" > /dev/null 2>&1; then
    log_info "Unison sync started (PID: $UNISON_PID)"
else
    log_error "Failed to start Unison background sync"
fi
