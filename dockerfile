FROM ubuntu:24.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        sudo \
        tini

# Set timezone to Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# Copy initialization scripts and set permissions
RUN mkdir -p /tmp/scripts
COPY scripts /tmp/scripts
RUN chmod 777 /tmp/scripts/init.sh

# Create necessary directories for the volume mount (devenv)
RUN mkdir -p /etc/devenv/
RUN chmod 777 /etc/devenv/
COPY devenv/ /etc/devenv/

# Create necessary directories for the volume mount (ssh) and set permissions
RUN mkdir -p /etc/ssh/
RUN chmod 777 /etc/ssh/

# Set password for root user
RUN echo 'root:root' | chpasswd
# Expose SSH port
EXPOSE 22

# Initialize log directory and run initialization script
RUN mkdir -p /var/log && chmod 777 /var/log
RUN /tmp/scripts/init.sh 2>&1 | tee /var/log/init.log

ENTRYPOINT ["/usr/bin/tini", "--", "/etc/devenv/entrypoint/entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]