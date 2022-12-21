# DevOpsCorner Demo

Demo Repository for PoC (Proof-of-Concepts)

![all contributors](https://img.shields.io/github/contributors/devopscorner/demo)
![tags](https://img.shields.io/github/v/tag/devopscorner/demo?sort=semver)
[![demo pulls](https://img.shields.io/docker/pulls/devopscorner/demo.svg?label=demo%20pulls&logo=docker)](https://hub.docker.com/r/devopscorner/demo/)
![download all](https://img.shields.io/github/downloads/devopscorner/demo/total.svg)
![download latest](https://img.shields.io/github/downloads/devopscorner/demo/0.1/total)
![view](https://views.whatilearened.today/views/github/devopscorner/demo.svg)
![clone](https://img.shields.io/badge/dynamic/json?color=success&label=clone&query=count&url=https://raw.githubusercontent.com/devopscorner/demo/master/clone.json?raw=True&logo=github)
![issues](https://img.shields.io/github/issues/devopscorner/demo)
![pull requests](https://img.shields.io/github/issues-pr/devopscorner/demo)
![forks](https://img.shields.io/github/forks/devopscorner/demo)
![stars](https://img.shields.io/github/stars/devopscorner/demo)
[![license](https://img.shields.io/github/license/devopscorner/demo)](https://img.shields.io/github/license/devopscorner/demo)

---

## Available Tags

### Alpine

| Image name                        | Size                                                                                                                                                                                                                                                 |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `devopscorner/demo:alpine`        | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/demo/alpine.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/demo/tags?page=1&ordering=last_updated&name=alpine)               |
| `devopscorner/demo:alpine-latest` | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/demo/alpine-latest.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/demo/tags?page=1&ordering=last_updated&name=alpine-latest) |
| `devopscorner/demo:alpine-3.16`   | [![docker image size](https://img.shields.io/docker/image-size/devopscorner/demo/alpine-3.16.svg?label=Image%20size&logo=docker)](https://hub.docker.com/repository/docker/devopscorner/demo/tags?page=1&ordering=last_updated&name=alpine-3.16)     |

---

## Prerequirements

- Docker (`docker`)
- Docker Compose (`docker-compose`)
- AWS Cli version 2 (`aws`)
- Terraform Cli (`terraform`)
- Terraform Environment (`tfenv`)

## Documentation

- Index Documentation, go to [this](docs/README.md) link
- Build, Tag & Push container `devopscorner/demo` image to **Amazon ECR (Elastic Container Registry)**, go to [this](docs/container-demo-ecr.md) link
- Running DEMO, go to [this](docs/container-demo-run.md) link
- Deploy with Docker CLI & Docker-Compose, detail [here](docs/deploy-docker-compose.md)
- Deploy with Ansible detail [here](docs/deploy-ansible.md)
- Deploy Amazon Elastic Container Service (ECS) with AWS Copilot, detail [here](docs/deploy-ecs-copilot.md)

## Terraform Features

Multi Environment Workspace:

- Remote State Terraform (S3 & DynamoDB)

- Core Infrastructure

  - VPC
  - Subnet EC2
  - Security Group
  - NAT Gateway
  - Internet Gateway
  - VPC Peers Single CIDR
  - VPC Peers Multi CIDR

- Resources Other Infra
  - Budget
  - AWS Elastic Computing (EC2)
    - Jumphost
    - PostgreSQL (PSQL)
    - Workspace Lab
  - Amazon Relational Database Service (RDS)
    - RDS `workspacedb`
  - Amazon ElastiCache for Redis

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

## Security Check

Make sure that you didn't push sensitive information in this repository

- [ ] AWS Credentials (AWS_ACCESS_KEY, AWS_SECRET_KEY)
- [ ] AWS Account ID
- [ ] AWS Resources ARN
- [ ] Username & Password
- [ ] Private (id_rsa) & Public Key (id_rsa.pub)
- [ ] DNS Zone ID
- [ ] APP & API Key

## Copyright

- Author: **Dwi Fahni Denni (@zeroc0d3)**
- Vendor: **DevOps Corner Indonesia (devopscorner.id)**
- License: **Apache v2**
