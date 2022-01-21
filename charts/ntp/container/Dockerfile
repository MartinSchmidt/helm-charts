FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y chrony && \
    rm -rf /var/lib/apt/lists/*

# We don't want to accidentally use it
RUN rm /etc/chrony/chrony.conf && \
    mkdir /run/chrony && \
    chmod 750 /run/chrony && \
    chown _chrony:_chrony /run/chrony && \
    setcap cap_sys_time,cap_net_bind_service+ep /usr/sbin/chronyd
COPY docker-entrypoint.sh /usr/local/bin/
COPY chrony-client.conf /etc/chrony/
COPY chrony-server.conf /etc/chrony/
RUN chown -R _chrony:_chrony /etc/chrony
ENTRYPOINT ["docker-entrypoint.sh"]

# grep _chrony /etc/passwd
USER 101:101
EXPOSE 123/udp
CMD ["server"]
