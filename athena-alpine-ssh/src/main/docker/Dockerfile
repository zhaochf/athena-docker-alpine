FROM alpine:latest
MAINTAINER zhaochf <zhaochf@aliyun.com>

COPY gosu-amd64 /usr/bin/gosu

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
    chmod +x /usr/bin/gosu

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]