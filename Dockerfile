FROM ubuntu:bionic

# SET ENV VARS
ENV RES=1920x1080 \
    DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0

# INSTALL DEPS
RUN apt-get update && apt-get -y install \
    curl \
    meld \
    xvfb \
    x11vnc \
    supervisor \
    i3 \
    && rm -rf /etc/i3/config;

# COPY I3 CONFIG
COPY i3config /etc/i3/config

# INSTALL NOVNC
RUN curl -sSL https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar -xzv -C /root/ && mv /root/noVNC-1.1.0 /opt/novnc && \
    ln -s /opt/novnc/vnc.html /opt/novnc/index.html && \
    curl -sSL https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar -xzv -C /root/ && \
    mv /root/websockify-0.9.0 /opt/novnc/utils/websockify;

# ADD SUPERVISOR CONFIG
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# RUN UNDERPRIVILEGED
RUN useradd -m user
USER user
WORKDIR /home/user

# EXPOSE PORT
EXPOSE 8080

# START SUPERVISORD
CMD ["/usr/bin/supervisord"]
