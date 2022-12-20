# DevOpsCorner Demo

Demo Repository for PoC (Proof-of-Concepts)

![all contributors](https://img.shields.io/github/contributors/devopscorner/demo)
![tags](https://img.shields.io/github/v/tag/devopscorner/demo?sort=semver)
[![demo pulls](https://img.shields.io/docker/pulls/devopscorner/demo.svg?label=demo%20pulls&logo=docker)](https://hub.docker.com/r/devopscorner/demo/)
![download all](https://img.shields.io/github/downloads/devopscorner/demo/total.svg)
![view](https://views.whatilearened.today/views/github/devopscorner/demo.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/demo/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/demo)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/demo)
![forks](https://img.shields.io/github/forks/devopscorner/demo)
![stars](https://img.shields.io/github/stars/devopscorner/demo)
[![license](https://img.shields.io/github/license/devopscorner/demo)](https://img.shields.io/github/license/devopscorner/demo)

---

## Build Container Image

- Clone this repository

  ```
  git clone https://github.com/devopscorner/demo.git
  ```

- Replace "YOUR_AWS_ACCOUNT" with your AWS ACCOUNT ID

  ```
  find ./ -type f -exec sed -i 's/YOUR_AWS_ACCOUNT/123456789012/g' {} \;
  ```

- Set Environment Variable

  ```
  export ALPINE_VERSION=3.16
  export BASE_IMAGE="alpine"
  export IMAGE="YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo"
  export TAG="latest"
  ```

- Execute Build Image

  ```
  # Golang 1.18 - Alpine 3.16
  docker build -f Dockerfile -t $IMAGE:alpine .
  docker build -f Dockerfile -t $IMAGE:alpine-3.16 .

  -- or --

  ./ecr-build.sh $(ARGS) Dockerfile CI_PATH=$IMAGE alpine $ALPINE_VERSION

  -- or --

  # default: 3.16
  make ecr-build ARGS=YOUR_AWS_ACCOUNT Dockerfile CI_PATH=$IMAGE alpine $ALPINE_VERSION
  ```

## Push Image to Amazon ECR (Elastic Container Registry)

- Create Tags Image
  - Example:

    ```
    # Alpine
    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo:latest

    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo:alpine-latest

    docker tag YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo:alpine YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo:alpine-3.16
    ```

  - With Script:

    ```
    # default: 3.16
    docker tag $IMAGE:$ALPINE_VERSION

    -- or --

    # default: 3.16
    ./ecr-tag.sh ARGS=YOUR_AWS_ACCOUNT CI_PATH=$IMAGE alpine $ALPINE_VERSION

    -- or --

    make ecr-tag ARGS=YOUR_AWS_ACCOUNT CI_PATH=$IMAGE
    ```

 Push Image to **Amazon ECR** with Tags

- Example:

    ```
    # Alpine
    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo:alpine

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo:alpine-latest

    docker push YOUR_AWS_ACCOUNT.dkr.ecr.ap-southeast-1.amazonaws.com/devopscorner/demo:alpine-3.16
    ```

- With Script:

    ```
    ./ecr-push.sh ARGS=YOUR_AWS_ACCOUNT CI_PATH=$IMAGE $ALPINE_VERSION

    -- or --

    make ecr-push-alpine ARGS=YOUR_AWS_ACCOUNT CI_PATH=$IMAGE
    ```
