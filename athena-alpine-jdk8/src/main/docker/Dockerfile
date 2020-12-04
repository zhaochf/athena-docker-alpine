FROM zhaochf/athena-alpine-ssh:1.0
MAINTAINER zhaochf <zhaochf@aliyun.com>

ADD --chown=root:root server-jre-8u271-linux-x64.tar.gz /data/app/
COPY --chown=root:root glibc-2.32-r0.apk glibc-bin-2.32-r0.apk glibc-i18n-2.32-r0.apk setjavaenv.sh /data/app/

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    apk add /data/app/glibc-2.32-r0.apk /data/app/glibc-bin-2.32-r0.apk /data/app/glibc-i18n-2.32-r0.apk && \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    rm -f /data/app/glibc*.apk

ENV JAVA_HOME=/data/app/jdk1.8.0_271 \
    PATH=$PATH:/data/app/jdk1.8.0_271/bin