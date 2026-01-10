#!/bin/bash

# install latest tmux
apt-get update \
&& apt-get install -y \
    tmux

if ! grep -q "export TERM=xterm-256color" /etc/bash.bashrc; then
    echo "export TERM=xterm-256color" >> /etc/bash.bashrc
    log_info "Created alias 'export TERM=xterm-256color' for Starship prompt on 'tmux'"
fi

if ! grep -q "export LANG=en_US.UTF-8" /etc/bash.bashrc; then
    echo "export LANG=en_US.UTF-8" >> /etc/bash.bashrc
    log_info "Created alias 'export LANG=en_US.UTF-8' for Starship prompt on 'tmux'"
fi

if ! grep -q "export LC_COLLATE=C" /etc/bash.bashrc; then
    echo "export LC_COLLATE=C" >> /etc/bash.bashrc
    log_info "Created alias 'export LC_COLLATE=C' for Starship prompt on 'tmux'"
fi

chmod 766 /etc/devenv/tmux/tmux.conf
mkdir -p /root/.config/tmux/
ln -sf /etc/devenv/tmux/tmux.conf /root/.config/tmux/tmux.conf