FROM debian:bullseye-slim

LABEL org.opencontainers.image.source=https://github.com/distributed-technologies/helm-charts

RUN apt-get update && \
    apt-get install -y squid && \
    rm -rf /var/lib/apt/lists/*

USER 13:13
EXPOSE 3128/tcp
CMD ["squid", "-N"]
