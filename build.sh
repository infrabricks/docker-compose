#!/bin/bash
IMAGE=docker-compose
ACCOUNT=infrabricks
TAG_LONG=1.10.0

docker build -t="${ACCOUNT}/$IMAGE" .
DATE=`date +'%Y%m%d%H%M'`
IID=$(docker inspect -f "{{.Id}}" ${ACCOUNT}/$IMAGE)
docker tag ${IID} ${ACCOUNT}/$IMAGE:$DATE
docker tag ${IID} ${ACCOUNT}/$IMAGE:$TAG_LONG
