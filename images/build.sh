#!/bin/bash

docker build \
  -t devcontainer:latest \
  --build-arg DEBIAN_VERSION=11.2 \
  --build-arg USER_NAME=vscode \
  --build-arg USER_UID=$(id -u) \
  --build-arg USER_GID=$(id -g) \
  --build-arg PYTHON_VERSION=3.10.2 \
  --build-arg NODEJS_VERSION=14.18.3 \
  --build-arg YARN_VERSION=1.22.17 \
  --build-arg AWS_CLI_VERSION=2.4.19 \
  --build-arg AWS_MFA_VERSION=0.0.12 \
  --build-arg AWS_SAM_VERSION=1.38.1 \
  .
