FROM alpine:3.13.6

RUN set -x && \
  apk --update upgrade                                  &&  \
  apk add git-daemon bash fcgiwrap spawn-fcgi      &&  \
  adduser git -h /var/lib/git -D                        &&  \
  git config --system http.receivepack true             &&  \
  git config --system http.uploadpack true                                  

ADD ./fcgi.sh /usr/local/bin/entrypoint

ENTRYPOINT [ "entrypoint" ]
