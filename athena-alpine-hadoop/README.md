# athena-alpine-hadoop
This is build hadoop docker images from alpine

## Build image 
mvn clean docker:build

## Push image
mvn docker:push

## Build and push image
mvn clean docker:build docker:push

## How to use this image
### Start a hadoop server instance
docker run -itd --name athen-alpine-hadoop -p 2022:22 [ImageId]

### Connect to Zookeeper from the Zookeeper command line client
docker exec -it [ContainerId] /bin/bash

### Start a Zookeeper server cluster instance
docker network create --driver bridge --subnet=172.18.0.0/16 --gateway=172.18.0.1 clusternet

mkdir -p /data/app/docker/zookeeper-cluster/zoo/conf
mkdir -p /data/app/docker/zookeeper-cluster/zoo/data
mkdir -p /data/app/docker/zookeeper-cluster/zoo/datalog
mkdir -p /data/app/docker/zookeeper-cluster/zoo/logs

cp -rf zoo zoo1
cp -rf zoo zoo2
cp -rf zoo zoo3

docker run -itd --name zoo1 -p 2022:22 -p 2181:2181 --privileged --restart always --network clusternet --ip 172.18.0.11 \
    -v /data/app/docker/zookeeper-cluster/zoo1/conf:/data/app/apache-zookeeper-3.6.2/conf \
	  -v /data/app/docker/zookeeper-cluster/zoo1/data:/data/app/apache-zookeeper-3.6.2/data \
    -v /data/app/docker/zookeeper-cluster/zoo1/datalog:/data/app/apache-zookeeper-3.6.2/datalog \
    -v /data/app/docker/zookeeper-cluster/zoo1/logs:/data/app/apache-zookeeper-3.6.2/logs \
    -e ZOO_MY_ID=1 \
    -e "ZOO_SERVERS=server.1=172.18.0.11:2888:3888;2181 server.2=172.18.0.12:2888:3888;2181 server.3=172.18.0.13:2888:3888;2181" \
    zhaochf/athena-alpine-zookeeper:1.0
   
    
docker run -itd --name zoo2 -p 2023:22 -p 2182:2181 --privileged --restart always --network clusternet --ip 172.18.0.12 \
    -v /data/app/docker/zookeeper-cluster/zoo1/conf:/data/app/apache-zookeeper-3.6.2/conf \
    -v /data/app/docker/zookeeper-cluster/zoo2/data:/data/app/apache-zookeeper-3.6.2/data \
    -v /data/app/docker/zookeeper-cluster/zoo2/datalog:/data/app/apache-zookeeper-3.6.2/datalog \
    -v /data/app/docker/zookeeper-cluster/zoo2/logs:/data/app/apache-zookeeper-3.6.2/logs \
    -e ZOO_MY_ID=2 \
    -e "ZOO_SERVERS=server.1=172.18.0.11:2888:3888;2181 server.2=172.18.0.12:2888:3888;2182 server.3=172.18.0.13:2888:3888;2181" \
    zhaochf/athena-alpine-zookeeper:1.0
    
docker run -itd --name zoo3 -p 2024:22 -p 2183:2181 --privileged --restart always --network clusternet --ip 172.18.0.13 \
    -v /data/app/docker/zookeeper-cluster/zoo1/conf:/data/app/apache-zookeeper-3.6.2/conf \
    -v /data/app/docker/zookeeper-cluster/zoo3/data:/data/app/apache-zookeeper-3.6.2/data \
    -v /data/app/docker/zookeeper-cluster/zoo3/datalog:/data/app/apache-zookeeper-3.6.2/datalog \
    -v /data/app/docker/zookeeper-cluster/zoo3/logs:/data/app/apache-zookeeper-3.6.2/logs \
    -e ZOO_MY_ID=3 \
    -e "ZOO_SERVERS=server.1=172.18.0.11:2888:3888;2181 server.2=172.18.0.12:2888:3888;2181 server.3=172.18.0.13:2888:3888;2181" \
    zhaochf/athena-alpine-zookeeper:1.0

docker exec -it zoo1 /bin/bash
zkServer.sh status
zkCli.sh
create /hi
ls /

docker exec -it zoo2 /bin/bash
zkServer.sh status
zkCli.sh
ls /

docker exec -it zoo3 /bin/bash
zkServer.sh status
zkCli.sh
ls /

### Start a Zookeeper server cluster instance wia docker-compose
docker network create --driver bridge --subnet=172.18.0.0/16 --gateway=172.18.0.1 clusternet

mkdir -p /data/app/docker/zookeeper-cluster/zoo/conf
mkdir -p /data/app/docker/zookeeper-cluster/zoo/data
mkdir -p /data/app/docker/zookeeper-cluster/zoo/datalog
mkdir -p /data/app/docker/zookeeper-cluster/zoo/logs

cp -rf zoo zoo1
cp -rf zoo zoo2
cp -rf zoo zoo3

docker-compose -f stack.yml up -d
