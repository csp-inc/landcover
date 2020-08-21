#!/usr/bin/env bash

IMAGE=${1:-cpu}
TAG=${2:-latest}

GROUP=ms
PROJECT=$(basename $(pwd))

IMAGE_NAME=cspinc/$GROUP/$PROJECT/$IMAGE:$TAG

FILE=$(find . -path \*$IMAGE/$TAG/Dockerfile)
docker build --no-cache --rm -t $IMAGE_NAME - < $FILE
