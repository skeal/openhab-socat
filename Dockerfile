ARG OPENHAB_VERSION=2.4.0-amd64-debian

FROM openhab/openhab:$OPENHAB_VERSION

# Install socat
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    socat\
    supervisor

COPY openhab.conf /etc/supervisor/conf.d/openhab.conf

RUN DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/supervisord", "-n"]
