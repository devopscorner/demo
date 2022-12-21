# DevOpsCorner Demo - Docker Compose

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

- Provisioning with Terraform & Ansible
- EC2 Docker Compose
- Python3 & Libraries
- Deploy with
  - Own Services (Existing) with EC2 Instances
    - Docker CLI
    - Docker-Compose
    - Ansible
  - Managed Services with Amazon ECS
    - AWS Copilot

---

## Prerequirements

- Docker
- Docker-Compose

## How-to-Run

- With Script

  ```
  ./run-docker.sh
  ```

- Running Docker-Compose with Spesific File

  ```
  ## Goto root folder
  docker-compose -p devopscorner-demo -f docker-compose.yml up -d
  ```

- Stop

  ```
  ## Goto root folder
  docker-compose -p devopscorner-demo -f docker-compose.yml stop
  ```

- Remove
  ```
  ## Goto root folder
  docker-compose -p devopscorner-demo -f docker-compose.yml down
  ```

## Tested Environment

### Versioning

- Docker version

  ```
  docker -v
  ---
  Docker version 20.10.17-rd, build c2e4e01

  docker version
  ---
  Client:
    Version:           20.10.17-rd
    API version:       1.41
    Go version:        go1.17.11
    Git commit:        c2e4e01
    Built:             Fri Jul 22 18:31:17 2022
    OS/Arch:           darwin/amd64
    Context:           default
    Experimental:      true

  Server: Docker Desktop 4.14.1 (91661)
  Engine:
    Version:          20.10.21
    API version:      1.41 (minimum version 1.12)
    Go version:       go9.7
    Git commit:       3056208
    Built:            Tue Oct 25 18:00:19 2022
    OS/Arch:          linux/amd64
    Experimental:     false
  containerd:
    Version:          1.6.9
    GitCommit:        1c90a442489720eec95342e1789ee8a5e1b9536f
  runc:
    Version:          1.1.4
    GitCommit:        v1.1.4-0-g5fd4c4d
  docker-init:
    Version:          0.19.0
    GitCommit:        de40ad0
  ```

- Docker-Compose version

  ```
  docker-compose -v
  ---
  Docker Compose version v2.11.1
  ```

- AWS Cli

  ```
  aws --version
  ---
  aws-cli/2.8.7 Python/3.9.11 Darwin/21.6.0 exe/x86_64 prompt/off
  ```

- Terraform Cli

  ```
  terraform version
  ---
  Terraform v1.3.5
  on darwin_amd64
  - provider registry.terraform.io/hashicorp/aws v3.74.3
  - provider registry.terraform.io/hashicorp/local v2.1.0
  - provider registry.terraform.io/hashicorp/null v3.1.0
  - provider registry.terraform.io/hashicorp/random v3.1.0
  - provider registry.terraform.io/hashicorp/time v0.7.2
  ```

- Terraform Environment Cli

  ```
  tfenv -v
  ---
  tfenv 2.2.2
  ```
