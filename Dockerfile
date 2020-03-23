FROM alpine@sha256:ab00606a42621fb68f2ed6ad3c88be54397f981a7b70a79db3d1172b11c4367d 
#3.11.3

LABEL maintainer="adrian.riobo.lorenzo@gmail.com"

ENV ALPINE_GLIBC_VERSION 2.31-r0
ENV GLIBC_DWNL_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$ALPINE_GLIBC_VERSION/glibc-$ALPINE_GLIBC_VERSION.apk \
    GLIBCBIN_DWNL_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$ALPINE_GLIBC_VERSION/glibc-bin-$ALPINE_GLIBC_VERSION.apk \
    GLIBCI18N_DWNL_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$ALPINE_GLIBC_VERSION/glibc-i18n-$ALPINE_GLIBC_VERSION.apk \
    AWSCLI_DWNL_URL=https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    USER_UID=1001

WORKDIR /tmp

COPY bin /usr/local/bin

RUN apk add --update bash \
    && wget $GLIBC_DWNL_URL -P /tmp \ 
    && wget $GLIBCBIN_DWNL_URL -P /tmp \  
    && wget $GLIBCI18N_DWNL_URL -P /tmp \
    && wget $AWSCLI_DWNL_URL -O /tmp/awscliv2.zip \
    && apk add --update --allow-untrusted bash jq *.apk \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf /tmp/* \
    && /usr/local/bin/user_setup

WORKDIR /root
USER $USER_UID

