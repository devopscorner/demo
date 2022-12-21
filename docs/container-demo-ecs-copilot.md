# DevOpsCorner Demo - AWS Copilot Deployment

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

## Deploy GO to Amazon ECS with AWS Copilot

- References:
  [Copilot CLI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/getting-started-aws-copilot-cli.html)

### Prequests

- Install Copilot CLI

  - Linux

    ```
    sudo curl -Lo /usr/local/bin/copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux \
        && sudo chmod +x /usr/local/bin/copilot \
        && copilot --help
    ```

  - Linux ARM

    ```
    sudo curl -Lo /usr/local/bin/copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux-arm64 \
        && sudo chmod +x /usr/local/bin/copilot \
        && copilot --help
    ```

  - Windows

    ```
    PS C:\> New-Item -Path 'C:\copilot' -ItemType directory; `
    Invoke-WebRequest -OutFile 'C:\copilot\copilot.exe' https://github.com/aws/copilot-cli/releases/latest/download/copilot-windows.exe
    ```

  - MacOS

    ```
    brew install aws/tap/copilot-cli

    ### or ###
    sudo curl -Lo /usr/local/bin/copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-darwin \
        && sudo chmod +x /usr/local/bin/copilot \
        && copilot --help
    ```

- Install AWS CLI

  - Linux

    ```
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
    ```

  - Linux ARM

    ```
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
    ```

  - Windows

    ```
    msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
    ```

  - MacOS

    ```
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg ./AWSCLIV2.pkg -target /
    ```

### Runnning

- Clone this repository

  ```
  git clone https://github.com/devopscorner/demo.git
  ```

- Command Run (Single Line)

  - From `Dockerfile`

    ```
    cd demo &&                            \
        copilot init --app demo             \
        --name api                          \
        --type 'Load Balanced Web Service'  \
        --dockerfile './Dockerfile'         \
        --port 8080                         \
        --deploy
    ```

  - From existing Images

    ```
    cd demo &&                            \
        copilot init --app demo             \
        --name api                          \
        --type 'Load Balanced Web Service'  \
        --image 'devopscorner/demo:latest'  \
        --port 8080                         \
        --deploy
    ```

- Interactive Mode

  - Init

    ```
    copilot init
    ```

  - Name Application

    ```
    What would you like to name your application? [? for help]
    ```

    Enter `demo`.

  - Service Type

    ```
    Which service type best represents your service's architecture? [Use arrows to move, type to filter, ? for more help]
    > Load Balanced Web Service
      Backend Service
      Scheduled Job
    ```

    Choose `Load Balanced Web Service`.

  - Provide Name Service

    ```
    What do you want to name this Load Balanced Web Service? [? for help]
    ```

    Enter `api` for your service name.

  - Select Dockerfile

    ```
    Which Dockerfile would you like to use for api? [Use arrows to move, type to filter, ? for more help]
    > ./Dockerfile
      Use an existing image instead
    ```

    Choose `Dockerfile`.
    For Windows users, enter the path to the Dockerfile in the `demo` folder (_`...\demo\Dockerfile`_\.).

  - Define Port

    ```
    Which port do you want customer traffic sent to? [? for help] (80)
    ```

    Enter `8080` or accept default.

  - You will see a log showing the application resources being created.

    ```
    Creating the infrastructure to manage services under application demo.
    ```

  - After the application resources are created, deploy a `test` environment.

    ```
    Would you like to deploy a test environment? [? for help] (y/N)
    ```

    Enter `y`.

    ```
    Proposing infrastructure changes for the test environment.
    ```

  - You will see a log displaying the status of your application deployment.

---

### Verify your application is running

View the status of your application by using the following commands.

- List all of your AWS Copilot applications.

  ```
  copilot app ls
  ```

- Show information about the environments and services in your application.

  ```
  copilot app show
  ```

- Show information about your environments.

  ```
  copilot env ls
  ```

- Show information about the service, including endpoints, capacity and related resources.

  ```
  copilot svc show
  ```

- List of all the services in an application.

  ```
  copilot svc ls
  ```

- Show logs of a deployed service.

  ```
  copilot svc logs
  ```

- Show service status.

  ```
  copilot svc status
  ```

- List available commands and options.

  ```
  copilot --help
  copilot init --help
  ```

### Cleanup Environment

```
copilot app delete
```

### Update Existing Stack Deployment

```
copilot svc delete --name [old_service_name]
copilot svc init --name [new_service_name]

## Redeploy
copilot pipeline deploy
---
eg:
copilot svc init --name demo
copilot svc init --name demo-new
copilot pipeline deploy
```
