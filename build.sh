#!/bin/bash

docker build \
  -t devcontainer:latest \
  --build-arg DEBIAN_VERSION=${DEBIAN_VERSION} \
  --build-arg USER_NAME=vscode \
  --build-arg USER_UID=$(id -u) \
  --build-arg USER_GID=$(id -g) \
  --build-arg PYTHON_VERSION=${PYTHON_VERSION} \
  --build-arg NODEJS_VERSION=${NODEJS_VERSION} \
  --build-arg YARN_VERSION=${YARN_VERSION} \
  --build-arg AWS_CLI_VERSION=${AWS_CLI_VERSION} \
  --build-arg AWS_MFA_VERSION=${AWS_MFA_VERSION} \
  --build-arg AWS_SAM_VERSION=${AWS_SAM_VERSION} \
  .
