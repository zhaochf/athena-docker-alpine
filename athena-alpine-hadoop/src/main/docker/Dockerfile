FROM zhaochf/athena-alpine-jdk8:1.0
MAINTAINER zhaochf <zhaochf@aliyun.com>

WORKDIR /data/app

ADD hadoop-3.3.0-mini.tar.gz ./

RUN set -eux; \
    addgroup --gid=1000 -S hadoop; \
    adduser -S -G hadoop --uid=1000 hadoop; \
    chown -R hadoop:hadoop hadoop-3.3.0

ENV HADOOP_HOME=/data/app/hadoop-3.3.0 \
    PATH=$PATH:/data/app/hadoop-3.3.0/bin:/data/app/hadoop-3.3.0/sbin

EXPOSE 8088 9780

#ENTRYPOINT ["/data/app/docker-entrypoint.sh"]

