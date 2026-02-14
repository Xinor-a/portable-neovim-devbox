FROM busybox

################################################################################
# Copy devbox configuration files

RUN mkdir -p /etc/devbox/dotfiles/
COPY ./dotfiles/ /etc/devbox/dotfiles/
COPY ./scripts/entrypoint/ /etc/devbox/scripts/entrypoint/

RUN chmod 777 /etc/devbox/scripts/entrypoint/entrypoint.sh
