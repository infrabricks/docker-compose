#!/bin/bash
IMAGE=docker-compose:alpine
ACCOUNT=infrabricks
TAG_LONG=1.10.0

docker build -f Dockerfile.alpine \
 -t="${ACCOUNT}/$IMAGE" \
 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
 --build-arg VCS_REF=`git rev-parse --short HEAD` \
 .
DATE=`date +'%Y%m%d%H%M'`
IID=$(docker inspect -f "{{.Id}}" ${ACCOUNT}/$IMAGE)
docker tag ${IID} ${ACCOUNT}/$IMAGE-$DATE
docker tag ${IID} ${ACCOUNT}/$IMAGE-$TAG_LONG
