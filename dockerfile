FROM ubuntu:24.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        sudo

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN mkdir -p /tmp/scripts
COPY scripts /tmp/scripts
RUN chmod 777 /tmp/scripts/init.sh

RUN mkdir -p /etc/devenv/
RUN chmod 777 /etc/devenv/

# Create necessary directories for the volume mount (ssh) and set permissions
RUN mkdir -p /etc/ssh/
RUN chmod 777 /etc/ssh/
RUN mkdir -p /etc/ssh/
RUN chmod 777 /etc/ssh/
# Set password for root user
RUN echo 'root:password' | chpasswd
# Expose SSH port
EXPOSE 22

COPY scripts/entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

RUN mkdir -p /var/log && chmod 777 /var/log
RUN /tmp/scripts/init.sh 2>&1 | tee /var/log/init.log

ENTRYPOINT ["/etc/entrypoint.sh"]