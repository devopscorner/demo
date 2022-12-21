# DevOpsCorner Demo - Ansible Deployment

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

## Folder Structure

```
.
├── README.md
├── ansible.cfg
├── keys
│   ├── devopscorner-prod.pem
│   └── devopscorner-staging.pem
├── main.go
├── playbooks
│   ├── docker
│   └── java
├── requirements.txt
├── roles
│   ├── amazon-aws
│   ├── ansible-pretasks
│   ├── apt-clear-cache
│   ├── aws-cli
│   ├── certbot
│   ├── common
│   ├── docker
│   ├── java
│   ├── golang
│   └── requirements.yaml
└── services
    ├── demo
    │   ├── ansible
    │   │   └── inventory
    │   │       ├── import_playbooks.yaml
    │   │       ├── prod
    │   │       │   ├── group_vars
    │   │       │   │   ├── all.yaml
    │   │       │   │   ├── inventory.ini
    │   │       │   │   └── local.yaml
    │   │       │   └── host_vars
    │   │       └── staging
    │   │           ├── group_vars
    │   │           │   ├── all.yaml
    │   │           │   ├── inventory.ini
    │   │           │   ├── local.yaml
    │   │           │   └── metadata_demo.yaml
    │   │           └── host_vars
    │   └── terraform
    └── docker
        ├── ansible
        │   └── inventory
        │       ├── import_playbooks.yaml
        │       ├── prod
        │       │   ├── group_vars
        │       │   │   ├── all.yaml
        │       │   │   ├── inventory.ini
        │       │   │   └── local.yaml
        │       │   └── host_vars
        │       └── staging
        │           ├── group_vars
        │           │   ├── all.yaml
        │           │   ├── inventory.ini
        │           │   ├── local.yaml
        │           │   └── metadata_docker.yaml
        │           └── host_vars
        └── terraform
```

## Ansible Libraries

1. Install python-pip

   ```
   sudo apt install python-pip
   ```

2. Suggested to using virtualenv, skip if you sure what you are doing,

   ```
   sudo pip install virtualenv && virtualenv ~/venv && source ~/venv/bin/activate
   ```

3. Install `ansible-core`

   ```
   export ANSIBLE_VERSION=2.12.2

   python3 -m pip install pip && \
      pip3 install --upgrade pip==22.3.1 cffi &&\
      # ================= #
      #  Install Ansible  #
      # ================= #
      pip3 install --no-cache-dir \
      ansible-core==${ANSIBLE_VERSION} \
      PyYaml \
      Jinja2 \
      httplib2 \
      six \
      requests \
      boto3
   ```

4. In root of `ansible` directory.

   ```
   cd ansible && pip3 install -r requirements.txt
   ```

5. Install ansible galaxy roles

   ```
   cd ansible && ansible-galaxy install -r roles/requirements.yml
   ```

## Deploy by Services

### Multi Tags Deployment

- Multi Tags Deployment (from ansible playbooks)

  ```
  ansible-playbook -i services/demo/ansible/inventory/staging/group_vars/inventory.ini playbooks/golang/service-golang-demo.yaml \
        -e "deploy_hosts=docker-golang-dev" \
        -e "env=staging" \
        -e "remote_user=ec2-user" \
        --private-key=/opt/keyserver/devopscorner-staging.pem \
        -K -vv -t=docker,golang
  ```

### GOLANG-DEMO without container

- Ansible GOLANG-DEMO (Staging)

  ```
  ansible-playbook -i services/demo/ansible/inventory/staging/group_vars/inventory.ini playbooks/golang/service-golang-demo.yaml \
        -e "deploy_hosts=docker-golang-dev" \
        -e "env=staging" \
        -e "remote_user=ec2-user" \
        --private-key=/opt/keyserver/devopscorner/devopscorner-staging.pem \
        -K -vv
  ```

### GOLANG-DEMO with container

- Ansible GOLANG-DEMO Container (Staging)

  ```
  ansible-playbook -i services/demo/ansible/inventory/staging/group_vars/inventory.ini playbooks/docker/deploy-docker-compose.yaml \
        -e "deploy_hosts=docker-golang-dev" \
        -e "env=staging" \
        -e "remote_user=ec2-user" \
        --private-key=/opt/keyserver/devopscorner/devopscorner-staging.pem \
        -K -vv
  ```

  ```
   ansible-playbook -i services/demo/ansible/inventory/staging/group_vars/inventory.ini playbooks/docker/deploy-docker-compose.yaml \
        -e "deploy_hosts=docker-golang-dev" \
        -e "env=staging" \
        -e "remote_user=ec2-user" \
        -K -vv
  ```
