# Container image that runs your code
FROM alpine/git

RUN wget https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz && tar -zxvf helm-v3.5.0-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin/helm

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
