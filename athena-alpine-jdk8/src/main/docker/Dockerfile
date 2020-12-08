FROM alpine:latest
MAINTAINER zhaochf <zhaochf@aliyun.com>

WORKDIR /data/app/

ADD server-jre-8u271-linux-x64.tar.gz ./
COPY glibc-2.32-r0.apk glibc-bin-2.32-r0.apk glibc-i18n-2.32-r0.apk gosu-amd64 ./


RUN set -eux; \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
    apk update; \
    apk add --no-cache openssh tzdata bash; \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config; \
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key; \
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key; \
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key; \
    echo "root:admin" | chpasswd; \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub; \
    apk add /data/app/glibc-2.32-r0.apk /data/app/glibc-bin-2.32-r0.apk /data/app/glibc-i18n-2.32-r0.apk; \
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8; \
    mv gosu-amd64 /usr/bin/gosu; \
    chmod +x /usr/bin/gosu; \
    chmod -R +x jdk1.8.0_271; \
    rm -f glibc*.apk

ENV JAVA_HOME=/data/app/jdk1.8.0_271 \
    PATH=$PATH:/data/app/jdk1.8.0_271/bin

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]