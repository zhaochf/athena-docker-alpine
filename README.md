# athena-docker-alpine
This is build docker images from alpine

## Build image 
mvn clean docker:build

## Push image
mvn docker:push

## Build and push image
mvn clean docker:build docker:push

## Run image
docker run -itd --name athen-alpine-[Name] -p 2022:22 [ImageId]