FROM alpine:3.7
MAINTAINER Xueshan Feng <xueshan.feng@gmail.com>
MAINTAINER Michal Schott <schott.michal@gmail.com>

ENV VERSION 0.6.0

RUN apk update --no-cache && \
    apk add --no-cache \
      bash \
      git \
      libgcc \
      libstdc++ \
      openssl \
      && \
    apk add --no-cache --virtual=build \
      curl \
      g++ \
      make \
      openssh \
      openssl-dev \
      && \
    rm -rf /var/cache/apk/* && \
    curl -L https://github.com/AGWA/git-crypt/archive/debian/$VERSION.tar.gz | tar zxv -C /var/tmp && \
    cd /var/tmp/git-crypt-debian && \
    make && \
    make install PREFIX=/usr/local && \
    rm -rf /var/tmp/git-crypt-debian && \
    apk del --purge build

WORKDIR /repo
VOLUME /repo
CMD ["/bin/bash"]
