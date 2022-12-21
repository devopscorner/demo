#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in CICD
# DOCKER_USERNAME
# DOCKER_PASSWORD

set -e

image="alpine/semver"

docker build --no-cache -t ${image}:latest .

DOCKER_PUSH="docker buildx build --no-cache --push --platform linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x"

# add another tag with git version, with this way, we can check this git image health
VERSION=($(docker run -i --rm ${image}:latest | head -1 | awk '{print $NF}'))
echo ${VERSION}

if [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == false ]]; then
    docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    docker buildx create --use
    ${DOCKER_PUSH} -t ${image}:latest -t ${image}:${VERSION} .
fi
