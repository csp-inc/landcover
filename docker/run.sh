#!/usr/bin/env bash

IMAGE=${1:-cpu}
TAG=${2:-latest}

GROUP=ms
PROJECT=$(basename $(pwd))

PORT=8080

if [ $IMAGE == "cpu" ]; then
		RUNTIME=""
elif [ $IMAGE == "gpu" ]; then
		RUNTIME="--runtime=nvidia"
else
    echo "Error: argument must be one of 'cpu' or 'gpu', you passed '$IMAGE'."
    exit 1
fi

IMAGE_NAME=cspinc/$GROUP/$PROJECT/$IMAGE:$TAG
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
  echo "Image not found, building from recipe...."
  ./$(find . -path \*build.sh) $IMAGE $TAG
fi

VOLUME="/content/$(basename $(pwd))"
docker run $RUNTIME -it --rm \
		--name $PROJECT-$IMAGE-$TAG \
		-v "$(pwd)":$VOLUME \
    -w $VOLUME \
		-p $PORT:8080 \
		$IMAGE_NAME \
		/bin/bash
