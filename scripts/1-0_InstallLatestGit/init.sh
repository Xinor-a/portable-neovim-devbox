#!/bin/bash

log_info "Installing basic development tools..."
apt-get update \
&& apt-get install -y \
    git

chmod 766 /etc/devenv/git/.gitconfig
ln -sf /etc/devenv/git/.gitconfig /root/.gitconfig

chmod 766 /etc/devenv/git/.gitattributes
ln -sf /etc/devenv/git/.gitattributes /root/.gitattributes