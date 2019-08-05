FROM openhab/openhab:latest

# Install socat
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    socat\
    supervisor

COPY openhab.conf /etc/supervisor/conf.d/openhab.conf
COPY socat-zwave.conf /etc/supervisor/conf.d/socat.conf

RUN DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/supervisord", "-n"]
