# -----------------------------------------------------------------------------
#  MAKEFILE RUNNING COMMAND
# -----------------------------------------------------------------------------
#  Author     : DevOps Engineer (support@devopscorner.id)
#  License    : Apache v2
# -----------------------------------------------------------------------------
# Notes:
# use [TAB] instead [SPACE]

export PATH_APP=`pwd`
export PATH_WORKSPACE="src"
export PATH_SCRIPT="scripts"
export PATH_COMPOSE="compose"
export PATH_DOCKER="."
export PROJECT_NAME="demo"
export TF_PATH="terraform/environment/providers/aws/infra"
export TF_CORE="$(TF_PATH)/core"
export TF_RESOURCES="$(TF_PATH)/resources"
export TF_STATE="$(TF_PATH)/tfstate"

export CI_REGISTRY     ?= $(ARGS).dkr.ecr.ap-southeast-1.amazonaws.com
export CI_PROJECT_PATH ?= devopscorner
export CI_PROJECT_NAME ?= demo

IMAGE          = $(CI_REGISTRY)/${CI_PROJECT_PATH}/${CI_PROJECT_NAME}
DIR            = $(shell pwd)
VERSION       ?= 1.5.0

export BASE_IMAGE=alpine
export BASE_VERSION=3.16
export ALPINE_VERSION=3.16

GO_APP        ?= demo
SOURCES        = $(shell find . -name '*.go' | grep -v /vendor/)
VERSION       ?= $(shell git describe --tags --always --dirty)
GOPKGS         = $(shell go list ./ | grep -v /vendor/)
BUILD_FLAGS   ?=
LDFLAGS       ?= -X github.com/devopscorner/demo/config.Version=$(VERSION) -w -s
TAG           ?= "v0.1.0"
GOARCH        ?= amd64
GOOS          ?= linux
GO111MODULE   ?= on

export PATH_APP=`pwd`

# ========================= #
#   BUILD GO APP (Binary)   #
# ========================= #
.PHONY: build

default: build

test.race:
	go test -v -race -count=1 `go list ./...`

test:
	go test -v -count=1 `go list ./...`

fmt:
	go fmt $(GOPKGS)

check:
	golint $(GOPKGS)
	go vet $(GOPKGS)

# build: build/$(BINARY)

# build/$(BINARY): $(SOURCES)
# 	GO111MODULE=$(GO111MODULE) GOOS=$(GOOS) GOARCH=$(GOARCH) CGO_ENABLED=0 go build -o build/$(BINARY) $(BUILD_FLAGS) -ldflags "$(LDFLAGS)" .

tag:
	git tag $(TAG)

build:
	@echo "============================================"
	@echo " Task      : Build Binary GO APP "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@echo ">> Build GO Apps... "
	@cd ${PATH_WORKSPACE} && GO111MODULE=$(GO111MODULE) GOOS=$(GOOS) GOARCH=$(GOARCH) CGO_ENABLED=0 go build -o build/$(GO_APP) $(BUILD_FLAGS) -ldflags "$(LDFLAGS)" ./main.go
	@echo '- DONE -'

build-mac-darwin:
	@echo "============================================"
	@echo " Task      : Build Binary GO APP "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@echo ">> Build GO Apps... "
	@cd ${PATH_WORKSPACE} && GO111MODULE=$(GO111MODULE) GOOS="darwin" GOARCH=$(GOARCH) CGO_ENABLED=0 go build -o build/$(GO_APP) $(BUILD_FLAGS) -ldflags "$(LDFLAGS)" ./main.go
	@echo '- DONE -'

build-mac-arm:
	@echo "============================================"
	@echo " Task      : Build Binary GO APP "
	@echo " Date/Time : `date`"
	@echo "============================================"
	@echo ">> Build GO Apps... "
	@cd ${PATH_WORKSPACE} && GO111MODULE=$(GO111MODULE) GOOS="arm" GOARCH=$(GOARCH) CGO_ENABLED=0 go build -o build/$(GO_APP) $(BUILD_FLAGS) -ldflags "$(LDFLAGS)" ./main.go
	@echo '- DONE -'

# ==================== #
#   SEMANTIC VERSION   #
# ==================== #
RELEASE_TYPE ?= patch

CURRENT_VERSION := $(shell git ls-remote --tags | awk '{ print $$2}'| sort -nr | head -n1|sed 's/refs\/tags\///g')

ifndef CURRENT_VERSION
  CURRENT_VERSION := 0.0.0
endif

NEXT_VERSION := $(shell docker run --rm alpine/semver semver -c -i $(RELEASE_TYPE) $(CURRENT_VERSION))

current-version:
	@echo $(CURRENT_VERSION)

next-version:
	@echo $(NEXT_VERSION)

release:
	git checkout master;
	git tag $(NEXT_VERSION)
	git push --tags

# =============== #
#   GET MODULES   #
# =============== #
.PHONY: sub-officials sub-community sub-all codebuild-modules
sub-officials:
	@echo "=============================================================="
	@echo " Task      : Get Official Submodules "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@mkdir -p $(TF_MODULES)/officials
	@cd $(PATH_APP) && ./get-officials.sh

sub-community:
	@echo "=============================================================="
	@echo " Task      : Get Community Submodules "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@mkdir -p $(TF_MODULES)/community
	@cd $(PATH_APP) && ./get-community.sh

sub-all:
	@make sub-officials
	@echo ''
	@make sub-community
	@echo ''
	@echo '---'
	@echo '- ALL DONE -'

codebuild-modules:
	@echo "=============================================================="
	@echo " Task      : Get CodeBuild Modules "
	@echo " Date/Time : `date` "
	@echo "=============================================================="
	@./get-modules-codebuild.sh

# ==================== #
#   CLONE REPOSITORY   #
# ==================== #
.PHONY: git-clone
git-clone:
	@echo "=============================================================="
	@echo " Task      : Clone Repository Sources "
	@echo " Date/Time : `date`"
	@echo "=============================================================="
	@sh ./git-clone.sh $(SOURCE) $(TARGET)
	@echo '- DONE -'

# ========================== #
#   BUILD CONTAINER GO-APP   #
# ========================== #
# ./ecr-build.sh [AWS_ACCOUNT] Dockerfile [ECR_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
.PHONY: ecr-build ecr-tag ecr-push
ecr-build:
	@echo "=============================================================="
	@echo " Task      : Create Container GO-APP Alpine Image "
	@echo " Date/Time : `date`"
	@echo "=============================================================="
	@sh ./ecr-build.sh $(ARGS) Dockerfile $(CI_PATH) alpine ${ALPINE_VERSION}

# ========================= #
#   TAGS CONTAINER GO-APP   #
# ========================= #
# ./ecr-tag.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|codebuild] [version|latest|tags] [custom-tags]
ecr-tag:
	@echo "=============================================================="
	@echo " Task      : Set Tags Image Alpine to ECR"
	@echo " Date/Time : `date`"
	@echo "=============================================================="
	@sh ./ecr-tag.sh $(ARGS) $(CI_PATH) alpine ${ALPINE_VERSION}

# ========================= #
#   PUSH CONTAINER GO-APP   #
# ========================= #
# ./ecr-push.sh [AWS_ACCOUNT] [ECR_PATH] [alpine|ubuntu|codebuild|version|latest|tags|custom-tags]
ecr-push:
	@echo "=============================================================="
	@echo " Task      : Push Image Alpine to ECR"
	@echo " Date/Time : `date`"
	@echo "=============================================================="
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) alpine
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) latest
	@sh ./ecr-push.sh $(ARGS) $(CI_PATH) ${ALPINE_VERSION}

# =========================== #
#   PROVISIONING INFRA CORE   #
# =========================== #
.PHONY: tf-core-init tf-core-create-workspace tf-core-select-workspace tf-core-plan tf-core-apply
tf-core-init:
	@echo "============================================================"
	@echo " Task      : Terraform Init "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform init $(ARGS)
	@echo '- DONE -'
tf-core-create-workspace:
	@echo "============================================================"
	@echo " Task      : Terraform Create Workspace "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform workspace new $(ARGS)
	@echo '- DONE -'
tf-core-select-workspace:
	@echo "============================================================"
	@echo " Task      : Terraform Select Workspace "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform workspace select $(ARGS)
	@echo '- DONE -'
tf-core-plan:
	@echo "============================================================"
	@echo " Task      : Terraform Plan Provisioning "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform plan $(ARGS)
	@echo '- DONE -'
tf-core-apply:
	@echo "============================================================"
	@echo " Task      : Provisioning Terraform "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_CORE) && terraform apply -auto-approve
	@echo '- DONE -'

# ================================ #
#   PROVISIONING RESOURCES INFRA   #
# ================================ #
.PHONY: tf-infra-init tf-infra-create-workspace tf-infra-select-workspace tf-infra-plan tf-infra-apply tf-infra-resource
tf-infra-init:
	@echo "============================================================"
	@echo " Task      : Terraform Init "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform init $(ARGS)
	@echo '- DONE -'
tf-infra-create-workspace:
	@echo "============================================================"
	@echo " Task      : Terraform Create Workspace "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform workspace new $(ARGS)
	@echo '- DONE -'
tf-infra-select-workspace:
	@echo "============================================================"
	@echo " Task      : Terraform Select Workspace "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform workspace select $(ARGS)
	@echo '- DONE -'
tf-infra-plan:
	@echo "============================================================"
	@echo " Task      : Terraform Plan Provisioning "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform plan $(ARGS)
	@echo '- DONE -'
tf-infra-apply:
	@echo "============================================================"
	@echo " Task      : Provisioning Terraform "
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform apply -auto-approve $(ARGS)
	@echo '- DONE -'

# =============================== #
#   PROVISIONING SPESIFIC INFRA   #
# =============================== #
.PHONY: tf-infra-resource
tf-infra-resource:
	@echo "============================================================"
	@echo " Task      : Terraform Command $(ARGS)"
	@echo " Date/Time : `date` "
	@echo "============================================================"
	@cd $(TF_RESOURCES)/$(INFRA_RESOURCES) && terraform $(ARGS)
	@echo '- DONE -'
