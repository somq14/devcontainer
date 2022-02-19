# Debian のバージョンを指定
# https://hub.docker.com/_/debian?tab=description
ARG DEBIAN_VERSION
FROM debian:${DEBIAN_VERSION}

################################################################################
# apt
################################################################################

RUN : \
  && apt update \
  && apt install -y \
    # よく使うコマンドを事前にインストール
    vim \
    git \
    curl \
    wget \
    less \
    tree \
    zip \
    # 日本語の有効化のため
    locales \
    # 一般ユーザ利用のため
    sudo \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

################################################################################
# Locale
################################################################################

# 日本語ローケルを生成する
RUN sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
 && locale-gen

# 言語を日本語にする
ENV LANG ja_JP.UTF-8

# タイムゾーンを日本にする
ENV TZ Asia/Tokyo

################################################################################
# Python
################################################################################

# Python のバージョンを指定
# https://www.python.org/downloads/
ARG PYTHON_VERSION

RUN : \
  && apt update \
  && apt update \
  && apt install -y \
    gcc \
    make \
    zlib1g-dev \
    libssl-dev \
    libreadline6-dev \
  && mkdir -p /tmp/python \
  && cd /tmp/python \
  && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
  && tar xvf Python-${PYTHON_VERSION}.tgz \
  && cd Python-${PYTHON_VERSION} \
  && ./configure --enable-optimizations \
  && make -j 16 \
  && make install \
  # 不要データの削除
  && rm -r /tmp/python \
  && apt remove -y gcc \
  && apt autoremove -y \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

################################################################################
# Node.js
################################################################################

# Node.js のバージョンを指定
# https://nodejs.org/ja/download/releases/
ARG NODEJS_VERSION

RUN : \
  && mkdir -p /tmp/nodejs \
  && cd /tmp/nodejs \
  && wget https://nodejs.org/download/release/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz \
  && tar xvf node-v${NODEJS_VERSION}-linux-x64.tar.gz \
  && cd node-v${NODEJS_VERSION}-linux-x64 \
  && cp -r bin include lib share /usr/local \
  && rm -r /tmp/nodejs

# yarn のバージョンを指定
# https://www.npmjs.com/package/yarn
ARG YARN_VERSION
RUN npm install -g yarn@${YARN_VERSION}

################################################################################
# aws-cli
################################################################################

# aws-cli のバージョンを指定
# https://nodejs.org/ja/download/releases/
ARG AWS_CLI_VERSION

RUN : \
  && mkdir -p /tmp/aws-cli \
  && cd /tmp/aws-cli \
  && curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip -o awscliv2.zip \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -r /tmp/aws-cli

# aws-mfa をインストール
ARG AWS_MFA_VERSION
RUN pip3 install aws-mfa===${AWS_MFA_VERSION}

################################################################################
# AWS SAM
################################################################################

# AWS SAM のバージョンを指定
# https://github.com/aws/aws-sam-cli/releases
ARG AWS_SAM_VERSION

RUN : \
  && mkdir -p /tmp/aws-sam \
  && cd /tmp/aws-sam \
  && wget https://github.com/aws/aws-sam-cli/releases/download/v${AWS_SAM_VERSION}/aws-sam-cli-linux-x86_64.zip \
  && unzip aws-sam-cli-linux-x86_64.zip \
  && ./install \
  && rm -rf /tmp/aws-sam

################################################################################
# 一般ユーザ作成
################################################################################

ARG USER_NAME
ARG USER_UID
ARG USER_GID

RUN : \
    # ユーザのグループを作成
    && groupadd --gid ${USER_GID} ${USER_NAME} \
    # ユーザを作成
    && useradd --uid ${USER_UID} --gid ${USER_GID} -s /bin/bash -m ${USER_NAME} \
    # sudo を有効にする
    && echo ${USER_NAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USER_NAME} \
    && chmod 0440 /etc/sudoers.d/${USER_NAME}

WORKDIR /home/${USER_NAME}
USER ${USER_NAME}
RUN mkdir -p ~/.persistent
