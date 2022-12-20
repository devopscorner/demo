#!/bin/sh

export AWS_ACCOUNT_ID=YOUR_AWS_ACCOUNT_ID
export AWS_REGION="ap-southeast-1"

export ALPINE_VERSION=3.16
export BASE_IMAGE="alpine"
export IMAGE="YOUR_AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/devopscorner/demo"
export TAG="latest"

docker build -f Dockerfile -t $IMAGE:alpine .

docker tag $IMAGE:$BASE_IMAGE $IMAGE:$TAG
docker tag $IMAGE:$BASE_IMAGE $IMAGE:alpine-$TAG
docker tag $IMAGE:$BASE_IMAGE $IMAGE:alpine-$ALPINE_VERSION

PASSWORD=$(aws ecr get-login-password --region $AWS_REGION)
echo $PASSWORD | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

docker push $IMAGE:$BASE_IMAGE
docker push $IMAGE:latest
docker push $IMAGE:alpine-latest
docker push $IMAGE:alpine-$ALPINE_VERSION
