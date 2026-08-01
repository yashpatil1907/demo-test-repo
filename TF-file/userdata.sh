#!/bin/bash

dnf update -y

# Install required tools
dnf install -y wget git docker maven awscli java-21-amazon-corretto

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

