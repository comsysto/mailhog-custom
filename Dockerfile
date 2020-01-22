FROM golang:alpine

# Install MailHog from master f5559ac00323e7f2ab5abcea3628e0c492bb3bf2 - 15 Oct 2019
RUN apk --no-cache add --virtual build-dependencies \
    git \
  && mkdir -p /root/gocode \
  && export GOPATH=/root/gocode \
  && export GO111MODULE=on \
  && go get github.com/mailhog/MailHog@f5559ac00323e7f2ab5abcea3628e0c492bb3bf2 \
  && mv /root/gocode/bin/MailHog /usr/local/bin \
  && rm -rf /root/gocode \
  && apk del --purge build-dependencies

# Add mailhog user/group with uid/gid 1000.
RUN adduser -D -u 1000 mailhog

ADD docker-entrypoint.sh /opt/docker-entrypoint.sh
RUN chmod +x /opt/docker-entrypoint.sh && \
    touch /opt/mailhog-auth && \
    chown mailhog /opt/mailhog-auth

USER mailhog

WORKDIR /home/mailhog

EXPOSE 1025 8025
ENTRYPOINT /opt/docker-entrypoint.sh
