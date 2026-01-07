#!/bin/bash

sudo timedatectl set-timezone Asia/Tokyo

sudo apt-get update
sudo apt-get install -y -q language-pack-ja
sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"

# AWS CLI
which aws
if [ $? = 0 ]; then
  echo "aws cli is already installed"
else
  sudo apt-get install -y -q curl unzip
  curl -fsSL https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip -o /tmp/aws-cli.zip
  unzip -q -d /tmp /tmp/aws-cli.zip
  /tmp/aws/install
  rm -rf /tmp/aws
fi

# Docker
which docker
if [ $? = 0 ]; then
  echo "docker is already installed"
else
  sudo apt-get install -y -q ca-certificates
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get -y -q install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker ubuntu
fi

# Git
which git
if [ $? = 0 ]; then
  echo "git is already installed"
else
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt-get update
  sudo apt-get install -y -q software-properties-common
  sudo apt-get install -y -q git
fi

# etc
sudo apt-get install -y -q build-essential jq
sudo apt-get install -y -q fd-find ripgrep bat lsd fzf zoxide

# Symbolic Links
mkdir -p ~/.local/bin
ln -sf $(which fdfind) ~/.local/bin/fd
ln -sf $(which batcat) ~/.local/bin/bat

# miseコアパッケージ
# chezmoiがmiseでインストールされている前提。miseがなければインストールもする。
mise use -g uv@latest
mise use -g python@latest
mise use -g node@lts
mise use -g bun@latest

# npmパッケージのインストール
mise use -g npm:tldr
mise use -g npm:@anthropic-ai/claude-code
