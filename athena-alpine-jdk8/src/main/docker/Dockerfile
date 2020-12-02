FROM registry.cn-beijing.aliyuncs.com/zhaochf/athena-alpine-ssh:1.0
MAINTAINER zhaochf <zhaochf@aliyun.com>

WORKDIR /data/app

ADD --chown=root:root server-jre-8u271-linux-x64.tar.gz .
COPY --chown=root:root setjavaenv.sh /etc/profile.d
COPY --chown=root:root glibc-2.32-r0.apk .
COPY --chown=root:root glibc-bin-2.32-r0.apk .
COPY --chown=root:root glibc-i18n-2.32-r0.apk .

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    apk add glibc-2.32-r0.apk glibc-bin-2.32-r0.apk glibc-i18n-2.32-r0.apk && \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 && \
    source /etc/profile.d/setjavaenv.sh && \
    rm -rf glibc*.apk

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]